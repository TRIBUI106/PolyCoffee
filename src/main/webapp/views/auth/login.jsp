<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />
<!DOCTYPE html>
<html class="h-full scroll-smooth">
<head>
    <title><fmt:message key="login.title"/> - PolyCoffee</title>
    <jsp:include page="/views/common/head.jsp" />
    <style>
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-4px); }
            20%, 40%, 60%, 80% { transform: translateX(4px); }
        }
        .animate-shake {
            animation: shake 0.5s cubic-bezier(.36,.07,.19,.97) both;
        }
    </style>
</head>
<body class="bg-nocturnal font-sans h-full flex items-center justify-center md:p-6 lg:p-8 relative overflow-hidden selection:bg-amber-500/30 selection:text-white text-slate-200 antialiased">
    
    <!-- Cinematic Texture Overlay -->
    <div class="fixed inset-0 pointer-events-none z-[100] opacity-[0.03] mix-blend-overlay">
        <svg viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg" width="100%" height="100%">
            <filter id="noiseFilter">
                <feTurbulence type="fractalNoise" baseFrequency="0.65" numOctaves="3" stitchTiles="stitch" />
            </filter>
            <rect width="100%" height="100%" filter="url(#noiseFilter)" />
        </svg>
    </div>

    <!-- Premium Background Glows -->
    <div class="fixed inset-0 pointer-events-none overflow-hidden z-0">
        <div class="absolute top-[-10%] left-[-10%] w-[60vw] h-[60vh] bg-amber-900/20 rounded-full blur-[120px]"></div>
        <div class="absolute bottom-[20%] right-[-5%] w-[50vw] h-[50vh] bg-orange-900/10 rounded-full blur-[100px]"></div>
    </div>

    <!-- Main Container -->
    <div class="w-full max-w-6xl h-full max-h-[850px] flex rounded-[3rem] overflow-hidden glass-card-deep shadow-2xl relative z-10 border border-white/5">
        
        <!-- Left Banner (Branding & Stats) -->
        <div class="hidden lg:flex flex-col justify-between w-1/2 p-16 relative overflow-hidden bg-black/40">
            <!-- Content -->
            <div class="relative z-10">
                <a href="${pageContext.request.contextPath}/" class="inline-flex items-center gap-3 mb-16 hover:opacity-80 transition-opacity">
                    <div class="w-12 h-12 bg-amber-500/20 rounded-2xl flex items-center justify-center border border-amber-500/20">
                        <i class="bi bi-cup-hot-fill text-amber-500 text-2xl"></i>
                    </div>
                    <span class="text-3xl font-serif-majestic text-white tracking-widest">PolyCoffee</span>
                </a>
                
                <h1 class="text-5xl font-serif-majestic text-white leading-tight mb-6 mt-10">
                    Sống Trọn Vẹn<br>
                    <span class="italic text-amber-glow">Từng Khoảnh Khắc</span>
                </h1>
                <p class="text-slate-400 text-lg max-w-md leading-relaxed font-light">
                    Hệ thống quản trị tập trung dành riêng cho nhân sự nội bộ và ban quản lý PolyCoffee SPA.
                </p>
            </div>

            <!-- Stats Real Data -->
            <div class="relative z-10 grid grid-cols-2 gap-6 mt-12 pb-8">
                <div class="bg-white/5 border border-white/10 p-6 rounded-[2rem] hover:-translate-y-1 transition-transform duration-300">
                    <div class="text-amber-500 mb-2"><i class="bi bi-receipt text-2xl"></i></div>
                    <p class="text-4xl font-serif-majestic text-white mb-1"><fmt:formatNumber value="${totalBills}" pattern="#,###"/></p>
                    <p class="text-[10px] font-bold text-slate-400 uppercase tracking-[0.2em]">Hóa đơn Kịp Thời</p>
                </div>
                <div class="bg-white/5 border border-white/10 p-6 rounded-[2rem] hover:-translate-y-1 transition-transform duration-300">
                    <div class="text-amber-400 mb-2"><i class="bi bi-graph-up-arrow text-2xl"></i></div>
                    <p class="text-4xl font-serif-majestic text-white mb-1"><fmt:formatNumber value="${totalRevenue}" pattern="#,###"/><span class="text-xl ml-1 text-amber-400/60 font-bold">VNĐ</span></p>
                    <p class="text-[10px] font-bold text-slate-400 uppercase tracking-[0.2em]">DOANH THU HỆ THỐNG</p>
                </div>
            </div>

            <!-- Decorative Pattern -->
            <div class="absolute inset-0 pointer-events-none opacity-20" style="background-image: radial-gradient(circle at 100% 100%, #f59e0b 0%, transparent 40%); mix-blend-mode: screen;"></div>
        </div>

        <!-- Right Side (Login Form) -->
        <div class="w-full lg:w-1/2 flex flex-col justify-center bg-black/20 backdrop-blur-3xl p-8 md:p-16 lg:p-20 relative">
            <div class="w-full max-w-md mx-auto relative z-10">
                <div class="lg:hidden flex items-center gap-3 mb-12">
                    <div class="w-12 h-12 bg-amber-500/20 rounded-2xl flex items-center justify-center border border-amber-500/20">
                        <i class="bi bi-cup-hot-fill text-amber-500 text-xl"></i>
                    </div>
                    <span class="text-2xl font-serif-majestic text-white tracking-widest">PolyCoffee</span>
                </div>

                <div class="mb-10 lg:mt-0 mt-8">
                    <h2 class="text-4xl font-serif-majestic text-white mb-3"><fmt:message key="login.welcome"/></h2>
                    <p class="text-slate-400 font-light text-sm"><fmt:message key="login.subtitle"/></p>
                </div>

                <c:if test="${not empty errorKey}">
                    <div class="bg-red-500/10 border border-red-500/20 text-red-400 p-4 rounded-2xl text-sm font-bold mb-8 flex items-center gap-3 animate-shake shadow-lg">
                        <div class="w-8 h-8 rounded-full bg-red-500/20 flex items-center justify-center shrink-0">
                            <i class="bi bi-exclamation-triangle-fill"></i>
                        </div>
                        <fmt:message key="${errorKey}"/>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/auth/login" method="post" class="space-y-6">
                    <div class="group">
                        <label class="block text-[10px] font-bold text-amber-500/60 uppercase tracking-widest mb-2 pl-1 group-focus-within:text-amber-500 transition-colors"><fmt:message key="login.email"/></label>
                        <div class="relative">
                            <i class="bi bi-envelope absolute left-4 top-1/2 -translate-y-1/2 text-slate-500 group-focus-within:text-amber-500 transition-colors"></i>
                            <input type="email" name="email" required placeholder="nhanvien@polycoffee.com"
                                   class="w-full bg-white/5 border border-white/10 pl-11 pr-5 py-4 rounded-2xl focus:bg-white/10 focus:ring-1 focus:ring-amber-500/50 focus:border-amber-500/50 outline-none transition-all placeholder:text-slate-600 text-white font-medium text-sm shadow-inner">
                        </div>
                    </div>
                    
                    <div class="group">
                        <div class="flex justify-between items-center mb-2 pl-1 pr-1">
                            <label class="text-[10px] font-bold text-amber-500/60 uppercase tracking-widest group-focus-within:text-amber-500 transition-colors"><fmt:message key="login.password"/></label>
                            <a href="#" class="text-[10px] font-bold text-slate-400 hover:text-amber-500 uppercase tracking-widest transition-colors">Trợ giúp?</a>
                        </div>
                        <div class="relative">
                            <i class="bi bi-lock absolute left-4 top-1/2 -translate-y-1/2 text-slate-500 group-focus-within:text-amber-500 transition-colors"></i>
                            <input type="password" name="password" required placeholder="••••••••"
                                   class="w-full bg-white/5 border border-white/10 pl-11 pr-5 py-4 rounded-2xl focus:bg-white/10 focus:ring-1 focus:ring-amber-500/50 focus:border-amber-500/50 outline-none transition-all placeholder:text-slate-600 text-white font-medium text-sm shadow-inner">
                        </div>
                    </div>

                    <div class="pt-6">
                        <button type="submit" 
                                class="w-full bg-amber-600 text-white rounded-2xl py-4 font-bold text-sm uppercase tracking-[0.1em] shadow-[0_0_20px_rgba(217,119,6,0.3)] hover:bg-amber-500 hover:-translate-y-0.5 hover:shadow-[0_0_30px_rgba(217,119,6,0.4)] transition-all active:scale-[0.98]">
                            Xác thực & Truy cập
                        </button>
                    </div>
                </form>
                
                <div class="mt-10 text-center border-t border-white/5 pt-8">
                    <p class="text-slate-500 text-[11px] font-light uppercase tracking-widest">&copy; 2026 Hệ thống nội bộ PolyCoffee</p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://unpkg.com/lucide@latest"></script>
    <script>lucide.createIcons();</script>
</body>
</html>
