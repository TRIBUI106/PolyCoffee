<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<c:if test="${not empty param.lang}">
    <c:set var="lang" value="${param.lang}" scope="session"/>
</c:if>
<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html lang="${empty sessionScope.lang ? 'vi' : sessionScope.lang}">
<head>
    <title><fmt:message key="pos.title"/></title>
    <jsp:include page="/views/common/head.jsp" />
    <script>
        // Extend existing config for POS specific needs
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        coffee: {
                            50: '#fdf8f6',
                            100: '#f2e8e5',
                            500: '#c67f63',
                            700: '#6F4E37', 
                        },
                        pos: {
                            bg: '#f0f2f5', 
                            panel: '#ffffff',
                            border: '#e1e4e8',
                            text: '#1f2937',
                            muted: '#6b7280',
                            accent: '#0088ff', 
                            success: '#10b981', 
                            danger: '#ef4444',
                        }
                    },
                    fontFamily: { sans: ['Inter', 'sans-serif'] },
                    boxShadow: { 'pos': '0 0 10px rgba(0,0,0,0.05)' }
                }
            }
        }
    </script>
    <style>
        body { background-color: #f0f2f5; font-family: 'Inter', sans-serif; overflow: hidden; }
        .hide-scroll::-webkit-scrollbar { display: none; }
        .hide-scroll { -ms-overflow-style: none; scrollbar-width: none; }
        .pos-grid-scroll::-webkit-scrollbar { width: 6px; }
        .pos-grid-scroll::-webkit-scrollbar-track { background: transparent; }
        .pos-grid-scroll::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 4px; }
    </style>
</head>
<body class="h-screen w-screen flex flex-col text-pos-text select-none">

    <!-- POS Top Bar -->
    <header class="h-14 bg-white border-b border-pos-border px-4 flex items-center justify-between shrink-0 z-10 shadow-sm relative">
        <div class="flex items-center gap-4">
            <a href="${pageContext.request.contextPath}/" title="<fmt:message key='header.home'/>" 
               class="w-10 h-10 flex items-center justify-center bg-coffee-50 text-coffee-700 rounded-lg hover:bg-coffee-100 transition-colors">
                <i class="bi bi-house-door-fill text-xl"></i>
            </a>
            <div class="h-6 w-px bg-pos-border"></div>
            <h1 class="font-bold text-lg flex items-center gap-2">
                <i class="bi bi-display text-coffee-700"></i>
                <span>Smart POS</span>
                <span class="text-xs bg-coffee-100 text-coffee-700 px-2 py-0.5 rounded-full ml-2">v1.2</span>
            </h1>
        </div>
        <div class="flex items-center gap-6">
            <div class="relative w-80 hidden md:block">
                <i class="bi bi-search absolute left-3 top-1/2 -translate-y-1/2 text-pos-muted"></i>
                <input type="text" placeholder="<fmt:message key='pos.search.placeholder'/>" 
                       class="w-full bg-pos-bg border border-pos-border rounded-lg pl-10 pr-4 py-1.5 text-sm focus:outline-none focus:border-coffee-500 focus:ring-1 focus:ring-coffee-500 transition-all">
            </div>
            
            <!-- Language Switcher -->
            <div class="flex items-center bg-pos-bg border border-pos-border rounded-md p-1">
                <a href="?lang=vi" class="px-2 py-0.5 text-xs font-bold rounded ${sessionScope.lang == 'vi' || empty sessionScope.lang ? 'bg-white shadow-sm text-coffee-700' : 'text-pos-muted hover:text-pos-text'}">VI</a>
                <a href="?lang=en" class="px-2 py-0.5 text-xs font-bold rounded ${sessionScope.lang == 'en' ? 'bg-white shadow-sm text-coffee-700' : 'text-pos-muted hover:text-pos-text'}">EN</a>
            </div>

            <div class="flex items-center gap-3 border-l border-pos-border pl-6">
                <div class="text-right hidden sm:block">
                    <p class="text-sm font-bold leading-tight">${sessionScope.user.fullName}</p>
                    <p class="text-[11px] text-pos-muted uppercase tracking-wider"><fmt:message key='pos.bill.serve'/></p>
                </div>
                <div class="w-9 h-9 bg-coffee-700 text-white rounded-full flex items-center justify-center font-bold shadow-sm">
                    ${fn:substring(sessionScope.user.fullName, 0, 1)}
                </div>
            </div>
        </div>
    </header>

    <!-- Main Workspace -->
    <main class="flex-grow flex overflow-hidden">
        
        <!-- Center/Left: Categories & Grid -->
        <div class="flex-grow flex flex-col min-w-0">
            <!-- Categories Bar -->
            <div class="h-14 bg-white border-b border-pos-border px-4 flex items-center shrink-0 shadow-sm z-0">
                <div class="flex gap-2 overflow-x-auto hide-scroll pb-1 items-center h-full">
                    <button class="bg-coffee-700 text-white px-5 py-2 rounded-lg text-sm font-semibold whitespace-nowrap shadow-sm"><fmt:message key="pos.category.all"/></button>
                    <c:forEach var="cat" items="${categories}">
                        <button class="bg-pos-bg hover:bg-coffee-50 text-pos-text hover:text-coffee-700 border border-transparent hover:border-coffee-200 px-5 py-2 rounded-lg text-sm font-medium whitespace-nowrap transition-colors">${cat.name}</button>
                    </c:forEach>
                </div>
            </div>

            <!-- Products Grid -->
            <div class="flex-grow p-4 overflow-y-auto pos-grid-scroll bg-pos-bg">
                <div class="grid grid-cols-3 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6 gap-3 pb-8">
                    <c:forEach var="d" items="${drinks}">
                        <c:set var="urlParams" value="drinkId=${d.id}" />
                        <c:if test="${not empty currentBill}">
                            <c:set var="urlParams" value="${urlParams}&billId=${currentBill.id}" />
                        </c:if>
                        <div class="bg-white rounded-xl border border-pos-border overflow-hidden hover:shadow-lg hover:border-coffee-300 transition-all cursor-pointer flex flex-col h-full active:scale-[0.98] group"
                             onclick="location.href='${pageContext.request.contextPath}/employee/pos/add?${urlParams}'">
                            <div class="aspect-[4/3] bg-pos-bg relative overflow-hidden">
                                <c:choose>
                                    <c:when test="${not empty d.image}">
                                        <c:set var="imgUrl" value="${fn:startsWith(d.image, 'http') ? d.image : pageContext.request.contextPath.concat('/uploads/').concat(d.image)}" />
                                        <img src="${imgUrl}" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="w-full h-full flex items-center justify-center text-pos-muted text-4xl group-hover:scale-110 transition-transform duration-500">
                                            <i class="bi bi-cup-hot"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <!-- Price overlay -->
                                <div class="absolute bottom-2 right-2 bg-black/75 backdrop-blur-sm text-white text-xs font-bold px-2 py-1 rounded shadow-sm">
                                    <fmt:formatNumber value="${d.price}" pattern="#,###"/>
                                </div>
                            </div>
                            <div class="p-2.5 flex-grow flex flex-col justify-between">
                                <h3 class="text-sm font-semibold text-pos-text line-clamp-2 leading-tight">${d.name}</h3>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!-- Right Side: Order/Cart -->
        <div class="w-[380px] xl:w-[420px] bg-white border-l border-pos-border flex flex-col shrink-0 relative z-20 shadow-[-5px_0_15px_-5px_rgba(0,0,0,0.05)]">
            
            <!-- Cart Header -->
            <div class="h-14 border-b border-pos-border px-4 flex items-center justify-between shrink-0 bg-white">
                <div class="flex-grow flex items-center gap-2">
                    <button class="text-pos-text hover:text-coffee-700 bg-pos-bg p-2 rounded-lg transition-colors border border-pos-border shadow-sm">
                        <i class="bi bi-person-plus-fill text-lg"></i>
                    </button>
                    <div class="flex-grow">
                        <p class="text-center font-bold text-sm bg-pos-bg py-2 rounded-lg border border-pos-border text-pos-text cursor-pointer hover:bg-gray-200 transition-colors shadow-sm">
                            <i class="bi bi-search mr-1 text-pos-muted"></i>
                            <fmt:message key="pos.customer.retail"/>
                        </p>
                    </div>
                </div>
            </div>

            <!-- Context Info -->
            <div class="flex items-center px-4 py-2.5 border-b border-pos-border bg-gray-50 text-xs font-semibold text-pos-muted uppercase tracking-wider">
                <span class="w-10"><fmt:message key="pos.table"/></span>
                <span class="ml-2 px-2.5 py-0.5 bg-coffee-100 text-coffee-700 rounded mr-auto"><fmt:message key="pos.takeaway"/></span>
                <span class="">
                    <fmt:message key="pos.bill.code"/>: 
                    <c:choose>
                        <c:when test="${not empty currentBill}">${currentBill.code}</c:when>
                        <c:otherwise><fmt:message key="pos.bill.new"/></c:otherwise>
                    </c:choose>
                </span>
            </div>

            <!-- Cart Items -->
            <div class="flex-grow overflow-y-auto pos-grid-scroll bg-white">
                <c:choose>
                    <c:when test="${not empty currentBill.billDetails}">
                        <table class="w-full text-sm">
                            <c:forEach var="item" items="${currentBill.billDetails}" varStatus="status">
                                <tr class="border-b border-pos-border hover:bg-pos-bg group transition-colors">
                                    <td class="p-3 w-8 text-center text-pos-muted text-xs align-top pt-4 font-medium">${status.index + 1}</td>
                                    <td class="py-3 pr-2 align-top">
                                        <div class="font-bold text-pos-text leading-tight mb-1">${item.drink.name}</div>
                                        <div class="text-[13px] text-pos-muted"><fmt:formatNumber value="${item.price}" pattern="#,###"/></div>
                                        
                                        <!-- Note Field (Visual only for real feel) -->
                                        <div class="mt-2 flex items-center gap-1 text-[11px] text-pos-muted hover:text-coffee-700 cursor-pointer w-max pl-1 border-l-2 border-transparent hover:border-coffee-500">
                                            <i class="bi bi-pencil-square"></i> <fmt:message key="pos.item.note"/>
                                        </div>
                                    </td>
                                    <td class="py-3 px-1 w-[110px] align-top">
                                        <div class="flex items-center bg-white border border-pos-border rounded-md shrink-0 overflow-hidden shadow-sm h-8 mt-1">
                                            <button class="w-8 h-full flex items-center justify-center text-pos-text hover:bg-gray-100 border-r border-pos-border shrink-0 active:bg-gray-200"
                                                    onclick="location.href='${pageContext.request.contextPath}/employee/pos/update?billId=${currentBill.id}&drinkId=${item.drink.id}&quantity=${item.quantity - 1}'">
                                                <i class="bi bi-dash"></i>
                                            </button>
                                            <input type="text" value="${item.quantity}" readonly class="w-8 h-full text-center font-bold text-sm bg-transparent outline-none p-0 cursor-default select-none">
                                            <button class="w-8 h-full flex items-center justify-center text-pos-text hover:bg-gray-100 border-l border-pos-border shrink-0 active:bg-gray-200"
                                                    onclick="location.href='${pageContext.request.contextPath}/employee/pos/update?billId=${currentBill.id}&drinkId=${item.drink.id}&quantity=${item.quantity + 1}'">
                                                <i class="bi bi-plus"></i>
                                            </button>
                                        </div>
                                    </td>
                                    <td class="py-3 pl-2 pr-4 text-right font-bold text-pos-text w-24 align-top pt-4">
                                        <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="h-full flex flex-col items-center justify-center text-pos-muted opacity-40">
                            <i class="bi bi-cart-x text-6xl mb-4 text-coffee-300"></i>
                            <p class="font-medium text-lg"><fmt:message key="pos.bill.empty"/></p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Cart Footer (Checkout) -->
            <div class="border-t border-pos-border bg-white shrink-0 shadow-[0_-5px_15px_-5px_rgba(0,0,0,0.05)]">
                <!-- Summary -->
                <div class="px-4 py-3 space-y-2 text-sm border-b border-pos-border bg-gray-50/30">
                    <div class="flex justify-between items-center text-pos-text">
                        <span><fmt:message key="pos.bill.total"/> (<c:out value="${fn:length(currentBill.billDetails)}"/> <fmt:message key="pos.bill.items"/>)</span>
                        <span class="font-bold text-base"><fmt:formatNumber value="${currentBill.total}" pattern="#,###"/></span>
                    </div>
                    <div class="flex justify-between items-center text-pos-muted">
                        <span><fmt:message key="pos.bill.discount"/> (F4)</span>
                        <span class="cursor-pointer border-b border-dashed border-pos-muted">0</span>
                    </div>
                </div>
                
                <!-- Total & Big Buttons -->
                <div class="p-4 bg-white">
                    <div class="flex justify-between items-center mb-4">
                        <span class="font-bold text-pos-text text-sm"><fmt:message key="pos.bill.payable"/></span>
                        <span class="text-3xl font-extrabold text-coffee-700 tracking-tight">
                            <fmt:formatNumber value="${currentBill.total != null ? currentBill.total : 0}" pattern="#,###"/>
                        </span>
                    </div>
                    
                    <fmt:message key="pos.bill.confirm.cancel" var="msgCancel" />
                    <fmt:message key="pos.bill.confirm.checkout" var="msgCheckout" />
                    
                    <div class="grid grid-cols-5 gap-3">
                        <!-- Extra Actions (Cancel) -->
                        <button class="col-span-1 border-2 border-pos-border text-pos-danger rounded-xl h-14 flex items-center justify-center font-bold text-xl hover:bg-red-50 hover:border-red-200 transition-colors ${empty currentBill.billDetails ? 'opacity-50 cursor-not-allowed' : 'active:scale-95'}"
                                ${empty currentBill.billDetails ? 'disabled' : ''}
                                onclick="if(confirm('${msgCancel}')) location.href='${pageContext.request.contextPath}/employee/pos/cancel?billId=${currentBill.id}'"
                                title="Huỷ đơn">
                            <i class="bi bi-trash3"></i>
                        </button>
                        
                        <!-- Pay Button -->
                        <button class="col-span-4 bg-[#10b981] hover:bg-[#059669] rounded-xl h-14 flex items-center justify-center gap-2 text-white font-bold text-lg shadow-[0_4px_14px_0_rgba(16,185,129,0.39)] transition-all ${empty currentBill.billDetails ? 'opacity-50 cursor-not-allowed shadow-none hover:bg-[#10b981]' : 'hover:-translate-y-0.5 active:translate-y-0 active:scale-95'}"
                                ${empty currentBill.billDetails ? 'disabled' : ''}
                                onclick="if(confirm('${msgCheckout}')) location.href='${pageContext.request.contextPath}/employee/pos/checkout?billId=${currentBill.id}'">
                            <i class="bi bi-cash-stack text-xl"></i>
                            <span class="tracking-wide"><fmt:message key="pos.bill.checkout"/> (F9)</span>
                        </button>
                    </div>
                </div>
            </div>
            
        </div>
    </main>

</body>
</html>
