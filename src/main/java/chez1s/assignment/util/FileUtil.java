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
    private static final String ACCESS_KEY = "admin";
    private static final String SECRET_KEY = "123456789";

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
            
            // Always set bucket policy to public for read-only access to ensure images are visible
            String policy = "{\n" +
                    "  \"Version\": \"2012-10-17\",\n" +
                    "  \"Statement\": [\n" +
                    "    {\n" +
                    "      \"Effect\": \"Allow\",\n" +
                    "      \"Principal\": { \"AWS\": [ \"*\" ] },\n" +
                    "      \"Action\": [ \"s3:GetBucketLocation\", \"s3:ListBucket\" ],\n" +
                    "      \"Resource\": [ \"arn:aws:s3:::" + BUCKET_NAME + "\" ]\n" +
                    "    },\n" +
                    "    {\n" +
                    "      \"Effect\": \"Allow\",\n" +
                    "      \"Principal\": { \"AWS\": [ \"*\" ] },\n" +
                    "      \"Action\": [ \"s3:GetObject\" ],\n" +
                    "      \"Resource\": [ \"arn:aws:s3:::" + BUCKET_NAME + "/*\" ]\n" +
                    "    }\n" +
                    "  ]\n" +
                    "}";
            minioClient.setBucketPolicy(
                io.minio.SetBucketPolicyArgs.builder().bucket(BUCKET_NAME).config(policy).build());
        } catch (Exception e) {
            System.err.println("Error initializing MinIO: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static String upload(HttpServletRequest request, String name) {
        if (minioClient == null) {
            System.err.println("MinIO Client not initialized!");
            return "";
        }
        try {
            Part part = request.getPart(name);
            if (part == null || part.getSize() <= 0)
                return "";

            String fileName = part.getSubmittedFileName();
            if (fileName == null || fileName.isEmpty())
                return "";

            String ext = "";
            int dotIdx = fileName.lastIndexOf(".");
            if (dotIdx >= 0) {
                ext = fileName.substring(dotIdx);
            }
            
            // Sanitize filename to be alphanumeric
            String safeBaseName = fileName.substring(0, dotIdx >= 0 ? dotIdx : fileName.length())
                                         .replaceAll("[^a-zA-Z0-9]", "_");
            
            String uniqueName = System.currentTimeMillis() + "_" + safeBaseName + ext;

            try (InputStream is = part.getInputStream()) {
                minioClient.putObject(
                        PutObjectArgs.builder()
                                .bucket(BUCKET_NAME)
                                .object(uniqueName)
                                .stream(is, part.getSize(), -1)
                                .contentType(part.getContentType())
                                .build());
            }

            // Return only the object name, the ImageServlet will handle proxying
            return uniqueName;
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    public static boolean delete(HttpServletRequest request, String fileName) {
        if (fileName == null || fileName.isEmpty())
            return false;
        try {
            // If fileName is full url, extract just the object name
            if (fileName.startsWith(MINIO_URL)) {
                fileName = fileName.substring(fileName.lastIndexOf("/") + 1);
            }
            minioClient.removeObject(
                    RemoveObjectArgs.builder()
                            .bucket(BUCKET_NAME)
                            .object(fileName)
                            .build());
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static InputStream getFile(String fileName) {
        if (minioClient == null || fileName == null || fileName.isEmpty())
            return null;
        try {
            // If fileName is full url, extract just the object name
            if (fileName.startsWith(MINIO_URL)) {
                fileName = fileName.substring(fileName.lastIndexOf("/") + 1);
            }
            return minioClient.getObject(
                    io.minio.GetObjectArgs.builder()
                            .bucket(BUCKET_NAME)
                            .object(fileName)
                            .build());
        } catch (Exception e) {
            return null;
        }
    }
}
