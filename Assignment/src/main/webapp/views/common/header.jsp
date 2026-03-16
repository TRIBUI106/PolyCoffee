<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<c:if test="${not empty param.lang}">
    <c:set var="lang" value="${param.lang}" scope="session"/>
</c:if>
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
                    coffee: { 50: '#fdf8f6', 100: '#f2e8e5', 200: '#EADBC8', 500: '#c67f63', 700: '#6F4E37', 800: '#5D4037', 900: '#3E2723' },
                    mocha: '#2D2424',
                },
                fontFamily: {
                    sans: ['Inter', 'sans-serif'],
                }
            }
        }
    }
</script>

<style type="text/tailwindcss">
    @layer components {
        .btn-coffee {
            @apply bg-coffee-700 text-white px-6 py-2 rounded-lg font-medium transition-colors hover:bg-coffee-800 active:bg-coffee-900 shadow-sm flex items-center gap-2;
        }
        .btn-soft {
            @apply bg-white text-coffee-800 border border-gray-200 px-6 py-2 rounded-lg font-medium transition-colors hover:bg-gray-50 active:bg-gray-100 shadow-sm flex items-center gap-2;
        }
        .nav-link-custom {
            @apply text-gray-600 hover:text-coffee-700 font-medium px-4 py-2 transition-colors relative flex items-center gap-1.5 rounded-lg hover:bg-gray-50;
        }
        .nav-link-active {
            @apply text-coffee-700 bg-coffee-50;
        }
        .dropdown-luxury {
            @apply absolute top-[calc(100%+0.5rem)] left-0 w-56 bg-white border border-gray-100 rounded-xl p-2 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200 shadow-lg z-50;
        }
        .dropdown-item {
            @apply flex items-center gap-3 px-3 py-2 hover:bg-gray-50 rounded-lg text-gray-700 text-sm transition-colors;
        }
    }
</style>

<header class="bg-white border-b border-gray-200 sticky top-0 z-50 shadow-sm">
    <nav class="max-w-7xl mx-auto px-4 md:px-6 h-16 flex items-center justify-between">
        <!-- Logo -->
        <a href="${pageContext.request.contextPath}/" class="flex items-center gap-3">
            <div class="bg-coffee-700 p-2 rounded-lg text-white">
                <i class="bi bi-cup-hot-fill text-lg"></i>
            </div>
            <span class="text-xl font-bold text-gray-900 tracking-tight">Poly<span class="text-coffee-700">Coffee</span></span>
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
                            <fmt:message key="header.management"/> <i class="bi bi-chevron-down text-[10px] text-gray-400"></i>
                        </button>
                        <div class="dropdown-luxury">
                            <div class="px-3 py-1.5 text-xs font-semibold text-gray-400 uppercase tracking-wider"><fmt:message key="header.catalog"/></div>
                            <a href="${pageContext.request.contextPath}/manager/categories" class="dropdown-item">
                                <i class="bi bi-grid-1x2 text-gray-400"></i> <fmt:message key="header.category"/>
                            </a>
                            <a href="${pageContext.request.contextPath}/manager/drinks" class="dropdown-item">
                                <i class="bi bi-cup-straw text-gray-400"></i> <fmt:message key="header.drink"/>
                            </a>
                            <a href="${pageContext.request.contextPath}/manager/staff" class="dropdown-item">
                                <i class="bi bi-people text-gray-400"></i> <fmt:message key="header.staff"/>
                            </a>
                            <div class="h-px bg-gray-100 my-1 mx-2"></div>
                            <div class="px-3 py-1.5 text-xs font-semibold text-gray-400 uppercase tracking-wider"><fmt:message key="header.intelligence"/></div>
                            <a href="${pageContext.request.contextPath}/manager/bills" class="dropdown-item">
                                <i class="bi bi-receipt text-gray-400"></i> <fmt:message key="header.bill"/>
                            </a>
                            <a href="${pageContext.request.contextPath}/manager/statistics" class="dropdown-item">
                                <i class="bi bi-graph-up-arrow text-gray-400"></i> <fmt:message key="header.report"/>
                            </a>
                        </div>
                    </div>
                </c:if>
            </c:if>
        </div>

        <!-- Action Area -->
        <div class="flex items-center gap-4">
            
            <!-- Language Switcher -->
            <div class="flex items-center bg-gray-100 rounded-lg p-0.5 border border-gray-200">
                <a href="?lang=vi" class="px-2.5 py-1 text-xs font-bold rounded-md transition-colors ${empty sessionScope.lang || sessionScope.lang == 'vi' ? 'bg-white shadow-sm text-coffee-700' : 'text-gray-500 hover:text-gray-900'}">VI</a>
                <a href="?lang=en" class="px-2.5 py-1 text-xs font-bold rounded-md transition-colors ${sessionScope.lang == 'en' ? 'bg-white shadow-sm text-coffee-700' : 'text-gray-500 hover:text-gray-900'}">EN</a>
            </div>

            <div class="w-px h-6 bg-gray-200 hidden sm:block"></div>

            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/auth/login" class="btn-coffee text-sm">
                        <fmt:message key="header.login"/>
                    </a>
                </c:when>
                <c:otherwise>
                    <div class="relative group">
                        <button class="flex items-center gap-2 hover:bg-gray-50 px-2 py-1.5 rounded-lg transition-colors">
                            <div class="w-8 h-8 rounded-full bg-coffee-100 text-coffee-700 flex items-center justify-center font-bold text-sm">
                                ${fn:substring(sessionScope.user.fullName, 0, 1)}
                            </div>
                            <span class="hidden sm:block font-medium text-gray-700 text-sm">${sessionScope.user.fullName}</span>
                            <i class="bi bi-chevron-down text-[10px] text-gray-400"></i>
                        </button>
                        <div class="dropdown-luxury right-0 left-auto">
                            <div class="px-3 py-2 border-b border-gray-100 mb-1">
                                <p class="text-[10px] uppercase text-gray-400 font-semibold mb-0.5"><fmt:message key="header.authAs"/></p>
                                <p class="text-sm font-semibold text-gray-800 truncate">${sessionScope.user.fullName}</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/auth/profile" class="dropdown-item">
                                <i class="bi bi-person-circle text-gray-400"></i> <fmt:message key="header.profile"/>
                            </a>
                            <div class="h-px bg-gray-100 my-1 mx-2"></div>
                            <a href="${pageContext.request.contextPath}/auth/logout" class="dropdown-item text-red-600 hover:bg-red-50 hover:text-red-700">
                                <i class="bi bi-box-arrow-right text-red-500"></i> <fmt:message key="header.logout"/>
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>
</header>
