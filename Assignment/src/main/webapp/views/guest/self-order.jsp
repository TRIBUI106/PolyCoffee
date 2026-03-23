<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html lang="${empty sessionScope.lang ? 'vi' : sessionScope.lang}">

<head>
    <title>Guest Self Order - PolyCoffee</title>
    <jsp:include page="/views/common/head.jsp" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" crossorigin="anonymous">
    <!-- Lucide Icons for Premium Look -->
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        coffee: {
                            50: '#fdf8f6',
                            100: '#f2e8e5',
                            200: '#eaddd7',
                            300: '#e0cec7',
                            400: '#d2bab0',
                            500: '#b89283',
                            600: '#9b7160',
                            700: '#6f4e37',
                            800: '#5a3d28',
                            900: '#462e1c',
                        },
                        slate: {
                            900: '#0F172A',
                            800: '#1E293B',
                            600: '#475569',
                            400: '#94A3B8',
                        }
                    },
                    fontFamily: { sans: ['Inter', 'sans-serif'] },
                    boxShadow: {
                        'premium': '0 4px 20px rgba(0,0,0,0.03), 0 1px 3px rgba(0,0,0,0.02)',
                        'premium-hover': '0 10px 30px rgba(111,78,55,0.08), 0 4px 6px rgba(0,0,0,0.02)',
                    }
                }
            }
        }
    </script>
    <style>
        .hide-scroll::-webkit-scrollbar { display: none; }
        .hide-scroll { -ms-overflow-style: none; scrollbar-width: none; }
        .glass-panel {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
        }
    </style>
</head>

<body class="h-screen w-screen flex flex-col bg-slate-50 text-slate-900 select-none overflow-hidden font-sans antialiased relative">
    <!-- Subtle Background Decor -->
    <div class="absolute inset-0 z-0 overflow-hidden pointer-events-none opacity-20 hidden lg:block">
        <div class="absolute -top-40 -right-40 w-96 h-96 rounded-full bg-coffee-200 blur-3xl"></div>
        <div class="absolute -bottom-40 -left-40 w-96 h-96 rounded-full bg-orange-100 blur-3xl"></div>
    </div>

    <!-- Header -->
    <header class="h-16 glass-panel border-b border-gray-200/60 px-6 flex items-center justify-between shrink-0 shadow-sm z-20 relative">
        <div class="flex items-center gap-4">
            <a href="${pageContext.request.contextPath}/" class="w-10 h-10 flex items-center justify-center bg-white shadow-sm border border-gray-100 text-coffee-700 rounded-xl hover:bg-slate-50 hover:border-gray-200 transition-colors duration-200 cursor-pointer">
                <i data-lucide="home" class="w-5 h-5 text-slate-700"></i>
            </a>
            <div class="h-6 w-px bg-gray-200"></div>
            <h1 class="font-bold text-2xl flex items-center gap-2 text-slate-900 tracking-tight">
                Self Order
                <span class="text-[10px] font-bold bg-slate-100 text-slate-600 px-2 py-1 rounded-md uppercase tracking-widest border border-slate-200">Guest</span>
            </h1>
        </div>
        <div class="flex items-center gap-3">
            <button onclick="openPointShop()" class="flex items-center gap-2 bg-gradient-to-r from-amber-400 to-orange-500 hover:from-amber-500 hover:to-orange-600 text-white px-4 py-2 rounded-xl shadow-md cursor-pointer transition-all active:scale-95">
                <i data-lucide="gift" class="w-4 h-4 text-orange-50"></i>
                <span class="text-sm font-bold tracking-wide">Đổi Điểm Nhận Quà</span>
            </button>
            <div class="text-sm font-semibold text-slate-500 flex items-center gap-2 bg-white px-4 py-2 rounded-xl border border-gray-100 shadow-sm">
                <i data-lucide="clock" class="w-4 h-4"></i> <span id="clock" class="tabular-nums"></span>
            </div>
        </div>
    </header>

    <!-- Main Workspace -->
    <main class="flex-grow flex overflow-hidden z-10 relative">
        <!-- Left: Menu Area -->
        <div class="flex-grow flex flex-col bg-transparent">
            <!-- Categories -->
            <div class="h-20 px-8 flex items-center gap-3 overflow-x-auto hide-scroll shrink-0">
                <button class="category-btn active px-6 py-2.5 rounded-full text-sm font-bold whitespace-nowrap transition-all duration-200 bg-slate-900 text-white shadow-lg shadow-slate-900/10 cursor-pointer" data-cat-id="0">
                    Tất cả
                </button>
                <c:forEach var="cat" items="${categories}">
                    <button class="category-btn px-6 py-2.5 rounded-full border border-gray-200 bg-white text-slate-600 hover:border-slate-300 hover:text-slate-900 text-sm font-semibold whitespace-nowrap transition-all duration-200 shadow-sm cursor-pointer" data-cat-id="${cat.id}">
                        ${cat.name}
                    </button>
                </c:forEach>
            </div>

            <!-- Drinks Grid -->
            <div class="flex-grow px-8 pb-8 overflow-y-auto">
                <div class="grid grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 2xl:grid-cols-5 gap-6 gap-y-8">
                    <c:forEach var="d" items="${drinks}">
                        <c:set var="imgUrl" value="${fn:startsWith(d.image, 'http') ? d.image : pageContext.request.contextPath.concat('/uploads/').concat(d.image)}" />
                        <div class="bg-white rounded-3xl border border-gray-100/50 shadow-premium hover:shadow-premium-hover transition-all duration-300 cursor-pointer flex flex-col group drink-item active:scale-[0.98]"
                             data-cat-id="${d.category.id}"
                             onclick="addToCart(${d.id}, '${fn:escapeXml(d.name)}', ${d.price}, '${imgUrl}')">
                            <div class="aspect-square bg-slate-50 relative overflow-hidden rounded-t-3xl border-b border-gray-50 p-4">
                                <c:choose>
                                    <c:when test="${not empty d.image}">
                                        <div class="w-full h-full rounded-2xl overflow-hidden shadow-sm relative filter group-hover:brightness-105 transition-all duration-300">
                                            <img src="${imgUrl}" class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500">
                                            <!-- Overlay vignette -->
                                            <div class="absolute inset-0 bg-gradient-to-t from-black/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="w-full h-full rounded-2xl flex items-center justify-center bg-gray-100 text-slate-300 group-hover:bg-coffee-50 transition-colors duration-300">
                                            <i data-lucide="coffee" class="w-12 h-12"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="absolute bottom-6 right-6 bg-white/95 backdrop-blur-md text-slate-900 text-sm font-black px-3.5 py-1.5 rounded-lg shadow-md border border-gray-100 group-hover:-translate-y-1 transition-transform duration-300">
                                    <fmt:formatNumber value="${d.price}" pattern="#,###" /> ₫
                                </div>
                            </div>
                            <div class="px-5 pt-4 pb-5 flex-grow flex flex-col justify-between bg-white rounded-b-3xl">
                                <p class="text-[11px] font-bold tracking-widest text-coffee-600 uppercase mb-1.5">${d.category.name}</p>
                                <h3 class="text-base font-bold text-slate-900 line-clamp-2 leading-snug group-hover:text-coffee-700 transition-colors duration-200">${d.name}</h3>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!-- Right: Cart & Checkout -->
        <div class="w-[420px] bg-white flex flex-col shrink-0 relative shadow-2xl z-30 border-l border-gray-100">
            <div class="px-6 py-5 border-b border-gray-100 flex justify-between items-center bg-white">
                <h2 class="text-lg font-black text-slate-900 tracking-tight flex items-center gap-2">
                    <i data-lucide="shopping-bag" class="w-5 h-5 text-coffee-600"></i> Hóa đơn của bạn
                </h2>
                <button onclick="clearCart()" class="text-slate-400 text-xs font-bold hover:text-red-500 transition-colors duration-200 cursor-pointer flex items-center gap-1 bg-slate-50 hover:bg-red-50 px-2 py-1.5 rounded-md">
                    <i data-lucide="trash-2" class="w-3.5 h-3.5"></i> Xóa
                </button>
            </div>
            
            <!-- Items Area -->
            <div class="flex-grow overflow-y-auto px-6 py-4 space-y-3 bg-slate-50/50" id="cartContainer">
                <div class="h-full flex flex-col items-center justify-center text-slate-300">
                    <div class="bg-slate-100 p-4 rounded-full mb-4">
                        <i data-lucide="shopping-cart" class="w-8 h-8 text-slate-400"></i>
                    </div>
                    <p class="font-semibold text-slate-500 text-sm">Chưa có món nào</p>
                    <p class="text-xs text-slate-400 mt-1">Chọn thức uống từ menu để đặt hàng</p>
                </div>
            </div>

            <!-- Checkout Section -->
            <div class="border-t border-gray-100 p-6 bg-white flex flex-col gap-4 shadow-[0_-10px_20px_rgba(0,0,0,0.02)] relative z-10">
                <!-- Vouchers Display Area -->
                <div id="activeVoucherBox" class="hidden justify-between items-center bg-emerald-50 border border-emerald-200 p-3 rounded-xl">
                    <div class="flex items-center gap-2">
                        <i data-lucide="ticket" class="w-5 h-5 text-emerald-600"></i>
                        <div>
                            <p class="text-[11px] text-emerald-700 uppercase font-bold tracking-wider">VOUCHER ÁP DỤNG</p>
                            <p class="text-sm text-emerald-900 font-bold" id="activeVoucherName">Giảm 25.000đ</p>
                        </div>
                    </div>
                    <button onclick="removeVoucher()" class="text-emerald-700 bg-emerald-200/50 hover:bg-emerald-200 p-1.5 rounded-lg transition-colors">
                        <i data-lucide="x" class="w-4 h-4"></i>
                    </button>
                </div>
                
                <!-- Guest Information Input -->
                <div class="grid grid-cols-1 gap-2.5">
                    <div class="relative flex items-center">
                        <i data-lucide="user" class="absolute left-3.5 w-4 h-4 text-slate-400"></i>
                        <input type="text" id="guestName" placeholder="Tên khách hàng" class="pl-10 pr-4 py-3 bg-slate-50 border border-slate-200 focus:bg-white focus:ring-2 focus:ring-coffee-500/20 focus:border-coffee-500 rounded-xl text-sm font-semibold w-full transition-all outline-none text-slate-900 placeholder:text-slate-400" autocomplete="off" required>
                    </div>
                    <div class="relative flex items-center">
                        <i data-lucide="phone" class="absolute left-3.5 w-4 h-4 text-slate-400"></i>
                        <input type="tel" id="guestPhone" onblur="fetchMyVouchers()" placeholder="Số điện thoại" class="pl-10 pr-4 py-3 bg-slate-50 border border-slate-200 focus:bg-white focus:ring-2 focus:ring-coffee-500/20 focus:border-coffee-500 rounded-xl text-sm font-semibold w-full transition-all outline-none text-slate-900 placeholder:text-slate-400" autocomplete="off" required>
                        <button onclick="fetchMyVouchers()" class="absolute right-2 text-xs font-bold text-white bg-slate-900 hover:bg-slate-800 px-3 py-1.5 rounded-lg active:scale-95 transition-all">
                            Tìm Voucher
                        </button>
                    </div>
                </div>
                
                <!-- Available Vouchers List (Hidden normally) -->
                <div id="voucherListContainer" class="hidden flex-col gap-2 max-h-36 overflow-y-auto hide-scroll pb-2 border-b border-gray-100">
                    <!-- Populated dynamically -->
                </div>

                <div class="flex justify-between items-end py-1">
                    <span class="text-slate-500 font-medium text-sm">Tổng cộng</span>
                    <span class="text-3xl font-black text-slate-900 tabular-nums" id="cartTotal">0 ₫</span>
                </div>

                <button onclick="checkout()" id="checkoutBtn" class="w-full bg-slate-900 hover:bg-coffee-700 text-white font-bold py-4 rounded-xl shadow-[0_4px_12px_rgba(15,23,42,0.15)] active:scale-[0.98] transition-all duration-200 flex items-center justify-center gap-2.5 text-base cursor-pointer disabled:opacity-50 disabled:cursor-not-allowed">
                    Thanh Toán Ngay <i data-lucide="arrow-right" class="w-4 h-4"></i>
                </button>
            </div>
        </div>
    </main>

    <!-- Point Shop Modal -->
    <div id="pointShopModal" class="fixed inset-0 bg-slate-900/40 backdrop-blur-sm z-50 items-center justify-center hidden opacity-0 transition-opacity duration-300">
        <div class="bg-white rounded-[2rem] shadow-2xl w-[90%] max-w-2xl transform scale-95 transition-transform duration-300 flex flex-col overflow-hidden max-h-[85vh]">
            <div class="px-8 py-6 border-b border-gray-100 flex justify-between items-center bg-gradient-to-r from-amber-50 to-orange-50">
                <div class="flex items-center gap-3">
                    <div class="bg-white p-2 rounded-xl shadow-sm"><i data-lucide="store" class="w-6 h-6 text-amber-600"></i></div>
                    <h2 class="text-2xl font-black text-slate-900 tracking-tight">Cửa hàng Điểm</h2>
                </div>
                <button onclick="closePointShop()" class="text-slate-400 hover:text-slate-900 transition-colors bg-white p-2 rounded-full shadow-sm"><i data-lucide="x" class="w-5 h-5"></i></button>
            </div>
            
            <div class="p-8 flex-grow overflow-y-auto">
                <!-- Check Points Form -->
                <div class="bg-slate-50 rounded-2xl p-6 border border-slate-100 flex gap-4 items-end mb-8 shadow-sm">
                    <div class="flex-glow w-full relative">
                        <label class="block text-xs font-bold text-slate-500 uppercase tracking-widest mb-2 px-1">Nhập Số Điện Thoại của bạn</label>
                        <i data-lucide="phone" class="absolute left-4 bottom-3.5 w-5 h-5 text-slate-400"></i>
                        <input type="tel" id="shopPhoneInput" class="pl-12 pr-4 py-3.5 bg-white border border-slate-300 focus:border-amber-500 focus:ring-2 focus:ring-amber-500/20 rounded-xl text-base font-bold w-full transition-all outline-none text-slate-900 placeholder:text-slate-300" placeholder="0901234567">
                    </div>
                    <button onclick="checkPoints()" class="bg-slate-900 text-white font-bold py-3.5 px-6 rounded-xl hover:bg-slate-800 transition-colors flex shrink-0 gap-2 items-center">
                        <i data-lucide="search" class="w-5 h-5"></i> Tra Cứu
                    </button>
                </div>

                <!-- Point Balance Display -->
                <div id="shopPointBalance" class="hidden mb-8 bg-gradient-to-br from-slate-900 to-slate-800 text-white p-6 rounded-2xl flex items-center justify-between shadow-lg">
                    <div>
                        <p class="text-slate-300 text-sm font-medium">Xin chào, số điện thoại <span id="shopPhoneLabel" class="font-bold text-white tracking-widest pl-1">...</span></p>
                        <p class="text-4xl font-black mt-1">Điểm hiện tại: <span id="shopPointVal" class="text-amber-400 text-5xl">0</span></p>
                    </div>
                    <i data-lucide="award" class="w-16 h-16 text-slate-700"></i>
                </div>

                <div id="shopPointError" class="hidden mb-8 bg-red-50 text-red-600 p-4 rounded-xl border border-red-200 font-medium flex items-center gap-3">
                    <i data-lucide="alert-circle" class="w-5 h-5"></i> <span id="shopErrorText">Không tìm thấy</span>
                </div>

                <h3 class="text-lg font-bold text-slate-900 mb-4 tracking-tight flex items-center gap-2">
                    <i data-lucide="tags" class="w-5 h-5 text-slate-400"></i> Đổi Vouchers Hấp Dẫn
                </h3>
                
                <!-- Catalog Grid -->
                <div id="shopCatalogGrid" class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div class="col-span-2 text-center py-8 text-slate-400 flex flex-col items-center">
                        <i data-lucide="loader" class="w-8 h-8 animate-spin"></i>
                        <p class="mt-2 font-medium">Đang tải...</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        lucide.createIcons();
        let cart = [];
        let subtotalAmt = 0;
        let activeVoucherId = null;
        let activeVoucherDiscount = 0;
        let currentShopPhone = "";
        let currentShopPoints = 0;

        function strPrice(val) {
            return new Intl.NumberFormat('vi-VN').format(val) + " ₫";
        }
        
        setInterval(() => {
            const d = new Date();
            document.getElementById('clock').innerText = d.toLocaleTimeString('vi-VN', {hour: '2-digit', minute:'2-digit'});
        }, 1000);

        // -- Cart Logic --
        function addToCart(id, name, price, img) {
            let item = cart.find(i => i.drinkId === id);
            if (item) {
                item.quantity++;
            } else {
                cart.push({ drinkId: id, name, price, quantity: 1, note: '' });
            }
            renderCart();
        }

        function updateQty(id, change) {
            let item = cart.find(i => i.drinkId === id);
            if (item) {
                item.quantity += change;
                if (item.quantity <= 0) {
                    cart = cart.filter(i => i.drinkId !== id);
                }
                renderCart();
            }
        }

        function clearCart() {
            cart = [];
            removeVoucher();
            renderCart();
        }

        function renderCart() {
            const container = document.getElementById('cartContainer');
            const totalEl = document.getElementById('cartTotal');
            const checkoutBtn = document.getElementById('checkoutBtn');
            const pointsPreview = document.getElementById('pointsPreview');
            const listContainer = document.getElementById('voucherListContainer');

            let total = 0;

            if (cart.length === 0) {
                container.innerHTML = `
                    <div class="h-full flex flex-col items-center justify-center text-slate-300">
                        <div class="bg-slate-100 p-4 rounded-full mb-4 ring-8 ring-white">
                            <i data-lucide="shopping-cart" class="w-8 h-8 text-slate-400"></i>
                        </div>
                        <p class="font-semibold text-slate-500 text-sm">Chưa có món nào</p>
                        <p class="text-xs text-slate-400 mt-1">Chọn thức uống từ menu để đặt hàng</p>
                    </div>
                `;
                lucide.createIcons();
                totalEl.innerText = "0 ₫";
                pointsPreview.innerText = "0";
                checkoutBtn.disabled = true;
                listContainer.classList.add('hidden');
                return;
            }

            checkoutBtn.disabled = false;

            let html = '';
            cart.forEach(item => {
                total += item.price * item.quantity;
                html += `
                <div class="bg-white p-3.5 rounded-2xl border border-gray-100/80 shadow-sm flex flex-col gap-3 group relative transform hover:-translate-y-0.5 transition-all duration-200">
                    <div class="flex justify-between items-center gap-4">
                        <div class="flex-grow pr-2">
                            <h4 class="font-bold text-slate-900 text-sm line-clamp-2 leading-tight">\${item.name}</h4>
                            <p class="text-coffee-600 font-bold mt-1 text-sm tabular-nums">\${strPrice(item.price)}</p>
                        </div>
                        <div class="flex items-center bg-slate-50 rounded-lg border border-slate-100 p-0.5">
                            <button onclick="updateQty(\${item.drinkId}, -1)" class="w-8 h-8 rounded-md bg-white text-slate-500 hover:text-slate-900 hover:shadow-sm flex items-center justify-center transition-all cursor-pointer"><i data-lucide="minus" class="w-3.5 h-3.5"></i></button>
                            <span class="w-8 text-center font-bold text-sm text-slate-900 tabular-nums">\${item.quantity}</span>
                            <button onclick="updateQty(\${item.drinkId}, 1)" class="w-8 h-8 rounded-md bg-white text-slate-500 hover:text-slate-900 hover:shadow-sm flex items-center justify-center transition-all cursor-pointer"><i data-lucide="plus" class="w-3.5 h-3.5"></i></button>
                        </div>
                    </div>
                </div>`;
            });

            container.innerHTML = html;
            lucide.createIcons();
            
            subtotalAmt = total;
            let finalAmt = Math.max(0, subtotalAmt - activeVoucherDiscount);

            totalEl.innerText = strPrice(finalAmt);
            pointsPreview.innerText = Math.floor(finalAmt / 1000);
        }

        // -- Apply Vouchers in Checkout --
        function fetchMyVouchers() {
            const phone = document.getElementById('guestPhone').value.trim();
            if(!phone) return;
            const container = document.getElementById('voucherListContainer');
            container.innerHTML = `<div class="text-xs font-semibold text-slate-500 p-2"><i data-lucide="loader" class="w-3 h-3 inline animate-spin mr-1"></i> Đang tải...</div>`;
            container.classList.remove('hidden');
            lucide.createIcons();

            fetch('${pageContext.request.contextPath}/guest/pointshop/status?phone=' + phone)
            .then(res => res.json())
            .then(data => {
                if(data.success) {
                    if(!data.vouchers || data.vouchers.length === 0) {
                        container.innerHTML = `<div class="text-[11px] font-bold text-slate-400 bg-slate-50 rounded-lg p-2.5 text-center">Tài khoản này chưa đổi voucher nào.</div>`;
                    } else {
                        let vHtml = '';
                        data.vouchers.forEach(v => {
                            vHtml += `
                                <div class="flex justify-between items-center bg-white border border-slate-200 rounded-lg p-2.5 hover:border-coffee-400 transition-colors cursor-pointer group" onclick="applyVoucher(\${v.id}, '\${v.name}', \${v.discountAmount})">
                                    <div class="flex items-center gap-2">
                                        <i data-lucide="ticket" class="w-4 h-4 text-coffee-500"></i>
                                        <span class="text-sm font-bold text-slate-700 group-hover:text-slate-900">\${v.name}</span>
                                    </div>
                                    <span class="bg-coffee-50 text-coffee-700 text-xs font-bold px-2 py-1 rounded">Áp Dụng</span>
                                </div>
                            `;
                        });
                        container.innerHTML = vHtml;
                    }
                } else {
                    container.innerHTML = `<div class="text-[11px] font-bold text-red-500 bg-red-50 rounded-lg p-2.5 text-center">Không khả dụng. Bạn cần tạo đơn hàng đầu tiên để lập tài khoản.</div>`;
                }
                lucide.createIcons();
            }).catch(e => {
                container.innerHTML = `<div class="text-[11px] font-bold text-red-500 p-2">Lỗi kết nối.</div>`;
            });
        }

        function applyVoucher(id, name, discount) {
            activeVoucherId = id;
            activeVoucherDiscount = discount;
            document.getElementById('voucherListContainer').classList.add('hidden');
            document.getElementById('activeVoucherName').innerText = name;
            document.getElementById('activeVoucherBox').classList.remove('hidden');
            document.getElementById('activeVoucherBox').classList.add('flex');
            renderCart();
        }

        function removeVoucher() {
            activeVoucherId = null;
            activeVoucherDiscount = 0;
            document.getElementById('activeVoucherBox').classList.add('hidden');
            document.getElementById('activeVoucherBox').classList.remove('flex');
            renderCart();
        }

        function checkout() {
            if (cart.length === 0) return;
            const name = document.getElementById('guestName').value.trim();
            const phone = document.getElementById('guestPhone').value.trim();

            if (!name || !phone) {
                Swal.fire({
                    icon: 'warning',
                    title: '<span class="text-xl font-bold font-sans">Thiếu thông tin!</span>',
                    html: '<p class="text-sm text-slate-500">Vui lòng nhập đầy đủ tên và số điện thoại.</p>',
                    confirmButtonColor: '#0F172A',
                    customClass: { popup: 'rounded-2xl', confirmButton: 'rounded-xl text-sm px-6 font-semibold' }
                });
                return;
            }

            checkoutBtn.disabled = true;
            checkoutBtn.innerHTML = '<i data-lucide="loader-2" class="w-4 h-4 animate-spin"></i> Đang xử lý...';
            lucide.createIcons();

            const payload = {
                guestName: name,
                guestPhone: phone,
                guestVoucherId: activeVoucherId,
                paymentMethod: 'CASH', // Guest mostly pays at desk
                items: cart.map(c => ({ drinkId: c.drinkId, quantity: c.quantity, note: c.note }))
            };

            fetch('${pageContext.request.contextPath}/guest/order/checkout', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    Swal.fire({
                        icon: 'success',
                        title: '<span class="text-2xl font-black font-sans tracking-tight text-slate-900">Đặt Món Thành Công!</span>',
                        html: `
                            <div class="text-left mt-6 text-sm flex flex-col gap-3">
                                <div class="bg-slate-50 p-4 rounded-xl border border-slate-100 flex justify-between items-center">
                                    <span class="text-slate-500 font-medium tracking-wide">Mã hóa đơn</span>
                                    <span class="text-slate-900 font-mono font-bold">\${data.billCode}</span>
                                </div>
                                <div class="bg-emerald-50 p-4 rounded-xl border border-emerald-100 flex justify-between items-center">
                                    <span class="text-emerald-700 font-bold tracking-wide">Tổng Phải Trả</span>
                                    <span class="text-emerald-700 font-bold tabular-nums text-2xl drop-shadow-sm">\${strPrice(data.total)}</span>
                                </div>
                                <div class="mt-2 text-center text-[10px] text-slate-400 font-medium uppercase tracking-widest px-8">
                                    Vui lòng thanh toán trực tiếp tại quầy trong vài phút tới nhé!
                                </div>
                            </div>
                        `,
                        confirmButtonText: 'Làm Mới',
                        confirmButtonColor: '#0F172A',
                        allowOutsideClick: false,
                        customClass: { 
                            popup: 'rounded-[2rem] p-8 shadow-2xl', 
                            confirmButton: 'rounded-xl text-sm px-8 py-3 w-full font-bold shadow-lg shadow-slate-900/20 active:scale-95 transition-transform' 
                        },
                        didOpen: () => lucide.createIcons()
                    }).then(() => {
                        window.location.reload();
                    });
                } else {
                    throw new Error(data.message || 'Lỗi server');
                }
            })
            .catch(err => {
                Swal.fire({
                    icon: 'error', 
                    title: '<span class="font-bold font-sans">Lỗi</span>', 
                    text: err.message,
                    confirmButtonColor: '#EF4444',
                    customClass: { popup: 'rounded-2xl', confirmButton: 'rounded-xl font-semibold px-6 py-2' }
                });
                checkoutBtn.disabled = false;
                checkoutBtn.innerHTML = 'Thanh Toán Ngay <i data-lucide="arrow-right" class="w-4 h-4"></i>';
                lucide.createIcons();
            });
        }

        // -- Category filter --
        document.querySelectorAll('.category-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                document.querySelectorAll('.category-btn').forEach(b => {
                    b.classList.remove('active', 'bg-slate-900', 'text-white', 'shadow-lg', 'shadow-slate-900/10');
                    b.classList.add('bg-white', 'border-gray-200', 'text-slate-600');
                });
                btn.classList.add('active', 'bg-slate-900', 'text-white', 'shadow-lg', 'shadow-slate-900/10');
                btn.classList.remove('bg-white', 'border-gray-200', 'text-slate-600');

                let catId = btn.getAttribute('data-cat-id');
                document.querySelectorAll('.drink-item').forEach(item => {
                    if (catId === '0' || item.getAttribute('data-cat-id') === catId) {
                        item.classList.remove('hidden');
                        setTimeout(() => { item.style.opacity = '1'; item.style.transform = 'translateY(0)'; }, 10);
                    } else {
                        item.style.opacity = '0'; item.style.transform = 'translateY(10px)';
                        setTimeout(() => { item.classList.add('hidden'); }, 300);
                    }
                });
            });
        });

        // -- Point Shop Modals --
        function openPointShop() {
            const m = document.getElementById('pointShopModal');
            m.classList.remove('hidden');
            m.classList.add('flex');
            setTimeout(() => {
                m.classList.remove('opacity-0');
                m.firstElementChild.classList.remove('scale-95');
            }, 10);
            loadCatalog();
        }

        function closePointShop() {
            const m = document.getElementById('pointShopModal');
            m.classList.add('opacity-0');
            m.firstElementChild.classList.add('scale-95');
            setTimeout(() => {
                m.classList.remove('flex');
                m.classList.add('hidden');
            }, 300);
        }

        function loadCatalog() {
            fetch('${pageContext.request.contextPath}/guest/pointshop/vouchers')
            .then(res => res.json())
            .then(data => {
                let html = '';
                data.forEach(v => {
                    html += `
                        <div class="bg-white rounded-2xl border border-dashed border-coffee-300 p-5 flex items-center justify-between group hover:border-coffee-500 hover:shadow-lg transition-all">
                            <div class="flex items-center gap-4">
                                <div class="bg-coffee-50 text-coffee-600 p-3 rounded-full group-hover:bg-coffee-600 group-hover:text-white transition-colors duration-300">
                                    <i data-lucide="ticket" class="w-6 h-6"></i>
                                </div>
                                <div>
                                    <h4 class="font-black text-slate-900 text-lg leading-tight">\${v.name}</h4>
                                    <p class="text-[12px] font-bold text-coffee-600 mt-1 flex items-center gap-1.5"><i data-lucide="award" class="w-3.5 h-3.5"></i> Yêu cầu \${v.requiredPoints} Điểm</p>
                                </div>
                            </div>
                            <button onclick="redeemPoints(\${v.id}, \${v.requiredPoints})" class="bg-slate-900 hover:bg-coffee-700 text-white font-bold py-2.5 px-6 rounded-xl transition-all shadow-md active:scale-95 text-sm uppercase tracking-wide">Đổi Ngay</button>
                        </div>
                    `;
                });
                document.getElementById('shopCatalogGrid').innerHTML = html || '<div class="col-span-2 text-center text-slate-500 py-6 font-semibold">Chưa có voucher nào.</div>';
                lucide.createIcons();
            });
        }

        function checkPoints() {
            const p = document.getElementById('shopPhoneInput').value.trim();
            if (!p) return;
            document.getElementById('shopPointError').classList.add('hidden');
            
            fetch('${pageContext.request.contextPath}/guest/pointshop/status?phone=' + p)
            .then(r => r.json())
            .then(data => {
                if (data.success) {
                    currentShopPhone = p;
                    currentShopPoints = data.points;
                    document.getElementById('shopPhoneLabel').innerText = p;
                    document.getElementById('shopPointVal').innerText = data.points;
                    document.getElementById('shopPointBalance').classList.remove('hidden');
                } else {
                    document.getElementById('shopErrorText').innerText = data.message;
                    document.getElementById('shopPointError').classList.remove('hidden');
                    document.getElementById('shopPointBalance').classList.add('hidden');
                    currentShopPhone = "";
                }
            });
        }

        function redeemPoints(voucherId, reqPoints) {
            if (!currentShopPhone) {
                Swal.fire({icon: 'warning', title: '<span class="font-sans">Lỗi</span>', html: 'Vui lòng tra cứu số điện thoại của bạn trước.', customClass: {popup: 'rounded-2xl'}});
                return;
            }
            if (currentShopPoints < reqPoints) {
                Swal.fire({icon: 'error', title: '<span class="font-sans">Rất tiếc!</span>', html: 'Bạn không đủ điểm để đổi voucher này.', customClass: {popup: 'rounded-2xl'}});
                return;
            }

            Swal.fire({
                title: 'Xác nhận đổi?',
                text: "Bạn sẽ dùng " + reqPoints + " điểm để lấy voucher.",
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#6f4e37',
                cancelButtonColor: '#94a3b8',
                confirmButtonText: 'Chắc chắn',
                cancelButtonText: 'Hủy',
                customClass: { popup: 'rounded-2xl font-sans' }
            }).then((result) => {
                if (result.isConfirmed) {
                    fetch('${pageContext.request.contextPath}/guest/pointshop/redeem', {
                        method: 'POST',
                        headers: {'Content-Type': 'application/json'},
                        body: JSON.stringify({phone: currentShopPhone, voucherId: voucherId})
                    }).then(r => r.json()).then(d => {
                        if (d.success) {
                            Swal.fire({icon: 'success', title: 'Thành công!', text: 'Voucher đã được thêm vào số điện thoại của bạn.', customClass: { popup: 'rounded-2xl font-sans' }});
                            checkPoints(); // reduce points live
                        } else {
                            Swal.fire({icon: 'error', title: 'Lỗi', text: d.message, customClass: { popup: 'rounded-2xl font-sans' }});
                        }
                    });
                }
            })
        }
    </script>
</body>
</html>
