<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html class="h-full bg-gray-50">
<head>
    <title><fmt:message key="error.404.title"/> - PolyCoffee</title>
    <jsp:include page="/views/common/head.jsp" />
</head>
<body class="bg-gray-50 font-sans h-full flex flex-col items-center justify-center">
    
    <div class="max-w-2xl text-center px-6">
        <div class="mb-10 text-coffee-700 animate-bounce">
            <i class="bi bi-cup-hot text-8xl"></i>
        </div>

        <h1 class="text-7xl font-bold text-gray-900 mb-4 opacity-10 select-none">404</h1>
        <h2 class="text-4xl font-bold text-gray-900 mb-6"><fmt:message key="error.404.h1"/></h2>
        <p class="text-gray-500 text-lg mb-12 max-w-md mx-auto">
            <fmt:message key="error.404.desc"/>
        </p>

        <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <a href="${pageContext.request.contextPath}/" class="bg-coffee-700 hover:bg-coffee-800 text-white px-8 py-3.5 rounded-xl font-bold transition-all shadow-sm flex items-center justify-center gap-2">
                <fmt:message key="error.404.home"/> <i class="bi bi-house"></i>
            </a>
            <button onclick="history.back()" class="bg-white hover:bg-gray-50 text-gray-700 border border-gray-200 px-8 py-3.5 rounded-xl font-bold transition-all shadow-sm flex items-center justify-center gap-2">
                <fmt:message key="error.404.back"/> <i class="bi bi-arrow-left"></i>
            </button>
        </div>
    </div>

    <div class="fixed bottom-10 text-[10px] font-bold tracking-widest uppercase text-gray-400">
        &copy; 2026 PolyCoffee
    </div>

</body>
</html>
