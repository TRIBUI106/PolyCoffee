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
    <title><fmt:message key="pos.title" /> - Guest</title>
    <!-- Basic meta and tailwind -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="${pageContext.request.contextPath}/assets/css/guest.css" rel="stylesheet"/>
    <script src="${pageContext.request.contextPath}/assets/js/guest-pos.js" defer></script>
</head>
<body class="bg-gray-50 font-sans text-gray-800 h-screen flex flex-col overflow-hidden select-none">

<!-- Header -->
<header class="h-14 bg-white/80 backdrop-blur-md border-b border-gray-200 flex items-center px-4 shadow-sm z-10 shrink-0">
    <h1 class="text-xl font-bold flex items-center gap-2 text-indigo-600">
        <svg class="w-6 h-6" fill="none" stroke="currentColor"
             viewBox="0 0 24 24"><path stroke-linecap="round"
             stroke-linejoin="round" stroke-width="2"
             d="M3 7h18M3 12h18M3 17h18"/></svg>
        <span>Guest POS</span>
    </h1>
    
    <div class="ml-auto flex items-center gap-4">
        <!-- Range filter (simulated UI requested) -->
        <div class="hidden sm:flex items-center gap-2 bg-gray-100 px-3 py-1 rounded-full border border-gray-200">
            <svg class="w-4 h-4 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z"/></svg>
            <input id="amountInput" type="number" placeholder="Max ₫"
                   class="w-20 bg-transparent text-sm font-semibold text-gray-700 outline-none"/>
            <input id="amountRange" type="range" min="0" max="1000000" step="1000" class="w-24 accent-indigo-600"/>
        </div>

        <!-- Language Switcher -->
        <div class="flex items-center bg-gray-100 border border-gray-200 rounded-lg p-1">
            <a href="?lang=vi"
               class="px-2 py-0.5 text-xs font-bold rounded ${sessionScope.lang == 'vi' || empty sessionScope.lang ? 'bg-white shadow-sm text-indigo-600' : 'text-gray-500 hover:text-gray-700'}">VI</a>
            <a href="?lang=en"
               class="px-2 py-0.5 text-xs font-bold rounded ${sessionScope.lang == 'en' ? 'bg-white shadow-sm text-indigo-600' : 'text-gray-500 hover:text-gray-700'}">EN</a>
        </div>

        <button id="guestInfoBtn"
                class="px-4 py-1.5 bg-indigo-600 text-white text-sm font-bold rounded-lg hover:bg-indigo-700 transition shadow-md flex items-center gap-2">
            <svg class="w-4 h-4" fill="none" stroke="currentColor"
                 viewBox="0 0 24 24"><path stroke-linecap="round"
                 stroke-linejoin="round" stroke-width="2"
                 d="M5.121 17.804A9 9 0 1118.88 6.196M15 11a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
            <span id="guestInfoLabel">Guest</span>
        </button>
    </div>
</header>

<!-- Toast Container -->
<div id="toastContainer" class="fixed top-20 right-5 z-50 flex flex-col gap-2"></div>

<!-- Main Section -->
<main class="flex-grow flex overflow-hidden">
    <!-- Category sidebar -->
    <aside class="w-24 md:w-48 bg-white border-r border-gray-200 flex flex-col shrink-0 overflow-y-auto hide-scroll">
        <div class="p-3">
            <button class="w-full mb-3 py-2.5 bg-indigo-600 text-white rounded-xl text-sm font-bold shadow-md shadow-indigo-200 transition-transform active:scale-95 text-center"
                    data-cat-id="0">All</button>
            <c:forEach var="cat" items="${categories}">
                <button class="w-full mb-3 py-2.5 bg-gray-50 hover:bg-indigo-50 border border-transparent hover:border-indigo-100 text-gray-700 hover:text-indigo-700 rounded-xl text-sm font-semibold transition-all text-center break-words"
                        data-cat-id="${cat.id}">${cat.name}</button>
            </c:forEach>
        </div>
    </aside>

    <!-- Drinks Grid -->
    <section class="flex-grow p-4 md:p-6 overflow-y-auto bg-gray-50 scroll-smooth">
        <div id="drinksGrid" class="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4 md:gap-6 pb-20">
            <c:forEach var="d" items="${drinks}">
                <div class="bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all cursor-pointer group flex flex-col overflow-hidden"
                     onclick="addDrink(${d.id})">
                    <div class="aspect-square bg-gray-100 relative overflow-hidden">
                        <c:choose>
                            <c:when test="${not empty d.image}">
                                <c:set var="imgUrl"
                                       value="${fn:startsWith(d.image, 'http') ? d.image : pageContext.request.contextPath.concat('/uploads/').concat(d.image)}" />
                                <img src="${imgUrl}"
                                     class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">
                            </c:when>
                            <c:otherwise>
                                <div class="w-full h-full flex items-center justify-center text-gray-300">
                                    <svg class="w-12 h-12" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M13 10V3L4 14h7v7l9-11h-7z"/></svg>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <!-- Price overlay -->
                        <div class="absolute bottom-2 right-2 bg-white/90 backdrop-blur-sm text-indigo-700 text-xs font-black px-2 py-1 rounded-lg shadow-sm border border-indigo-100">
                            <fmt:formatNumber value="${d.price}" pattern="#,###" />₫
                        </div>
                    </div>
                    <div class="p-3">
                        <h3 class="font-bold text-sm text-gray-800 line-clamp-2 leading-tight group-hover:text-indigo-600 transition-colors">${d.name}</h3>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>
</main>

<!-- Pending Bill Notification (if redirected after purchase) -->
<c:if test="${not empty param.billId}">
    <div id="successModal" class="fixed inset-0 bg-black/40 backdrop-blur-sm flex items-center justify-center z-[100] animate-fadeIn">
        <div class="bg-white rounded-2xl shadow-2xl p-8 max-w-sm w-full mx-4 text-center transform scale-100 transition-transform animate-popIn">
            <div class="w-16 h-16 bg-green-100 text-green-600 rounded-full flex items-center justify-center mx-auto mb-4">
                <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/></svg>
            </div>
            <h2 class="text-2xl font-black text-gray-900 mb-2">Order Placed!</h2>
            <p class="text-gray-500 text-sm mb-6">Your order #${param.billId} has been sent to the staff. Please wait while we process it.</p>
            <button onclick="document.getElementById('successModal').remove()" class="w-full py-3 bg-gray-900 text-white rounded-xl font-bold hover:bg-black transition-colors">
                Continue Browsing
            </button>
        </div>
    </div>
</c:if>

<!-- Guest Info Modal -->
<div id="guestModal" class="fixed inset-0 bg-black/40 backdrop-blur-sm flex items-center justify-center z-[60] hidden transition-opacity">
    <div class="bg-white rounded-2xl shadow-2xl w-full max-w-md p-6 mx-4 transform transition-all">
        <h2 class="text-xl font-black text-gray-900 mb-1">Welcome! 👋</h2>
        <p class="text-sm text-gray-500 mb-5">Please enter your details to order.</p>
        
        <form id="guestForm" class="space-y-4">
            <div>
                <label class="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-1">Your Name</label>
                <div class="relative">
                    <svg class="w-5 h-5 absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/></svg>
                    <input type="text" name="guestName" required placeholder="John Doe"
                           class="w-full bg-gray-50 border border-gray-200 rounded-xl py-3 pl-10 pr-4 text-sm font-semibold focus:bg-white focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition-all"/>
                </div>
            </div>
            <div>
                <label class="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-1">Phone Number</label>
                <div class="relative">
                    <svg class="w-5 h-5 absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/></svg>
                    <input type="tel" name="guestPhone" required placeholder="0123 456 789"
                           class="w-full bg-gray-50 border border-gray-200 rounded-xl py-3 pl-10 pr-4 text-sm font-semibold focus:bg-white focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition-all"/>
                </div>
            </div>
            <div class="flex gap-3 pt-2">
                <button type="button" id="guestCancel"
                        class="flex-1 py-3 bg-white border border-gray-200 text-gray-700 rounded-xl font-bold hover:bg-gray-50 transition-colors">Cancel</button>
                <button type="submit"
                        class="flex-1 py-3 bg-indigo-600 text-white rounded-xl font-bold hover:bg-indigo-700 shadow-md shadow-indigo-200 transition-all">Save info</button>
            </div>
        </form>
    </div>
</div>

<style>
/* Animations */
@keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
@keyframes popIn { from { opacity: 0; transform: scale(0.9); } to { opacity: 1; transform: scale(1); } }
.animate-fadeIn { animation: fadeIn 0.3s ease-out forwards; }
.animate-popIn { animation: popIn 0.3s cubic-bezier(0.16, 1, 0.3, 1) forwards; }
.hide-scroll::-webkit-scrollbar { display: none; }
.hide-scroll { -ms-overflow-style: none; scrollbar-width: none; }
</style>

</body>
</html>
