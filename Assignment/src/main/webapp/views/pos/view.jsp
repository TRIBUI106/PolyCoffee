<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

                <c:if test="${not empty param.lang}">
                    <c:set var="lang" value="${param.lang}" scope="session" />
                </c:if>
                <fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
                <fmt:setBundle basename="messages" />

                <!DOCTYPE html>
                <html lang="${empty sessionScope.lang ? 'vi' : sessionScope.lang}">

                <head>
                    <title>
                        <fmt:message key="pos.title" />
                    </title>
                    <jsp:include page="/views/common/head.jsp" />
                    <!-- Bootstrap CSS required for modal components -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
                        rel="stylesheet" />
                    <style>
                        body {
                            background-color: #f0f2f5;
                            font-family: 'Inter', sans-serif;
                            overflow: hidden;
                        }

                        .hide-scroll::-webkit-scrollbar {
                            display: none;
                        }

                        .hide-scroll {
                            -ms-overflow-style: none;
                            scrollbar-width: none;
                        }

                        .pos-grid-scroll::-webkit-scrollbar {
                            width: 6px;
                        }

                        .pos-grid-scroll::-webkit-scrollbar-track {
                            background: transparent;
                        }

                        .pos-grid-scroll::-webkit-scrollbar-thumb {
                            background: #cbd5e1;
                            border-radius: 4px;
                        }
                    </style>
                </head>

                <body class="h-screen w-screen flex flex-col text-pos-text select-none">

                    <!-- POS Top Bar -->
                    <header
                        class="h-14 bg-white border-b border-pos-border px-4 flex items-center justify-between shrink-0 z-10 shadow-sm relative">
                        <div class="flex items-center gap-4">
                            <a href="${pageContext.request.contextPath}/" title="<fmt:message key='header.home'/>"
                                class="w-10 h-10 flex items-center justify-center bg-coffee-50 text-coffee-700 rounded-lg hover:bg-coffee-100 transition-colors">
                                <i class="bi bi-house-door-fill text-xl"></i>
                            </a>
                            <div class="h-6 w-px bg-pos-border"></div>
                            <h1 class="font-bold text-lg flex items-center gap-2">
                                <i class="bi bi-display text-coffee-700"></i>
                                <span>Smart POS</span>
                                <span
                                    class="text-xs bg-coffee-100 text-coffee-700 px-2 py-0.5 rounded-full ml-2">v1.2</span>
                            </h1>
                        </div>
                        <div class="flex items-center gap-6">
                            <!-- <div class="relative w-80 hidden md:block">
                                <i class="bi bi-search absolute left-3 top-1/2 -translate-y-1/2 text-pos-muted"></i>
                                <input type="text" placeholder="<fmt:message key='pos.search.placeholder'/>"
                                    class="w-full bg-pos-bg border border-pos-border rounded-lg pl-10 pr-4 py-1.5 text-sm focus:outline-none focus:border-coffee-500 focus:ring-1 focus:ring-coffee-500 transition-all">
                            </div> -->

                            <!-- Language Switcher -->
                            <!-- <div class="flex items-center bg-pos-bg border border-pos-border rounded-md p-1">
                                <a href="?lang=vi"
                                    class="px-2 py-0.5 text-xs font-bold rounded ${sessionScope.lang == 'vi' || empty sessionScope.lang ? 'bg-white shadow-sm text-coffee-700' : 'text-pos-muted hover:text-pos-text'}">VI</a>
                                <a href="?lang=en"
                                    class="px-2 py-0.5 text-xs font-bold rounded ${sessionScope.lang == 'en' ? 'bg-white shadow-sm text-coffee-700' : 'text-pos-muted hover:text-pos-text'}">EN</a>
                            </div> -->

                            <div class="flex items-center gap-3 border-l border-pos-border pl-6">
                                <div class="text-right hidden sm:block">
                                    <p class="text-sm font-bold leading-tight">${sessionScope.user.fullName}</p>
                                    <p class="text-[11px] text-pos-muted uppercase tracking-wider">
                                        <fmt:message key='pos.bill.serve' />
                                    </p>
                                </div>
                                <div
                                    class="w-9 h-9 bg-coffee-700 text-white rounded-full flex items-center justify-center font-bold shadow-sm">
                                    ${fn:substring(sessionScope.user.fullName, 0, 1)}
                                </div>
                            </div>
                        </div>
                    </header>

                    <!-- Notifications -->
                    <c:if test="${not empty sessionScope.message}">
                        <div
                            class="fixed top-20 right-4 z-[100] bg-green-500 text-white px-6 py-3 rounded-xl shadow-2xl animate-bounce font-bold flex items-center gap-3">
                            <i class="bi bi-check-circle-fill"></i> ${sessionScope.message}
                            <c:remove var="message" scope="session" />
                        </div>
                    </c:if>
                    <c:if test="${not empty sessionScope.error}">
                        <div
                            class="fixed top-20 right-4 z-[100] bg-red-500 text-white px-6 py-3 rounded-xl shadow-2xl animate-pulse font-bold flex items-center gap-3">
                            <i class="bi bi-exclamation-triangle-fill"></i> ${sessionScope.error}
                            <c:remove var="error" scope="session" />
                        </div>
                    </c:if>

                    <!-- Main Workspace -->
                    <main class="flex-grow flex overflow-hidden">

                        <!-- Admin Sidebar (Pro Mode) -->
                        <c:if test="${sessionScope.user.role}">
                            <div
                                class="w-20 bg-white border-r border-[#e2e8f0] flex flex-col items-center py-8 gap-6 shrink-0 shadow-[4px_0_24px_rgba(0,0,0,0.02)] z-30">
                                <a href="?tab=pos"
                                    class="w-12 h-12 flex items-center justify-center rounded-2xl transition-all ${activeTab == 'pos' ? 'bg-[#6F4E37] text-white shadow-xl shadow-coffee-200 scale-110' : 'text-[#94a3b8] hover:bg-coffee-50 hover:text-coffee-700'}"
                                    title="POS Dashboard">
                                    <i class="bi bi-display-fill text-xl"></i>
                                </a>
                                <div class="w-10 h-px bg-slate-400 mx-auto"></div>
                                <a href="?tab=drinks"
                                    class="w-12 h-12 flex items-center justify-center rounded-2xl transition-all ${activeTab == 'drinks' ? 'bg-[#6F4E37] text-white shadow-xl shadow-coffee-200 scale-110' : 'text-[#94a3b8] hover:bg-coffee-50 hover:text-coffee-700'}"
                                    title="Menu Catalog">
                                    <i class="bi bi-cup-hot-fill text-xl"></i>
                                </a>
                                <a href="?tab=categories"
                                    class="w-12 h-12 flex items-center justify-center rounded-2xl transition-all ${activeTab == 'categories' ? 'bg-[#6F4E37] text-white shadow-xl shadow-coffee-200 scale-110' : 'text-[#94a3b8] hover:bg-coffee-50 hover:text-coffee-700'}"
                                    title="Categories">
                                    <i class="bi bi-tags-fill text-xl"></i>
                                </a>
                                <a href="?tab=users"
                                    class="w-12 h-12 flex items-center justify-center rounded-2xl transition-all ${activeTab == 'users' ? 'bg-[#6F4E37] text-white shadow-xl shadow-coffee-200 scale-110' : 'text-[#94a3b8] hover:bg-coffee-50 hover:text-coffee-700'}"
                                    title="Staff Directory">
                                    <i class="bi bi-people-fill text-xl"></i>
                                </a>
                                <a href="?tab=bills"
                                    class="w-12 h-12 flex items-center justify-center rounded-2xl transition-all ${activeTab == 'bills' ? 'bg-[#6F4E37] text-white shadow-xl shadow-coffee-200 scale-110' : 'text-[#94a3b8] hover:bg-coffee-50 hover:text-coffee-700'}"
                                    title="Ledger / Bills">
                                    <i class="bi bi-receipt-cutoff text-xl"></i>
                                </a>
                                <a href="?tab=tables"
                                    class="w-12 h-12 flex items-center justify-center rounded-2xl transition-all ${activeTab == 'tables' ? 'bg-[#6F4E37] text-white shadow-xl shadow-coffee-200 scale-110' : 'text-[#94a3b8] hover:bg-coffee-50 hover:text-coffee-700'}"
                                    title="Floor Planner">
                                    <i class="bi bi-grid-3x3-gap-fill text-xl"></i>
                                </a>
                                <div class="flex-grow"></div>
                                <a href="?tab=stats"
                                    class="w-12 h-12 flex items-center justify-center rounded-2xl transition-all ${activeTab == 'stats' ? 'bg-[#6F4E37] text-white shadow-xl shadow-coffee-200 scale-110' : 'text-[#94a3b8] hover:bg-coffee-50 hover:text-coffee-700'}"
                                    title="Intelligence Science">
                                    <i class="bi bi-graph-up-arrow text-lg"></i>
                                </a>
                                <div class="w-10 h-px bg-slate-400 mx-auto"></div>
                                <a href="${pageContext.request.contextPath}/auth/logout"
                                    class="w-12 h-12 flex items-center justify-center rounded-2xl transition-all text-[#94a3b8] hover:bg-coffee-50 hover:text-coffee-700"
                                    title="Logout">
                                    <i class="bi bi-box-arrow-right text-lg"></i>
                                </a>
                            </div>
                        </c:if>

                        <!-- Dynamic Content Area -->
                        <div class="flex-grow flex flex-col min-w-0">
                            <c:choose>
                                <c:when test="${activeTab == 'pos'}">
                                    <!-- Categories Bar -->
                                    <div
                                        class="h-14 bg-white border-b border-pos-border px-4 flex items-center shrink-0 shadow-sm z-0">
                                        <div class="flex gap-2 overflow-x-auto hide-scroll pb-1 items-center h-full">
                                            <button
                                                class="bg-coffee-700 text-white px-5 py-2 rounded-lg text-sm font-semibold whitespace-nowrap shadow-sm category-btn"
                                                data-cat-id="0">
                                                <fmt:message key="pos.category.all" />
                                            </button>
                                            <c:forEach var="cat" items="${categories}">
                                                <button
                                                    class="bg-pos-bg hover:bg-coffee-50 text-pos-text hover:text-coffee-700 border border-transparent hover:border-coffee-200 px-5 py-2 rounded-lg text-sm font-medium whitespace-nowrap transition-colors category-btn"
                                                    data-cat-id="${cat.id}">${cat.name}</button>
                                            </c:forEach>
                                        </div>
                                    </div>

                                    <!-- Products Grid -->
                                    <div class="flex-grow p-4 overflow-y-auto pos-grid-scroll bg-pos-bg">
                                        <div
                                            class="grid grid-cols-3 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6 gap-3 pb-8">
                                            <c:forEach var="d" items="${drinks}">
                                                <c:set var="urlParams" value="drinkId=${d.id}" />
                                                <c:if test="${not empty currentBill}">
                                                    <c:set var="urlParams"
                                                        value="${urlParams}&billId=${currentBill.id}" />
                                                </c:if>
                                                <div class="bg-white rounded-xl border border-pos-border overflow-hidden hover:shadow-lg hover:border-coffee-300 transition-all cursor-pointer flex flex-col h-full active:scale-[0.98] group drink-item"
                                                    data-cat-id="${d.category.id}" onclick="addDrinkAjax(${d.id})">
                                                    <div class="aspect-[4/3] bg-pos-bg relative overflow-hidden">
                                                        <c:choose>
                                                            <c:when test="${not empty d.image}">
                                                                <c:set var="imgUrl"
                                                                    value="${fn:startsWith(d.image, 'http') ? d.image : pageContext.request.contextPath.concat('/uploads/').concat(d.image)}" />
                                                                <img src="${imgUrl}"
                                                                    class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div
                                                                    class="w-full h-full flex items-center justify-center text-pos-muted text-4xl group-hover:scale-110 transition-transform duration-500">
                                                                    <i class="bi bi-cup-hot"></i>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <!-- Price overlay -->
                                                        <div
                                                            class="absolute bottom-2 right-2 bg-black/75 backdrop-blur-sm text-white text-xs font-bold px-2 py-1 rounded shadow-sm">
                                                            <fmt:formatNumber value="${d.price}" pattern="#,###" />
                                                        </div>
                                                    </div>
                                                    <div class="p-2.5 flex-grow flex flex-col justify-between">
                                                        <h3
                                                            class="text-sm font-semibold text-pos-text line-clamp-2 leading-tight">
                                                            ${d.name}</h3>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${activeTab == 'drinks'}">
                                    <div class="flex-grow flex flex-col bg-pos-bg overflow-hidden p-6">
                                        <div class="flex justify-between items-center mb-6">
                                            <h2 class="text-2xl font-black text-gray-900">
                                                <fmt:message key="admin.drink.subtitle" />
                                            </h2>
                                            <div class="flex flex-col sm:flex-row gap-4 items-center">
                                                <div class="relative w-64">
                                                    <i
                                                        class="bi bi-search absolute left-3 top-1/2 -translate-y-1/2 text-pos-muted"></i>
                                                    <input type="text" id="drinkSearch" placeholder="Tìm kiếm món..."
                                                        class="w-full pl-10 pr-4 py-2 bg-white border border-pos-border rounded-xl text-sm focus:outline-none focus:border-coffee-500 transition-all">
                                                </div>
                                                <button type="button" onclick="openDrinkModal()"
                                                    class="bg-coffee-700 text-white px-6 py-2.5 rounded-xl font-bold flex items-center gap-2 shadow-lg shadow-coffee-100 active:scale-95 transition-all">
                                                    <i class="bi bi-plus-lg"></i>
                                                    <fmt:message key="admin.drink.btn.add" />
                                                </button>
                                            </div>
                                        </div>
                                        <div
                                            class="bg-white rounded-2xl border border-pos-border shadow-sm flex-grow overflow-hidden flex flex-col">
                                            <div class="overflow-y-auto">
                                                <table class="w-full text-left">
                                                    <thead
                                                        class="bg-gray-50 border-b border-pos-border sticky top-0 z-10">
                                                        <tr>
                                                            <th
                                                                class="px-6 py-4 text-xs font-bold text-pos-muted uppercase">
                                                                <fmt:message key="admin.drink.name" />
                                                            </th>
                                                            <th
                                                                class="px-6 py-4 text-xs font-bold text-pos-muted uppercase">
                                                                <fmt:message key="admin.drink.category" />
                                                            </th>
                                                            <th
                                                                class="px-6 py-4 text-xs font-bold text-pos-muted uppercase text-right">
                                                                <fmt:message key="admin.drink.price" />
                                                            </th>
                                                            <th
                                                                class="px-6 py-4 text-xs font-bold text-pos-muted uppercase text-center">
                                                                <fmt:message key="admin.drink.status" />
                                                            </th>
                                                            <th
                                                                class="px-6 py-4 text-xs font-bold text-pos-muted uppercase text-right">
                                                                <fmt:message key="admin.drink.action" />
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody class="divide-y divide-pos-border">
                                                        <c:forEach var="item" items="${allDrinks}">
                                                            <tr class="hover:bg-pos-bg transition-colors drink-row">
                                                                <td class="px-6 py-4">
                                                                    <div class="flex items-center gap-3">
                                                                        <div
                                                                            class="w-10 h-10 rounded-lg overflow-hidden bg-gray-100 shrink-0 border border-pos-border flex items-center justify-center">
                                                                            <c:choose>
                                                                                <c:when test="${not empty item.image}">
                                                                                    <c:set var="imgUrl"
                                                                                        value="${fn:startsWith(item.image, 'http') ? item.image : pageContext.request.contextPath.concat('/uploads/').concat(item.image)}" />
                                                                                    <img src="${imgUrl}"
                                                                                        class="w-full h-full object-cover">
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <i
                                                                                        class="bi bi-cup-hot text-gray-400"></i>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </div>
                                                                        <div
                                                                            class="font-bold text-pos-text text-sm drink-name">
                                                                            ${item.name}</div>
                                                                    </div>
                                                                </td>
                                                                <td class="px-6 py-4 text-sm text-pos-muted">
                                                                    ${item.category.name}</td>
                                                                <td class="px-6 py-4 text-sm font-bold text-right">
                                                                    <fmt:formatNumber value="${item.price}"
                                                                        pattern="#,###" />
                                                                </td>
                                                                <td class="px-6 py-4 text-center">
                                                                    <span
                                                                        class="px-3 py-1 rounded-full text-[11px] font-bold ${item.active ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}">
                                                                        ${item.active ? '
                                                                        <fmt:message key="admin.status.yes" />' : '
                                                                        <fmt:message key="admin.status.no" />'}
                                                                    </span>
                                                                </td>
                                                                <td class="px-6 py-4 text-right space-x-2">
                                                                    <button type="button"
                                                                        class="edit-drink-trigger text-pos-accent hover:text-blue-700 bg-blue-50 p-2 rounded-lg transition-colors"
                                                                        data-id="${item.id}"
                                                                        data-name="${fn:escapeXml(item.name)}"
                                                                        data-cat-id="${item.category.id}"
                                                                        data-price="${item.price}"
                                                                        data-active="${item.active}"
                                                                        data-desc="${fn:escapeXml(item.description)}"
                                                                        data-img="${item.image}">
                                                                        <i class="bi bi-pencil-square"></i>
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${activeTab == 'categories'}">
                                    <div class="flex-grow flex flex-col bg-pos-bg overflow-hidden p-6">
                                        <div class="flex justify-between items-center mb-6">
                                            <h2 class="text-2xl font-black text-gray-900">
                                                <fmt:message key="admin.category.title" />
                                            </h2>
                                            <button type="button" onclick="openCategoryModal()"
                                                class="bg-coffee-700 text-white px-6 py-2.5 rounded-xl font-bold flex items-center gap-2 shadow-lg shadow-coffee-100">
                                                <i class="bi bi-plus-lg"></i>
                                                <fmt:message key="admin.category.btn.add" />
                                            </button>
                                            <div class="relative w-64">
                                                <i
                                                    class="bi bi-search absolute left-3 top-1/2 -translate-y-1/2 text-pos-muted"></i>
                                                <input type="text" id="categorySearch"
                                                    placeholder="Tìm kiếm danh mục..."
                                                    class="w-full pl-10 pr-4 py-2 bg-white border border-pos-border rounded-xl text-sm focus:outline-none focus:border-coffee-500 transition-all">
                                            </div>
                                        </div>
                                        <div
                                            class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 overflow-y-auto pr-2">
                                            <c:forEach var="item" items="${categories}">
                                                <div
                                                    class="bg-white p-5 rounded-2xl border border-pos-border shadow-sm flex items-center justify-between group hover:border-coffee-300 transition-all category-card">
                                                    <div class="flex items-center gap-4">
                                                        <div
                                                            class="w-12 h-12 bg-coffee-50 rounded-xl flex items-center justify-center text-coffee-700 text-xl font-black">
                                                            ${fn:substring(item.name, 0, 1)}
                                                        </div>
                                                        <div>
                                                            <div class="font-bold text-pos-text category-name">
                                                                ${item.name}</div>
                                                            <div class="text-xs text-pos-muted">
                                                                <fmt:message key="admin.category.table.status" />:
                                                                ${item.active ?
                                                                '
                                                                <fmt:message key="admin.status.yes" />' : '
                                                                <fmt:message key="admin.status.no" />'}
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="flex gap-2">
                                                        <button type="button"
                                                            class="edit-category-trigger text-pos-accent hover:bg-blue-50 p-2 rounded-lg"
                                                            data-id="${item.id}" data-name="${fn:escapeXml(item.name)}"
                                                            data-active="${item.active}">
                                                            <i class="bi bi-pencil"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${activeTab == 'users'}">
                                    <div class="flex-grow flex flex-col bg-pos-bg overflow-hidden p-6">
                                        <div class="flex justify-between items-center mb-6">
                                            <h2 class="text-2xl font-black text-gray-900">
                                                <fmt:message key="admin.staff.title" />
                                            </h2>
                                            <button type="button" onclick="openStaffModal()"
                                                class="bg-coffee-700 text-white px-6 py-2.5 rounded-xl font-bold shadow-lg shadow-coffee-100 flex items-center gap-2">
                                                <i class="bi bi-person-plus"></i>
                                                <fmt:message key="admin.staff.btn.add" />
                                            </button>
                                            <div class="relative w-64">
                                                <i
                                                    class="bi bi-search absolute left-3 top-1/2 -translate-y-1/2 text-pos-muted"></i>
                                                <input type="text" id="staffSearch" placeholder="Tìm kiếm nhân viên..."
                                                    class="w-full pl-10 pr-4 py-2 bg-white border border-pos-border rounded-xl text-sm focus:outline-none focus:border-coffee-500 transition-all">
                                            </div>
                                        </div>
                                        <div
                                            class="bg-white rounded-2xl border border-pos-border flex-grow overflow-hidden flex flex-col">
                                            <div class="overflow-y-auto">
                                                <table class="w-full text-left">
                                                    <thead class="bg-gray-50 border-b border-pos-border sticky top-0">
                                                        <tr>
                                                            <th
                                                                class="px-6 py-4 text-xs font-bold text-pos-muted uppercase">
                                                                <fmt:message key="admin.staff.name" />
                                                            </th>
                                                            <th
                                                                class="px-6 py-4 text-xs font-bold text-pos-muted uppercase">
                                                                <fmt:message key="admin.staff.email" />
                                                            </th>
                                                            <th
                                                                class="px-6 py-4 text-xs font-bold text-pos-muted uppercase">
                                                                <fmt:message key="admin.staff.role" />
                                                            </th>
                                                            <th
                                                                class="px-6 py-4 text-xs font-bold text-pos-muted uppercase text-center">
                                                                <fmt:message key="admin.staff.status" />
                                                            </th>
                                                            <th
                                                                class="px-6 py-4 text-xs font-bold text-pos-muted uppercase text-right">
                                                                <fmt:message key="admin.staff.action" />
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody class="divide-y divide-pos-border">
                                                        <c:forEach var="item" items="${staffList}">
                                                            <tr class="hover:bg-pos-bg staff-row">
                                                                <td class="px-6 py-4 font-bold text-sm staff-name">
                                                                    ${item.fullName}
                                                                </td>
                                                                <td class="px-6 py-4 text-sm text-pos-muted">
                                                                    ${item.email}</td>
                                                                <td class="px-6 py-4">
                                                                    <span
                                                                        class="px-2.5 py-1 rounded text-[10px] font-black tracking-widest ${item.role ? 'bg-purple-100 text-purple-700' : 'bg-gray-100 text-gray-700'}">
                                                                        ${item.role ? '
                                                                        <fmt:message key="admin.role.manager" />' : '
                                                                        <fmt:message key="admin.role.staff" />'}
                                                                    </span>
                                                                </td>
                                                                <td class="px-6 py-4 text-center">
                                                                    <div class="flex justify-center">
                                                                        <span
                                                                            class="w-2 h-2 rounded-full ${item.active ? 'bg-green-500' : 'bg-red-500'}"
                                                                            title="${item.active ? 'ACTIVE' : 'LOCKED'}"></span>
                                                                    </div>
                                                                </td>
                                                                <td class="px-6 py-4 text-right">
                                                                    <button type="button"
                                                                        class="edit-staff-trigger text-pos-accent hover:bg-blue-50 p-2 rounded-lg transition-colors"
                                                                        data-id="${item.id}"
                                                                        data-name="${fn:escapeXml(item.fullName)}"
                                                                        data-email="${item.email}"
                                                                        data-phone="${item.phone}"
                                                                        data-role="${item.role}"
                                                                        data-active="${item.active}">
                                                                        <i class="bi bi-pencil-square"></i>
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${activeTab == 'bills'}">
                                    <div class="flex-grow flex flex-col bg-pos-bg overflow-hidden p-6">
                                        <div class="flex justify-between items-center mb-6">
                                            <h2 class="text-2xl font-black text-gray-900">
                                                <fmt:message key="admin.bill.title" />
                                            </h2>
                                            <div class="flex items-center gap-4">
                                                <div
                                                    class="flex items-center gap-2 bg-white px-3 py-1.5 rounded-xl border border-pos-border shadow-sm">
                                                    <span class="text-xs font-bold text-gray-500">Max: </span>
                                                    <input id="adminAmountInput" type="number" placeholder="1,000,000"
                                                        class="w-24 bg-transparent text-sm font-semibold outline-none text-right placeholder-gray-300" />
                                                    <span class="text-xs font-bold text-gray-500">₫</span>
                                                    <input id="adminAmountRange" type="range" min="0" max="1000000"
                                                        step="10000" class="w-24 accent-coffee-600" />
                                                </div>
                                                <button type="button"
                                                    class="bg-coffee-600 hover:bg-coffee-700 text-white px-5 py-2.5 rounded-xl font-bold flex items-center gap-2 shadow-md shadow-coffee-200 transition-all active:scale-95"
                                                    data-bs-toggle="modal" data-bs-target="#findBillModal">
                                                    <i class="bi bi-search"></i>
                                                    <fmt:message key="admin.bill.search.btn" />
                                                </button>
                                            </div>
                                        </div>
                                        <div
                                            class="bg-white rounded-2xl border border-pos-border flex-grow overflow-hidden flex flex-col">
                                            <table class="w-full text-left">
                                                <thead class="bg-gray-50 border-b border-pos-border sticky top-0">
                                                    <tr>
                                                        <th
                                                            class="px-6 py-4 text-xs font-bold text-pos-muted uppercase">
                                                            <fmt:message key="admin.bill.code" />
                                                        </th>
                                                        <th
                                                            class="px-6 py-4 text-xs font-bold text-pos-muted uppercase">
                                                            <fmt:message key="admin.bill.date" />
                                                        </th>
                                                        <th
                                                            class="px-6 py-4 text-xs font-bold text-pos-muted uppercase text-right">
                                                            <fmt:message key="admin.bill.total" />
                                                        </th>
                                                        <th
                                                            class="px-6 py-4 text-xs font-bold text-pos-muted uppercase text-center">
                                                            <fmt:message key="admin.bill.status" />
                                                        </th>
                                                        <th
                                                            class="px-6 py-4 text-xs font-bold text-pos-muted uppercase text-right">
                                                            <fmt:message key="admin.drink.action" />
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody class="divide-y divide-pos-border">
                                                    <c:forEach var="item" items="${billHistory}">
                                                        <tr class="hover:bg-pos-bg transition-colors admin-bill-row"
                                                            data-total="${item.total}">
                                                            <td class="px-6 py-4 font-mono text-xs font-bold">
                                                                ${item.code}</td>
                                                            <td class="px-6 py-4 text-sm text-pos-muted">
                                                                <fmt:formatDate value="${item.createdAt}"
                                                                    pattern="yyyy-MM-dd HH:mm" />
                                                            </td>
                                                            <td
                                                                class="px-6 py-4 text-sm font-bold text-right text-coffee-700">
                                                                <fmt:formatNumber value="${item.total}"
                                                                    pattern="#,###" />
                                                            </td>
                                                            <td class="px-6 py-4 text-center text-xs">
                                                                <c:choose>
                                                                    <c:when test="${item.status == 'WAITING'}">
                                                                        <span
                                                                            class="bg-yellow-100 text-yellow-700 px-3 py-1 rounded-full font-bold">
                                                                            <fmt:message
                                                                                key="admin.bill.status.waiting" />
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${item.status == 'PENDING'}">
                                                                        <span
                                                                            class="bg-orange-100 text-orange-700 px-3 py-1 rounded-full font-bold">
                                                                            Pending (Guest)
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when
                                                                        test="${item.status == 'PAID' || item.status == 'FINISHED'}">
                                                                        <span
                                                                            class="bg-green-100 text-green-700 px-3 py-1 rounded-full font-bold">
                                                                            <fmt:message
                                                                                key="admin.bill.status.finished" />
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span
                                                                            class="bg-red-100 text-red-700 px-3 py-1 rounded-full font-bold">
                                                                            <fmt:message
                                                                                key="admin.bill.status.cancelled" />
                                                                        </span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td
                                                                class="px-6 py-4 text-right flex items-center justify-end gap-2">
                                                                <c:if test="${item.status == 'PENDING'}">
                                                                    <form
                                                                        action="${pageContext.request.contextPath}/guest/pos/accept"
                                                                        method="POST" class="inline m-0 p-0">
                                                                        <input type="hidden" name="billId"
                                                                            value="${item.id}" />
                                                                        <button type="submit"
                                                                            class="bg-indigo-600 text-white hover:bg-indigo-700 px-3 py-1.5 rounded-lg transition-colors font-bold text-xs"
                                                                            title="Accept Guest Order">
                                                                            Accept
                                                                        </button>
                                                                    </form>
                                                                </c:if>
                                                                <a href="?tab=bills&billId=${item.id}"
                                                                    class="text-pos-accent hover:bg-blue-50 p-2 rounded-lg transition-colors">
                                                                    <i class="bi bi-eye-fill"></i>
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                            <div class="p-4 bg-gray-50 border-t border-pos-border flex justify-center">
                                                <a href="${pageContext.request.contextPath}/manager/bills"
                                                    class="text-xs font-bold text-coffee-700 hover:underline uppercase tracking-widest flex items-center gap-2">
                                                    <i class="bi bi-journal-text"></i>
                                                    <fmt:message key="header.bill" /> &rarr;
                                                </a>
                                            </div>
                                        </div>
                                        <!-- Find Bill Modal -->
                                        <div class="modal fade" id="findBillModal" tabindex="-1"
                                            aria-labelledby="findBillModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-lg modal-dialog-centered">
                                                <div
                                                    class="modal-content bg-white border-0 shadow-2xl rounded-3xl overflow-hidden">
                                                    <div
                                                        class="modal-header border-b border-pos-border bg-pos-bg px-6 py-5">
                                                        <div>
                                                            <h5 class="text-xl font-black text-gray-900"
                                                                id="findBillModalLabel">
                                                                <fmt:message key="admin.bill.search.placeholder" />
                                                            </h5>
                                                        </div>
                                                        <button type="button"
                                                            class="w-8 h-8 flex items-center justify-center rounded-lg bg-white border border-pos-border text-pos-muted hover:text-pos-text hover:bg-gray-50 transition-colors"
                                                            data-bs-dismiss="modal" aria-label="Close">
                                                            <i class="bi bi-x-lg"></i>
                                                        </button>
                                                    </div>
                                                    <form method="GET"
                                                        action="${pageContext.request.contextPath}/employee/pos">
                                                        <input type="hidden" name="tab" value="bills" />
                                                        <div class="modal-body p-6">
                                                            <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                                                                <div class="space-y-2">
                                                                    <label for="query"
                                                                        class="text-xs font-bold text-pos-muted uppercase tracking-wider block">Mã
                                                                        HĐ / Tên Nhân Viên</label>
                                                                    <div class="relative">
                                                                        <i
                                                                            class="bi bi-search absolute left-4 top-1/2 -translate-y-1/2 text-pos-muted"></i>
                                                                        <input type="text" id="query" name="query"
                                                                            placeholder="<fmt:message key='admin.bill.search.placeholder'/>"
                                                                            value="${param.query}"
                                                                            class="w-full pl-11 pr-4 py-3 bg-pos-bg border border-pos-border focus:bg-white focus:ring-2 focus:ring-coffee-500 focus:border-coffee-500 rounded-xl text-sm font-semibold text-pos-text transition-all" />
                                                                    </div>
                                                                </div>
                                                                <div class="space-y-2">
                                                                    <label for="status"
                                                                        class="text-xs font-bold text-pos-muted uppercase tracking-wider block">Trạng
                                                                        Thái Giao Dịch</label>
                                                                    <div class="relative">
                                                                        <i
                                                                            class="bi bi-info-circle absolute left-4 top-1/2 -translate-y-1/2 text-pos-muted"></i>
                                                                        <select name="status" id="status"
                                                                            class="w-full pl-11 pr-4 py-3 bg-pos-bg border border-pos-border focus:bg-white focus:ring-2 focus:ring-coffee-500 focus:border-coffee-500 rounded-xl text-sm font-semibold text-pos-text transition-all cursor-pointer">
                                                                            <option value="ALL" ${param.status=='ALL'
                                                                                ? 'selected' : '' }>
                                                                                <fmt:message
                                                                                    key="admin.bill.status.all" />
                                                                            </option>
                                                                            <option value="WAITING"
                                                                                ${param.status=='WAITING' ? 'selected'
                                                                                : '' }>
                                                                                <fmt:message
                                                                                    key="admin.bill.status.waiting" />
                                                                            </option>
                                                                            <option value="FINISHED"
                                                                                ${param.status=='FINISHED' ? 'selected'
                                                                                : '' }>
                                                                                <fmt:message
                                                                                    key="admin.bill.status.finished" />
                                                                            </option>
                                                                            <option value="CANCELLED"
                                                                                ${param.status=='CANCELLED' ? 'selected'
                                                                                : '' }>
                                                                                <fmt:message
                                                                                    key="admin.bill.status.cancelled" />
                                                                            </option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div
                                                            class="modal-footer border-t border-pos-border bg-pos-bg px-6 py-4 flex gap-3">
                                                            <button type="button"
                                                                class="px-6 py-2.5 rounded-xl font-bold bg-white border border-pos-border text-pos-muted hover:bg-gray-50 hover:text-pos-text transition-all"
                                                                data-bs-dismiss="modal">Thoát</button>
                                                            <button type="submit"
                                                                class="px-6 py-2.5 rounded-xl font-bold bg-coffee-600 hover:bg-coffee-700 text-white shadow-md shadow-coffee-200 transition-all flex items-center gap-2">
                                                                <i class="bi bi-search text-xs"></i> Lọc Kết Quả
                                                            </button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${activeTab == 'stats'}">
                                    <div class="flex-grow flex flex-col bg-[#f8fafc] overflow-y-auto p-8 lg:p-12">
                                        <!-- Dashboard Header -->
                                        <div
                                            class="mb-10 flex flex-col md:flex-row md:items-center justify-between gap-6">
                                            <div>
                                                <h1 class="text-4xl font-black text-[#1e293b] tracking-tight mb-2">
                                                    Insights
                                                </h1>
                                                <p class="text-slate-500 font-medium">Business performance at a glance.
                                                    <span class="text-coffee-600/60 ml-1 font-bold">PolyCoffee
                                                        Intelligence</span>
                                                </p>
                                            </div>
                                            <div class="flex items-center gap-4">
                                                <button onclick="refreshDashboard()"
                                                    class="p-3 bg-white border border-slate-200 rounded-2xl text-slate-600 hover:text-coffee-700 hover:border-coffee-200 hover:bg-coffee-50 transition-all shadow-sm active:rotate-180 duration-500"
                                                    title="Refresh Data">
                                                    <i class="bi bi-arrow-clockwise text-xl"></i>
                                                </button>
                                                <div
                                                    class="bg-white border border-slate-200 rounded-2xl px-5 py-3 flex items-center gap-3 shadow-sm">
                                                    <div class="w-2.5 h-2.5 rounded-full bg-emerald-500 animate-pulse">
                                                    </div>
                                                    <span class="text-sm font-bold text-slate-700">Real-time Sync</span>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Summary Cards -->
                                        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8 mb-12">
                                            <!-- Card 1: Today Revenue -->
                                            <div
                                                class="bg-white p-8 rounded-[36px] border border-slate-200 shadow-sm hover:shadow-2xl hover:shadow-coffee-100/40 hover:-translate-y-1 transition-all group relative overflow-hidden">
                                                <div
                                                    class="absolute -right-6 -top-6 w-32 h-32 bg-coffee-50/50 rounded-full transition-transform group-hover:scale-125 duration-700">
                                                </div>
                                                <div class="flex items-center justify-between relative z-10 mb-6">
                                                    <div
                                                        class="w-14 h-14 bg-coffee-100 text-coffee-700 rounded-2xl flex items-center justify-center text-2xl shadow-inner">
                                                        <i class="bi bi-currency-dollar"></i>
                                                    </div>
                                                    <span
                                                        class="text-[10px] font-black text-coffee-700 bg-coffee-50 px-3 py-1.5 rounded-full uppercase tracking-tighter">Growth
                                                        Tracking</span>
                                                </div>
                                                <h3
                                                    class="text-xs font-black text-slate-400 uppercase tracking-widest mb-1">
                                                    Today Revenue</h3>
                                                <p class="text-3xl font-black text-slate-900 mb-2 skeleton-text"
                                                    id="todayRevenueText">
                                                    <fmt:formatNumber value="${dashboard.todayRevenue}"
                                                        pattern="#,###" /> ₫
                                                </p>
                                                <div
                                                    class="flex items-center gap-1.5 text-xs font-bold text-emerald-600">
                                                    <i class="bi bi-graph-up"></i>
                                                    <span>+12.5% from yesterday</span>
                                                </div>
                                            </div>

                                            <!-- Card 2: Today Orders -->
                                            <div
                                                class="bg-white p-8 rounded-[36px] border border-slate-200 shadow-sm hover:shadow-2xl hover:shadow-blue-100/40 hover:-translate-y-1 transition-all group relative overflow-hidden">
                                                <div
                                                    class="absolute -right-6 -top-6 w-32 h-32 bg-blue-50/50 rounded-full transition-transform group-hover:scale-125 duration-700">
                                                </div>
                                                <div class="flex items-center justify-between relative z-10 mb-6">
                                                    <div
                                                        class="w-14 h-14 bg-blue-100 text-blue-700 rounded-2xl flex items-center justify-center text-2xl shadow-inner">
                                                        <i class="bi bi-bag-heart"></i>
                                                    </div>
                                                    <span
                                                        class="text-[10px] font-black text-blue-700 bg-blue-50 px-3 py-1.5 rounded-full uppercase tracking-tighter">Volume</span>
                                                </div>
                                                <h3
                                                    class="text-xs font-black text-slate-400 uppercase tracking-widest mb-1">
                                                    Orders Count</h3>
                                                <p class="text-3xl font-black text-slate-900 mb-2 skeleton-text"
                                                    id="todayOrdersText">${dashboard.todayOrders} <span
                                                        class="text-sm font-bold text-slate-400">Bills</span></p>
                                                <div class="flex items-center gap-1.5 text-xs font-bold text-slate-500">
                                                    <i class="bi bi-clock-history"></i>
                                                    <span>Last order 2m ago</span>
                                                </div>
                                            </div>

                                            <!-- Card 3: Week Revenue -->
                                            <div
                                                class="bg-white p-8 rounded-[36px] border border-slate-200 shadow-sm hover:shadow-2xl hover:shadow-emerald-100/40 hover:-translate-y-1 transition-all group relative overflow-hidden">
                                                <div
                                                    class="absolute -right-6 -top-6 w-32 h-32 bg-emerald-50/50 rounded-full transition-transform group-hover:scale-125 duration-700">
                                                </div>
                                                <div class="flex items-center justify-between relative z-10 mb-6">
                                                    <div
                                                        class="w-14 h-14 bg-emerald-100 text-emerald-700 rounded-2xl flex items-center justify-center text-2xl shadow-inner">
                                                        <i class="bi bi-calendar-check"></i>
                                                    </div>
                                                    <span
                                                        class="text-[10px] font-black text-emerald-700 bg-emerald-50 px-3 py-1.5 rounded-full uppercase tracking-tighter">Weekly
                                                        Trend</span>
                                                </div>
                                                <h3
                                                    class="text-xs font-black text-slate-400 uppercase tracking-widest mb-1">
                                                    This Week</h3>
                                                <p class="text-3xl font-black text-slate-900 mb-2 skeleton-text"
                                                    id="weekRevenueText">
                                                    <fmt:formatNumber value="${dashboard.weekRevenue}"
                                                        pattern="#,###" /> ₫
                                                </p>
                                                <div
                                                    class="w-full bg-slate-100 h-1.5 rounded-full mt-3 overflow-hidden">
                                                    <div class="bg-emerald-500 h-full w-[65%]" id="weekProgress"></div>
                                                </div>
                                            </div>

                                            <!-- Card 4: Total Overall -->
                                            <div
                                                class="bg-[#1e293b] p-8 rounded-[36px] shadow-2xl hover:-translate-y-1 transition-all group relative overflow-hidden">
                                                <div
                                                    class="absolute -right-6 -top-6 w-32 h-32 bg-white/5 rounded-full transition-transform group-hover:scale-125 duration-700">
                                                </div>
                                                <div class="flex items-center justify-between relative z-10 mb-6">
                                                    <div
                                                        class="w-14 h-14 bg-white/10 text-white rounded-2xl flex items-center justify-center text-2xl border border-white/5 shadow-2xl">
                                                        <i class="bi bi-database"></i>
                                                    </div>
                                                    <span
                                                        class="text-[10px] font-black text-white/40 border border-white/10 px-3 py-1.5 rounded-full uppercase tracking-tighter">Lifetime</span>
                                                </div>
                                                <h3
                                                    class="text-xs font-black text-slate-400 uppercase tracking-widest mb-1">
                                                    Total Records</h3>
                                                <p class="text-3xl font-black text-white mb-2 skeleton-text"
                                                    id="totalBillsText">${dashboard.totalBills}</p>
                                                <p
                                                    class="text-[10px] font-bold text-slate-500 uppercase tracking-wider">
                                                    All-time transactions</p>
                                            </div>
                                        </div>

                                        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                                            <!-- Revenue Chart -->
                                            <div
                                                class="lg:col-span-2 bg-white p-10 rounded-[42px] border border-slate-200 shadow-sm relative overflow-hidden">
                                                <div class="flex items-center justify-between mb-10 relative z-10">
                                                    <div>
                                                        <h3 class="text-xl font-black text-slate-900">Revenue Analytics
                                                        </h3>
                                                        <p
                                                            class="text-[10px] text-slate-400 font-black uppercase tracking-[0.2em]">
                                                            Sales flow of the last 7 days</p>
                                                    </div>
                                                </div>

                                                <div class="h-80 w-full relative">
                                                    <canvas id="revenueChart"></canvas>
                                                </div>
                                            </div>

                                            <!-- Best Selling Drinks -->
                                            <div
                                                class="bg-white p-10 rounded-[42px] border border-slate-200 shadow-sm flex flex-col">
                                                <h3 class="text-xl font-black text-slate-900 mb-8">Top Selling</h3>

                                                <div class="h-64 w-full mb-8 relative">
                                                    <canvas id="drinksChart"></canvas>
                                                </div>

                                                <div class="space-y-4" id="topDrinksList">
                                                    <c:forEach var="drink" items="${dashboard.topDrinks}"
                                                        varStatus="st">
                                                        <div
                                                            class="flex items-center gap-4 group hover:bg-slate-50 p-2 -mx-2 rounded-xl transition-colors">
                                                            <div
                                                                class="w-9 h-9 rounded-full bg-slate-100 group-hover:bg-coffee-100 flex items-center justify-center font-black text-slate-400 group-hover:text-coffee-700 text-xs transition-colors shrink-0">
                                                                ${st.index + 1}
                                                            </div>
                                                            <div class="flex-grow min-w-0">
                                                                <p class="text-sm font-bold text-slate-800 truncate">
                                                                    ${drink.drinkName}</p>
                                                                <div class="flex items-center gap-2">
                                                                    <div
                                                                        class="w-24 bg-slate-100 h-1 rounded-full overflow-hidden">
                                                                        <div class="bg-coffee-400 h-full"
                                                                            style="width: ${drink.totalQuantitySold * 10}%">
                                                                        </div>
                                                                    </div>
                                                                    <span
                                                                        class="text-[10px] text-slate-400 font-bold">${drink.totalQuantitySold}
                                                                        sold</span>
                                                                </div>
                                                            </div>
                                                            <div class="text-right">
                                                                <p class="text-xs font-black text-slate-900">
                                                                    <fmt:formatNumber value="${drink.totalRevenue}"
                                                                        pattern="#,###" />₫
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${activeTab == 'tables'}">
                                    <div class="flex-grow flex flex-col bg-[#f8fafc] overflow-y-auto p-8 lg:p-12">
                                        <!-- Header -->
                                        <div
                                            class="mb-10 flex flex-col md:flex-row md:items-center justify-between gap-6">
                                            <div>
                                                <h1 class="text-4xl font-black text-[#1e293b] tracking-tight mb-2">
                                                    Table Management
                                                </h1>
                                                <p class="text-slate-500 font-medium">Coordinate your shop layout and QR
                                                    ordering system. <span
                                                        class="text-coffee-600/60 ml-1 font-bold">PolyCoffee
                                                        Infrastructure</span></p>
                                            </div>
                                            <button
                                                class="bg-coffee-700 hover:bg-slate-900 text-white px-8 py-4 rounded-3xl font-black flex items-center gap-3 shadow-2xl shadow-coffee-200 transition-all hover:-translate-y-1 active:scale-95 group"
                                                data-bs-toggle="modal" data-bs-target="#addTableModal">
                                                <div
                                                    class="w-8 h-8 bg-white/10 rounded-xl flex items-center justify-center group-hover:bg-white/20 transition-colors">
                                                    <i class="bi bi-plus-lg"></i>
                                                </div>
                                                <span>New Table Entity</span>
                                            </button>
                                        </div>

                                        <!-- Table Grid -->
                                        <div
                                            class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 2xl:grid-cols-5 gap-8">
                                            <c:forEach var="table" items="${tables}">
                                                <div
                                                    class="bg-white p-8 rounded-[42px] border border-slate-200 shadow-sm hover:shadow-2xl hover:shadow-coffee-100/40 hover:-translate-y-2 transition-all group flex flex-col items-center gap-6 relative overflow-hidden">
                                                    <!-- Status Indicator & Background Glow -->
                                                    <div
                                                        class="absolute -right-8 -top-8 w-32 h-32 ${table.active ? 'bg-coffee-50/50' : 'bg-red-50/50'} rounded-full transition-transform group-hover:scale-150 duration-700">
                                                    </div>

                                                    <!-- Main Icon Circle -->
                                                    <div
                                                        class="w-24 h-24 rounded-[32px] ${table.active ? 'bg-coffee-50 text-coffee-700 shadow-inner ring-1 ring-coffee-100' : 'bg-red-50 text-red-400 ring-1 ring-red-100'} flex items-center justify-center text-4xl relative z-10 transition-transform group-hover:rotate-12 duration-500">
                                                        <i class="bi bi-grid-3x3-gap"></i>
                                                    </div>

                                                    <!-- Table Info -->
                                                    <div class="text-center relative z-10">
                                                        <p class="text-2xl font-black text-slate-900 mb-1">
                                                            ${table.tableNumber}</p>
                                                        <div class="flex items-center justify-center gap-2">
                                                            <span
                                                                class="text-[10px] font-black text-slate-400 uppercase tracking-[0.2em] border border-slate-100 px-3 py-1 rounded-full bg-slate-50">CODE</span>
                                                            <span
                                                                class="text-sm font-black text-coffee-600/60">${table.code}</span>
                                                        </div>
                                                    </div>

                                                    <!-- Actions Tooltip-style bar -->
                                                    <div
                                                        class="flex items-center gap-3 relative z-10 bg-slate-50/80 backdrop-blur-sm p-3 rounded-3xl border border-slate-100 mt-2">
                                                        <button
                                                            onclick="showQR('${table.id}', '${table.tableNumber}', '${table.code}')"
                                                            class="w-12 h-12 flex items-center justify-center text-slate-400 hover:text-coffee-700 hover:bg-white hover:shadow-lg transition-all rounded-2xl group/action"
                                                            title="QR Code">
                                                            <i
                                                                class="bi bi-qr-code text-xl group-hover/action:scale-110"></i>
                                                        </button>
                                                        <div class="w-px h-6 bg-slate-200"></div>
                                                        <button
                                                            onclick="editTable('${table.id}', '${table.tableNumber}', '${table.code}')"
                                                            class="w-12 h-12 flex items-center justify-center text-slate-400 hover:text-blue-600 hover:bg-white hover:shadow-lg transition-all rounded-2xl group/action"
                                                            title="Edit">
                                                            <i
                                                                class="bi bi-pencil-square text-xl group-hover/action:scale-110"></i>
                                                        </button>
                                                        <div class="w-px h-6 bg-slate-200"></div>
                                                        <a href="${pageContext.request.contextPath}/manager/tables/delete?id=${table.id}"
                                                            class="w-12 h-12 flex items-center justify-center text-slate-400 hover:text-red-600 hover:bg-white hover:shadow-lg transition-all rounded-2xl group/action"
                                                            onclick="return confirm('Archive this table entity?')">
                                                            <i
                                                                class="bi bi-trash3 text-xl group-hover/action:scale-110"></i>
                                                        </a>
                                                    </div>
                                                </div>
                                            </c:forEach>

                                            <!-- Empty State / Add Placeholder -->
                                            <c:if test="${empty tables}">
                                                <div
                                                    class="col-span-full py-20 flex flex-col items-center justify-center text-slate-300">
                                                    <div
                                                        class="w-24 h-24 border-4 border-dashed border-slate-200 rounded-[42px] flex items-center justify-center mb-6">
                                                        <i class="bi bi-grid-3x3-gap text-4xl"></i>
                                                    </div>
                                                    <p class="text-xl font-black tracking-tight">No tables established
                                                        yet</p>
                                                    <p class="text-sm font-medium">Click "New Table Entity" to begin
                                                        shop layout</p>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:when>
                            </c:choose>
                        </div>

                        <!-- Right Side: Order/Cart or Detail View -->
                        <c:if test="${activeTab == 'pos' || (activeTab == 'bills' && not empty currentBill)}">
                            <div id="billPanel"
                                class="w-[380px] xl:w-[420px] bg-white border-l border-pos-border flex flex-col shrink-0 relative z-20 shadow-[-5px_0_15px_-5px_rgba(0,0,0,0.05)]">

                                <!-- Cart Header -->
                                <div
                                    class="h-14 border-b border-pos-border px-4 flex items-center justify-between shrink-0 bg-white">
                                    <div class="flex-grow flex items-center gap-2">
                                        <button
                                            class="text-pos-text hover:text-coffee-700 bg-pos-bg p-2 rounded-lg transition-colors border border-pos-border shadow-sm">
                                            <i class="bi bi-person-plus-fill text-lg"></i>
                                        </button>
                                        <div class="flex-grow">
                                            <p
                                                class="text-center font-bold text-sm bg-pos-bg py-2 rounded-lg border border-pos-border text-pos-text cursor-pointer hover:bg-gray-200 transition-colors shadow-sm">
                                                <i class="bi bi-search mr-1 text-pos-muted"></i>
                                                <fmt:message key="pos.customer.retail" />
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Context Info -->
                                <div
                                    class="flex items-center px-4 py-2.5 border-b border-pos-border bg-gray-50 text-xs font-semibold text-pos-muted uppercase tracking-wider">
                                    <span class="w-10">
                                        <fmt:message key="pos.table" />
                                    </span>
                                    <span class="ml-2 px-2.5 py-0.5 bg-coffee-100 text-coffee-700 rounded mr-auto">
                                        <fmt:message key="pos.takeaway" />
                                    </span>
                                    <span class="">
                                        <fmt:message key="pos.bill.code" />:
                                        <c:choose>
                                            <c:when test="${not empty currentBill}">${currentBill.code}</c:when>
                                            <c:otherwise>
                                                <fmt:message key="pos.bill.new" />
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>

                                <!-- Cart Items -->
                                <div class="flex-grow overflow-y-auto pos-grid-scroll bg-white">
                                    <c:choose>
                                        <c:when test="${not empty currentBill.billDetails}">
                                            <table class="w-full text-sm">
                                                <c:forEach var="item" items="${currentBill.billDetails}"
                                                    varStatus="status">
                                                    <tr
                                                        class="border-b border-pos-border hover:bg-pos-bg group transition-colors">
                                                        <td
                                                            class="p-3 w-8 text-center text-pos-muted text-xs align-top pt-4 font-medium">
                                                            ${status.index + 1}</td>
                                                        <td class="py-3 pr-2 align-top">
                                                            <div class="font-bold text-pos-text leading-tight mb-1">
                                                                ${item.drink.name}</div>
                                                            <div class="text-[13px] text-pos-muted">
                                                                <fmt:formatNumber value="${item.price}"
                                                                    pattern="#,###" />
                                                            </div>

                                                            <!-- Note Field with Quick Dropdown -->
                                                            <div class="relative mt-2">
                                                                <c:choose>
                                                                    <c:when test="${currentBill.status == 'WAITING'}">
                                                                        <div onclick="toggleNoteDropdown('${item.drink.id}')"
                                                                            class="flex items-center gap-1 text-[11px] ${not empty item.note ? 'text-coffee-700 font-bold' : 'text-pos-muted'} hover:text-coffee-700 cursor-pointer w-max transition-all bg-gray-50 px-2 py-0.5 rounded border border-pos-border">
                                                                            <i class="bi bi-pencil-square"></i>
                                                                            <span class="truncate max-w-[120px]">${not
                                                                                empty
                                                                                item.note ? item.note : '
                                                                                <fmt:message key="pos.item.note" />'}
                                                                            </span>
                                                                        </div>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div
                                                                            class="flex items-center gap-1 text-[11px] ${not empty item.note ? 'text-gray-600 font-bold' : 'text-pos-muted'} cursor-default w-max transition-all bg-gray-50 px-2 py-0.5 rounded border border-pos-border">
                                                                            <i class="bi bi-pencil-square"></i>
                                                                            <span class="truncate max-w-[120px]">${not
                                                                                empty
                                                                                item.note ? item.note : '
                                                                                <fmt:message key="pos.item.note" />'}
                                                                            </span>
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>

                                                                <!-- Dropdown for notes -->
                                                                <div id="note-dropdown-${item.drink.id}"
                                                                    class="note-dropdown hidden absolute top-full left-0 mt-1 w-48 bg-white border border-pos-border rounded-lg shadow-xl z-50 py-2">
                                                                    <div
                                                                        class="px-3 py-1.5 text-[10px] font-bold text-gray-400 uppercase tracking-widest bg-gray-50 mb-1">
                                                                        <fmt:message key="pos.item.note.select" />
                                                                    </div>
                                                                    <c:forEach var="n"
                                                                        items="${['50% Sugar', '70% Sugar', '100% Sugar', 'No Ice', 'No Sugar']}">
                                                                        <a href="javascript:void(0)"
                                                                            onclick="updateNoteAjax(${currentBill.id}, ${item.drink.id}, '${n}')"
                                                                            class="block px-4 py-1.5 text-xs hover:bg-coffee-50 hover:text-coffee-700 text-pos-text transition-all">
                                                                            ${n}
                                                                        </a>
                                                                    </c:forEach>
                                                                    <div
                                                                        class="border-t border-pos-border mt-2 pt-2 px-2">
                                                                        <input type="text"
                                                                            onkeyup="if(event.key === 'Enter') handleCustomNoteInput(this, ${not empty currentBill.id ? currentBill.id : 0}, ${not empty item.drink.id ? item.drink.id : 0})"
                                                                            placeholder="<fmt:message key='pos.item.note.placeholder' />"
                                                                            value="${item.note}" class="w-full text-xs p-2 bg-gray-50 border
                                                                        border-pos-border rounded-md focus:outline-none
                                                                        focus:border-coffee-500 focus:ring-1
                                                                        focus:ring-coffee-200 transition-all">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td class="py-3 px-1 w-[110px] align-top">
                                                            <div
                                                                class="flex items-center bg-white border border-pos-border rounded-md shrink-0 overflow-hidden shadow-sm h-8 mt-1">
                                                                <c:choose>
                                                                    <c:when test="${currentBill.status == 'WAITING'}">
                                                                        <button
                                                                            class="w-8 h-full flex items-center justify-center text-pos-text hover:bg-gray-100 border-r border-pos-border shrink-0 active:bg-gray-200"
                                                                            onclick="updateQtyAjax(${currentBill.id}, ${item.drink.id}, ${item.quantity - 1})">
                                                                            <i class="bi bi-dash"></i>
                                                                        </button>
                                                                        <input type="text" value="${item.quantity}"
                                                                            readonly
                                                                            class="w-8 h-full text-center font-bold text-sm bg-transparent outline-none p-0 cursor-default select-none">
                                                                        <button
                                                                            class="w-8 h-full flex items-center justify-center text-pos-text hover:bg-gray-100 border-l border-pos-border shrink-0 active:bg-gray-200"
                                                                            onclick="updateQtyAjax(${currentBill.id}, ${item.drink.id}, ${item.quantity + 1})">
                                                                            <i class="bi bi-plus"></i>
                                                                        </button>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span
                                                                            class="w-full text-center font-bold text-sm text-pos-muted">x${item.quantity}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </td>
                                                        <td
                                                            class="py-3 pl-2 pr-4 text-right font-bold text-pos-text w-24 align-top pt-4">
                                                            <fmt:formatNumber value="${item.price * item.quantity}"
                                                                pattern="#,###" />
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </c:when>
                                        <c:otherwise>
                                            <div
                                                class="h-full flex flex-col items-center justify-center text-pos-muted opacity-40">
                                                <i class="bi bi-cart-x text-6xl mb-4 text-coffee-300"></i>
                                                <p class="font-medium text-lg">
                                                    <fmt:message key="pos.bill.empty" />
                                                </p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- Cart Footer (Checkout) -->
                                <div
                                    class="border-t border-pos-border bg-white shrink-0 shadow-[0_-5px_15px_-5px_rgba(0,0,0,0.05)]">
                                    <!-- Summary -->
                                    <div class="px-4 py-3 space-y-2 text-sm border-b border-pos-border bg-gray-50/30">
                                        <div class="flex justify-between items-center text-pos-text">
                                            <span>
                                                <fmt:message key="pos.bill.total" /> (
                                                <c:out value="${fn:length(currentBill.billDetails)}" />
                                                <fmt:message key="pos.bill.items" />)
                                            </span>
                                            <span class="font-bold text-base">
                                                <fmt:formatNumber value="${currentBill.total}" pattern="#,###" />
                                            </span>
                                        </div>
                                        <div class="flex justify-between items-center text-pos-muted">
                                            <span>
                                                <fmt:message key="pos.bill.discount" /> (F4)
                                            </span>
                                            <span
                                                class="cursor-pointer border-b border-dashed border-pos-muted">0</span>
                                        </div>
                                    </div>

                                    <!-- Total & Big Buttons -->
                                    <div class="p-4 bg-white">
                                        <div class="flex justify-between items-center mb-4">
                                            <span class="font-bold text-pos-text text-sm">
                                                <fmt:message key="pos.bill.payable" />
                                            </span>
                                            <span class="text-3xl font-extrabold text-coffee-700 tracking-tight">
                                                <fmt:formatNumber
                                                    value="${currentBill.total != null ? currentBill.total : 0}"
                                                    pattern="#,###" />
                                            </span>
                                        </div>

                                        <fmt:message key="pos.bill.confirm.cancel" var="msgCancel" />
                                        <fmt:message key="pos.bill.confirm.checkout" var="msgCheckout" />

                                        <div class="grid grid-cols-5 gap-3">
                                            <!-- Extra Actions (Cancel) -->
                                            <button
                                                class="col-span-1 border-2 border-pos-border text-pos-danger rounded-xl h-14 flex items-center justify-center font-bold text-xl hover:bg-red-50 hover:border-red-200 transition-colors ${empty currentBill.billDetails ? 'opacity-50 cursor-not-allowed' : 'active:scale-95'}"
                                                ${empty currentBill.billDetails ? 'disabled' : '' }
                                                onclick="if(confirm('${msgCancel}')) location.href='${pageContext.request.contextPath}/employee/pos/cancel?billId=${currentBill.id}'"
                                                title="Huỷ đơn">
                                                <i class="bi bi-trash3"></i>
                                            </button>

                                            <!-- Print Bill Button -->
                                            <button
                                                class="col-span-1 border-2 border-pos-border text-coffee-700 rounded-xl h-14 flex items-center justify-center font-bold text-xl hover:bg-coffee-50 hover:border-coffee-200 transition-colors ${empty currentBill.billDetails ? 'opacity-50 cursor-not-allowed' : 'active:scale-95'}"
                                                ${empty currentBill.billDetails ? 'disabled' : '' }
                                                onclick="showPrintModal()" title="In hoá đơn">
                                                <i class="bi bi-printer"></i>
                                            </button>

                                            <c:choose>
                                                <c:when test="${currentBill.status == 'WAITING'}">
                                                    <!-- Pay Button -->
                                                    <button
                                                        class="col-span-3 bg-[#10b981] hover:bg-[#059669] rounded-xl h-14 flex items-center justify-center gap-2 text-white font-bold text-lg shadow-[0_4px_14px_0_rgba(16,185,129,0.39)] transition-all ${empty currentBill.billDetails ? 'opacity-50 cursor-not-allowed shadow-none hover:bg-[#10b981]' : 'hover:-translate-y-0.5 active:translate-y-0 active:scale-95'}"
                                                        ${empty currentBill.billDetails ? 'disabled' : '' }
                                                        onclick="if(confirm('${msgCheckout}')) location.href='${pageContext.request.contextPath}/employee/pos/checkout?billId=${currentBill.id}'">
                                                        <i class="bi bi-cash-stack text-xl"></i>
                                                        <span class="tracking-wide text-sm">
                                                            <fmt:message key="pos.bill.checkout" /> (F9)
                                                        </span>
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/employee/pos"
                                                        class="col-span-3 bg-blue-600 hover:bg-blue-700 rounded-xl h-14 flex items-center justify-center gap-2 text-white font-bold text-lg shadow-[0_4px_14px_0_rgba(37,99,235,0.39)] transition-all active:scale-95">
                                                        <i class="bi bi-plus-circle text-xl"></i>
                                                        <span class="tracking-wide text-sm">New Order</span>
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                        </c:if>

                        <!-- Create/Edit Table Modal -->
                        <div class="modal fade" id="addTableModal" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content bg-white border-0 shadow-2xl rounded-[42px] overflow-hidden">
                                    <div class="p-10">
                                        <div class="flex justify-between items-center mb-8">
                                            <div>
                                                <h5 class="text-3xl font-black text-slate-900 tracking-tight">Table
                                                    Entity</h5>
                                                <p class="text-slate-400 font-medium text-sm mt-1">Configure layout
                                                    parameters</p>
                                            </div>
                                            <button type="button"
                                                class="w-12 h-12 flex items-center justify-center rounded-2xl bg-slate-50 text-slate-400 hover:text-slate-900 transition-colors"
                                                data-bs-dismiss="modal">
                                                <i class="bi bi-x-lg"></i>
                                            </button>
                                        </div>

                                        <form action="${pageContext.request.contextPath}/manager/tables/save"
                                            method="POST" class="space-y-6">
                                            <div class="space-y-2">
                                                <label
                                                    class="text-[10px] font-black text-slate-400 uppercase tracking-[0.2em] ml-1">Visible
                                                    Name</label>
                                                <div class="relative">
                                                    <i
                                                        class="bi bi-tag absolute left-5 top-1/2 -translate-y-1/2 text-coffee-600/40 text-lg"></i>
                                                    <input type="text" name="name" required
                                                        placeholder="e.g. Premium Table 04"
                                                        class="w-full pl-14 pr-6 py-4 bg-slate-50 border border-slate-100 focus:bg-white focus:ring-4 focus:ring-coffee-100 focus:border-coffee-300 rounded-[24px] text-sm font-bold text-slate-700 transition-all outline-none">
                                                </div>
                                            </div>

                                            <div class="space-y-2">
                                                <label
                                                    class="text-[10px] font-black text-slate-400 uppercase tracking-[0.2em] ml-1">Entity
                                                    Code</label>
                                                <div class="relative">
                                                    <i
                                                        class="bi bi-qr-code-scan absolute left-5 top-1/2 -translate-y-1/2 text-coffee-600/40 text-lg"></i>
                                                    <input type="text" name="code" required placeholder="e.g. TABLE-04"
                                                        class="w-full pl-14 pr-6 py-4 bg-slate-50 border border-slate-100 focus:bg-white focus:ring-4 focus:ring-coffee-100 focus:border-coffee-300 rounded-[24px] text-sm font-bold text-slate-700 transition-all outline-none uppercase">
                                                </div>
                                            </div>

                                            <div class="flex gap-4 pt-4">
                                                <button type="button" data-bs-dismiss="modal"
                                                    class="flex-1 py-4 bg-slate-50 text-slate-400 font-black rounded-3xl hover:bg-slate-100 transition-all">Discard</button>
                                                <button type="submit"
                                                    class="flex-1 py-4 bg-coffee-700 text-white font-black rounded-3xl shadow-xl shadow-coffee-100 hover:bg-slate-900 transition-all active:scale-95">Save
                                                    Entity</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- QR Display Modal -->
                        <div class="modal fade" id="qrModal" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content bg-white border-0 shadow-2xl rounded-[42px] overflow-hidden">
                                    <div class="p-10 text-center">
                                        <div class="flex justify-end mb-2">
                                            <button type="button"
                                                class="w-10 h-10 flex items-center justify-center rounded-xl bg-slate-50 text-slate-400 hover:text-slate-900 transition-colors"
                                                data-bs-dismiss="modal">
                                                <i class="bi bi-x-lg"></i>
                                            </button>
                                        </div>

                                        <div
                                            class="w-20 h-20 bg-coffee-50 text-coffee-700 rounded-[28px] flex items-center justify-center text-3xl mx-auto mb-6 shadow-inner">
                                            <i class="bi bi-qr-code"></i>
                                        </div>

                                        <h5 id="qrTableInfo" class="text-2xl font-black text-slate-900 mb-2">Table Info
                                        </h5>
                                        <p class="text-slate-400 font-medium text-sm mb-8">Generated dynamic ordering
                                            gateway</p>

                                        <div class="bg-slate-50 p-8 rounded-[42px] border border-slate-100 mb-8 flex justify-center group overflow-hidden"
                                            id="printableQR">
                                            <img id="qrImage" src="" alt="QR"
                                                class="w-48 h-48 rounded-2xl shadow-sm group-hover:scale-105 transition-transform duration-500 bg-white p-2">
                                        </div>

                                        <div class="flex gap-4">
                                            <button onclick="printQR()"
                                                class="flex-1 py-4 bg-coffee-700 text-white font-black rounded-3xl shadow-xl shadow-coffee-100 hover:bg-slate-900 transition-all active:scale-95 flex items-center justify-center gap-2">
                                                <i class="bi bi-printer-fill"></i>
                                                Print Label
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </main>

                    <!-- Print Modal -->
                    <div id="printModal" class="fixed inset-0 z-[200] hidden">
                        <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" onclick="hidePrintModal()"></div>
                        <div
                            class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[400px] bg-white rounded-2xl shadow-2xl overflow-hidden flex flex-col max-h-[90vh]">
                            <!-- Content already defined above in printableBill, we keep it as is for printing -->
                            <div class="p-4 border-b border-gray-100 flex justify-between items-center bg-gray-50">
                                <h3 class="font-bold text-gray-800 flex items-center gap-2">
                                    <i class="bi bi-receipt"></i>
                                    <fmt:message key="admin.bill.print.preview" />
                                </h3>
                                <button onclick="hidePrintModal()" class="text-gray-400 hover:text-gray-600">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </div>

                            <div id="printableBill"
                                class="flex-grow overflow-y-auto p-8 bg-white text-black font-mono text-sm leading-relaxed">
                                <!-- Bill Header -->
                                <div class="text-center mb-6">
                                    <h2 class="text-xl font-black uppercase tracking-tighter mb-1">POLY COFFEE</h2>
                                    <p class="text-[10px] text-gray-500 italic">
                                        <fmt:message key="app.subtitle" />
                                    </p>
                                    <p class="text-[11px] mt-2 underline decoration-gray-200">
                                        <fmt:message key="admin.bill.print.address" />
                                    </p>
                                    <p class="text-[11px]">
                                        <fmt:message key="admin.bill.print.phone" />
                                    </p>
                                </div>

                                <div class="border-t border-dashed border-gray-300 my-4"></div>

                                <!-- Bill Info -->
                                <div class="space-y-1 text-xs mb-4">
                                    <div class="flex justify-between">
                                        <span>
                                            <fmt:message key="admin.bill.print.code" />:
                                        </span>
                                        <span class="font-bold text-right">${currentBill.code}</span>
                                    </div>
                                    <div class="flex justify-between">
                                        <span>
                                            <fmt:message key="admin.bill.print.date" />:
                                        </span>
                                        <span>
                                            <fmt:formatDate value="${currentBill.createdAt}"
                                                pattern="dd/MM/yyyy HH:mm" />
                                        </span>
                                    </div>
                                    <div class="flex justify-between">
                                        <span>
                                            <fmt:message key="admin.bill.print.cashier" />:
                                        </span>
                                        <span>${sessionScope.user.fullName}</span>
                                    </div>
                                    <div class="flex justify-between">
                                        <span>
                                            <fmt:message key="admin.bill.print.type" />:
                                        </span>
                                        <span class="font-bold">
                                            <fmt:message key="pos.takeaway" />
                                        </span>
                                    </div>
                                </div>

                                <div class="border-t border-dashed border-gray-300 my-4"></div>

                                <!-- Items -->
                                <table class="w-full text-xs">
                                    <thead>
                                        <tr class="border-b border-gray-100 italic">
                                            <th class="text-left py-2 font-normal">
                                                <fmt:message key="admin.bill.print.item" />
                                            </th>
                                            <th class="text-center py-2 font-normal">
                                                <fmt:message key="admin.bill.print.qty" />
                                            </th>
                                            <th class="text-right py-2 font-normal">
                                                <fmt:message key="admin.bill.print.price" />
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-gray-50">
                                        <c:forEach var="item" items="${currentBill.billDetails}">
                                            <tr>
                                                <td class="py-2">
                                                    <div class="font-bold">${item.drink.name}</div>
                                                    <c:if test="${not empty item.note}">
                                                        <div class="text-[10px] text-gray-500 italic">(${item.note})
                                                        </div>
                                                    </c:if>
                                                </td>
                                                <td class="text-center py-2">${item.quantity}</td>
                                                <td class="text-right py-2 font-bold">
                                                    <fmt:formatNumber value="${item.price * item.quantity}"
                                                        pattern="#,###" />
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <div class="border-t border-dashed border-gray-300 my-4"></div>

                                <!-- Totals -->
                                <div class="space-y-2 mb-6">
                                    <div class="flex justify-between text-xs">
                                        <span>
                                            <fmt:message key="admin.bill.print.subtotal" />:
                                        </span>
                                        <span>
                                            <fmt:formatNumber value="${currentBill.total}" pattern="#,###" />
                                        </span>
                                    </div>
                                    <div class="flex justify-between text-xs">
                                        <span>
                                            <fmt:message key="admin.bill.print.discount" />:
                                        </span>
                                        <span>0</span>
                                    </div>
                                    <div class="flex justify-between text-lg font-black pt-2 border-t border-gray-100">
                                        <span>
                                            <fmt:message key="admin.bill.print.total" />:
                                        </span>
                                        <span class="text-coffee-700">
                                            <fmt:formatNumber value="${currentBill.total}" pattern="#,###" />
                                            <fmt:message key="common.currency" />
                                        </span>
                                    </div>
                                </div>

                                <!-- QR Area -->
                                <p class="text-[14px] uppercase font-black text-gray-400 tracking-widest text-center">
                                    <fmt:message key="admin.bill.print.qr_label" />
                                </p>
                                <div class="flex flex-col items-center gap-3 bg-white py-2">
                                    <img id="vietqr-img" src="" alt="QR Code" class="w-75 h-75 object-contain mx-auto">
                                </div>
                                <!-- <div class="text-center">
                                    <p class="text-[11px] font-bold text-blue-800">
                                        <fmt:message key="bank.id" />
                                    </p>
                                    <p class="text-[10px] text-gray-600">STK:
                                        <fmt:message key="bank.account.no" />
                                    </p>
                                    <p class="text-[10px] font-black uppercase">
                                        <fmt:message key="bank.account.name" />
                                    </p>
                                </div> -->

                                <div class="text-center mt-8 space-y-1">
                                    <p class="text-[10px] font-bold">
                                        <fmt:message key="admin.bill.print.thankyou" />
                                    </p>
                                    <p class="text-[9px] text-gray-400">
                                        <fmt:message key="admin.bill.print.footer" />
                                    </p>
                                    <p class="text-[8px] text-gray-300 mt-4">Powered by SmartPOS v1.2</p>
                                </div>
                            </div>

                            <div class="p-4 border-t border-gray-100 flex gap-3 bg-gray-50">
                                <button onclick="printBill()"
                                    class="flex-grow bg-coffee-700 text-white font-bold py-3 rounded-xl hover:bg-coffee-800 shadow-lg shadow-coffee-100 flex items-center justify-center gap-2">
                                    <i class="bi bi-printer-fill"></i>
                                    <fmt:message key="admin.bill.print.btn" />
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Bill Detail Modal (Viewer only) -->
                    <div id="detailModal" class="fixed inset-0 z-[200] hidden">
                        <div class="absolute inset-0 bg-black/60 backdrop-blur-sm" onclick="hideDetailModal()"></div>
                        <div
                            class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[450px] bg-white rounded-3xl shadow-2xl overflow-hidden flex flex-col max-h-[90vh]">
                            <div
                                class="p-6 border-b border-gray-100 flex justify-between items-center bg-white sticky top-0 z-10">
                                <div>
                                    <h3 class="font-black text-gray-900 text-lg flex items-center gap-2">
                                        <i class="bi bi-info-square text-coffee-600"></i>
                                        Bill Details
                                    </h3>
                                    <p class="text-[11px] text-pos-muted font-bold uppercase tracking-wider mt-0.5">
                                        Reviewing order history
                                    </p>
                                </div>
                                <button onclick="hideDetailModal()"
                                    class="w-10 h-10 flex items-center justify-center rounded-full bg-gray-50 text-gray-400 hover:text-gray-600 transition-colors">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </div>

                            <div class="flex-grow overflow-y-auto p-6 space-y-6">
                                <!-- Order Info Card -->
                                <div class="grid grid-cols-2 gap-4 p-4 bg-pos-bg rounded-2xl border border-pos-border">
                                    <div>
                                        <p class="text-[10px] text-pos-muted font-black uppercase tracking-widest mb-1">
                                            Bill Code</p>
                                        <p class="font-mono text-sm font-bold text-coffee-700">${currentBill.code}</p>
                                    </div>
                                    <div>
                                        <p class="text-[10px] text-pos-muted font-black uppercase tracking-widest mb-1">
                                            Status</p>
                                        <span
                                            class="px-2 py-0.5 bg-green-100 text-green-700 text-[10px] font-black rounded-full uppercase">
                                            ${currentBill.status}
                                        </span>
                                    </div>
                                    <div>
                                        <p class="text-[10px] text-pos-muted font-black uppercase tracking-widest mb-1">
                                            Date Time</p>
                                        <p class="text-xs font-bold text-gray-700">
                                            <fmt:formatDate value="${currentBill.createdAt}"
                                                pattern="yyyy-MM-dd HH:mm" />
                                        </p>
                                    </div>
                                    <div>
                                        <p class="text-[10px] text-pos-muted font-black uppercase tracking-widest mb-1">
                                            Cashier</p>
                                        <p class="text-xs font-bold text-gray-700">${sessionScope.user.fullName}</p>
                                    </div>
                                </div>

                                <!-- Items Table -->
                                <div>
                                    <h4 class="text-xs font-black text-gray-400 uppercase tracking-widest mb-3 px-1">
                                        Order Items</h4>
                                    <div class="bg-white rounded-2xl border border-pos-border overflow-hidden">
                                        <table class="w-full text-sm">
                                            <thead class="bg-gray-50 border-b border-pos-border">
                                                <tr>
                                                    <th
                                                        class="text-left p-3 text-[10px] font-black uppercase text-pos-muted">
                                                        Item</th>
                                                    <th
                                                        class="text-center p-3 text-[10px] font-black uppercase text-pos-muted">
                                                        Qty</th>
                                                    <th
                                                        class="text-right p-3 text-[10px] font-black uppercase text-pos-muted">
                                                        Subtotal</th>
                                                </tr>
                                            </thead>
                                            <tbody class="divide-y divide-pos-border">
                                                <c:forEach var="item" items="${currentBill.billDetails}">
                                                    <tr>
                                                        <td class="p-3">
                                                            <div class="font-bold text-gray-800">${item.drink.name}
                                                            </div>
                                                            <c:if test="${not empty item.note}">
                                                                <div class="text-[10px] text-coffee-600 italic mt-0.5">
                                                                    ${item.note}</div>
                                                            </c:if>
                                                        </td>
                                                        <td class="p-3 text-center font-bold text-gray-600">
                                                            ${item.quantity}</td>
                                                        <td class="p-3 text-right font-black text-gray-900">
                                                            <fmt:formatNumber value="${item.price * item.quantity}"
                                                                pattern="#,###" />
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <!-- Total Card -->
                                <div
                                    class="p-5 bg-coffee-50 rounded-2xl border border-coffee-100 flex justify-between items-center">
                                    <span class="font-black text-coffee-700 uppercase tracking-widest text-xs">Total
                                        Amount Paid</span>
                                    <span class="text-2xl font-black text-coffee-800">
                                        <fmt:formatNumber value="${currentBill.total}" pattern="#,###" />
                                        <span class="text-sm font-bold ml-1">VNĐ</span>
                                    </span>
                                </div>
                            </div>

                            <div class="p-6 bg-gray-50 border-t border-gray-100 flex gap-3">
                                <button onclick="hideDetailModal()"
                                    class="flex-grow bg-white border border-pos-border text-gray-700 font-bold py-3 rounded-2xl hover:bg-gray-100 transition-colors shadow-sm">
                                    Close Window
                                </button>
                                <button onclick="hideDetailModal(); showPrintModal();"
                                    class="w-14 bg-white border border-pos-border text-coffee-600 rounded-2xl flex items-center justify-center hover:bg-coffee-50 transition-colors shadow-sm"
                                    title="Print/Pay Options">
                                    <i class="bi bi-printer-fill"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <style type="text/css" media="print">
                        @page {
                            size: 80mm auto;
                            margin: 0;
                        }

                        body * {
                            visibility: hidden;
                        }

                        #printableBill,
                        #printableBill * {
                            visibility: visible;
                        }

                        #printableBill {
                            position: absolute;
                            left: 0;
                            top: 0;
                            width: 80mm !important;
                            max-width: 80mm !important;
                            padding: 0mm !important;
                            margin: 0 auto;
                        }

                        #printableBill * {
                            color: black !important;
                            text-shadow: none !important;
                            box-shadow: none !important;
                        }

                        #printModal {
                            background: white !important;
                        }

                        .absolute.inset-0.bg-black\/60 {
                            display: none !important;
                        }

                        #printModal>div:last-child {
                            position: static !important;
                            transform: none !important;
                            width: 100% !important;
                            box-shadow: none !important;
                            max-height: none !important;
                        }

                        .p-4.border-b,
                        .p-4.border-t {
                            display: none !important;
                        }
                    </style>

                    <!-- Management Modals -->
                    <!-- Drink Modal -->
                    <div class="modal fade" id="drinkModal" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-lg modal-dialog-centered">
                            <div class="modal-content border-0 shadow-2xl rounded-[32px] overflow-hidden">
                                <div class="modal-header border-b border-pos-border bg-pos-bg px-8 py-6">
                                    <h5 class="text-xl font-black text-gray-900" id="drinkModalLabel">Modify Product
                                    </h5>
                                    <button type="button"
                                        class="w-10 h-10 flex items-center justify-center rounded-xl bg-white border border-pos-border text-gray-400 hover:text-gray-900 transition-all"
                                        data-bs-dismiss="modal">
                                        <i class="bi bi-x-lg"></i>
                                    </button>
                                </div>
                                <form id="drinkModalForm"
                                    action="${pageContext.request.contextPath}/manager/drinks/save" method="post"
                                    enctype="multipart/form-data">
                                    <input type="hidden" name="id" id="mDrinkId">
                                    <div class="modal-body p-8 lg:p-10">
                                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-10">
                                            <!-- Info -->
                                            <div class="space-y-6">
                                                <div>
                                                    <label
                                                        class="block text-[10px] font-black text-gray-400 uppercase tracking-[0.2em] mb-2.5">Product
                                                        Identity</label>
                                                    <input type="text" name="name" id="mDrinkName" required
                                                        placeholder="Enter drink name..."
                                                        class="w-full bg-slate-50 border border-slate-200 px-5 py-4 rounded-2xl focus:ring-4 focus:ring-coffee-500/10 focus:border-coffee-500 focus:bg-white outline-none transition-all font-bold text-gray-900">
                                                </div>
                                                <div class="grid grid-cols-2 gap-4">
                                                    <div>
                                                        <label
                                                            class="block text-[10px] font-black text-gray-400 uppercase tracking-[0.2em] mb-2.5">Category</label>
                                                        <select name="categoryId" id="mDrinkCat"
                                                            class="w-full bg-slate-50 border border-slate-200 px-5 py-4 rounded-2xl outline-none appearance-none font-bold text-gray-900 focus:border-coffee-500 focus:bg-white transition-all cursor-pointer"
                                                            required>
                                                            <c:forEach var="cat" items="${categories}">
                                                                <option value="${cat.id}">${cat.name}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <div>
                                                        <label
                                                            class="block text-[10px] font-black text-gray-400 uppercase tracking-[0.2em] mb-2.5">Market
                                                            Price</label>
                                                        <div class="relative">
                                                            <input type="number" name="price" id="mDrinkPrice" required
                                                                placeholder="0"
                                                                class="w-full bg-slate-50 border border-slate-200 px-5 py-4 rounded-2xl outline-none focus:border-coffee-500 focus:bg-white transition-all font-black text-coffee-700">
                                                            <span
                                                                class="absolute right-5 top-1/2 -translate-y-1/2 text-slate-400 font-bold text-xs uppercase">VND</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div>
                                                    <label
                                                        class="block text-[10px] font-black text-gray-400 uppercase tracking-[0.2em] mb-2.5">Product
                                                        Essence</label>
                                                    <textarea name="description" id="mDrinkDesc"
                                                        class="w-full bg-slate-50 border border-slate-200 px-5 py-4 rounded-2xl outline-none focus:border-coffee-500 focus:bg-white transition-all min-h-[120px] font-medium text-gray-600 resize-none"
                                                        placeholder="Describe this masterpiece..."></textarea>
                                                </div>
                                            </div>
                                            <!-- Media -->
                                            <div class="space-y-6">
                                                <div>
                                                    <label
                                                        class="block text-[10px] font-black text-gray-400 uppercase tracking-[0.2em] mb-2.5">Visual
                                                        Asset</label>
                                                    <div onclick="document.getElementById('mDrinkImgInput').click()"
                                                        class="relative border-4 border-dashed border-slate-100 rounded-[32px] p-2 flex flex-col items-center justify-center min-h-[240px] bg-slate-50 hover:bg-white hover:border-coffee-200 transition-all cursor-pointer group overflow-hidden">
                                                        <input type="file" name="image" id="mDrinkImgInput"
                                                            onchange="previewDrinkImage(this)" class="hidden"
                                                            accept="image/*">
                                                        <img id="mDrinkImgPreview" src=""
                                                            class="hidden w-full h-[240px] rounded-[28px] object-cover absolute inset-0">
                                                        <div id="mDrinkImgPlaceholder" class="text-center">
                                                            <div
                                                                class="w-16 h-16 bg-white rounded-3xl flex items-center justify-center text-slate-300 shadow-sm mb-4 mx-auto group-hover:scale-110 group-hover:bg-coffee-50 group-hover:text-coffee-600 transition-all">
                                                                <i class="bi bi-camera text-2xl"></i>
                                                            </div>
                                                            <p
                                                                class="font-black text-slate-400 text-xs uppercase tracking-widest">
                                                                Capture Visual</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="bg-slate-50 p-6 rounded-[28px] border border-slate-100">
                                                    <div class="flex items-center justify-between">
                                                        <div>
                                                            <h4
                                                                class="font-black text-gray-900 text-xs uppercase tracking-widest">
                                                                Active Status</h4>
                                                            <p class="text-[10px] text-slate-400 font-bold mt-1">Make
                                                                visible to consumers</p>
                                                        </div>
                                                        <div class="relative inline-block w-14 h-7">
                                                            <input type="checkbox" name="active" value="1"
                                                                id="mDrinkActive" class="peer hidden" checked>
                                                            <label for="mDrinkActive"
                                                                class="block w-full h-full bg-slate-200 rounded-full transition-all peer-checked:bg-coffee-600 cursor-pointer"></label>
                                                            <div
                                                                class="absolute w-5 h-5 bg-white rounded-full top-1 left-1 pointer-events-none transition-all peer-checked:translate-x-7 shadow-lg shadow-black/5">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer border-t border-pos-border bg-pos-bg px-8 py-6 gap-4">
                                        <button type="button"
                                            class="px-8 py-4 rounded-2xl font-black text-xs uppercase tracking-widest bg-white border border-slate-200 text-slate-400 hover:bg-slate-50 hover:text-slate-900 transition-all"
                                            data-bs-dismiss="modal">Abandon</button>
                                        <button type="submit"
                                            class="px-10 py-4 rounded-2xl font-black text-xs uppercase tracking-widest bg-coffee-700 text-white shadow-xl shadow-coffee-200 hover:bg-coffee-800 transition-all">Commit
                                            Changes</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Category Modal -->
                    <div class="modal fade" id="categoryModal" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content border-0 shadow-2xl rounded-[32px] overflow-hidden">
                                <div class="modal-header border-b border-pos-border bg-pos-bg px-8 py-6">
                                    <h5 class="text-xl font-black text-gray-900" id="categoryModalLabel">Category Logic
                                    </h5>
                                    <button type="button"
                                        class="w-10 h-10 flex items-center justify-center rounded-xl bg-white border border-pos-border text-gray-400 hover:text-gray-900 transition-all"
                                        data-bs-dismiss="modal">
                                        <i class="bi bi-x-lg"></i>
                                    </button>
                                </div>
                                <form id="categoryModalForm"
                                    action="${pageContext.request.contextPath}/manager/categories/save" method="post">
                                    <input type="hidden" name="id" id="mCatId">
                                    <div class="modal-body p-8 lg:p-10 space-y-8">
                                        <div>
                                            <label
                                                class="block text-[10px] font-black text-gray-400 uppercase tracking-[0.2em] mb-2.5">Classification
                                                Name</label>
                                            <input type="text" name="name" id="mCatName" required
                                                placeholder="e.g., Espresso Series"
                                                class="w-full bg-slate-50 border border-slate-200 px-5 py-4 rounded-2xl focus:ring-4 focus:ring-coffee-500/10 focus:border-coffee-500 focus:bg-white outline-none transition-all font-bold text-gray-900">
                                        </div>
                                        <div class="bg-slate-50 p-6 rounded-[28px] border border-slate-100">
                                            <div class="flex items-center justify-between">
                                                <div>
                                                    <h4
                                                        class="font-black text-gray-900 text-xs uppercase tracking-widest">
                                                        Visibility state</h4>
                                                    <p class="text-[10px] text-slate-400 font-bold mt-1">Show this group
                                                        in the menu</p>
                                                </div>
                                                <div class="relative inline-block w-14 h-7">
                                                    <input type="checkbox" name="active" value="1" id="mCatActive"
                                                        class="peer hidden" checked>
                                                    <label for="mCatActive"
                                                        class="block w-full h-full bg-slate-200 rounded-full transition-all peer-checked:bg-coffee-600 cursor-pointer"></label>
                                                    <div
                                                        class="absolute w-5 h-5 bg-white rounded-full top-1 left-1 pointer-events-none transition-all peer-checked:translate-x-7 shadow-lg shadow-black/5">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer border-t border-pos-border bg-pos-bg px-8 py-6 gap-4">
                                        <button type="button"
                                            class="px-8 py-4 rounded-2xl font-black text-xs uppercase tracking-widest bg-white border border-slate-200 text-slate-400 hover:bg-slate-50 hover:text-slate-900 transition-all"
                                            data-bs-dismiss="modal">Abandon</button>
                                        <button type="submit"
                                            class="px-10 py-4 rounded-2xl font-black text-xs uppercase tracking-widest bg-coffee-700 text-white shadow-xl shadow-coffee-200 hover:bg-coffee-800 transition-all">Synchronize</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Staff Modal -->
                    <div class="modal fade" id="staffModal" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-lg modal-dialog-centered">
                            <div class="modal-content border-0 shadow-2xl rounded-[32px] overflow-hidden">
                                <div class="modal-header border-b border-pos-border bg-pos-bg px-8 py-6">
                                    <h5 class="text-xl font-black text-gray-900" id="staffModalLabel">Human Resources
                                        Portfolio</h5>
                                    <button type="button"
                                        class="w-10 h-10 flex items-center justify-center rounded-xl bg-white border border-pos-border text-gray-400 hover:text-gray-900 transition-all"
                                        data-bs-dismiss="modal">
                                        <i class="bi bi-x-lg"></i>
                                    </button>
                                </div>
                                <form id="staffModalForm" action="${pageContext.request.contextPath}/manager/staff/save"
                                    method="post">
                                    <input type="hidden" name="id" id="mStaffId">
                                    <div class="modal-body p-8 lg:p-10">
                                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-10">
                                            <div class="space-y-6">
                                                <div>
                                                    <label
                                                        class="block text-[10px] font-black text-gray-400 uppercase tracking-[0.2em] mb-2.5">Legal
                                                        Identity</label>
                                                    <input type="text" name="fullName" id="mStaffName" required
                                                        placeholder="Full name..."
                                                        class="w-full bg-slate-50 border border-slate-200 px-5 py-4 rounded-2xl focus:ring-4 focus:ring-coffee-500/10 focus:border-coffee-500 focus:bg-white outline-none transition-all font-bold text-gray-900">
                                                </div>
                                                <div>
                                                    <label
                                                        class="block text-[10px] font-black text-gray-400 uppercase tracking-[0.2em] mb-2.5">Secure
                                                        Email</label>
                                                    <input type="email" name="email" id="mStaffEmail" required
                                                        placeholder="email@polycoffee.com"
                                                        class="w-full bg-slate-50 border border-slate-200 px-5 py-4 rounded-2xl focus:ring-4 focus:ring-coffee-500/10 focus:border-coffee-500 focus:bg-white outline-none transition-all font-bold text-gray-900">
                                                </div>
                                                <div id="mStaffPasswordRow">
                                                    <label
                                                        class="block text-[10px] font-black text-gray-400 uppercase tracking-[0.2em] mb-2.5">Access
                                                        Credential</label>
                                                    <input type="password" name="password" id="mStaffPassword"
                                                        placeholder="Minimum 6 characters..."
                                                        class="w-full bg-slate-50 border border-slate-200 px-5 py-4 rounded-2xl focus:ring-4 focus:ring-coffee-500/10 focus:border-coffee-500 focus:bg-white outline-none transition-all font-bold text-gray-900">
                                                </div>
                                            </div>
                                            <div class="space-y-6">
                                                <div>
                                                    <label
                                                        class="block text-[10px] font-black text-gray-400 uppercase tracking-[0.2em] mb-2.5">Network
                                                        Contact</label>
                                                    <input type="text" name="phone" id="mStaffPhone" required
                                                        placeholder="098xxxxxxxx"
                                                        class="w-full bg-slate-50 border border-slate-200 px-5 py-4 rounded-2xl focus:ring-4 focus:ring-coffee-500/10 focus:border-coffee-500 focus:bg-white outline-none transition-all font-bold text-gray-900">
                                                </div>
                                                <div>
                                                    <label
                                                        class="block text-[10px] font-black text-gray-400 uppercase tracking-[0.2em] mb-2.5">Hierarchical
                                                        Role</label>
                                                    <select name="role" id="mStaffRole"
                                                        class="w-full bg-slate-50 border border-slate-200 px-5 py-4 rounded-2xl outline-none appearance-none font-bold text-gray-900 focus:border-coffee-500 focus:bg-white transition-all cursor-pointer"
                                                        required>
                                                        <option value="false">Staff Member</option>
                                                        <option value="true">Executive Manager</option>
                                                    </select>
                                                </div>
                                                <div class="bg-slate-50 p-6 rounded-[28px] border border-slate-100">
                                                    <div class="flex items-center justify-between">
                                                        <div>
                                                            <h4
                                                                class="font-black text-gray-900 text-xs uppercase tracking-widest">
                                                                Active state</h4>
                                                            <p class="text-[10px] text-slate-400 font-bold mt-1">Grant
                                                                system permissions</p>
                                                        </div>
                                                        <div class="relative inline-block w-14 h-7">
                                                            <input type="checkbox" name="active" value="1"
                                                                id="mStaffActive" class="peer hidden" checked>
                                                            <label for="mStaffActive"
                                                                class="block w-full h-full bg-slate-200 rounded-full transition-all peer-checked:bg-coffee-600 cursor-pointer"></label>
                                                            <div
                                                                class="absolute w-5 h-5 bg-white rounded-full top-1 left-1 pointer-events-none transition-all peer-checked:translate-x-7 shadow-lg shadow-black/5">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer border-t border-pos-border bg-pos-bg px-8 py-6 gap-4">
                                        <button type="button"
                                            class="px-8 py-4 rounded-2xl font-black text-xs uppercase tracking-widest bg-white border border-slate-200 text-slate-400 hover:bg-slate-50 hover:text-slate-900 transition-all"
                                            data-bs-dismiss="modal">Abandon</button>
                                        <button type="submit"
                                            class="px-10 py-4 rounded-2xl font-black text-xs uppercase tracking-widest bg-coffee-700 text-white shadow-xl shadow-coffee-200 hover:bg-coffee-800 transition-all">Grant
                                            Clearance</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>


                    <script>
                        function toggleNoteDropdown(id) {
                            const el = document.getElementById('note-dropdown-' + id);
                            const isHidden = el.classList.contains('hidden');

                            // Close all other dropdowns
                            document.querySelectorAll('.note-dropdown').forEach(d => d.classList.add('hidden'));

                            if (isHidden) {
                                el.classList.remove('hidden');
                                // Auto focus input
                                setTimeout(() => el.querySelector('input').focus(), 100);
                            }
                        }

                        // POS AJAX helpers - prevent full page reload on cart operations
                        const _posCtxPath = '${pageContext.request.contextPath}';
                        let _currentBillId = ${ not empty currentBill ?currentBill.id: 0};

                        async function _refreshBillPanel(url) {
                            try {
                                const resp = await fetch(url, { redirect: 'follow' });
                                const html = await resp.text();
                                const doc = new DOMParser().parseFromString(html, 'text/html');
                                const newPanel = doc.getElementById('billPanel');
                                const panel = document.getElementById('billPanel');
                                if (newPanel && panel) {
                                    panel.innerHTML = newPanel.innerHTML;
                                    const match = resp.url.match(/[?&]billId=(\d+)/);
                                    if (match) _currentBillId = parseInt(match[1]);
                                }
                            } catch (e) {
                                console.error('POS AJAX error:', e);
                                window.location.href = url;
                            }
                        }

                        function addDrinkAjax(drinkId) {
                            _refreshBillPanel(_posCtxPath + '/employee/pos/add?drinkId=' + drinkId + '&billId=' + _currentBillId);
                        }

                        function updateQtyAjax(billId, drinkId, qty) {
                            _refreshBillPanel(_posCtxPath + '/employee/pos/update?billId=' + billId + '&drinkId=' + drinkId + '&quantity=' + qty);
                        }

                        function updateNoteAjax(billId, drinkId, note) {
                            _refreshBillPanel(_posCtxPath + '/employee/pos/note?billId=' + billId + '&drinkId=' + drinkId + '&note=' + encodeURIComponent(note));
                        }

                        function showQR(tableId, tableNum, tableCode) {
                            const baseUrl = window.location.origin + '${pageContext.request.contextPath}';
                            const orderUrl = baseUrl + '/guest/order?tableId=' + tableId;
                            const qrUrl = 'https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=' + encodeURIComponent(orderUrl);

                            document.getElementById('qrImage').src = qrUrl;
                            document.getElementById('qrTableInfo').innerText = tableNum + ' (' + tableCode + ')';

                            const modal = new bootstrap.Modal(document.getElementById('qrModal'));
                            modal.show();
                        }

                        function editTable(id, name, code) {
                            const form = document.querySelector('#addTableModal form');
                            form.action = '${pageContext.request.contextPath}/manager/tables/save';
                            form.querySelector('input[name="name"]').value = name;
                            form.querySelector('input[name="code"]').value = code;

                            // Add ID field if it doesn't exist
                            let idInput = form.querySelector('input[name="id"]');
                            if (!idInput) {
                                idInput = document.createElement('input');
                                idInput.type = 'hidden';
                                idInput.name = 'id';
                                form.appendChild(idInput);
                            }
                            idInput.value = id;

                            document.querySelector('#addTableModal h5').innerText = 'Edit Table Definition';
                            const modal = new bootstrap.Modal(document.getElementById('addTableModal'));
                            modal.show();
                        }

                        // Reset modal on close/open for "Add"
                        document.getElementById('addTableModal').addEventListener('hidden.bs.modal', function () {
                            const form = this.querySelector('form');
                            form.querySelector('input[name="name"]').value = '';
                            form.querySelector('input[name="code"]').value = '';
                            form.querySelector('input[name="id"]')?.remove();
                            this.querySelector('h5').innerText = 'Establish New Table';
                        });

                        function printQR() {
                            const url = document.getElementById('qrImage').src;
                            const name = document.getElementById('qrTableInfo').innerText;
                            const win = window.open('', '_blank');
                            win.document.write(`
                                <html>
                                <head><title>Print Label - ${name}</title></head>
                                <body style="text-align: center; font-family: 'Outfit', sans-serif; padding: 60px; color: #1e293b; background: white;">
                                    <div style="border: 4px solid #f1f5f9; padding: 60px; border-radius: 60px; display: inline-block;">
                                        <h1 style="font-size: 48px; font-weight: 900; margin-top: 0; margin-bottom: 40px; text-transform: uppercase; letter-spacing: -1px; color: #1e293b;">${name}</h1>
                                        <div style="background: #f8fafc; padding: 40px; border-radius: 40px; border: 1px solid #e2e8f0; margin-bottom: 40px;">
                                            <img src="${url}" style="width: 320px; height: 320px; display: block; filter: contrast(110%);">
                                        </div>
                                        <p style="font-weight: 900; letter-spacing: 4px; color: #6F4E37; font-size: 14px; margin: 0;">&bull; SCAN TO DISCOVER &bull;</p>
                                        <p style="font-weight: 500; font-size: 12px; color: #94a3b8; margin-top: 8px;">PolyCoffee Intelligence Network</p>
                                    </div>
                                    <script>window.onload = () => { setTimeout(() => { window.print(); window.close(); }, 500); }<\/script>
                                </body>
                                </html>
                            `);
                            win.document.close();
                        }

                        function handleCustomNote(billId, drinkId, note) {
                            updateNoteAjax(billId, drinkId, note);
                        }

                        // Management Modals Logic
                        function openDrinkModal(data = null) {
                            const modal = new bootstrap.Modal(document.getElementById('drinkModal'));
                            const form = document.getElementById('drinkModalForm');
                            const label = document.getElementById('drinkModalLabel');

                            // Reset form
                            form.reset();
                            document.getElementById('mDrinkImgPreview').classList.add('hidden');
                            document.getElementById('mDrinkImgPlaceholder').classList.remove('hidden');

                            if (data) {
                                label.innerText = 'Edit Product: ' + data.name;
                                document.getElementById('mDrinkId').value = data.id;
                                document.getElementById('mDrinkName').value = data.name;
                                document.getElementById('mDrinkCat').value = data.catId;
                                document.getElementById('mDrinkPrice').value = data.price;
                                document.getElementById('mDrinkDesc').value = data.desc;
                                document.getElementById('mDrinkActive').checked = data.active === 'true';

                                if (data.img) {
                                    const imgUrl = data.img.startsWith('http') ? data.img : '${pageContext.request.contextPath}/uploads/' + data.img;
                                    document.getElementById('mDrinkImgPreview').src = imgUrl;
                                    document.getElementById('mDrinkImgPreview').classList.remove('hidden');
                                    document.getElementById('mDrinkImgPlaceholder').classList.add('hidden');
                                }
                            } else {
                                label.innerText = 'Launch New Product';
                                document.getElementById('mDrinkId').value = '';
                                document.getElementById('mDrinkActive').checked = true;
                            }

                            modal.show();
                        }

                        function previewDrinkImage(input) {
                            if (input.files && input.files[0]) {
                                const reader = new FileReader();
                                reader.onload = function (e) {
                                    document.getElementById('mDrinkImgPreview').src = e.target.result;
                                    document.getElementById('mDrinkImgPreview').classList.remove('hidden');
                                    document.getElementById('mDrinkImgPlaceholder').classList.add('hidden');
                                }
                                reader.readAsDataURL(input.files[0]);
                            }
                        }

                        function openCategoryModal(data = null) {
                            const modal = new bootstrap.Modal(document.getElementById('categoryModal'));
                            const form = document.getElementById('categoryModalForm');
                            const label = document.getElementById('categoryModalLabel');

                            form.reset();

                            if (data) {
                                label.innerText = 'Update Category: ' + data.name;
                                document.getElementById('mCatId').value = data.id;
                                document.getElementById('mCatName').value = data.name;
                                document.getElementById('mCatActive').checked = data.active === 'true';
                            } else {
                                label.innerText = 'Define New Category';
                                document.getElementById('mCatId').value = '';
                                document.getElementById('mCatActive').checked = true;
                            }

                            modal.show();
                        }

                        function openStaffModal(data = null) {
                            const modal = new bootstrap.Modal(document.getElementById('staffModal'));
                            const form = document.getElementById('staffModalForm');
                            const label = document.getElementById('staffModalLabel');

                            form.reset();

                            if (data) {
                                label.innerText = 'Manage Identity: ' + data.name;
                                document.getElementById('mStaffId').value = data.id;
                                document.getElementById('mStaffName').value = data.name;
                                document.getElementById('mStaffEmail').value = data.email;
                                document.getElementById('mStaffPhone').value = data.phone;
                                document.getElementById('mStaffRole').value = data.role === 'true' ? 'true' : 'false';
                                document.getElementById('mStaffActive').checked = data.active === 'true';
                                document.getElementById('mStaffPasswordRow').classList.add('hidden');
                                document.getElementById('mStaffPassword').required = false;
                            } else {
                                label.innerText = 'Onboard New Staff';
                                document.getElementById('mStaffId').value = '';
                                document.getElementById('mStaffActive').checked = true;
                                document.getElementById('mStaffPasswordRow').classList.remove('hidden');
                                document.getElementById('mStaffPassword').required = true;
                            }

                            modal.show();
                        }

                        // Event Delegation for Edit Triggers
                        document.addEventListener('click', (e) => {
                            const drinkBtn = e.target.closest('.edit-drink-trigger');
                            if (drinkBtn) openDrinkModal(drinkBtn.dataset);

                            const catBtn = e.target.closest('.edit-category-trigger');
                            if (catBtn) openCategoryModal(catBtn.dataset);

                            const staffBtn = e.target.closest('.edit-staff-trigger');
                            if (staffBtn) openStaffModal(staffBtn.dataset);
                        });

                        // Initialize Animations
                        document.addEventListener('DOMContentLoaded', () => {
                            if (typeof AOS !== 'undefined') {
                                AOS.init({
                                    duration: 800,
                                    once: true,
                                    offset: 50
                                });
                            }

                            // Modal Entrance Animations
                            const managementModals = ['drinkModal', 'categoryModal', 'staffModal', 'addTableModal', 'qrModal'];
                            managementModals.forEach(id => {
                                const el = document.getElementById(id);
                                if (el) {
                                    el.addEventListener('show.bs.modal', function () {
                                        anime({
                                            targets: this.querySelector('.modal-content'),
                                            opacity: [0, 1],
                                            translateY: [30, 0],
                                            scale: [0.9, 1],
                                            rotateX: [10, 0],
                                            easing: 'easeOutElastic(1, .8)',
                                            duration: 800
                                        });
                                    });
                                }
                            });
                        });

                        function handleCustomNoteInput(input, billId, drinkId) {
                            handleCustomNote(billId, drinkId, input.value);
                        }

                        // Close on click outside
                        document.addEventListener('click', function (e) {
                            if (!e.target.closest('.relative')) {
                                document.querySelectorAll('.note-dropdown').forEach(d => d.classList.add('hidden'));
                            }
                        });

                        function showPrintModal() {
                            const modal = document.getElementById('printModal');
                            const qrImg = document.getElementById('vietqr-img');

                            // Bank Details from Messages Bundle
                            const bankId = '<fmt:message key="bank.id" />';
                            const accountNo = '<fmt:message key="bank.account.no" />';
                            const accountName = '<fmt:message key="bank.account.name" />';
                            const template = '<fmt:message key="bank.qr.template" />';
                            const amount = parseInt('${not empty currentBill.total ? currentBill.total : 0}');
                            const billCode = '${currentBill.code}';
                            const description = encodeURIComponent('Thanh toan hoa don ' + billCode);

                            // Construct VietQR URL properly via standard API format
                            const vietqrUrl = 'https://img.vietqr.io/image/' + bankId + '-' + accountNo + '-' + template + '.png?amount=' + amount + '&addInfo=' + description + '&accountName=' + encodeURIComponent(accountName);

                            qrImg.src = vietqrUrl;
                            modal.classList.remove('hidden');
                        }

                        function hidePrintModal() {
                            document.getElementById('printModal').classList.add('hidden');
                        }

                        function printBill() {
                            window.print();
                        }

                        function showDetailModal() {
                            const modal = document.getElementById('detailModal');
                            if (modal) {
                                modal.classList.remove('hidden');
                            }
                        }

                        function hideDetailModal() {
                            const modal = document.getElementById('detailModal');
                            if (modal) {
                                modal.classList.add('hidden');
                            }
                        }

                        // Employee POS Category Filtering
                        const catButtons = document.querySelectorAll('.category-btn');
                        const drinkItems = document.querySelectorAll('.drink-item');

                        catButtons.forEach(btn => {
                            btn.addEventListener('click', () => {
                                const catId = btn.getAttribute('data-cat-id');

                                // Update UI
                                catButtons.forEach(b => {
                                    b.classList.remove('bg-coffee-700', 'text-white', 'shadow-lg');
                                    b.classList.add('bg-pos-bg', 'text-pos-text');
                                });
                                btn.classList.add('bg-coffee-700', 'text-white', 'shadow-lg');
                                btn.classList.remove('bg-pos-bg', 'text-pos-text');

                                // Filter Items
                                drinkItems.forEach(item => {
                                    if (catId === '0' || item.getAttribute('data-cat-id') === catId) {
                                        item.style.display = 'flex';
                                    } else {
                                        item.style.display = 'none';
                                    }
                                });
                            });
                        });

                        // Admin Staff Search
                        const staffSearch = document.getElementById('staffSearch');
                        if (staffSearch) {
                            staffSearch.addEventListener('input', () => {
                                const term = staffSearch.value.toLowerCase();
                                document.querySelectorAll('.staff-row').forEach(row => {
                                    const name = row.querySelector('.staff-name').textContent.toLowerCase();
                                    row.style.display = name.includes(term) ? '' : 'none';
                                });
                            });
                        }

                        // Admin Category Search
                        const categorySearch = document.getElementById('categorySearch');
                        if (categorySearch) {
                            categorySearch.addEventListener('input', () => {
                                const term = categorySearch.value.toLowerCase();
                                document.querySelectorAll('.category-card').forEach(card => {
                                    const name = card.querySelector('.category-name').textContent.toLowerCase();
                                    card.style.display = name.includes(term) ? 'flex' : 'none';
                                });
                            });
                        }

                        // Admin Drink Search
                        const drinkSearch = document.getElementById('drinkSearch');
                        if (drinkSearch) {
                            drinkSearch.addEventListener('input', () => {
                                const term = drinkSearch.value.toLowerCase();
                                document.querySelectorAll('.drink-row').forEach(row => {
                                    const name = row.querySelector('.drink-name').textContent.toLowerCase();
                                    row.style.display = name.includes(term) ? '' : 'none';
                                });
                            });
                        }

                        // On page load, auto-show modal if needed:
                        window.addEventListener('load', () => {
                            const isCheckout = '${param.checkout}' === 'true';
                            const isHistoryTab = '${param.tab}' === 'bills';
                            const billStatus = '${currentBill.status}';

                            if (isCheckout && billStatus === 'FINISHED') {
                                showPrintModal();
                            } else if (isHistoryTab && billStatus != '') {
                                showDetailModal();
                            }

                            // Admin Bills Amount Filter
                            const adminAmountInput = document.getElementById('adminAmountInput');
                            const adminAmountRange = document.getElementById('adminAmountRange');

                            if (adminAmountInput && adminAmountRange) {
                                function filterAdminBills() {
                                    const max = parseInt(adminAmountRange.value, 10);
                                    document.querySelectorAll('.admin-bill-row').forEach(row => {
                                        const total = parseInt(row.getAttribute('data-total') || '0', 10);
                                        row.style.display = (total <= max) ? '' : 'none';
                                    });
                                }

                                adminAmountInput.addEventListener('input', () => {
                                    adminAmountRange.value = adminAmountInput.value || 0;
                                    filterAdminBills();
                                });

                                adminAmountRange.addEventListener('input', () => {
                                    adminAmountInput.value = adminAmountRange.value;
                                    filterAdminBills();
                                });

                                // init
                                adminAmountRange.value = 1000000;
                                adminAmountInput.value = 1000000;
                            }
                        });


                        // Charting Logic
                        let revenueChart = null;
                        let drinksChart = null;

                        function initCharts(data) {
                            const canvasRev = document.getElementById('revenueChart');
                            const canvasDrk = document.getElementById('drinksChart');
                            if (!canvasRev || !canvasDrk) return;

                            const ctxRev = canvasRev.getContext('2d');
                            const ctxDrk = canvasDrk.getContext('2d');

                            // 1. Revenue Chart
                            const revLabels = data.revenueByDay.slice(-7).map(d => {
                                const date = new Date(d.revenueDate);
                                return date.toLocaleDateString('vi-VN', { day: '2-digit', month: '2-digit' });
                            });
                            const revData = data.revenueByDay.slice(-7).map(d => d.totalRevenue);

                            const gradient = ctxRev.createLinearGradient(0, 0, 0, 300);
                            gradient.addColorStop(0, 'rgba(111, 78, 55, 0.15)');
                            gradient.addColorStop(1, 'rgba(111, 78, 55, 0)');

                            revenueChart = new Chart(ctxRev, {
                                type: 'line',
                                data: {
                                    labels: revLabels,
                                    datasets: [{
                                        label: 'Revenue',
                                        data: revData,
                                        borderColor: '#6F4E37',
                                        borderWidth: 4,
                                        pointBackgroundColor: '#fff',
                                        pointBorderColor: '#6F4E37',
                                        pointBorderWidth: 3,
                                        pointRadius: 6,
                                        pointHoverRadius: 9,
                                        fill: true,
                                        backgroundColor: gradient,
                                        tension: 0.4
                                    }]
                                },
                                options: {
                                    responsive: true,
                                    maintainAspectRatio: false,
                                    plugins: {
                                        legend: { display: false },
                                        tooltip: {
                                            backgroundColor: '#1e293b',
                                            padding: 12,
                                            titleFont: { size: 14, weight: 'bold' },
                                            bodyFont: { size: 13 },
                                            cornerRadius: 12,
                                            displayColors: false,
                                            callbacks: {
                                                label: (context) => context.parsed.y.toLocaleString() + ' ₫'
                                            }
                                        }
                                    },
                                    scales: {
                                        y: {
                                            beginAtZero: true,
                                            grid: { color: 'rgba(0,0,0,0.03)', drawBorder: false },
                                            ticks: {
                                                callback: (v) => v.toLocaleString() + ' ₫',
                                                font: { weight: 'bold', size: 11 },
                                                color: '#94a3b8'
                                            }
                                        },
                                        x: {
                                            grid: { display: false },
                                            ticks: {
                                                font: { weight: 'bold', size: 11 },
                                                color: '#94a3b8'
                                            }
                                        }
                                    }
                                }
                            });

                            // 2. Drinks Pie/Doughnut Chart
                            const drkLabels = data.topDrinks.map(d => d.drinkName);
                            const drkData = data.topDrinks.map(d => d.totalQuantitySold);
                            const colors = ['#6F4E37', '#8B5E3C', '#A67B5B', '#C29979', '#DEB887'];

                            drinksChart = new Chart(ctxDrk, {
                                type: 'doughnut',
                                data: {
                                    labels: drkLabels,
                                    datasets: [{
                                        data: drkData,
                                        backgroundColor: colors,
                                        borderWidth: 0,
                                        hoverOffset: 15
                                    }]
                                },
                                options: {
                                    responsive: true,
                                    maintainAspectRatio: false,
                                    cutout: '78%',
                                    plugins: {
                                        legend: { display: false },
                                        tooltip: {
                                            backgroundColor: '#1e293b',
                                            padding: 12,
                                            cornerRadius: 12,
                                            displayColors: true
                                        }
                                    }
                                }
                            });
                        }

                        function updateDashboardUI(data) {
                            if (!document.getElementById('todayRevenueText')) return;

                            document.getElementById('todayRevenueText').innerText = data.todayRevenue.toLocaleString() + ' ₫';
                            document.getElementById('todayOrdersText').innerHTML = data.todayOrders + ' <span class="text-sm font-bold text-slate-400">Bills</span>';
                            document.getElementById('weekRevenueText').innerText = data.weekRevenue.toLocaleString() + ' ₫';
                            document.getElementById('totalBillsText').innerText = data.totalBills;

                            // Update Charts
                            if (revenueChart) {
                                revenueChart.data.labels = data.revenueByDay.slice(-7).map(d => {
                                    const date = new Date(d.revenueDate);
                                    return date.toLocaleDateString('vi-VN', { day: '2-digit', month: '2-digit' });
                                });
                                revenueChart.data.datasets[0].data = data.revenueByDay.slice(-7).map(d => d.totalRevenue);
                                revenueChart.update();
                            }

                            if (drinksChart) {
                                drinksChart.data.labels = data.topDrinks.map(d => d.drinkName);
                                drinksChart.data.datasets[0].data = data.topDrinks.map(d => d.totalQuantitySold);
                                drinksChart.update();
                            }

                            // Update Top Drinks List
                            let html = '';
                            data.topDrinks.forEach((d, i) => {
                                html += `
                                    <div class="flex items-center gap-4 group hover:bg-slate-50 p-2 -mx-2 rounded-xl transition-colors">
                                        <div class="w-9 h-9 rounded-full bg-slate-100 group-hover:bg-coffee-100 flex items-center justify-center font-black text-slate-400 group-hover:text-coffee-700 text-xs transition-colors shrink-0">
                                            ${i + 1}
                                        </div>
                                        <div class="flex-grow min-w-0">
                                            <p class="text-sm font-bold text-slate-800 truncate">${d.drinkName}</p>
                                            <div class="flex items-center gap-2">
                                                <div class="w-24 bg-slate-100 h-1 rounded-full overflow-hidden">
                                                    <div class="bg-coffee-400 h-full" style="width: ${d.totalQuantitySold * 10}%"></div>
                                                </div>
                                                <span class="text-[10px] text-slate-400 font-bold">${d.totalQuantitySold} sold</span>
                                            </div>
                                        </div>
                                        <div class="text-right">
                                            <p class="text-xs font-black text-slate-900">${d.totalRevenue.toLocaleString()} ₫</p>
                                        </div>
                                    </div>
                                `;
                            });
                            document.getElementById('topDrinksList').innerHTML = html;
                        }

                        function refreshDashboard() {
                            fetch('${pageContext.request.contextPath}/api/stats')
                                .then(res => res.json())
                                .then(data => {
                                    updateDashboardUI(data);
                                })
                                .catch(err => console.error('Error refreshing dashboard:', err));
                        }

                        // Auto refresh every 60 seconds if on stats tab
                        setInterval(() => {
                            if ('${activeTab}' === 'stats') {
                                refreshDashboard();
                            }
                        }, 60000);

                        // Initial data load for charts
                        window.addEventListener('DOMContentLoaded', () => {
                            if ('${activeTab}' === 'stats') {
                                // Extract and normalize data from JSTL
                                const revDataRaw = [
                                    <c:forEach var="day" items="${dashboard.revenueByDay}" varStatus="st">
                                        {revenueDate: "${day.revenueDate}", totalRevenue: ${day.totalRevenue} }${!st.last ? ',' : ''}
                                    </c:forEach>
                                ];
                                const drkDataRaw = [
                                    <c:forEach var="drink" items="${dashboard.topDrinks}" varStatus="st">
                                        {drinkName: "${drink.drinkName}", totalQuantitySold: ${drink.totalQuantitySold}, totalRevenue: ${drink.totalRevenue} }${!st.last ? ',' : ''}
                                    </c:forEach>
                                ];

                                initCharts({
                                    revenueByDay: revDataRaw,
                                    topDrinks: drkDataRaw
                                });
                            }
                        });
                    </script>
                    </div>
                    </div>
                    </div>
                </body>

                </html>