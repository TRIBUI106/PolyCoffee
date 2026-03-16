<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />
<!DOCTYPE html>
<html class="h-full">
<head>
    <title><fmt:message key="login.title"/></title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { cream: '#FDF7E4', coffee: { 700: '#6F4E37' }, mocha: '#2D2424' },
                    fontFamily: { sans: ['Outfit', 'sans-serif'] }
                }
            }
        }
    </script>
</head>
<body class="bg-cream font-sans h-full flex items-center justify-center px-4 relative overflow-hidden">
    
    <!-- Background Decor -->
    <div class="absolute -top-24 -left-24 w-96 h-96 bg-coffee-700/5 rounded-full blur-3xl"></div>
    <div class="absolute -bottom-24 -right-24 w-96 h-96 bg-coffee-700/5 rounded-full blur-3xl"></div>

    <div class="w-full max-w-md relative">
        <div class="bg-white/70 backdrop-blur-xl border border-white/20 p-10 rounded-[2rem] shadow-2xl">
            <div class="text-center mb-10">
                <div class="inline-flex bg-coffee-700 p-4 rounded-2xl mb-6 shadow-xl shadow-coffee-700/20">
                    <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 21l-8-4.5v-9L12 3l8 4.5v9z" />
                    </svg>
                </div>
                <h1 class="text-3xl font-bold text-mocha mb-2"><fmt:message key="login.welcome"/></h1>
                <p class="text-mocha/40 font-medium"><fmt:message key="login.subtitle"/></p>
            </div>
            
            <c:if test="${not empty errorKey}">
                <div class="bg-red-50 text-red-500 p-4 rounded-2xl text-sm font-bold mb-6 border border-red-100 flex items-center gap-2">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                    </svg>
                    <fmt:message key="${errorKey}"/>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/auth/login" method="post" class="space-y-6">
                <div>
                    <label class="block text-xs font-bold text-mocha/40 uppercase tracking-widest mb-2 pl-1"><fmt:message key="login.email"/></label>
                    <input type="email" name="email" required placeholder="name@polycoffee.com"
                           class="w-full bg-coffee-50/50 border-0 px-5 py-4 rounded-2xl focus:ring-2 focus:ring-coffee-700/20 outline-none transition-all placeholder:text-mocha/20 text-mocha font-medium">
                </div>
                
                <div>
                    <label class="block text-xs font-bold text-mocha/40 uppercase tracking-widest mb-2 pl-1"><fmt:message key="login.password"/></label>
                    <input type="password" name="password" required placeholder="••••••••"
                           class="w-full bg-coffee-50/50 border-0 px-5 py-4 rounded-2xl focus:ring-2 focus:ring-coffee-700/20 outline-none transition-all placeholder:text-mocha/20 text-mocha font-medium">
                </div>

                <button type="submit" 
                        class="w-full bg-coffee-700 text-white rounded-2xl py-4 font-bold text-lg shadow-xl shadow-coffee-700/30 hover:bg-mocha hover:-translate-y-1 transition-all active:scale-95">
                    <fmt:message key="login.btn"/>
                </button>
            </form>
            
            <div class="mt-10 text-center">
                <a href="${pageContext.request.contextPath}/" class="text-mocha/30 hover:text-coffee-700 text-sm font-bold transition-colors flex items-center justify-center gap-2">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M15 19l-7-7 7-7" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>
                    <fmt:message key="login.back"/>
                </a>
            </div>
        </div>
    </div>
</body>
</html>
