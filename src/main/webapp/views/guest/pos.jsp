<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%>

<c:if test="${not empty param.lang}">
    <c:set var="lang" value="${param.lang}" scope="session" />
</c:if>
<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html lang="${empty sessionScope.lang ? 'vi' : sessionScope.lang}">
<head>
    <title>PolyCoffee - Guest Order</title>
    <jsp:include page="/views/common/head.jsp" />
    <script src="${pageContext.request.contextPath}/assets/js/guest-pos.js" defer></script>
    <style>
        .active-category { @apply bg-indigo-600 text-white shadow-lg shadow-indigo-200; }
    </style>
</head>
<body class="bg-gray-50 flex flex-col h-screen overflow-hidden">

    <!-- Header -->
    <header class="bg-white/80 backdrop-blur-lg border-b border-gray-100 px-4 py-3 flex items-center justify-between sticky top-0 z-40">
        <a href="${pageContext.request.contextPath}">
            <div class="flex items-center gap-3">
                <div class="w-10 h-10 bg-indigo-600 rounded-xl flex items-center justify-center text-white shadow-lg shadow-indigo-200">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M13 10V3L4 14h7v7l9-11h-7z"/></svg>
                </div>
                <h1 class="font-black text-gray-900 leading-none">PolyCoffee</h1>
                <p id="tableInfo" class="text-[10px] font-bold text-indigo-600 uppercase tracking-widest mt-1">
                    <c:choose>
                        <c:when test="${not empty sessionScope.tableId}">Table #${sessionScope.tableId}</c:when>
                        <c:otherwise>TAKE AWAY</c:otherwise>
                    </c:choose>
                </p>
            </div>
        </a>
        
        <button id="guestInfoBtn" class="flex items-center gap-2 bg-gray-100 hover:bg-gray-200 px-3 py-2 rounded-xl transition-colors">
            <div id="guestAvatar" class="w-6 h-6 bg-white rounded-lg flex items-center justify-center text-gray-400">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/></svg>
            </div>
            <span id="guestInfoLabel" class="text-xs font-bold text-gray-700">Guest</span>
        </button>
    </header>

    <!-- Horizontal Categories -->
    <div class="bg-white px-4 py-3 border-b border-gray-100 overflow-x-auto hide-scroll flex gap-2 shrink-0">
        <button class="px-6 py-2 rounded-full text-sm font-bold transition-all whitespace-nowrap active-category category-btn" data-cat-id="0">All</button>
        <c:forEach var="cat" items="${categories}">
            <button class="px-6 py-2 rounded-full text-sm font-bold text-gray-500 bg-gray-50 hover:bg-gray-100 transition-all whitespace-nowrap category-btn" data-cat-id="${cat.id}">${cat.name}</button>
        </c:forEach>
    </div>

    <!-- Drinks Grid -->
    <main class="flex-grow overflow-y-auto p-4 md:p-6 bg-gray-50">
        <div id="drinksGrid" class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-6 gap-4 pb-24">
            <c:forEach var="d" items="${drinks}">
                <div class="bg-white rounded-3xl p-3 border border-gray-100 shadow-sm hover:shadow-xl transition-all cursor-pointer group active:scale-95 drink-card" 
                     data-id="${d.id}" data-name="${d.name}" data-price="${d.price}" data-image="${d.image}" data-cat-id="${d.category.id}">
                    <div class="aspect-square rounded-2xl bg-gray-100 mb-3 overflow-hidden relative">
                        <c:choose>
                            <c:when test="${not empty d.image}">
                                <c:set var="imgUrl" value="${fn:startsWith(d.image, 'http') ? d.image : pageContext.request.contextPath.concat('/uploads/').concat(d.image)}" />
                                <img src="${imgUrl}" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">
                            </c:when>
                            <c:otherwise>
                                <div class="w-full h-full flex items-center justify-center text-gray-300">
                                    <svg class="w-10 h-10" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M13 10V3L4 14h7v7l9-11h-7z"/></svg>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="absolute bottom-2 right-2 bg-indigo-600/90 backdrop-blur-md px-2 py-1 rounded-lg text-white font-black text-[10px] shadow-sm">
                            <fmt:formatNumber value="${d.price}" pattern="#,###" />₫
                        </div>
                    </div>
                    <h3 class="font-bold text-sm text-gray-900 line-clamp-2 leading-tight">${d.name}</h3>
                </div>
            </c:forEach>
        </div>
    </main>

    <!-- Bottom Cart Bar -->
    <div id="bottomCartBar" class="fixed bottom-0 left-0 right-0 bg-white/80 backdrop-blur-xl border-t border-gray-100 p-4 pb-8 z-40 translate-y-full transition-transform duration-300">
        <div class="max-w-md mx-auto flex items-center justify-between gap-4">
            <div class="flex flex-col">
                <span class="text-[10px] font-black text-gray-400 uppercase tracking-widest">Your Cart</span>
                <span id="cartTotalDisplay" class="text-xl font-black text-gray-900">0₫</span>
            </div>
            <button id="viewCartBtn" class="bg-indigo-600 hover:bg-indigo-700 text-white px-8 py-4 rounded-2xl font-black text-sm shadow-xl shadow-indigo-200 transition-all active:scale-95 flex items-center gap-2">
                View Order
                <span id="cartCountBadge" class="bg-white/20 px-2 py-0.5 rounded-lg text-xs">0</span>
            </button>
        </div>
    </div>

    <!-- Active Order Bar -->
    <div id="activeOrderBar" class="fixed bottom-0 left-0 right-0 bg-indigo-600 text-white p-4 pb-8 z-40 translate-y-full transition-transform duration-300">
        <div class="max-w-md mx-auto flex items-center justify-between gap-4">
            <div class="flex flex-col">
                <span class="text-[10px] font-black text-white/60 uppercase tracking-widest">Active Order <span id="activeOrderCode"></span></span>
                <span id="activeOrderStatus" class="text-xl font-black">PREPARING...</span>
            </div>
            <button onclick="window.location.reload()" class="bg-white text-indigo-600 px-6 py-3 rounded-2xl font-black text-xs shadow-xl transition-all active:scale-95">
                Refresh Status
            </button>
        </div>
    </div>

    <!-- Drink Options Modal -->
    <div id="drinkModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm z-[100] flex items-end sm:items-center justify-center hidden">
        <div class="bg-white w-full max-w-md rounded-t-3xl sm:rounded-3xl p-6 transform transition-all animate-popIn">
            <div class="flex gap-4 mb-6">
                <div id="modalDrinkImage" class="w-24 h-24 rounded-2xl bg-gray-100 overflow-hidden shrink-0"></div>
                <div class="flex flex-col justify-center">
                    <h2 id="modalDrinkName" class="text-xl font-black text-gray-900 leading-tight mb-1"></h2>
                    <span id="modalDrinkPrice" class="text-indigo-600 font-bold"></span>
                </div>
            </div>
            
            <div class="space-y-6">
                <div>
                    <label class="block text-xs font-black text-gray-400 uppercase tracking-widest mb-3">Quantity</label>
                    <div class="flex items-center gap-6">
                        <button onclick="changeModalQty(-1)" class="w-12 h-12 rounded-xl bg-gray-100 flex items-center justify-center text-gray-900 hover:bg-gray-200 transition-colors">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M20 12H4"/></svg>
                        </button>
                        <span id="modalQty" class="text-2xl font-black text-gray-900 w-8 text-center">1</span>
                        <button onclick="changeModalQty(1)" class="w-12 h-12 rounded-xl bg-indigo-600 flex items-center justify-center text-white hover:bg-indigo-700 transition-colors shadow-lg shadow-indigo-100">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M12 4v16m8-8H4"/></svg>
                        </button>
                    </div>
                </div>
                
                <div>
                    <label class="block text-xs font-black text-gray-400 uppercase tracking-widest mb-3">Special Requests</label>
                    <textarea id="modalNote" rows="2" placeholder="e.g. Less ice, extra sugar..." 
                              class="w-full bg-gray-50 border border-gray-100 rounded-2xl p-4 text-sm font-bold focus:outline-none focus:ring-2 focus:ring-indigo-500 transition-all"></textarea>
                </div>
            </div>

            <div class="flex gap-3 mt-8">
                <button id="closeDrinkModal" class="flex-1 py-4 bg-gray-100 text-gray-900 rounded-2xl font-black text-sm hover:bg-gray-200 transition-colors">Cancel</button>
                <button id="addToCartBtn" class="flex-2 px-8 py-4 bg-indigo-600 text-white rounded-2xl font-black text-sm hover:bg-indigo-700 shadow-xl shadow-indigo-100 transition-all">Add to Cart</button>
            </div>
        </div>
    </div>

    <!-- Cart Overview Modal -->
    <div id="cartModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm z-[150] flex items-end sm:items-center justify-center hidden">
        <div class="bg-white w-full max-w-md h-[80vh] sm:h-auto sm:max-h-[85vh] rounded-t-3xl sm:rounded-3xl p-6 flex flex-col transform transition-all">
            <div class="flex items-center justify-between mb-6">
                <h2 class="text-2xl font-black text-gray-900">Your Order</h2>
                <button id="closeCartModal" class="w-10 h-10 rounded-full bg-gray-100 flex items-center justify-center text-gray-500 hover:bg-gray-200">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M6 18L18 6M6 6l12 12"/></svg>
                </button>
            </div>
            
            <div id="cartItemsList" class="flex-grow overflow-y-auto space-y-4 pr-1 hide-scroll mb-6">
                <!-- Items injected here -->
            </div>
            
            <div class="border-t border-gray-100 pt-6 space-y-4">
                <div>
                    <label class="block text-xs font-black text-gray-400 uppercase tracking-widest mb-3 px-1">Payment Method</label>
                    <div class="grid grid-cols-2 gap-3">
                        <button type="button" onclick="selectPayment('VIETQR')" id="payVietQR" class="payment-opt-btn flex flex-col items-center justify-center p-3 rounded-2xl border-2 border-indigo-600 bg-indigo-50 text-indigo-600 transition-all">
                            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v1m6 11h2m-6 0h-2v4m0-11v3m0 0h.01M12 12h4.01M16 20h4M4 12h4m12 0h.01M5 8h2a1 1 0 001-1V5a1 1 0 00-1-1H5a1 1 0 00-1 1v2a1 1 0 001 1zm12 0h2a1 1 0 001-1V5a1 1 0 00-1-1h-2a1 1 0 00-1 1v2a1 1 0 001 1zM5 20h2a1 1 0 001-1v-2a1 1 0 00-1-1H5a1 1 0 00-1 1v2a1 1 0 001 1z"/></svg>
                            <span class="text-[10px] font-black uppercase">VietQR</span>
                        </button>
                        <button type="button" onclick="selectPayment('CASH')" id="payCash" class="payment-opt-btn flex flex-col items-center justify-center p-3 rounded-2xl border-2 border-transparent bg-gray-50 text-gray-400 grayscale hover:grayscale-0 transition-all">
                            <svg class="w-6 h-6 mb-1" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z"/></svg>
                            <span class="text-[10px] font-black uppercase">Cash</span>
                        </button>
                    </div>
                </div>

                <div class="flex items-center justify-between">
                    <span class="text-gray-500 font-bold">Total Amount</span>
                    <span id="finalTotal" class="text-3xl font-black text-indigo-600">0₫</span>
                </div>
                <button id="checkoutBtn" class="w-full py-5 bg-indigo-600 text-white rounded-3xl font-black text-lg hover:bg-indigo-700 shadow-2xl shadow-indigo-200 transition-all active:scale-95">
                    Place Order Now
                </button>
            </div>
        </div>
    </div>

    <!-- Payment Modal (VietQR) -->
    <div id="paymentModal" class="fixed inset-0 bg-black/80 backdrop-blur-xl z-[200] flex items-center justify-center hidden">
        <div class="bg-white w-full max-w-sm rounded-[3rem] p-8 mx-4 text-center transform shadow-2xl animate-popIn">
            <div class="w-20 h-20 bg-green-100 text-green-600 rounded-full flex items-center justify-center mx-auto mb-6">
                <svg class="w-10 h-10" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M5 13l4 4L19 7"/></svg>
            </div>
            <h2 class="text-2xl font-black text-gray-900 mb-2">Almost Done!</h2>
            <p class="text-gray-500 font-medium mb-8"><span id="paymentMethodLabel">Pay for</span> order <span id="paymentBillCode" class="text-indigo-600 font-black"></span></p>
            
            <div id="qrContainer" class="bg-gray-50 rounded-3xl p-6 mb-8 border-2 border-dashed border-gray-200">
                <img id="vietqrImg" src="" alt="Payment QR" class="w-full rounded-2xl shadow-lg border border-white">
                <p class="mt-4 text-xs font-black text-gray-400 uppercase tracking-widest">Open your banking app to scan</p>
            </div>

            <div id="cashContainer" class="hidden bg-indigo-50 rounded-3xl p-6 mb-8 border-2 border-dashed border-indigo-200">
                <div class="text-indigo-600 mb-2">
                    <svg class="w-12 h-12 mx-auto" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z"/></svg>
                </div>
                <p class="text-indigo-900 font-bold text-sm">Please pay <span id="paymentAmountLabel" class="font-black text-lg"></span> at the counter</p>
                <p class="mt-2 text-[10px] font-black text-indigo-400 uppercase tracking-widest">Wait for staff to confirm</p>
            </div>
            
            <button onclick="document.getElementById('paymentModal').classList.add('hidden')" class="w-full py-4 bg-gray-900 text-white rounded-2xl font-black text-sm hover:bg-black transition-all">
                Done, I've Paid
            </button>
        </div>
    </div>

    <!-- Guest Details Modal -->
    <div id="guestModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm z-[110] flex items-center justify-center hidden">
        <div class="bg-white w-full max-w-md rounded-3xl p-8 mx-4 shadow-2xl">
            <h2 class="text-2xl font-black text-gray-900 mb-1">Welcome! 👋</h2>
            <p class="text-gray-500 font-medium mb-8">Please tell us who you are.</p>
            
            <form id="guestForm" class="space-y-4">
                <div>
                    <label class="block text-xs font-black text-gray-400 uppercase tracking-widest mb-2 px-1">Your Name</label>
                    <input type="text" name="guestName" required placeholder="Nguyen Van A"
                           class="w-full bg-gray-50 border border-transparent rounded-2xl py-4 px-5 text-sm font-bold focus:bg-white focus:outline-none focus:ring-2 focus:ring-indigo-500 transition-all"/>
                </div>
                <div>
                    <label class="block text-xs font-black text-gray-400 uppercase tracking-widest mb-2 px-1">Phone Number</label>
                    <input type="tel" name="guestPhone" required placeholder="09xx xxx xxx"
                           class="w-full bg-gray-50 border border-transparent rounded-2xl py-4 px-5 text-sm font-bold focus:bg-white focus:outline-none focus:ring-2 focus:ring-indigo-500 transition-all"/>
                </div>
                <div class="pt-4">
                    <button type="submit" class="w-full py-4 bg-indigo-600 text-white rounded-2xl font-black text-sm hover:bg-indigo-700 shadow-xl shadow-indigo-100">Save info</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const contextPath = "${pageContext.request.contextPath}";
    </script>
</body>
</html>
