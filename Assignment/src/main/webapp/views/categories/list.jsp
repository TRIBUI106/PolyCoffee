<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html class="h-full bg-gray-50">
<head>
    <title><fmt:message key="admin.category.title"/> - PolyCoffee</title>
</head>
<body class="bg-gray-50 font-sans min-h-screen text-gray-800">
    <jsp:include page="../common/header.jsp" />

    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <div class="mb-10">
            <h1 class="text-3xl font-bold text-gray-900 tracking-tight"><fmt:message key="admin.category.title"/></h1>
            <p class="text-gray-500 mt-2"><fmt:message key="admin.category.subtitle"/></p>
        </div>
        
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
            <!-- Form Card (4 cols) -->
            <div class="lg:col-span-4">
                <div class="bg-white border border-gray-200 p-6 rounded-2xl shadow-sm sticky top-24">
                    <h2 class="text-lg font-bold text-gray-900 mb-5 flex items-center gap-2">
                        <span class="w-1.5 h-6 bg-coffee-700 rounded-full"></span>
                        <c:choose>
                            <c:when test="${category == null}"><fmt:message key="admin.category.add"/></c:when>
                            <c:otherwise><fmt:message key="admin.category.edit"/></c:otherwise>
                        </c:choose>
                    </h2>
                    
                    <form action="${pageContext.request.contextPath}/manager/categories/save" method="post" class="space-y-5">
                        <input type="hidden" name="id" value="${category.id}">
                        <div>
                            <label class="block text-xs font-bold text-gray-500 uppercase tracking-widest mb-1.5"><fmt:message key="admin.category.name.label"/></label>
                            <input type="text" name="name" value="${category.name}" required placeholder="<fmt:message key='admin.category.name.placeholder'/>"
                                   class="w-full bg-gray-50 border border-gray-200 px-4 py-3 rounded-xl focus:ring-2 focus:ring-coffee-500 focus:border-coffee-500 outline-none transition-all placeholder:text-gray-400 font-medium">
                        </div>
                        
                        <div class="flex flex-col gap-3 pt-2">
                            <button type="submit" class="bg-coffee-700 hover:bg-coffee-800 text-white font-semibold py-3 px-4 rounded-xl transition-colors shadow-sm focus:ring-2 focus:ring-offset-2 focus:ring-coffee-700 flex justify-center items-center gap-2">
                                <i class="bi bi-floppy"></i>
                                <c:choose>
                                    <c:when test="${category == null}"><fmt:message key="admin.category.btn.save"/></c:when>
                                    <c:otherwise><fmt:message key="admin.category.btn.update"/></c:otherwise>
                                </c:choose>
                            </button>
                            <c:if test="${category != null}">
                                <a href="${pageContext.request.contextPath}/manager/categories" 
                                   class="bg-white hover:bg-gray-50 border border-gray-200 text-gray-700 font-semibold py-3 px-4 rounded-xl text-center transition-colors">
                                   <fmt:message key="admin.category.btn.cancel"/>
                                </a>
                            </c:if>
                        </div>
                    </form>
                </div>
            </div>

            <!-- List Space (8 cols) -->
            <div class="lg:col-span-8 flex flex-col gap-6">
                <!-- Count Card -->
                <div class="bg-white border border-gray-200 p-5 rounded-2xl flex items-center justify-between shadow-sm">
                    <div class="flex items-center gap-4">
                        <div class="bg-coffee-50 p-3.5 rounded-xl text-coffee-700">
                            <i class="bi bi-collection text-xl"></i>
                        </div>
                        <div>
                            <div class="text-[10px] font-bold text-gray-400 uppercase tracking-widest"><fmt:message key="admin.category.stat.active"/></div>
                            <div class="text-2xl font-bold text-gray-900"><c:out value="${categories.size()}"/> <span class="text-sm font-semibold text-gray-500"><fmt:message key="admin.category.stat.groups"/></span></div>
                        </div>
                    </div>
                </div>

                <!-- Table Container -->
                <div class="bg-white border border-gray-200 overflow-hidden rounded-2xl shadow-sm hidden md:block">
                    <div class="overflow-x-auto">
                        <table class="w-full text-left border-collapse">
                            <thead>
                                <tr class="bg-gray-50/50 border-b border-gray-200">
                                    <th class="px-6 py-4 text-[10px] font-bold text-gray-400 uppercase tracking-wider"><fmt:message key="admin.category.table.id"/></th>
                                    <th class="px-6 py-4 text-[10px] font-bold text-gray-400 uppercase tracking-wider"><fmt:message key="admin.category.table.name"/></th>
                                    <th class="px-6 py-4 text-[10px] font-bold text-gray-400 uppercase tracking-wider text-center"><fmt:message key="admin.category.table.status"/></th>
                                    <th class="px-6 py-4 text-[10px] font-bold text-gray-400 uppercase tracking-wider text-right"><fmt:message key="admin.category.table.actions"/></th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                                <c:forEach var="cat" items="${categories}">
                                    <tr class="hover:bg-gray-50 transition-colors group">
                                        <td class="px-6 py-4 align-middle">
                                            <span class="bg-gray-100 text-gray-600 text-xs font-semibold px-2.5 py-1 rounded-md">ID-${cat.id}</span>
                                        </td>
                                        <td class="px-6 py-4 align-middle">
                                            <div class="font-bold text-gray-900">${cat.name}</div>
                                        </td>
                                        <td class="px-6 py-4 align-middle text-center">
                                            <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-[10px] font-bold border ${cat.active ? 'bg-green-50 text-green-700 border-green-200' : 'bg-red-50 text-red-700 border-red-200'}">
                                                <span class="w-1.5 h-1.5 rounded-full ${cat.active ? 'bg-green-500' : 'bg-red-500'}"></span>
                                                ${cat.active ? '<fmt:message key="admin.category.status.show"/>' : '<fmt:message key="admin.category.status.hide"/>'}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 align-middle text-right w-24">
                                            <div class="flex items-center justify-end gap-2 opacity-100 md:opacity-0 md:group-hover:opacity-100 transition-opacity">
                                                <a href="?id=${cat.id}" class="w-8 h-8 flex items-center justify-center rounded-lg bg-blue-50 text-blue-600 hover:bg-blue-600 hover:text-white transition-all shadow-sm">
                                                    <i class="bi bi-pencil-square"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/manager/categories/delete?id=${cat.id}" 
                                                   onclick="return confirm('<fmt:message key="admin.category.confirm.delete"/>')"
                                                   class="w-8 h-8 flex items-center justify-center rounded-lg bg-red-50 text-red-600 hover:bg-red-600 hover:text-white transition-all shadow-sm">
                                                    <i class="bi bi-trash3"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <!-- Mobile List view -->
                <div class="md:hidden space-y-4">
                    <c:forEach var="cat" items="${categories}">
                        <div class="bg-white border border-gray-200 rounded-xl p-4 shadow-sm flex items-center justify-between">
                            <div>
                                <div class="font-bold text-gray-900 text-lg mb-1">${cat.name}</div>
                                <span class="bg-gray-100 text-gray-600 text-xs font-semibold px-2 py-0.5 rounded-md inline-block mb-2">ID-${cat.id}</span>
                                <div>
                                    <span class="inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-[10px] font-bold border ${cat.active ? 'bg-green-50 text-green-700 border-green-200' : 'bg-red-50 text-red-700 border-red-200'}">
                                        <span class="w-1 h-1 rounded-full ${cat.active ? 'bg-green-500' : 'bg-red-500'}"></span>
                                        ${cat.active ? '<fmt:message key="admin.category.status.show"/>' : '<fmt:message key="admin.category.status.hide"/>'}
                                    </span>
                                </div>
                            </div>
                            <div class="flex flex-col gap-2">
                                <a href="?id=${cat.id}" class="w-9 h-9 flex items-center justify-center rounded-lg bg-blue-50 text-blue-600 active:bg-blue-600 active:text-white transition-all">
                                    <i class="bi bi-pencil-square"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/manager/categories/delete?id=${cat.id}" 
                                   onclick="return confirm('<fmt:message key="admin.category.confirm.delete"/>')"
                                   class="w-9 h-9 flex items-center justify-center rounded-lg bg-red-50 text-red-600 active:bg-red-600 active:text-white transition-all">
                                    <i class="bi bi-trash3"></i>
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
