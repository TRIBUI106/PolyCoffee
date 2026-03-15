package chez1s.assignment.util;

import io.minio.BucketExistsArgs;
import io.minio.MakeBucketArgs;
import io.minio.MinioClient;
import io.minio.PutObjectArgs;
import io.minio.RemoveObjectArgs;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import java.io.InputStream;

public final class FileUtil {
    private static final String BUCKET_NAME = "polycoffee";
    private static final String MINIO_URL = "http://127.0.0.1:9000";
    private static final String ACCESS_KEY = "minioadmin";
    private static final String SECRET_KEY = "minioadmin";

    private static MinioClient minioClient;

    static {
        try {
            minioClient = MinioClient.builder()
                    .endpoint(MINIO_URL)
                    .credentials(ACCESS_KEY, SECRET_KEY)
                    .build();
            
            boolean isExist = minioClient.bucketExists(BucketExistsArgs.builder().bucket(BUCKET_NAME).build());
            if (!isExist) {
                minioClient.makeBucket(MakeBucketArgs.builder().bucket(BUCKET_NAME).build());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String upload(HttpServletRequest request, String name) {
        try {
            Part part = request.getPart(name);
            if (part == null || part.getSize() <= 0) return "";
            
            String fileName = part.getSubmittedFileName();
            if (fileName == null || fileName.isEmpty()) return "";
            
            String ext = fileName.substring(fileName.lastIndexOf("."));
            String uniqueName = System.currentTimeMillis() + ext;
            
            try (InputStream is = part.getInputStream()) {
                minioClient.putObject(
                    PutObjectArgs.builder()
                        .bucket(BUCKET_NAME)
                        .object(uniqueName)
                        .stream(is, part.getSize(), -1)
                        .contentType(part.getContentType())
                        .build()
                );
            }
            
            // Return the full minio path
            return MINIO_URL + "/" + BUCKET_NAME + "/" + uniqueName;
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    public static boolean delete(HttpServletRequest request, String fileName) {
        if (fileName == null || fileName.isEmpty()) return false;
        try {
            // If fileName is full url, extract just the object name
            if (fileName.startsWith(MINIO_URL)) {
                fileName = fileName.substring(fileName.lastIndexOf("/") + 1);
            }
            minioClient.removeObject(
                RemoveObjectArgs.builder()
                    .bucket(BUCKET_NAME)
                    .object(fileName)
                    .build()
            );
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
