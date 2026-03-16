<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html class="h-full bg-gray-50">
<head>
    <title><fmt:message key="admin.drink.title"/> - PolyCoffee</title>
</head>
<body class="bg-gray-50 font-sans min-h-screen text-gray-800">
    <jsp:include page="../common/header.jsp" />

    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <div class="flex flex-col md:flex-row md:items-end justify-between gap-6 mb-10">
            <div>
                <h1 class="text-3xl font-bold text-gray-900 tracking-tight mb-2"><fmt:message key="admin.drink.subtitle"/></h1>
                <p class="text-gray-500"><fmt:message key="admin.drink.desc"/></p>
            </div>
            <a href="${pageContext.request.contextPath}/manager/drinks/form" class="bg-coffee-700 hover:bg-coffee-800 text-white font-semibold py-3 px-6 rounded-xl transition-all shadow-sm flex items-center gap-2 group">
                <i class="bi bi-plus-circle"></i>
                <fmt:message key="admin.drink.btn.add"/>
            </a>
        </div>

        <div class="bg-white border border-gray-200 overflow-hidden rounded-2xl shadow-sm">
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="bg-gray-50/50 border-b border-gray-200">
                            <th class="px-8 py-5 text-xs font-bold text-gray-500 uppercase tracking-wider"><fmt:message key="admin.drink.table.info"/></th>
                            <th class="px-6 py-5 text-xs font-bold text-gray-500 uppercase tracking-wider"><fmt:message key="admin.drink.table.category"/></th>
                            <th class="px-6 py-5 text-xs font-bold text-gray-500 uppercase tracking-wider"><fmt:message key="admin.drink.table.price"/></th>
                            <th class="px-6 py-5 text-xs font-bold text-gray-500 uppercase tracking-wider text-center"><fmt:message key="admin.drink.table.status"/></th>
                            <th class="px-8 py-5 text-xs font-bold text-gray-500 uppercase tracking-wider text-right"><fmt:message key="admin.drink.table.action"/></th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-100">
                        <c:forEach var="d" items="${drinks}">
                            <tr class="hover:bg-gray-50 transition-colors group">
                                <td class="px-8 py-5">
                                    <div class="flex items-center gap-5">
                                        <div class="w-16 h-16 rounded-xl border border-gray-100 overflow-hidden flex-shrink-0 bg-gray-50">
                                            <c:choose>
                                                <c:when test="${not empty d.image}">
                                                    <c:set var="imgUrl" value="${fn:startsWith(d.image, 'http') ? d.image : pageContext.request.contextPath.concat('/uploads/').concat(d.image)}" />
                                                    <img src="${imgUrl}" class="w-full h-full object-cover">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="w-full h-full flex items-center justify-center text-gray-300 text-2xl">
                                                        <i class="bi bi-image"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div>
                                            <div class="font-bold text-gray-900 text-base mb-1">${d.name}</div>
                                            <div class="text-xs font-medium text-gray-500 line-clamp-1 max-w-[250px]">${d.description}</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-5 align-middle">
                                    <span class="bg-gray-100 text-gray-600 text-[11px] font-bold px-3 py-1.5 rounded-lg border border-gray-200 uppercase">
                                        ${d.category.name}
                                    </span>
                                </td>
                                <td class="px-6 py-5 align-middle">
                                    <div class="font-black text-gray-900"><fmt:formatNumber value="${d.price}" pattern="#,###"/> <span class="text-[10px] text-gray-500 ml-0.5">VNĐ</span></div>
                                </td>
                                <td class="px-6 py-5 align-middle text-center">
                                    <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold ${d.active ? 'bg-green-50 text-green-700 border border-green-200' : 'bg-gray-50 text-gray-500 border border-gray-200'}">
                                        <span class="w-1.5 h-1.5 rounded-full ${d.active ? 'bg-green-500' : 'bg-gray-400'}"></span>
                                        ${d.active ? '<fmt:message key="admin.drink.status.selling"/>' : '<fmt:message key="admin.drink.status.suspended"/>'}
                                    </span>
                                </td>
                                <td class="px-8 py-5 align-middle text-right">
                                    <div class="flex items-center justify-end gap-2 opacity-100 md:opacity-0 md:group-hover:opacity-100 transition-opacity">
                                        <a href="${pageContext.request.contextPath}/manager/drinks/form?id=${d.id}" 
                                           class="w-9 h-9 flex items-center justify-center rounded-lg bg-white text-gray-600 hover:bg-blue-500 hover:text-white shadow-sm border border-gray-200 hover:border-blue-500 transition-all">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/manager/drinks/delete?id=${d.id}" 
                                           onclick="return confirm('<fmt:message key="admin.drink.confirm.delete"/>')"
                                           class="w-9 h-9 flex items-center justify-center rounded-lg bg-white text-red-500 hover:bg-red-500 hover:text-white shadow-sm border border-gray-200 hover:border-red-500 transition-all">
                                            <i class="bi bi-trash3"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <c:if test="${empty drinks}">
                <div class="py-24 text-center text-gray-400">
                    <i class="bi bi-inbox text-5xl block mb-4"></i>
                    <p class="font-medium"><fmt:message key="admin.drink.empty"/></p>
                </div>
            </c:if>
        </div>
    </main>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
