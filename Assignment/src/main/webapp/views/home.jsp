<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html class="h-full">
<head>
    <title>PolyCoffee - Cà Phê Thượng Hạng</title>
</head>
<body class="bg-gray-50 font-sans min-h-screen flex flex-col overflow-x-hidden selection:bg-coffee-200 selection:text-coffee-900">
    <jsp:include page="common/header.jsp" />

    <main class="flex-grow">
        <!-- Hero Section -->
        <section class="max-w-7xl mx-auto px-6 py-20 md:py-28 text-center relative z-10">
            <div class="inline-flex items-center gap-2 bg-white px-4 py-1.5 rounded-full text-coffee-700 text-xs font-bold mb-8 shadow-sm border border-gray-200 uppercase tracking-widest">
                <span class="flex h-2 w-2 rounded-full bg-coffee-600 animate-pulse"></span>
                <fmt:message key="home.hero.badge"/>
            </div>
            
            <h1 class="text-5xl md:text-7xl font-black text-gray-900 mb-8 leading-[1.1] tracking-tight">
                <fmt:message key="home.hero.title1"/> <br/> <fmt:message key="home.hero.title2"/>
                <span class="text-coffee-700 relative inline-block">
                    <fmt:message key="home.hero.title3"/>
                </span>
            </h1>
            
            <p class="text-gray-500 text-lg md:text-xl max-w-2xl mx-auto mb-12 leading-relaxed">
                <fmt:message key="home.hero.desc"/>
            </p>

            <div class="flex flex-col sm:flex-row gap-4 justify-center items-center">
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/auth/login" class="bg-coffee-700 hover:bg-coffee-800 text-white px-8 py-3 rounded-xl font-semibold shadow-sm transition-all flex items-center gap-2">
                            <fmt:message key="home.btn.login"/> <i class="bi bi-arrow-right"></i>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/employee/pos" class="bg-coffee-700 hover:bg-coffee-800 text-white px-8 py-3 rounded-xl font-semibold shadow-sm transition-all flex items-center gap-2">
                            <fmt:message key="home.btn.pos"/> <i class="bi bi-speedometer2"></i>
                        </a>
                    </c:otherwise>
                </c:choose>
                <a href="#features" class="bg-white hover:bg-gray-50 text-gray-700 border border-gray-200 px-8 py-3 rounded-xl font-semibold shadow-sm transition-all flex items-center gap-2">
                    <fmt:message key="home.btn.demo"/> <i class="bi bi-play-circle"></i>
                </a>
            </div>
        </section>

        <!-- Stats Section -->
        <section id="features" class="max-w-7xl mx-auto px-6 py-24 border-t border-gray-200">
            <div class="text-center mb-16">
                <h2 class="text-3xl font-bold text-gray-900 mb-4 tracking-tight"><fmt:message key="home.feature.title"/></h2>
                <p class="text-gray-500 max-w-xl mx-auto"><fmt:message key="home.feature.desc"/></p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <!-- Feature 1 -->
                <div class="bg-white p-8 rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-shadow">
                    <div class="w-14 h-14 bg-coffee-50 rounded-xl flex items-center justify-center text-coffee-700 text-2xl mb-6">
                        <i class="bi bi-lightning-charge-fill"></i>
                    </div>
                    <h3 class="text-lg font-bold text-gray-900 mb-3"><fmt:message key="home.feature1.title"/></h3>
                    <p class="text-gray-500 leading-relaxed text-sm"><fmt:message key="home.feature1.desc"/></p>
                    <div class="mt-6 flex items-center gap-2 text-coffee-700 font-semibold text-sm cursor-pointer group">
                        <fmt:message key="home.feature.more"/> <i class="bi bi-arrow-right group-hover:translate-x-1 transition-transform"></i>
                    </div>
                </div>

                <!-- Feature 2 -->
                <div class="bg-white p-8 rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-shadow">
                    <div class="w-14 h-14 bg-blue-50 rounded-xl flex items-center justify-center text-blue-600 text-2xl mb-6">
                        <i class="bi bi-graph-up-arrow"></i>
                    </div>
                    <h3 class="text-lg font-bold text-gray-900 mb-3"><fmt:message key="home.feature2.title"/></h3>
                    <p class="text-gray-500 leading-relaxed text-sm"><fmt:message key="home.feature2.desc"/></p>
                    <div class="mt-6 flex items-center gap-2 text-coffee-700 font-semibold text-sm cursor-pointer group">
                        <fmt:message key="home.feature.more"/> <i class="bi bi-arrow-right group-hover:translate-x-1 transition-transform"></i>
                    </div>
                </div>

                <!-- Feature 3 -->
                <div class="bg-white p-8 rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-shadow">
                    <div class="w-14 h-14 bg-green-50 rounded-xl flex items-center justify-center text-green-600 text-2xl mb-6">
                        <i class="bi bi-shield-fill-check"></i>
                    </div>
                    <h3 class="text-lg font-bold text-gray-900 mb-3"><fmt:message key="home.feature3.title"/></h3>
                    <p class="text-gray-500 leading-relaxed text-sm"><fmt:message key="home.feature3.desc"/></p>
                    <div class="mt-6 flex items-center gap-2 text-coffee-700 font-semibold text-sm cursor-pointer group">
                        <fmt:message key="home.feature.more"/> <i class="bi bi-arrow-right group-hover:translate-x-1 transition-transform"></i>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <jsp:include page="common/footer.jsp" />

</body>
</html>
