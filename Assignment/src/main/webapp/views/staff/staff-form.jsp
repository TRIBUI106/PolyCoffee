<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html class="h-full bg-gray-50">
<head>
    <title><fmt:message key="${staff == null ? 'admin.staff.form.title.add' : 'admin.staff.form.title.edit'}"/> - PolyCoffee</title>
</head>
<body class="bg-gray-50 font-sans min-h-screen text-gray-800">
    <jsp:include page="../common/header.jsp" />

    <main class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <div class="flex items-center justify-between mb-8">
            <a href="${pageContext.request.contextPath}/manager/staff" class="group flex items-center gap-2 text-gray-500 hover:text-coffee-700 transition-colors font-semibold text-sm tracking-wide">
                <i class="bi bi-arrow-left transition-transform group-hover:-translate-x-1"></i>
                <fmt:message key="admin.staff.form.back"/>
            </a>
            <div class="text-right">
                <h1 class="text-2xl font-bold text-gray-900"><fmt:message key="${staff == null ? 'admin.staff.form.title.add' : 'admin.staff.form.title.edit'}"/></h1>
                <p class="text-gray-500 font-medium text-xs mt-1 tracking-widest uppercase"><fmt:message key="admin.staff.form.subtitle"/></p>
            </div>
        </div>

        <div class="bg-white p-8 sm:p-10 rounded-2xl shadow-sm border border-gray-200">

            <c:if test="${not empty error}">
                <div class="bg-red-50 text-red-600 p-4 rounded-xl text-sm font-semibold mb-8 border border-red-200 flex items-center gap-3">
                    <i class="bi bi-exclamation-octagon text-lg"></i>
                    ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/manager/staff/save" method="post" class="space-y-8">
                <input type="hidden" name="id" value="${staff.id}">
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                    <!-- Primary Identity -->
                    <div class="space-y-6">
                        <div>
                            <label class="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-2"><fmt:message key="admin.staff.form.name"/></label>
                            <input type="text" name="fullName" value="${staff.fullName}" required placeholder="<fmt:message key="admin.staff.form.name.ph"/>"
                                   class="w-full bg-gray-50 border border-gray-200 px-5 py-3.5 rounded-xl focus:ring-2 focus:ring-coffee-500/20 focus:border-coffee-500 focus:bg-white outline-none transition-all font-semibold text-gray-900">
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-2"><fmt:message key="admin.staff.form.phone"/></label>
                            <input type="text" name="phone" value="${staff.phone}" required pattern="0[0-9]{9}" placeholder="0987 654 321"
                                   class="w-full bg-gray-50 border border-gray-200 px-5 py-3.5 rounded-xl focus:ring-2 focus:ring-coffee-500/20 focus:border-coffee-500 focus:bg-white outline-none transition-all font-semibold text-gray-900">
                        </div>
                    </div>

                    <!-- System Access -->
                    <div class="space-y-6">
                        <c:if test="${staff == null}">
                            <div>
                                <label class="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-2"><fmt:message key="admin.staff.form.email"/></label>
                                <input type="email" name="email" value="${staff.email}" required placeholder="staff@polycoffee.com"
                                       class="w-full bg-gray-50 border border-gray-200 px-5 py-3.5 rounded-xl focus:ring-2 focus:ring-coffee-500/20 focus:border-coffee-500 focus:bg-white outline-none transition-all font-semibold text-gray-900">
                            </div>
                            <div>
                                <label class="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-2"><fmt:message key="admin.staff.form.pass"/></label>
                                <input type="password" name="password" required placeholder="<fmt:message key="admin.staff.form.pass.ph"/>" minlength="6"
                                       class="w-full bg-gray-50 border border-gray-200 px-5 py-3.5 rounded-xl focus:ring-2 focus:ring-coffee-500/20 focus:border-coffee-500 focus:bg-white outline-none transition-all font-semibold text-gray-900">
                            </div>
                        </c:if>
                        
                        <c:if test="${staff != null}">
                            <div class="p-6 rounded-xl bg-gray-50 border border-gray-200 flex flex-col justify-center h-full">
                                <div class="text-xs font-bold text-gray-500 uppercase tracking-wider mb-2"><i class="bi bi-shield-lock mr-1.5"></i><fmt:message key="admin.staff.form.sec.title"/></div>
                                <p class="text-sm text-gray-600 font-medium leading-relaxed"><fmt:message key="admin.staff.form.sec.desc"/></p>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Footer Operations -->
                <div class="pt-8 border-t border-gray-100 flex flex-col md:flex-row items-center justify-between gap-6">
                    <div class="flex flex-col sm:flex-row items-start sm:items-center gap-4">
                        <span class="text-xs font-bold text-gray-500 uppercase tracking-wider"><fmt:message key="admin.staff.form.status"/></span>
                        <div class="flex gap-4">
                            <label class="flex items-center gap-2.5 cursor-pointer group">
                                <input type="radio" name="active" value="1" ${staff.active || staff == null ? 'checked' : ''} class="peer hidden">
                                <div class="w-5 h-5 rounded-full border border-gray-300 peer-checked:border-coffee-600 peer-checked:bg-coffee-600 transition-all flex items-center justify-center">
                                    <div class="w-2 h-2 rounded-full bg-white opacity-0 peer-checked:opacity-100 transition-opacity"></div>
                                </div>
                                <span class="text-sm font-semibold text-gray-500 peer-checked:text-gray-900 group-hover:text-gray-900 transition-colors"><fmt:message key="admin.staff.form.status.active"/></span>
                            </label>
                            <label class="flex items-center gap-2.5 cursor-pointer group">
                                <input type="radio" name="active" value="0" ${not staff.active && staff != null ? 'checked' : ''} class="peer hidden">
                                <div class="w-5 h-5 rounded-full border border-gray-300 peer-checked:border-red-600 peer-checked:bg-red-600 transition-all flex items-center justify-center">
                                    <div class="w-2 h-2 rounded-full bg-white opacity-0 peer-checked:opacity-100 transition-opacity"></div>
                                </div>
                                <span class="text-sm font-semibold text-gray-500 peer-checked:text-gray-900 group-hover:text-gray-900 transition-colors"><fmt:message key="admin.staff.form.status.locked"/></span>
                            </label>
                        </div>
                    </div>

                    <div class="w-full md:w-auto">
                        <button type="submit" class="w-full md:w-auto bg-coffee-700 hover:bg-coffee-800 text-white font-bold py-3.5 px-8 rounded-xl shadow-sm transition-colors">
                            <fmt:message key="admin.staff.form.btn.save"/>
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </main>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
