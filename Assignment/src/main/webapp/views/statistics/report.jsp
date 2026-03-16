<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html class="h-full bg-gray-50">
<head>
    <title><fmt:message key="admin.report.title"/> - PolyCoffee</title>
</head>
<body class="bg-gray-50 font-sans min-h-screen text-gray-800">
    <jsp:include page="../common/header.jsp" />

    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <div class="flex flex-col lg:flex-row lg:items-center justify-between gap-8 mb-10">
            <div>
                <h1 class="text-3xl font-bold text-gray-900 tracking-tight mb-2"><fmt:message key="admin.report.subtitle"/></h1>
                <p class="text-gray-500 font-medium text-xs tracking-widest uppercase"><fmt:message key="admin.report.desc"/></p>
            </div>
            
            <form action="" method="get" class="bg-white p-3 rounded-2xl flex flex-wrap lg:flex-nowrap items-center gap-4 border border-gray-200 shadow-sm">
                <div class="flex items-center gap-2 pl-4">
                    <i class="bi bi-calendar-event text-gray-400"></i>
                    <span class="text-[10px] font-bold text-gray-400 uppercase tracking-widest"><fmt:message key="admin.report.filter.time"/></span>
                </div>
                <input type="date" name="from" class="bg-gray-50 px-4 py-2.5 rounded-xl outline-none font-bold text-sm text-gray-700 border border-transparent focus:border-coffee-500 focus:bg-white transition-colors" value="${param.from}">
                <div class="text-gray-300 font-bold">—</div>
                <input type="date" name="to" class="bg-gray-50 px-4 py-2.5 rounded-xl outline-none font-bold text-sm text-gray-700 border border-transparent focus:border-coffee-500 focus:bg-white transition-colors" value="${param.to}">
                <button type="submit" class="bg-coffee-700 hover:bg-coffee-800 text-white font-semibold py-2.5 px-6 rounded-xl text-sm transition-colors shadow-sm"><fmt:message key="admin.report.filter.btn"/></button>
            </form>
        </div>

        <div class="grid grid-cols-1 xl:grid-cols-2 gap-8 mb-16">
            <!-- Best Sellers Card -->
            <div class="flex flex-col gap-5">
                <div class="flex items-center gap-3 px-2">
                    <div class="w-10 h-10 bg-coffee-100 rounded-xl flex items-center justify-center text-coffee-700 text-lg">
                        <i class="bi bi-award"></i>
                    </div>
                    <h2 class="text-xl font-bold text-gray-900"><fmt:message key="admin.report.best.title"/></h2>
                </div>

                <div class="bg-white border border-gray-200 p-8 rounded-2xl shadow-sm">
                    <div class="space-y-6">
                        <c:forEach var="item" items="${topDrinks}" varStatus="status">
                            <div class="group relative flex items-center gap-5">
                                <div class="w-12 h-12 rounded-xl border flex items-center justify-center font-bold transition-all ${status.index == 0 ? 'bg-orange-50 text-orange-600 border-orange-200' : 'bg-gray-50 text-gray-500 border-gray-200 group-hover:bg-white'}">
                                    ${status.index + 1}
                                </div>
                                <div class="flex-grow">
                                    <div class="flex items-center justify-between mb-1.5">
                                        <h4 class="font-bold text-gray-900">${item.drinkName}</h4>
                                        <span class="text-gray-900 font-bold"><fmt:formatNumber value="${item.totalRevenue}" pattern="#,###"/> <span class="text-[10px] text-gray-400">VNĐ</span></span>
                                    </div>
                                    <!-- Simple Progress Bar -->
                                    <div class="h-1.5 w-full bg-gray-100 rounded-full overflow-hidden">
                                        <div class="h-full bg-coffee-600 rounded-full transition-all duration-1000" 
                                             style="width: ${status.index == 0 ? '100%' : (100 - (status.index * 15))}%;"></div>
                                    </div>
                                    <div class="mt-2 text-[10px] font-bold text-gray-400 uppercase tracking-widest flex items-center gap-3">
                                        <span><fmt:message key="admin.report.best.sold"/>: ${item.totalQuantitySold} <fmt:message key="admin.report.best.cup"/></span>
                                        <span class="w-1 h-1 bg-gray-200 rounded-full"></span>
                                        <span><fmt:message key="admin.report.best.rank"/>: Top ${status.index + 1}</span>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty topDrinks}">
                            <div class="py-16 text-center text-gray-400">
                                <i class="bi bi-activity text-4xl mb-3 block"></i>
                                <span class="font-medium"><fmt:message key="admin.report.best.empty"/></span>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Revenue Daily Card -->
            <div class="flex flex-col gap-5">
                <div class="flex items-center gap-3 px-2">
                    <div class="w-10 h-10 bg-blue-50 rounded-xl flex items-center justify-center text-blue-600 text-lg">
                        <i class="bi bi-graph-up-arrow"></i>
                    </div>
                    <h2 class="text-xl font-bold text-gray-900"><fmt:message key="admin.report.rev.title"/></h2>
                </div>

                <div class="bg-white border border-gray-200 rounded-2xl overflow-hidden shadow-sm">
                    <table class="w-full text-left collapse">
                        <thead>
                            <tr class="border-b border-gray-100 bg-gray-50/50">
                                <th class="px-8 py-5 text-xs font-bold text-gray-500 uppercase tracking-wider"><fmt:message key="admin.report.rev.date"/></th>
                                <th class="px-6 py-5 text-xs font-bold text-gray-500 uppercase tracking-wider"><fmt:message key="admin.report.rev.volume"/></th>
                                <th class="px-8 py-5 text-xs font-bold text-gray-500 uppercase tracking-wider text-right"><fmt:message key="admin.report.rev.net"/></th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100">
                            <c:forEach var="row" items="${revenueReport}">
                                <tr class="hover:bg-gray-50 transition-colors">
                                    <td class="px-8 py-5 font-semibold text-gray-900">
                                        <fmt:formatDate value="${row.revenueDate}" pattern="MMM dd, yyyy"/>
                                    </td>
                                    <td class="px-6 py-5 font-bold text-gray-600">
                                        ${row.totalBills} <span class="text-[10px] text-gray-400 ml-1"><fmt:message key="admin.report.rev.bills"/></span>
                                    </td>
                                    <td class="px-8 py-5 text-right font-black text-gray-900">
                                        <fmt:formatNumber value="${row.totalRevenue}" pattern="#,###"/> <span class="text-[10px] text-gray-400 ml-0.5">VNĐ</span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <c:if test="${empty revenueReport}">
                        <div class="py-24 text-center text-gray-400 border-t border-gray-100">
                            <i class="bi bi-cloud-slash text-4xl mb-3 block"></i>
                            <span class="font-medium"><fmt:message key="admin.report.rev.empty"/></span>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
