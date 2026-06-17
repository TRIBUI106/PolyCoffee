package chez1s.assignment.controller;

import chez1s.assignment.util.FileUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

@WebServlet("/uploads/*")
public class ImageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String fileName = pathInfo.substring(1);

        // 1. Try to get from MinIO
        try (InputStream minioStream = FileUtil.getFile(fileName)) {
            if (minioStream != null) {
                serveImage(minioStream, fileName, resp);
                return;
            }
        } catch (Exception e) {
            // Log error
        }

        // 2. If not in MinIO, try to get from webapp resources (legacy/seed data)
        try (InputStream localStream = getServletContext().getResourceAsStream("/uploads/" + fileName)) {
            if (localStream != null) {
                serveImage(localStream, fileName, resp);
                return;
            }
        } catch (Exception e) {
            // Log error
        }

        resp.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    private void serveImage(InputStream is, String fileName, HttpServletResponse resp) throws IOException {
        String contentType = getServletContext().getMimeType(fileName);
        if (contentType != null) {
            resp.setContentType(contentType);
        }

        try (OutputStream os = resp.getOutputStream()) {
            byte[] buffer = new byte[8192];
            int bytesRead;
            while ((bytesRead = is.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        }
    }
}
