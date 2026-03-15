<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html class="h-full">
<head>
    <title>Phân Tích Kinh Doanh - PolyCoffee</title>
</head>
<body class="bg-cream font-sans min-h-full">
    <jsp:include page="../common/header.jsp" />

    <main class="max-w-7xl mx-auto px-4 py-12">
        <div class="flex flex-col lg:flex-row lg:items-center justify-between gap-8 mb-16">
            <div>
                <h1 class="text-4xl font-black text-mocha mb-2 italic">Phân Tích Số Liệu</h1>
                <p class="text-latte font-bold text-xs tracking-[0.3em] uppercase">Bảng Quản Trị Hệ Thống Số</p>
            </div>
            
            <form action="" method="get" class="glass p-3 rounded-[2rem] flex flex-wrap lg:flex-nowrap items-center gap-4 border-coffee-100 shadow-xl shadow-coffee-700/5">
                <div class="flex items-center gap-2 pl-4">
                    <i class="bi bi-calendar-event text-latte"></i>
                    <span class="text-[10px] font-black text-mocha/30 uppercase tracking-widest">Thời Gian</span>
                </div>
                <input type="date" name="from" class="bg-white px-5 py-3 rounded-2xl outline-none font-bold text-sm text-mocha border border-coffee-50 focus:border-coffee-700 transition-colors" value="${param.from}">
                <div class="text-mocha/20 font-bold">—</div>
                <input type="date" name="to" class="bg-white px-5 py-3 rounded-2xl outline-none font-bold text-sm text-mocha border border-coffee-50 focus:border-coffee-700 transition-colors" value="${param.to}">
                <button type="submit" class="btn-coffee py-3 px-8 text-sm">Lọc Dữ Liệu</button>
            </form>
        </div>

        <div class="grid grid-cols-1 xl:grid-cols-2 gap-10 mb-20">
            <!-- Best Sellers Card -->
            <div class="flex flex-col gap-6">
                <div class="flex items-center gap-4 px-6">
                    <div class="w-10 h-10 bg-coffee-700 rounded-2xl flex items-center justify-center text-white text-lg">
                        <i class="bi bi-award"></i>
                    </div>
                    <h2 class="text-2xl font-black text-mocha">Đồ Uống Ưu Việt</h2>
                </div>

                <div class="glass p-10 rounded-[3rem] bg-white">
                    <div class="space-y-8">
                        <c:forEach var="item" items="${topDrinks}" varStatus="status">
                            <div class="group relative flex items-center gap-6">
                                <div class="w-14 h-14 rounded-2xl glass flex items-center justify-center font-black transition-all ${status.index == 0 ? 'bg-caramel text-mocha border-caramel/20 scale-110 shadow-xl shadow-caramel/20' : 'text-coffee-700 bg-coffee-50 border-coffee-100 group-hover:scale-105 group-hover:bg-white'}">
                                    ${status.index + 1}
                                </div>
                                <div class="flex-grow">
                                    <div class="flex items-center justify-between mb-2">
                                        <h4 class="font-bold text-mocha text-lg">${item.drinkName}</h4>
                                        <span class="text-latte font-black"><fmt:formatNumber value="${item.totalRevenue}" pattern="#,###"/> <span class="text-[10px] opacity-30">đ</span></span>
                                    </div>
                                    <!-- Simple Progress Bar -->
                                    <div class="h-2 w-full bg-coffee-50 rounded-full overflow-hidden">
                                        <div class="h-full bg-gradient-to-r from-coffee-700 to-caramel rounded-full transition-all duration-1000" 
                                             style="width: ${status.index == 0 ? '100%' : (100 - (status.index * 15))}%;"></div>
                                    </div>
                                    <div class="mt-2 text-[10px] font-black text-mocha/30 uppercase tracking-widest flex items-center gap-4">
                                        <span>Số Lượng Bán: ${item.totalQuantitySold} Ly</span>
                                        <span class="w-1 h-1 bg-mocha/10 rounded-full"></span>
                                        <span>Xếp Hạng: Top ${status.index + 1}</span>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty topDrinks}">
                            <div class="py-20 text-center text-mocha/20">
                                <i class="bi bi-activity text-5xl mb-3 block"></i>
                                <span class="font-bold">Đang chờ dữ liệu kinh doanh...</span>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Revenue Daily Card -->
            <div class="flex flex-col gap-6">
                <div class="flex items-center gap-4 px-6">
                    <div class="w-10 h-10 bg-mocha rounded-2xl flex items-center justify-center text-white text-lg">
                        <i class="bi bi-graph-up-arrow"></i>
                    </div>
                    <h2 class="text-2xl font-black text-mocha">Dòng Tiền Doanh Thu</h2>
                </div>

                <div class="glass p-0 rounded-[3rem] overflow-hidden bg-white">
                    <table class="w-full text-left order-collapse">
                        <thead>
                            <tr class="border-b border-coffee-50">
                                <th class="px-10 py-6 text-[10px] font-black text-mocha/30 uppercase tracking-[0.2em]">Ngày Giao Dịch</th>
                                <th class="px-8 py-6 text-[10px] font-black text-mocha/30 uppercase tracking-[0.2em]">Khối Lượng Đơn</th>
                                <th class="px-10 py-6 text-[10px] font-black text-mocha/30 uppercase tracking-[0.2em] text-right">Doanh Thu Ròng</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-coffee-50/50">
                            <c:forEach var="row" items="${revenueReport}">
                                <tr class="hover:bg-coffee-50/30 transition-colors">
                                    <td class="px-10 py-8 italic font-bold text-mocha">
                                        <fmt:formatDate value="${row.revenueDate}" pattern="MMMM dd, yyyy"/>
                                    </td>
                                    <td class="px-8 py-8 font-black text-latte">
                                        ${row.totalBills} <span class="text-[10px] opacity-40 font-bold ml-1">ĐƠN HÀNG</span>
                                    </td>
                                    <td class="px-10 py-8 text-right font-black text-mocha text-lg">
                                        <fmt:formatNumber value="${row.totalRevenue}" pattern="#,###"/> <span class="text-[10px] text-mocha/20 ml-1">đ</span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <c:if test="${empty revenueReport}">
                        <div class="py-32 text-center text-mocha/20">
                            <i class="bi bi-cloud-slash text-5xl mb-3 block"></i>
                            <span class="font-bold">Không thu thập được dữ liệu định kỳ.</span>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
