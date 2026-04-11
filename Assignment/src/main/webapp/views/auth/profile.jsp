<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
                <fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
                <fmt:setBundle basename="messages" />
                <!DOCTYPE html>
                <html lang="${empty sessionScope.lang ? 'vi' : sessionScope.lang}">

                <head>
                    <title>Profile - PolyCoffee</title>
                    <jsp:include page="/views/common/head.jsp" />
                </head>

                <body
                    class="bg-nocturnal text-slate-200 font-sans min-h-screen flex flex-col selection:bg-amber-500/30 selection:text-white antialiased">
                    <!-- Premium Background Glows -->
                    <div class="fixed inset-0 pointer-events-none overflow-hidden z-0">
                        <div class="absolute top-[-10%] left-[-10%] w-[60vw] h-[60vh] bg-amber-900/20 rounded-full blur-[120px]"></div>
                        <div class="absolute bottom-[20%] right-[-5%] w-[50vw] h-[50vh] bg-orange-900/10 rounded-full blur-[100px]"></div>
                    </div>

                    <!-- Cinematic Texture Overlay -->
                    <div class="fixed inset-0 pointer-events-none z-[100] opacity-[0.03] mix-blend-overlay">
                        <svg viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
                            <filter id="noiseFilter">
                                <feTurbulence type="fractalNoise" baseFrequency="0.65" numOctaves="3" stitchTiles="stitch" />
                            </filter>
                            <rect width="100%" height="100%" filter="url(#noiseFilter)" />
                        </svg>
                    </div>

                    <div class="relative z-50 border-b border-white/5 bg-black/20 backdrop-blur-md">
                        <jsp:include page="/views/common/header.jsp" />
                    </div>

                    <main class="flex-grow flex flex-col justify-center relative z-20 max-w-2xl mx-auto w-full px-6 py-20">
                        <h2 class="text-4xl md:text-5xl font-serif-majestic text-white mb-2 text-center" data-aos="fade-down">
                            Hồ Sơ <span class="italic text-amber-glow">Cá Nhân</span>
                        </h2>
                        <p class="text-slate-400 text-center mb-12 font-outfit" data-aos="fade-up" data-aos-delay="100">
                            Quản lý thông tin và tài khoản hệ thống của bạn.
                        </p>

                        <div class="glass-card-deep rounded-[3rem] p-10 md:p-14 mb-8" data-aos="zoom-in" data-aos-delay="200">
                            <!-- Avatar -->
                            <div class="flex flex-col items-center mb-10">
                                <div class="w-28 h-28 rounded-full bg-gradient-to-br from-amber-400 to-amber-600 text-black flex items-center justify-center font-serif-majestic text-5xl shadow-[0_0_30px_rgba(217,119,6,0.3)] mb-5">
                                    ${fn:substring(sessionScope.user.fullName, 0, 1)}
                                </div>
                                <h1 class="text-3xl font-bold text-white tracking-tight mb-3">${sessionScope.user.fullName}</h1>
                                <div class="flex items-center gap-2">
                                    <span class="inline-flex items-center px-4 py-1.5 text-xs font-bold uppercase tracking-widest rounded-full border ${sessionScope.user.role ? 'bg-amber-500/10 text-amber-500 border-amber-500/20' : 'bg-blue-500/10 text-blue-400 border-blue-500/20'}">
                                        ${sessionScope.user.role ? 'Quản Lý' : 'Nhân Viên'}
                                    </span>
                                    <span class="inline-flex items-center px-4 py-1.5 text-xs font-bold uppercase tracking-widest rounded-full border ${sessionScope.user.active ? 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20' : 'bg-red-500/10 text-red-400 border-red-500/20'}">
                                        ${sessionScope.user.active ? 'Hoạt Động' : 'Đã Khóa'}
                                    </span>
                                </div>
                            </div>

                            <!-- Info -->
                            <div class="space-y-4">
                                <div class="bg-white/5 rounded-2xl p-5 border border-white/5 flex flex-col md:flex-row justify-between md:items-center gap-2">
                                    <span class="text-slate-400 text-sm font-medium flex items-center gap-2">
                                        <i data-lucide="mail" class="w-4 h-4"></i> Địa chỉ Email
                                    </span>
                                    <span class="text-slate-200 font-outfit font-medium text-lg">${sessionScope.user.email}</span>
                                </div>
                                <div class="bg-white/5 rounded-2xl p-5 border border-white/5 flex flex-col md:flex-row justify-between md:items-center gap-2">
                                    <span class="text-slate-400 text-sm font-medium flex items-center gap-2">
                                        <i data-lucide="phone" class="w-4 h-4"></i> Số điện thoại
                                    </span>
                                    <span class="text-slate-200 font-outfit font-medium text-lg">${empty sessionScope.user.phone ? 'Chưa cập nhật' : sessionScope.user.phone}</span>
                                </div>
                            </div>

                            <!-- Actions -->
                            <div class="flex flex-col sm:flex-row gap-4 mt-12 justify-center">
                                <a href="${pageContext.request.contextPath}/employee/pos"
                                   class="group relative px-8 py-4 bg-amber-600 text-white rounded-full font-bold text-lg overflow-hidden transition-all hover:bg-amber-500 hover:scale-105 active:scale-95 shadow-[0_0_30px_rgba(217,119,6,0.2)] text-center flex-1">
                                    <span class="relative z-10 flex justify-center items-center gap-2">
                                        Truy Cập POS
                                        <i data-lucide="arrow-right" class="w-5 h-5 group-hover:translate-x-1 transition-transform"></i>
                                    </span>
                                </a>
                                <a href="${pageContext.request.contextPath}/auth/logout"
                                   class="px-8 py-4 bg-white/5 hover:bg-red-500/10 text-white hover:text-red-400 border border-white/10 hover:border-red-500/30 rounded-full font-bold text-lg transition-all text-center backdrop-blur-md active:scale-95 flex-1 flex justify-center items-center gap-2">
                                    Đăng Xuất
                                    <i data-lucide="log-out" class="w-5 h-5"></i>
                                </a>
                            </div>
                        </div>
                    </main>

                    <script>
                        if (typeof lucide !== 'undefined') {
                            lucide.createIcons();
                        }
                        if (typeof window.AOS !== 'undefined') {
                            AOS.init({ duration: 800, once: true });
                        }
                    </script>
                </body>

                </html>