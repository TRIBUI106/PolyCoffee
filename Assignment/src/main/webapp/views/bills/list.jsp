<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html class="h-full bg-gray-50">
<head>
    <title><fmt:message key="admin.bill.title"/> - PolyCoffee</title>
    <jsp:include page="/views/common/head.jsp" />
</head>
<body class="bg-gray-50 font-sans min-h-screen text-gray-800">
    <jsp:include page="../common/header.jsp" />

    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <div class="mb-10 flex flex-col md:flex-row md:items-end md:justify-between gap-6">
            <div>
                <h1 class="text-3xl font-bold text-gray-900 tracking-tight mb-2"><fmt:message key="admin.bill.subtitle"/></h1>
                <p class="text-gray-500 font-medium text-xs tracking-widest uppercase"><fmt:message key="admin.bill.desc"/></p>
            </div>
            
            <form action="${pageContext.request.contextPath}/manager/bills" method="get" class="flex flex-wrap items-center gap-3 bg-white p-2 rounded-2xl border border-gray-200 shadow-sm">
                <div class="relative flex-grow min-w-[240px]">
                    <i class="bi bi-search absolute left-4 top-1/2 -translate-y-1/2 text-gray-400"></i>
                    <input type="text" name="query" value="${param.query}" placeholder="<fmt:message key='admin.bill.search.placeholder'/>" 
                        class="w-full pl-11 pr-4 py-2.5 bg-gray-50 border-transparent focus:bg-white focus:ring-2 focus:ring-coffee-500 focus:border-coffee-500 rounded-xl text-sm transition-all">
                </div>
                
                <select name="status" onchange="this.form.submit()" 
                    class="pl-4 pr-10 py-2.5 bg-gray-50 border-transparent focus:bg-white focus:ring-2 focus:ring-coffee-500 focus:border-coffee-500 rounded-xl text-sm font-semibold text-gray-700 transition-all cursor-pointer">
                    <option value="ALL" ${param.status == 'ALL' ? 'selected' : ''}><fmt:message key="admin.bill.status.all"/></option>
                    <option value="WAITING" ${param.status == 'WAITING' ? 'selected' : ''}><fmt:message key="admin.bill.status.waiting"/></option>
                    <option value="FINISHED" ${param.status == 'FINISHED' ? 'selected' : ''}><fmt:message key="admin.bill.status.finished"/></option>
                    <option value="CANCELLED" ${param.status == 'CANCELLED' ? 'selected' : ''}><fmt:message key="admin.bill.status.cancelled"/></option>
                </select>
                
                <button type="submit" class="bg-coffee-600 hover:bg-coffee-700 text-white font-bold py-2.5 px-6 rounded-xl text-sm transition-all shadow-md shadow-coffee-200">
                    <fmt:message key="admin.bill.search.btn"/>
                </button>
            </form>
        </div>

        <div class="flex flex-col xl:flex-row gap-8 items-start">
            
            <!-- Ledger List -->
            <div class="flex-grow w-full">
                <div class="bg-white border border-gray-200 overflow-hidden rounded-2xl shadow-sm">
                    <div class="overflow-x-auto">
                        <table class="w-full text-left collapse">
                            <thead>
                                <tr class="bg-gray-50/50 border-b border-gray-100">
                                    <th class="px-8 py-5 text-xs font-bold text-gray-500 uppercase tracking-wider"><fmt:message key="admin.bill.table.id"/></th>
                                    <th class="px-6 py-5 text-xs font-bold text-gray-500 uppercase tracking-wider"><fmt:message key="admin.bill.table.time"/></th>
                                    <th class="px-6 py-5 text-xs font-bold text-gray-500 uppercase tracking-wider"><fmt:message key="admin.bill.table.total"/></th>
                                    <th class="px-6 py-5 text-xs font-bold text-gray-500 uppercase tracking-wider text-center"><fmt:message key="admin.bill.table.status"/></th>
                                    <th class="px-8 py-5 text-xs font-bold text-gray-500 uppercase tracking-wider text-right"><fmt:message key="admin.bill.table.action"/></th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-100">
                                <c:forEach var="b" items="${bills}">
                                    <tr class="group hover:bg-gray-50 transition-colors ${bill.id == b.id ? 'bg-coffee-50/50' : ''}">
                                        <td class="px-8 py-5">
                                            <div class="bg-gray-800 text-white text-[10px] font-bold px-2.5 py-1 rounded inline-block mb-1">${b.code}</div>
                                            <div class="text-xs font-semibold text-gray-400 uppercase tracking-tight"><fmt:message key="admin.bill.label.secure"/></div>
                                        </td>
                                        <td class="px-6 py-5">
                                            <div class="text-sm font-semibold text-gray-900 capitalize"><fmt:formatDate value="${b.createdAt}" pattern="MMM dd, yyyy"/></div>
                                            <div class="text-xs font-medium text-gray-500"><fmt:formatDate value="${b.createdAt}" pattern="hh:mm a"/></div>
                                        </td>
                                        <td class="px-6 py-5">
                                            <div class="font-bold text-gray-900 text-base"><fmt:formatNumber value="${b.total}" pattern="#,###"/> <span class="text-[10px] text-gray-400"><fmt:message key="common.currency"/></span></div>
                                        </td>
                                        <td class="px-6 py-5 text-center">
                                            <span class="inline-flex py-1 px-3 rounded-md text-xs font-bold border 
                                                ${b.status == 'FINISHED' ? 'bg-green-50 text-green-700 border-green-200' : (b.status == 'CANCELLED' ? 'bg-red-50 text-red-700 border-red-200' : 'bg-orange-50 text-orange-600 border-orange-200')}">
                                                ${b.status}
                                            </span>
                                        </td>
                                        <td class="px-8 py-5 text-right">
                                            <a href="?id=${b.id}" class="w-9 h-9 inline-flex items-center justify-center rounded-lg bg-white text-gray-600 hover:bg-coffee-600 hover:text-white hover:border-coffee-600 shadow-sm border border-gray-200 transition-all">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Detail Sidebar -->
            <c:if test="${not empty bill}">
                <div class="xl:w-[450px] sticky top-24 shrink-0 w-full mb-10 xl:mb-0">
                    <div class="bg-white p-6 sm:p-8 rounded-2xl border border-gray-200 shadow-sm flex flex-col h-[calc(100vh-8rem)]">
                        <div class="flex items-center justify-between mb-6 pb-4 border-b border-gray-100 flex-shrink-0">
                            <div>
                                <h2 class="text-lg font-bold text-gray-900"><fmt:message key="admin.bill.detail.title"/></h2>
                                <p class="text-[10px] font-bold text-gray-400 tracking-widest uppercase"><fmt:message key="admin.bill.detail.desc"/></p>
                            </div>
                            <a href="${pageContext.request.contextPath}/manager/bills" class="w-8 h-8 flex items-center justify-center rounded-lg hover:bg-gray-100 text-gray-400 hover:text-gray-600 transition-colors">
                                <i class="bi bi-x-lg"></i>
                            </a>
                        </div>

                        <div class="flex-grow overflow-y-auto pr-2 space-y-4 mb-6 custom-scrollbar">
                            <c:forEach var="item" items="${bill.billDetails}">
                                <div class="flex flex-wrap sm:flex-nowrap items-center justify-between group py-2 border-b border-gray-50 last:border-0 gap-2">
                                    <div class="flex items-center gap-3 w-full sm:w-auto">
                                        <div class="w-8 h-8 bg-gray-50 rounded-lg flex items-center justify-center text-gray-700 font-bold text-xs border border-gray-100 flex-shrink-0">
                                            ${item.quantity}<span class="text-[8px] ml-0.5 text-gray-400">x</span>
                                        </div>
                                        <div class="flex-grow min-w-0">
                                            <h4 class="font-bold text-gray-900 text-sm truncate w-[200px] xl:w-[150px]"><c:out value="${item.drink.name}" /></h4>
                                            <p class="text-xs text-gray-500 font-medium"><fmt:message key="admin.bill.detail.price"/>: <fmt:formatNumber value="${item.price}" pattern="#,###"/> đ</p>
                                        </div>
                                    </div>
                                    <div class="text-gray-900 font-bold text-sm sm:w-auto w-full text-right">
                                        <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/> <span class="text-[10px] text-gray-400"><fmt:message key="common.currency"/></span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="bg-gray-50 p-5 rounded-xl space-y-3 flex-shrink-0 border border-gray-100">
                            <div class="flex justify-between text-[10px] font-bold tracking-widest uppercase mb-1">
                                <span class="text-gray-400"><fmt:message key="admin.bill.detail.info"/></span>
                                <span class="text-gray-500"><fmt:message key="admin.bill.detail.check"/></span>
                            </div>
                            <div class="flex justify-between items-center text-sm">
                                <span class="text-gray-500 font-medium"><fmt:message key="admin.bill.detail.status"/></span>
                                <span class="font-bold text-gray-900">${bill.status}</span>
                            </div>
                            <div class="flex justify-between items-center text-sm">
                                <span class="text-gray-500 font-medium"><fmt:message key="admin.bill.detail.staff"/></span>
                                <span class="font-bold text-gray-900">${bill.user.fullName}</span>
                            </div>
                            <div class="flex justify-between items-center text-sm">
                                <span class="text-gray-500 font-medium"><fmt:message key="admin.bill.detail.ref"/></span>
                                <span class="font-bold text-gray-900">#0${bill.id}</span>
                            </div>
                            
                            <hr class="border-gray-200 my-3">
                            
                            <div class="flex flex-wrap lg:flex-nowrap justify-between items-end gap-2">
                                <span class="text-base font-bold text-gray-900"><fmt:message key="admin.bill.detail.total"/></span>
                                <span class="text-xl md:text-2xl font-black text-coffee-700 tracking-tight"><fmt:formatNumber value="${bill.total}" pattern="#,###"/> <span class="text-sm text-gray-500 font-bold text-opacity-80"><fmt:message key="common.currency"/></span></span>
                            </div>
                        </div>

                        <button onclick="window.print()" class="w-full mt-4 bg-white border border-gray-200 text-gray-700 hover:bg-gray-50 font-semibold py-3 flex flex-shrink-0 items-center justify-center gap-2 rounded-xl transition-colors">
                            <i class="bi bi-printer text-gray-400"></i>
                            <fmt:message key="admin.bill.detail.print"/>
                        </button>
                    </div>
                </div>
            </c:if>

        </div>
    </main>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
