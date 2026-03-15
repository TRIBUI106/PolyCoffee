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
<body class="bg-[#FCF9F3] font-sans min-h-full flex flex-col overflow-x-hidden selection:bg-coffee-200 selection:text-coffee-900">

    <!-- Background Decoration -->
    <div class="fixed inset-0 -z-10 overflow-hidden">
        <div class="blob w-[600px] h-[600px] bg-coffee-300 -top-20 -left-20"></div>
        <div class="blob w-[500px] h-[500px] bg-caramel/40 bottom-0 -right-20 animate-morph" style="animation-delay: -2s"></div>
        <div class="blob w-[400px] h-[400px] bg-latte/30 top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 animate-morph" style="animation-duration: 12s"></div>
    </div>

    <jsp:include page="common/header.jsp" />

    <main class="flex-grow">
        <!-- Hero Section -->
        <section class="max-w-7xl mx-auto px-6 py-24 md:py-32 text-center relative">
            <div class="inline-flex items-center gap-3 bg-white/60 backdrop-blur-md px-6 py-2.5 rounded-full text-coffee-700 text-sm font-bold mb-10 shadow-lg border border-white/50 transition-all hover:scale-105 cursor-default">
                <span class="flex h-3 w-3 rounded-full bg-coffee-600 animate-pulse"></span>
                <span class="tracking-widest uppercase"><fmt:message key="home.hero.badge"/></span>
            </div>
            
            <h1 class="text-6xl md:text-8xl font-black text-mocha mb-10 leading-[1.1] text-display">
                <fmt:message key="home.hero.title1"/> <br/> <fmt:message key="home.hero.title2"/>
                <span class="text-coffee-700 relative inline-block">
                    <fmt:message key="home.hero.title3"/>
                    <svg class="absolute -bottom-2 left-0 w-full" viewBox="0 0 100 20" preserveAspectRatio="none">
                        <path d="M0 10 Q 50 20 100 10" stroke="#6F4E37" stroke-width="2" fill="none" />
                    </svg>
                </span>
            </h1>
            
            <p class="text-mocha/70 text-xl md:text-2xl max-w-3xl mx-auto mb-16 leading-relaxed font-light">
                <fmt:message key="home.hero.desc"/>
            </p>

            <div class="flex flex-col sm:flex-row gap-6 justify-center items-center">
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/auth/login" class="btn-coffee text-xl">
                            <fmt:message key="home.btn.login"/> <i class="bi bi-arrow-right"></i>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/employee/pos" class="btn-coffee text-xl">
                            <fmt:message key="home.btn.pos"/> <i class="bi bi-speedometer2"></i>
                        </a>
                    </c:otherwise>
                </c:choose>
                <a href="#features" class="btn-soft text-xl">
                    <fmt:message key="home.btn.demo"/> <i class="bi bi-play-circle"></i>
                </a>
            </div>
        </section>

        <!-- Stats Section -->
        <section id="features" class="max-w-7xl mx-auto px-6 py-32">
            <div class="text-center mb-20">
                <h2 class="text-4xl md:text-5xl font-bold text-mocha mb-4 text-display"><fmt:message key="home.feature.title"/></h2>
                <p class="text-mocha/60 max-w-xl mx-auto"><fmt:message key="home.feature.desc"/></p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-10">
                <!-- Feature 1 -->
                <div class="liquid-glass p-10 rounded-coffee transition-all duration-500 hover:-translate-y-4 group cursor-pointer">
                    <div class="absolute inset-0 bg-gradient-to-br from-coffee-100/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity"></div>
                    <div class="w-20 h-20 bg-coffee-700 rounded-3xl flex items-center justify-center text-white text-3xl mb-8 shadow-2xl group-hover:rotate-[10deg] transition-transform duration-500">
                        <i class="bi bi-lightning-charge"></i>
                    </div>
                    <h3 class="text-2xl font-bold text-mocha mb-4 text-display"><fmt:message key="home.feature1.title"/></h3>
                    <p class="text-mocha/70 leading-relaxed"><fmt:message key="home.feature1.desc"/></p>
                    <div class="mt-8 flex items-center gap-2 text-coffee-700 font-bold opacity-0 group-hover:opacity-100 transition-all translate-x-[-10px] group-hover:translate-x-0">
                        <fmt:message key="home.feature.more"/> <i class="bi bi-chevron-right text-sm"></i>
                    </div>
                </div>

                <!-- Feature 2 -->
                <div class="liquid-glass p-10 rounded-coffee transition-all duration-500 hover:-translate-y-4 group cursor-pointer">
                    <div class="absolute inset-0 bg-gradient-to-br from-caramel/10 to-transparent opacity-0 group-hover:opacity-100 transition-opacity"></div>
                    <div class="w-20 h-20 bg-mocha rounded-3xl flex items-center justify-center text-white text-3xl mb-8 shadow-2xl group-hover:rotate-[10deg] transition-transform duration-500">
                        <i class="bi bi-graph-up-arrow"></i>
                    </div>
                    <h3 class="text-2xl font-bold text-mocha mb-4 text-display"><fmt:message key="home.feature2.title"/></h3>
                    <p class="text-mocha/70 leading-relaxed"><fmt:message key="home.feature2.desc"/></p>
                    <div class="mt-8 flex items-center gap-2 text-coffee-700 font-bold opacity-0 group-hover:opacity-100 transition-all translate-x-[-10px] group-hover:translate-x-0">
                        <fmt:message key="home.feature.more"/> <i class="bi bi-chevron-right text-sm"></i>
                    </div>
                </div>

                <!-- Feature 3 -->
                <div class="liquid-glass p-10 rounded-coffee transition-all duration-500 hover:-translate-y-4 group cursor-pointer">
                    <div class="absolute inset-0 bg-gradient-to-br from-latte/10 to-transparent opacity-0 group-hover:opacity-100 transition-opacity"></div>
                    <div class="w-20 h-20 bg-coffee-600 rounded-3xl flex items-center justify-center text-white text-3xl mb-8 shadow-2xl group-hover:rotate-[10deg] transition-transform duration-500">
                        <i class="bi bi-shield-check"></i>
                    </div>
                    <h3 class="text-2xl font-bold text-mocha mb-4 text-display"><fmt:message key="home.feature3.title"/></h3>
                    <p class="text-mocha/70 leading-relaxed"><fmt:message key="home.feature3.desc"/></p>
                    <div class="mt-8 flex items-center gap-2 text-coffee-700 font-bold opacity-0 group-hover:opacity-100 transition-all translate-x-[-10px] group-hover:translate-x-0">
                        <fmt:message key="home.feature.more"/> <i class="bi bi-chevron-right text-sm"></i>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <jsp:include page="common/footer.jsp" />

</body>
</html>
