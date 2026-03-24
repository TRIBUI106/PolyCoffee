<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!-- Luxury Glass Header -->
<header class="fixed top-0 left-0 right-0 z-[100] transition-all duration-500 border-b border-white/5 backdrop-blur-xl bg-black/20" id="main-header">
    <nav class="max-w-screen-2xl mx-auto px-6 md:px-12 h-20 flex items-center justify-between">
        
        <!-- Premium Logo Section -->
        <a href="${pageContext.request.contextPath}/" class="flex items-center gap-4 group">
            <div class="relative w-11 h-11 flex items-center justify-center">
                <div class="absolute inset-0 bg-amber-500/20 rounded-xl rotate-45 group-hover:rotate-90 transition-transform duration-700 blur-sm"></div>
                <div class="relative bg-gradient-to-br from-amber-400 to-amber-600 p-2.5 rounded-xl shadow-lg shadow-amber-900/40 text-black">
                    <i class="bi bi-cup-hot-fill text-xl"></i>
                </div>
            </div>
            <div class="flex flex-col leading-none">
                <span class="text-2xl font-serif font-bold text-white tracking-wider">Poly<span class="text-amber-500">Coffee</span></span>
                <span class="text-[10px] uppercase tracking-[0.2em] text-amber-500/60 font-medium">Nocturnal Roast</span>
            </div>
        </a>

        <!-- Desktop Navigation: Fluid & Minimal -->
        <div class="hidden lg:flex items-center gap-10">
            <a href="${pageContext.request.contextPath}/" 
               class="relative group py-2 text-sm font-medium tracking-wide transition-colors ${pageContext.request.requestURI.endsWith('/home.jsp') || pageContext.request.requestURI.endsWith('/') ? 'text-amber-500' : 'text-gray-300 hover:text-white'}">
                <fmt:message key="header.home" />
                <span class="absolute -bottom-1 left-0 w-0 h-0.5 bg-amber-500 transition-all duration-500 group-hover:w-full ${pageContext.request.requestURI.endsWith('/home.jsp') || pageContext.request.requestURI.endsWith('/') ? 'w-full' : ''}"></span>
            </a>

            <c:if test="${not empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/employee/pos" 
                   class="relative group py-2 text-sm font-medium tracking-wide transition-colors ${pageContext.request.requestURI.contains('/pos') ? 'text-amber-500' : 'text-gray-300 hover:text-white'}">
                    <fmt:message key="header.pos" />
                    <span class="absolute -bottom-1 left-0 w-0 h-0.5 bg-amber-500 transition-all duration-500 group-hover:w-full ${pageContext.request.requestURI.contains('/pos') ? 'w-full' : ''}"></span>
                </a>
            </c:if>
        </div>

        <!-- Action Area -->
        <div class="flex items-center gap-6">
            
            <!-- Minimalist Language Switcher -->
            <div class="flex items-center bg-white/5 p-1 rounded-full border border-white/10">
                <a href="?lang=vi" 
                   class="w-9 h-9 flex items-center justify-center text-[11px] font-bold rounded-full transition-all duration-300 ${empty sessionScope.lang || sessionScope.lang == 'vi' ? 'bg-amber-500 text-black shadow-lg shadow-amber-900/20' : 'text-gray-400 hover:text-white'}">VI</a>
                <a href="?lang=en" 
                   class="w-9 h-9 flex items-center justify-center text-[11px] font-bold rounded-full transition-all duration-300 ${sessionScope.lang == 'en' ? 'bg-amber-500 text-black shadow-lg shadow-amber-900/20' : 'text-gray-400 hover:text-white'}">EN</a>
            </div>

            <div class="hidden sm:block w-px h-8 bg-white/10"></div>

            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/auth/login" 
                       class="relative overflow-hidden px-8 py-2.5 rounded-full bg-white text-black text-sm font-bold tracking-tight hover:bg-amber-500 hover:text-black transition-all duration-300 shadow-xl shadow-white/5 active:scale-95">
                        <fmt:message key="header.login" />
                    </a>
                </c:when>
                <c:otherwise>
                    <div class="relative group">
                        <button class="flex items-center gap-3 bg-white/5 pl-2 pr-4 py-1.5 rounded-full border border-white/10 hover:border-amber-500/50 transition-all duration-300 active:scale-95 group">
                            <div class="w-9 h-9 rounded-full bg-gradient-to-br from-amber-400 to-amber-600 text-black flex items-center justify-center font-bold text-sm shadow-inner overflow-hidden">
                                <span class="relative z-10">${fn:substring(sessionScope.user.fullName, 0, 1)}</span>
                            </div>
                            <div class="flex flex-col items-start leading-none">
                                <span class="hidden sm:block font-bold text-white text-xs">${sessionScope.user.fullName}</span>
                                <span class="text-[9px] text-amber-500/60 uppercase tracking-tighter">Verified Member</span>
                            </div>
                            <i class="bi bi-chevron-down text-[10px] text-gray-500 group-hover:text-amber-500 transition-colors"></i>
                        </button>
                        
                        <!-- Premium User Dropdown -->
                        <div class="absolute top-full right-0 mt-3 w-64 translate-y-4 opacity-0 pointer-events-none group-hover:translate-y-0 group-hover:opacity-100 group-hover:pointer-events-auto transition-all duration-500 ease-out z-[110]">
                            <div class="bg-[#111] border border-white/10 p-2 rounded-2xl shadow-2xl backdrop-blur-2xl ring-1 ring-white/5">
                                <div class="px-4 py-4 border-b border-white/5 mb-2 bg-white/5 rounded-xl">
                                    <p class="text-[9px] uppercase text-amber-500/60 font-bold mb-1 tracking-widest leading-none">
                                        <fmt:message key="header.authAs" />
                                    </p>
                                    <p class="text-sm font-serif font-bold text-white truncate italic">
                                        ${sessionScope.user.fullName}
                                    </p>
                                </div>
                                <a href="${pageContext.request.contextPath}/auth/profile" 
                                   class="flex items-center gap-3 px-4 py-3 text-sm text-gray-400 hover:text-white hover:bg-white/5 rounded-xl transition-all duration-200">
                                    <i class="bi bi-person-circle text-amber-500/70"></i>
                                    <fmt:message key="header.profile" />
                                </a>
                                <div class="h-px bg-white/5 my-2 mx-2"></div>
                                <a href="${pageContext.request.contextPath}/auth/logout" 
                                   class="flex items-center gap-3 px-4 py-3 text-sm text-red-400 hover:text-red-300 hover:bg-red-500/10 rounded-xl transition-all duration-200">
                                    <i class="bi bi-box-arrow-right"></i>
                                    <fmt:message key="header.logout" />
                                </a>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>
</header>

<script>
    // Header Scroll Effect
    window.addEventListener('scroll', () => {
        const header = document.getElementById('main-header');
        if (window.scrollY > 20) {
            header.classList.add('bg-black/60', 'h-16', 'border-white/10');
            header.classList.remove('h-20', 'bg-black/20', 'border-white/5');
        } else {
            header.classList.add('h-20', 'bg-black/20', 'border-white/5');
            header.classList.remove('bg-black/60', 'h-16', 'border-white/10');
        }
    });
</script>