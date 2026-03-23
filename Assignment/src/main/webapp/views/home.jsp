<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html lang="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" class="h-full scroll-smooth">

<head>
    <title>
        <fmt:message key="app.name" /> - PolyCoffee
    </title>
    <jsp:include page="/views/common/head.jsp" />
    <script src="https://unpkg.com/lucide@latest"></script>
</head>

<body class="bg-white font-sans min-h-screen flex flex-col overflow-x-hidden selection:bg-coffee-200 selection:text-coffee-900 text-slate-900 antialiased">
    <!-- Premium Background Effects -->
    <div class="fixed inset-0 pointer-events-none overflow-hidden z-0">
        <div class="absolute -top-[10%] -left-[10%] w-[50vw] h-[50vh] bg-coffee-100/40 rounded-full blur-[120px] mix-blend-multiply"></div>
        <div class="absolute top-[30%] -right-[10%] w-[40vw] h-[60vh] bg-orange-50/50 rounded-full blur-[100px] mix-blend-multiply"></div>
    </div>

    <div class="relative z-20 shadow-sm border-b border-gray-100/50 bg-white/80 backdrop-blur-xl">
        <jsp:include page="/views/common/header.jsp" />
    </div>

    <main class="flex-grow flex flex-col relative z-10">
        <!-- Hero Section -->
        <section class="max-w-[85rem] mx-auto px-6 py-24 md:py-32 w-full flex flex-col items-center text-center relative">
            <div class="absolute inset-0 bg-[url('https://grainy-gradients.vercel.app/noise.svg')] opacity-20 mix-blend-overlay pointer-events-none"></div>

            <div class="inline-flex items-center gap-2 bg-gradient-to-r from-coffee-50 to-orange-50 border border-coffee-200/50 px-5 py-2 rounded-full text-coffee-700 text-xs font-black mb-10 shadow-sm uppercase tracking-widest cursor-default hover:scale-105 transition-transform">
                <span class="flex h-2 w-2 rounded-full bg-coffee-500 animate-pulse"></span>
                Trải nghiệm Phục vụ Cà phê Hiện đại
            </div>

            <h1 class="text-6xl md:text-[5.5rem] font-black text-slate-900 mb-8 leading-[1.05] tracking-tighter">
                Quản lý Cà phê <br />
                Đỉnh cao <span class="bg-gradient-to-r from-coffee-600 to-orange-500 bg-clip-text text-transparent drop-shadow-sm">Công nghệ</span>.
            </h1>

            <p class="text-slate-500 text-xl max-w-2xl mx-auto mb-14 leading-relaxed font-medium">
                Giao diện quản lý thông minh, tinh giản mọi thao tác bán hàng và nâng tầm trải nghiệm cho cả nhân viên lẫn khách thưởng thức.
            </p>

            <div class="flex flex-col sm:flex-row gap-5 justify-center items-center w-full sm:w-auto">
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/guest/order"
                            class="group relative inline-flex items-center justify-center gap-3 bg-slate-900 text-white px-10 py-4 rounded-2xl font-bold shadow-[0_8px_30px_rgb(15,23,42,0.2)] hover:shadow-[0_8px_30px_rgb(15,23,42,0.3)] hover:-translate-y-1 transition-all duration-300 w-full sm:w-auto text-lg overflow-hidden">
                            <div class="absolute inset-0 w-full h-full bg-gradient-to-r from-transparent via-white/10 to-transparent -translate-x-[150%] skew-x-[-20deg] group-hover:animate-[shimmer_1.5s_infinite]"></div>
                            <span>Đặt Món Dành Cho Khách</span>
                            <i data-lucide="arrow-right" class="w-5 h-5 group-hover:translate-x-1 transition-transform"></i>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/employee/pos"
                            class="group relative inline-flex items-center justify-center gap-3 bg-slate-900 text-white px-10 py-4 rounded-2xl font-bold shadow-[0_8px_30px_rgb(15,23,42,0.2)] hover:shadow-[0_8px_30px_rgb(15,23,42,0.3)] hover:-translate-y-1 transition-all duration-300 w-full sm:w-auto text-lg overflow-hidden">
                            <div class="absolute inset-0 w-full h-full bg-gradient-to-r from-transparent via-white/10 to-transparent -translate-x-[150%] skew-x-[-20deg] group-hover:animate-[shimmer_1.5s_infinite]"></div>
                            <span>Mở Máy POS Chuyên Sử Dụng</span>
                            <i data-lucide="layout-dashboard" class="w-5 h-5 group-hover:scale-110 transition-transform"></i>
                        </a>
                    </c:otherwise>
                </c:choose>
                <a href="#features"
                    class="group bg-white hover:bg-slate-50 text-slate-700 border border-gray-200 px-10 py-4 rounded-2xl font-bold shadow-sm hover:shadow-md transition-all duration-300 flex items-center justify-center gap-2 w-full sm:w-auto text-lg hover:-translate-y-0.5">
                    Khám phá Tính năng <i data-lucide="chevron-down" class="w-5 h-5 text-slate-400 group-hover:translate-y-1 transition-transform"></i>
                </a>
            </div>
            
            <div class="mt-20 flex items-center justify-center gap-8 opacity-60 grayscale filter hover:grayscale-0 transition-all duration-500">
                <span class="text-sm font-bold tracking-widest uppercase text-slate-400">Được Tin Dùng Bởi</span>
                <i data-lucide="coffee" class="w-8 h-8 text-coffee-600"></i>
                <i data-lucide="croissant" class="w-8 h-8 text-amber-600"></i>
                <i data-lucide="cup-soda" class="w-8 h-8 text-rose-500"></i>
            </div>
        </section>

        <!-- Features Grid -->
        <section id="features" class="bg-slate-50 py-24 border-t border-gray-100">
            <div class="max-w-7xl mx-auto px-6">
                <div class="text-center mb-20">
                    <h2 class="text-4xl md:text-5xl font-black text-slate-900 mb-5 tracking-tight">Tính Năng Ưu Việt</h2>
                    <p class="text-slate-500 text-lg max-w-2xl mx-auto">Trải nghiệm hệ thống hoàn hảo với tốc độ phản hồi cực nhanh, an toàn dữ liệu và tối ưu hóa tối đa cho nhân viên.</p>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                    <!-- Feature 1 -->
                    <div class="bg-white p-10 rounded-[2rem] border border-gray-100 shadow-[0_4px_20px_rgb(0,0,0,0.03)] hover:shadow-[0_10px_40px_rgb(0,0,0,0.06)] hover:-translate-y-1 transition-all duration-300 group">
                        <div class="w-16 h-16 bg-gradient-to-br from-amber-100 to-amber-50 rounded-2xl flex items-center justify-center text-amber-600 mb-8 border border-amber-100/50 group-hover:scale-110 transition-transform">
                            <i data-lucide="zap" class="w-8 h-8 fill-amber-500/20"></i>
                        </div>
                        <h3 class="text-2xl font-black text-slate-900 mb-4">Tốc Độ Tối Đa</h3>
                        <p class="text-slate-500 leading-relaxed font-medium">Thao tác mượt mà không độ trễ, hệ thống POS của PolyCoffee hỗ trợ nhân viên chốt đơn liên tục trong giờ cao điểm.</p>
                    </div>

                    <!-- Feature 2 -->
                    <div class="bg-white p-10 rounded-[2rem] border border-gray-100 shadow-[0_4px_20px_rgb(0,0,0,0.03)] hover:shadow-[0_10px_40px_rgb(0,0,0,0.06)] hover:-translate-y-1 transition-all duration-300 group">
                        <div class="w-16 h-16 bg-gradient-to-br from-blue-100 to-blue-50 rounded-2xl flex items-center justify-center text-blue-600 mb-8 border border-blue-100/50 group-hover:scale-110 transition-transform">
                            <i data-lucide="bar-chart-3" class="w-8 h-8 fill-blue-500/20"></i>
                        </div>
                        <h3 class="text-2xl font-black text-slate-900 mb-4">Báo Cáo Thông Minh</h3>
                        <p class="text-slate-500 leading-relaxed font-medium">Theo dõi doanh thu, số lượng đơn hàng và số liệu vận hành chặt chẽ với những thẻ báo biểu đồ tương tác thời gian thực.</p>
                    </div>

                    <!-- Feature 3 -->
                    <div class="bg-white p-10 rounded-[2rem] border border-gray-100 shadow-[0_4px_20px_rgb(0,0,0,0.03)] hover:shadow-[0_10px_40px_rgb(0,0,0,0.06)] hover:-translate-y-1 transition-all duration-300 group">
                        <div class="w-16 h-16 bg-gradient-to-br from-emerald-100 to-emerald-50 rounded-2xl flex items-center justify-center text-emerald-600 mb-8 border border-emerald-100/50 group-hover:scale-110 transition-transform">
                            <i data-lucide="shield-check" class="w-8 h-8 fill-emerald-500/20"></i>
                        </div>
                        <h3 class="text-2xl font-black text-slate-900 mb-4">Bảo Mật Kín Kẽ</h3>
                        <p class="text-slate-500 leading-relaxed font-medium">Quyền hạn truy cập được phân tách chặt chẽ. Dữ liệu hoá đơn được lưu trữ an toàn, chống thất thoát doanh số hiệu quả.</p>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <div class="relative z-20 bg-slate-900">
        <jsp:include page="/views/common/footer.jsp" />
    </div>

    <style>
        @keyframes shimmer {
            0% { transform: translateX(-150%) skewX(-20deg); }
            100% { transform: translateX(200%) skewX(-20deg); }
        }
    </style>
    <script>
        lucide.createIcons();
    </script>
</body>

</html>