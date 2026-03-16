<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html class="h-full bg-gray-50">
<head>
    <title><fmt:message key="error.gen.title"/> - PolyCoffee</title>
    <jsp:include page="/views/common/head.jsp" />
</head>
<body class="bg-gray-50 font-sans h-full flex flex-col items-center justify-center">
    
    <div class="max-w-3xl text-center px-6">
        <div class="mb-10 text-yellow-500">
            <i class="bi bi-exclamation-triangle-fill text-8xl"></i>
        </div>

        <h1 class="text-4xl font-bold text-gray-900 mb-6"><fmt:message key="error.gen.h1"/></h1>
        <p class="text-gray-500 text-lg mb-12 max-w-md mx-auto">
            <fmt:message key="error.gen.desc"/>
        </p>

        <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <a href="${pageContext.request.contextPath}/" class="bg-coffee-700 hover:bg-coffee-800 text-white px-8 py-3.5 rounded-xl font-bold transition-all shadow-sm flex items-center justify-center gap-2">
                <fmt:message key="error.404.home"/> <i class="bi bi-house"></i>
            </a>
            <button onclick="history.back()" class="bg-white hover:bg-gray-50 text-gray-700 border border-gray-200 px-8 py-3.5 rounded-xl font-bold transition-all shadow-sm flex items-center justify-center gap-2">
                <fmt:message key="error.404.back"/> <i class="bi bi-arrow-left"></i>
            </button>
        </div>

        <div class="mt-12 text-left bg-white border border-gray-200 rounded-xl overflow-hidden shadow-sm">
            <div class="bg-gray-50 px-6 py-3 border-b border-gray-200 flex justify-between items-center">
                <span class="text-[10px] font-bold text-gray-400 uppercase tracking-widest">Exception Journal</span>
                <span class="text-[10px] bg-gray-200 px-2 py-0.5 rounded text-gray-500 font-mono">${pageContext.errorPage}</span>
            </div>
            <div class="p-6 max-h-[240px] overflow-auto">
                <c:if test="${not empty exception}">
                    <p class="font-bold text-sm mb-3 text-red-700">${exception.getClass().name}: ${exception.message}</p>
                    <pre class="text-[10px] text-gray-500 font-mono whitespace-pre-wrap leading-relaxed">
                        <c:forEach var="trace" items="${exception.stackTrace}">
                            at ${trace}
                        </c:forEach>
                    </pre>
                </c:if>
                <c:if test="${empty exception}">
                    <p class="text-gray-400 italic text-sm">No explicit stack traces were captured for this event.</p>
                </c:if>
            </div>
        </div>
    </div>

    <div class="fixed bottom-10 text-[10px] font-bold tracking-widest uppercase text-gray-400">
        &copy; 2026 PolyCoffee
    </div>

</body>
</html>
