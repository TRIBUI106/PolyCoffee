<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<script src="https://cdn.tailwindcss.com"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<script>
    tailwind.config = {
        theme: {
            extend: {
                colors: {
                    coffee: {
                        50: '#fdf8f6',
                        100: '#f2e8e5',
                        200: '#eaddd7',
                        300: '#e0c1b3',
                        400: '#d3a08b',
                        500: '#c67f63',
                        600: '#b95d3b',
                        700: '#6F4E37', // Primary
                        800: '#5c402d',
                        900: '#4a3424',
                    },
                    cream: '#FDF7E4',
                    latte: '#A67B5B',
                    caramel: '#ECB176',
                    mocha: '#2D2424',
                },
                fontFamily: {
                    sans: ['Inter', 'sans-serif'],
                    display: ['Playfair Display', 'serif'],
                },
                borderRadius: {
                    'coffee': '2rem',
                },
                animation: {
                    'morph': 'morph 8s ease-in-out infinite',
                    'spin-slow': 'spin 8s linear infinite',
                },
                keyframes: {
                    morph: {
                        '0%, 100%': { borderRadius: '40% 60% 70% 30% / 40% 40% 60% 50%' },
                        '50%': { borderRadius: '70% 30% 50% 50% / 30% 30% 70% 70%' },
                    }
                }
            }
        }
    }
</script>

<style type="text/tailwindcss">
    @layer components {
        .glass {
            @apply bg-white/40 backdrop-blur-xl border border-white/30 shadow-[0_8px_32px_0_rgba(111,78,55,0.1)];
        }
        .luxury-nav {
            @apply sticky top-6 z-50 mx-auto max-w-7xl px-4 md:px-6;
        }
        .nav-container {
            @apply bg-white/40 backdrop-blur-2xl border border-white/40 shadow-[0_20px_50px_rgba(111,78,55,0.1)] rounded-[2rem] px-6 py-3 flex items-center justify-between transition-all duration-500;
        }
        .liquid-glass {
            @apply relative overflow-hidden bg-white/30 backdrop-blur-2xl border border-white/40 shadow-2xl;
        }
        .btn-coffee {
            @apply bg-coffee-700 text-white px-8 py-2.5 rounded-full font-semibold transition-all duration-500 hover:bg-coffee-800 hover:scale-105 active:scale-95 shadow-xl shadow-coffee-700/30 flex items-center gap-2;
        }
        .btn-soft {
            @apply bg-white/50 backdrop-blur-md text-coffee-800 border border-coffee-200/50 px-8 py-2.5 rounded-full font-semibold transition-all duration-500 hover:bg-cream/80 hover:border-coffee-300 shadow-lg flex items-center gap-2;
        }
        .nav-link-custom {
            @apply text-mocha/70 hover:text-coffee-700 font-medium px-5 py-2 transition-all duration-300 relative tracking-wide flex items-center gap-1.5;
        }
        .nav-link-active {
            @apply text-coffee-700;
        }
        .nav-indicator {
            @apply absolute -bottom-1 left-1/2 -translate-x-1/2 w-1.5 h-1.5 rounded-full bg-coffee-700 opacity-0 transition-all duration-300;
        }
        .nav-link-active .nav-indicator {
            @apply opacity-100 translate-y-[-2px];
        }
        .dropdown-luxury {
            @apply absolute top-[calc(100%+1rem)] left-0 w-56 bg-white/80 backdrop-blur-2xl border border-white/40 rounded-[1.5rem] p-3 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-500 translate-y-4 group-hover:translate-y-0 shadow-2xl shadow-coffee-900/10;
        }
    }
    
    .text-display {
        font-family: 'Playfair Display', serif;
    }
    
    .blob {
        @apply absolute blur-[80px] opacity-20 animate-morph;
    }
</style>

<header class="luxury-nav">
    <nav class="nav-container">
        <!-- Logo -->
        <a href="${pageContext.request.contextPath}/" class="flex items-center gap-3 group">
            <div class="bg-coffee-700 p-2.5 rounded-2xl group-hover:rotate-[15deg] transition-all duration-500 shadow-lg shadow-coffee-700/20">
                <i class="bi bi-cup-hot-fill text-white text-xl"></i>
            </div>
            <span class="text-2xl font-black text-mocha text-display tracking-tight">Poly<span class="text-coffee-700">Coffee</span></span>
        </a>

        <!-- Navigation Links -->
        <div class="hidden md:flex items-center gap-2">
            <a href="${pageContext.request.contextPath}/" class="nav-link-custom ${pageContext.request.requestURI.endsWith('/home.jsp') || pageContext.request.requestURI.endsWith('/') ? 'nav-link-active' : ''}">
                <fmt:message key="header.home"/>
                <span class="nav-indicator"></span>
            </a>
            
            <c:if test="${not empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/employee/pos" class="nav-link-custom ${pageContext.request.requestURI.contains('/pos') ? 'nav-link-active' : ''}">
                    <fmt:message key="header.pos"/>
                    <span class="nav-indicator"></span>
                </a>
                
                <c:if test="${sessionScope.user.role}">
                    <div class="relative group">
                        <button class="nav-link-custom">
                            <fmt:message key="header.management"/> <i class="bi bi-chevron-down text-[10px] opacity-50 group-hover:rotate-180 transition-transform duration-300"></i>
                            <span class="nav-indicator"></span>
                        </button>
                        <div class="dropdown-luxury">
                            <div class="mb-2 px-3 py-1 text-[10px] uppercase tracking-[0.2em] font-bold text-mocha/30"><fmt:message key="header.catalog"/></div>
                            <a href="${pageContext.request.contextPath}/manager/categories" class="flex items-center gap-3 px-4 py-2.5 hover:bg-coffee-50 rounded-xl text-mocha text-sm transition-all group/item">
                                <i class="bi bi-grid-1x2 text-coffee-300 group-hover/item:text-coffee-700"></i> <fmt:message key="header.category"/>
                            </a>
                            <a href="${pageContext.request.contextPath}/manager/drinks" class="flex items-center gap-3 px-4 py-2.5 hover:bg-coffee-50 rounded-xl text-mocha text-sm transition-all group/item">
                                <i class="bi bi-cup-straw text-coffee-300 group-hover/item:text-coffee-700"></i> <fmt:message key="header.drink"/>
                            </a>
                            <a href="${pageContext.request.contextPath}/manager/staff" class="flex items-center gap-3 px-4 py-2.5 hover:bg-coffee-50 rounded-xl text-mocha text-sm transition-all group/item">
                                <i class="bi bi-people text-coffee-300 group-hover/item:text-coffee-700"></i> <fmt:message key="header.staff"/>
                            </a>
                            <div class="h-px bg-coffee-100/50 my-2 mx-2"></div>
                            <div class="mb-2 px-3 py-1 text-[10px] uppercase tracking-[0.2em] font-bold text-mocha/30"><fmt:message key="header.intelligence"/></div>
                            <a href="${pageContext.request.contextPath}/manager/bills" class="flex items-center gap-3 px-4 py-2.5 hover:bg-coffee-50 rounded-xl text-mocha text-sm transition-all group/item font-medium text-coffee-700">
                                <i class="bi bi-receipt"></i> <fmt:message key="header.bill"/>
                            </a>
                            <a href="${pageContext.request.contextPath}/manager/statistics" class="flex items-center gap-3 px-4 py-2.5 hover:bg-coffee-50 rounded-xl text-mocha text-sm transition-all group/item font-medium text-coffee-700">
                                <i class="bi bi-graph-up-arrow"></i> <fmt:message key="header.report"/>
                            </a>
                        </div>
                    </div>
                </c:if>
            </c:if>
        </div>

        <!-- Action Area -->
        <div class="flex items-center gap-4">
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/auth/login" class="btn-coffee py-2 shadow-none">
                        <fmt:message key="header.login"/>
                    </a>
                </c:when>
                <c:otherwise>
                    <div class="relative group">
                        <button class="flex items-center gap-3 bg-white/60 backdrop-blur-md border border-white/40 px-4 py-2 rounded-2xl hover:bg-white transition-all duration-500 group-hover:shadow-xl shadow-coffee-900/5">
                            <div class="w-8 h-8 rounded-xl bg-coffee-700 flex items-center justify-center text-white font-bold text-xs shadow-lg shadow-coffee-700/20">
                                ${sessionScope.user.fullName.substring(0,1)}
                            </div>
                            <span class="hidden sm:block font-bold text-mocha text-sm tracking-tight">${sessionScope.user.fullName}</span>
                            <i class="bi bi-chevron-down text-[10px] opacity-30 group-hover:rotate-180 transition-transform"></i>
                        </button>
                        <div class="dropdown-luxury left-auto right-0">
                            <div class="px-4 py-3 mb-2 border-b border-coffee-100/50">
                                <p class="text-[10px] uppercase tracking-widest text-mocha/40 font-bold mb-1"><fmt:message key="header.authAs"/></p>
                                <p class="text-sm font-bold text-mocha truncate">${sessionScope.user.fullName}</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/auth/profile" class="flex items-center gap-3 px-4 py-2.5 hover:bg-coffee-50 rounded-xl text-mocha text-sm transition-all">
                                <i class="bi bi-person-circle text-coffee-300"></i> <fmt:message key="header.profile"/>
                            </a>
                            <div class="h-px bg-coffee-100/50 my-2 mx-2"></div>
                            <a href="${pageContext.request.contextPath}/auth/logout" class="flex items-center gap-3 px-4 py-2.5 hover:bg-red-50 text-red-500 rounded-xl text-sm transition-all group/logout">
                                <i class="bi bi-box-arrow-right group-hover/logout:translate-x-1 transition-transform"></i> <fmt:message key="header.logout"/>
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>
</header>
