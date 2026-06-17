package chez1s.assignment.util;

import jakarta.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

public final class ParamUtil {
    public static String getString(HttpServletRequest request, String name) {
        String val = request.getParameter(name);
        return (val != null) ? val.trim() : "";
    }

    public static int getInt(HttpServletRequest request, String name) {
        try {
            return Integer.parseInt(request.getParameter(name));
        } catch (Exception e) {
            return 0;
        }
    }

    public static Date getDate(HttpServletRequest request, String name, String pattern) {
        try {
            String value = request.getParameter(name);
            if (value == null || value.isEmpty()) return null;
            return new SimpleDateFormat(pattern).parse(value);
        } catch (Exception e) {
            return null;
        }
    }
}
