<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%>
<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />
<!DOCTYPE html>
<html lang="${empty sessionScope.lang ? 'vi' : sessionScope.lang}">
<head>
    <title>Profile - PolyCoffee</title>
    <jsp:include page="/views/common/head.jsp" />
</head>
<body class="bg-nocturnal min-h-screen font-sans">
    <div class="relative z-50 border-b border-white/5 bg-black/20 backdrop-blur-md">
        <jsp:include page="/views/common/header.jsp" />
    </div>

    <main class="max-w-2xl mx-auto px-4 py-20 pt-32">
        <div class="bg-white/5 backdrop-blur-xl border border-white/10 rounded-3xl p-8 shadow-2xl">
            <!-- Avatar -->
            <div class="flex flex-col items-center mb-8">
                <div class="w-24 h-24 rounded-full bg-gradient-to-br from-amber-400 to-amber-600 text-black flex items-center justify-center font-black text-4xl shadow-2xl shadow-amber-900/30 mb-4">
                    ${fn:substring(sessionScope.user.fullName, 0, 1)}
                </div>
                <h1 class="text-3xl font-black text-white tracking-tight">${sessionScope.user.fullName}</h1>
                <span class="mt-2 text-xs font-bold uppercase tracking-widest px-3 py-1 rounded-full border ${sessionScope.user.role ? 'bg-purple-500/10 text-purple-300 border-purple-500/20' : 'bg-amber-500/10 text-amber-300 border-amber-500/20'}">
                    ${sessionScope.user.role ? 'Manager' : 'Staff'}
                </span>
            </div>

            <!-- Info -->
            <div class="space-y-4">
                <div class="bg-white/5 rounded-2xl p-4 border border-white/10 flex justify-between items-center">
                    <span class="text-gray-400 text-sm font-medium">Email</span>
                    <span class="text-white font-bold">${sessionScope.user.email}</span>
                </div>
                <div class="bg-white/5 rounded-2xl p-4 border border-white/10 flex justify-between items-center">
                    <span class="text-gray-400 text-sm font-medium">Phone</span>
                    <span class="text-white font-bold">${empty sessionScope.user.phone ? '—' : sessionScope.user.phone}</span>
                </div>
                <div class="bg-white/5 rounded-2xl p-4 border border-white/10 flex justify-between items-center">
                    <span class="text-gray-400 text-sm font-medium">Status</span>
                    <span class="font-bold ${sessionScope.user.active ? 'text-emerald-400' : 'text-red-400'}">${sessionScope.user.active ? 'Active' : 'Inactive'}</span>
                </div>
            </div>

            <!-- Actions -->
            <div class="flex gap-4 mt-8">
                <a href="${pageContext.request.contextPath}/employee/pos"
                   class="flex-1 py-3 bg-amber-500 hover:bg-amber-400 text-black font-black rounded-2xl text-center transition-all active:scale-95 shadow-lg shadow-amber-900/20">
                    Go to POS
                </a>
                <a href="${pageContext.request.contextPath}/auth/logout"
                   class="flex-1 py-3 bg-white/5 hover:bg-red-500/20 text-red-400 hover:text-red-300 border border-white/10 hover:border-red-500/30 font-bold rounded-2xl text-center transition-all active:scale-95">
                    Logout
                </a>
            </div>
        </div>
    </main>
</body>
</html>
