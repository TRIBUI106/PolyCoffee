<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html class="h-full bg-gray-50">
<head>
    <title><fmt:message key="admin.staff.title"/> - PolyCoffee</title>
</head>
<body class="bg-gray-50 font-sans min-h-screen text-gray-800">
    <jsp:include page="../common/header.jsp" />

    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <div class="flex flex-col md:flex-row md:items-end justify-between gap-6 mb-10">
            <div>
                <h1 class="text-3xl font-bold text-gray-900 tracking-tight mb-2"><fmt:message key="admin.staff.title"/></h1>
                <p class="text-gray-500 font-medium text-xs tracking-widest uppercase"><fmt:message key="admin.staff.subtitle"/></p>
            </div>
            <a href="${pageContext.request.contextPath}/manager/staff/form" class="bg-coffee-700 hover:bg-coffee-800 text-white font-semibold py-3 px-6 rounded-xl transition-all shadow-sm flex items-center gap-2 group">
                <i class="bi bi-person-plus group-hover:scale-110 transition-transform"></i>
                <fmt:message key="admin.staff.btn.add"/>
            </a>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach var="s" items="${staffList}">
                <div class="group bg-white p-6 rounded-2xl border border-gray-200 transition-all hover:-translate-y-1 hover:shadow-md shadow-sm">
                    <div class="flex items-start justify-between mb-6">
                        <div class="w-14 h-14 rounded-xl bg-gray-50 flex items-center justify-center text-coffee-700 text-xl font-black border border-gray-100">
                            ${fn:substring(s.fullName, 0, 1)}
                        </div>
                        <div class="flex flex-col items-end">
                            <span class="px-2.5 py-1 rounded-md text-[10px] font-bold border ${s.active ? 'bg-green-50 text-green-700 border-green-200' : 'bg-red-50 text-red-700 border-red-200'}">
                                ${s.active ? '<fmt:message key="admin.staff.status.active"/>' : '<fmt:message key="admin.staff.status.locked"/>'}
                            </span>
                            <span class="text-[10px] font-bold text-gray-400 mt-2 uppercase tracking-tight">ID: #0${s.id}</span>
                        </div>
                    </div>

                    <div class="mb-6">
                        <h3 class="text-lg font-bold text-gray-900 mb-1 group-hover:text-coffee-700 transition-colors">${s.fullName}</h3>
                        <p class="text-gray-500 text-sm font-medium flex items-center gap-2">
                            <i class="bi bi-envelope text-gray-400"></i> ${s.email}
                        </p>
                        <p class="text-gray-500 text-sm font-medium flex items-center gap-2 mt-1">
                            <i class="bi bi-telephone text-gray-400"></i> ${s.phone}
                        </p>
                    </div>

                    <div class="pt-5 border-t border-gray-100 flex items-center justify-between">
                        <div class="flex gap-2">
                            <a href="${pageContext.request.contextPath}/manager/staff/form?id=${s.id}" class="w-9 h-9 rounded-lg bg-blue-50 text-blue-600 hover:bg-blue-600 hover:text-white flex items-center justify-center transition-all shadow-sm">
                                <i class="bi bi-pencil-square"></i>
                            </a>
                        </div>
                        <c:choose>
                            <c:when test="${s.active}">
                                <a href="${pageContext.request.contextPath}/manager/staff/status?id=${s.id}&active=0" 
                                   class="px-4 py-2 rounded-lg text-xs font-bold bg-white border border-red-200 text-red-600 hover:bg-red-50 hover:border-red-300 transition-colors shadow-sm">
                                   <fmt:message key="admin.staff.btn.lock"/>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/manager/staff/status?id=${s.id}&active=1" 
                                   class="px-4 py-2 rounded-lg text-xs font-bold bg-emerald-600 text-white hover:bg-emerald-700 transition-colors shadow-sm cursor-pointer">
                                   <fmt:message key="admin.staff.btn.unlock"/>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty staffList}">
            <div class="py-24 text-center text-gray-400">
                <i class="bi bi-people text-5xl block mb-4"></i>
                <p class="font-medium"><fmt:message key="admin.staff.empty"/></p>
            </div>
        </c:if>
    </main>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
