package com.poly.lab4.util;

import jakarta.servlet.http.HttpServletRequest;

public class ParamUtil {

    public static int getInt(HttpServletRequest request, String name, int defaultValue){

        try{
            return Integer.parseInt(request.getParameter(name));
        }catch(Exception e){
            return defaultValue;
        }

    }

    public static String getString(HttpServletRequest request, String name, String defaultValue){

        String value = request.getParameter(name);

        if(value == null || value.trim().isEmpty()){
            return defaultValue;
        }

        return value;
    }

    public static boolean getBoolean(HttpServletRequest request, String name, boolean defaultValue){

        try{
            return Boolean.parseBoolean(request.getParameter(name));
        }catch(Exception e){
            return defaultValue;
        }
    }
}