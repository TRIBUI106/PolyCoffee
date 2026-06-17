<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>POS - Bán hàng</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<style>
    .thumb { width: 80px; height: 60px; object-fit: cover; border-radius: 4px; }
    .product-card { cursor: pointer; transition: transform .12s ease; }
    .product-card:hover { transform: translateY(-4px); }
    .qty-btn { width: 34px; height: 34px; }
    .fixed-right { position: sticky; top: 20px; }
    /* Left 60% / Right 40% layout using Bootstrap cols (8/4) */
    @media (max-width: 767px) {
        .fixed-right { position: static; margin-top: 1rem; }
    }
</style>
</head>
<body>
<div class="container-fluid mt-3">
    <div class="row">
        <!-- Left: Product Grid (60%) -->
        <div class="col-lg-8 col-md-7">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4 class="mb-0">Danh sách sản phẩm</h4>
                <div>
                    <input id="searchInput" class="form-control form-control-sm" placeholder="Tìm kiếm..." style="width: 220px;">
                </div>
            </div>

            <div id="productGrid" class="row g-3">
                <!-- Products will be rendered here -->
            </div>
        </div>

        <!-- Right: Order Summary (40%) -->
        <div class="col-lg-4 col-md-5">
            <div class="card fixed-right">
                <div class="card-body">
                    <h5 class="card-title">Đơn hàng</h5>
                    <div class="table-responsive" style="max-height: 420px; overflow:auto;">
                        <table id="cartTable" class="table table-sm align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th style="width:40px"></th>
                                    <th>Tên</th>
                                    <th class="text-center" style="width:110px">SL</th>
                                    <th class="text-end" style="width:90px">Thành tiền</th>
                                    <th style="width:40px"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Cart items go here -->
                            </tbody>
                        </table>
                    </div>

                    <div class="mt-3">
                        <div class="d-flex justify-content-between">
                            <div>Tạm tính</div>
                            <div id="subtotal">0₫</div>
                        </div>
                        <div class="d-flex justify-content-between fw-bold fs-5 mt-2">
                            <div>Tổng</div>
                            <div id="total">0₫</div>
                        </div>
                    </div>

                    <div class="d-flex gap-2 mt-3">
                        <button id="completeBtn" class="btn btn-success w-100">Hoàn thành đơn</button>
                        <button id="cancelBtn" class="btn btn-outline-danger w-100">Huỷ đơn</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script>
    // Context path for fetch (evaluated on server side)
    const CONTEXT_PATH = '<%= request.getContextPath() %>';

    // Products will be loaded from manager-list.jsp; fallback to built-in samples if fetch fails
    let products = [];

    // Fallback sample products (kept small) in case fetch fails
    const fallbackProducts = [
        {id: 1, name: 'Cà phê sữa', price: 35000, img: 'https://picsum.photos/seed/coffee1/200/150'},
        {id: 2, name: 'Cà phê đen', price: 30000, img: 'https://picsum.photos/seed/coffee2/200/150'},
        {id: 3, name: 'Bạc xỉu', price: 40000, img: 'https://picsum.photos/seed/coffee3/200/150'},
        {id: 4, name: 'Capuchino', price: 45000, img: 'https://picsum.photos/seed/coffee4/200/150'},
        {id: 5, name: 'Americano', price: 30000, img: 'https://picsum.photos/seed/coffee5/200/150'}
    ];

    function parsePrice(text) {
        if (!text) return 0;
        // remove non-digit characters
        const digits = text.replace(/[^0-9]/g, '');
        return digits ? parseInt(digits, 10) : 0;
    }

    async function loadProductsFromManagerList() {
        try {
            const resp = await fetch(CONTEXT_PATH + '/views/drink/manager-list.jsp', { cache: 'no-store' });
            if (!resp.ok) throw new Error('Fetch failed');
            const html = await resp.text();
            const parser = new DOMParser();
            const doc = parser.parseFromString(html, 'text/html');
            const rows = doc.querySelectorAll('table tbody tr');
            const loaded = [];
            rows.forEach(row => {
                const tds = row.querySelectorAll('td');
                if (tds.length >= 5) {
                    const idText = tds[0].textContent.trim();
                    const id = parseInt(idText, 10) || Date.now();
                    const name = tds[1].textContent.trim();
                    const desc = tds[2].textContent.trim();
                    const imgEl = tds[3].querySelector('img');
                    let img = imgEl ? imgEl.getAttribute('src') : '';
                    // If img is relative, make absolute using context path
                    if (img && img.startsWith('/') && CONTEXT_PATH && !img.startsWith(CONTEXT_PATH)) {
                        img = CONTEXT_PATH + img;
                    }
                    const priceText = tds[4].textContent.trim();
                    const price = parsePrice(priceText);
                    loaded.push({ id, name, price, img, desc });
                }
            });

            if (loaded.length === 0) {
                products = fallbackProducts.slice();
            } else {
                products = loaded;
            }
        } catch (err) {
            console.warn('Could not load products from manager-list.jsp:', err);
            products = fallbackProducts.slice();
        }
    }

    const cart = new Map(); // key: productId, value: {product, qty}

    function formatVND(n) {
        return n.toLocaleString('vi-VN') + '₫';
    }

    function renderProducts(filter = '') {
        const grid = document.getElementById('productGrid');
        grid.innerHTML = '';
        const filtered = products.filter(p => p.name.toLowerCase().includes(filter.toLowerCase()));
        filtered.forEach(p => {
            const col = document.createElement('div');
            col.className = 'col-6 col-sm-4 col-md-4 col-lg-3';
            col.innerHTML = `
                <div class="card product-card h-100" data-id="${p.id}">
                    <img src="${p.img}" class="card-img-top" alt="${p.name}" style="height:140px; object-fit:cover;">
                    <div class="card-body p-2 d-flex flex-column">
                        <div class="d-flex justify-content-between align-items-start">
                            <h6 class="card-title mb-1">${p.name}</h6>
                            <div class="text-end text-success fw-bold">${formatVND(p.price)}</div>
                        </div>
                        <div class="mt-auto d-flex gap-2">
                            <button class="btn btn-sm btn-primary w-100 add-btn">Thêm</button>
                        </div>
                    </div>
                </div>
            `;
            grid.appendChild(col);
        });

        // attach handlers
        document.querySelectorAll('.add-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const card = e.target.closest('.product-card');
                const id = Number(card.getAttribute('data-id'));
                addToCart(id, 1);
            });
        });
    }

    function addToCart(productId, qty) {
        const prod = products.find(p => p.id === productId);
        if (!prod) return;
        if (cart.has(productId)) {
            const entry = cart.get(productId);
            entry.qty += qty;
            cart.set(productId, entry);
        } else {
            cart.set(productId, { product: prod, qty: qty });
        }
        renderCart();
    }

    function renderCart() {
        const tbody = document.querySelector('#cartTable tbody');
        tbody.innerHTML = '';
        let subtotal = 0;
        cart.forEach((entry, id) => {
            const total = entry.product.price * entry.qty;
            subtotal += total;
            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td><img src="${entry.product.img}" class="thumb" alt=""></td>
                <td style="min-width:120px">${entry.product.name}</td>
                <td class="text-center">
                    <div class="d-flex justify-content-center align-items-center gap-1">
                        <button class="btn btn-sm btn-outline-secondary qty-decrease">-</button>
                        <div class="px-2 qty-text">${entry.qty}</div>
                        <button class="btn btn-sm btn-outline-secondary qty-increase">+</button>
                    </div>
                </td>
                <td class="text-end">${formatVND(total)}</td>
                <td class="text-end"><button class="btn btn-sm btn-light text-danger remove-item">X</button></td>
            `;
            // attach product id to row for handlers
            tr.setAttribute('data-id', id);
            tbody.appendChild(tr);
        });

        document.getElementById('subtotal').textContent = formatVND(subtotal);
        document.getElementById('total').textContent = formatVND(subtotal); // could include taxes/discounts

        // attach handlers
        document.querySelectorAll('.qty-increase').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const id = Number(e.target.closest('tr').getAttribute('data-id'));
                changeQty(id, 1);
            });
        });
        document.querySelectorAll('.qty-decrease').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const id = Number(e.target.closest('tr').getAttribute('data-id'));
                changeQty(id, -1);
            });
        });
        document.querySelectorAll('.remove-item').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const id = Number(e.target.closest('tr').getAttribute('data-id'));
                removeFromCart(id);
            });
        });
    }

    function changeQty(productId, delta) {
        if (!cart.has(productId)) return;
        const entry = cart.get(productId);
        entry.qty += delta;
        if (entry.qty <= 0) {
            cart.delete(productId);
        } else {
            cart.set(productId, entry);
        }
        renderCart();
    }

    function removeFromCart(productId) {
        cart.delete(productId);
        renderCart();
    }

    // --- Add a helper to pre-populate the cart with sample items ---
    function initDefaultCart() {
        // Define default items to add: {id, qty}
        const defaults = [
            { id: 1, qty: 2 }, // Cà phê sữa x2
            { id: 2, qty: 1 }, // Trà đào x1
            { id: 4, qty: 1 }  // Sinh tố bơ x1
        ];
        cart.clear();
        defaults.forEach(d => {
            const prod = products.find(p => Number(p.id) === Number(d.id));
            if (prod) {
                cart.set(Number(prod.id), { product: prod, qty: d.qty });
            }
        });
    }

    document.getElementById('completeBtn').addEventListener('click', () => {
        if (cart.size === 0) {
            alert('Giỏ hàng rỗng.');
            return;
        }
        // For demo: show order summary and then clear cart
        const lines = [];
        cart.forEach((entry) => lines.push(`${entry.product.name} x${entry.qty} = ${formatVND(entry.product.price * entry.qty)}`));
        const total = document.getElementById('total').textContent;

        // If includeCatalogChk is checked, append full product catalog to confirmation
        const includeCatalog = document.getElementById('includeCatalogChk').checked;
        let message = 'ĐƠN HÀNG:\n' + lines.join('\n') + '\nTổng: ' + total;
        if (includeCatalog) {
            const catalogLines = products.map(p => `${p.name} - ${formatVND(p.price)}`);
            message += '\n\nDanh sách sản phẩm (catalog):\n' + catalogLines.join('\n');
        }

        if (confirm('Xác nhận hoàn thành đơn?\n\n' + message)) {
            alert('Đã hoàn thành đơn.\n' + message);
            cart.clear();
            renderCart();
        }
    });

    document.getElementById('cancelBtn').addEventListener('click', () => {
        if (cart.size === 0) return;
        if (confirm('Bạn có chắc muốn huỷ đơn?')) {
            cart.clear();
            renderCart();
        }
    });

    // Search
    document.getElementById('searchInput').addEventListener('input', (e) => {
        renderProducts(e.target.value);
    });

    // Initial render: load products from manager-list.jsp first
    loadProductsFromManagerList().then(() => {
        renderProducts();
        // Pre-populate cart with a few sample products
        initDefaultCart();
        renderCart();
    });
</script>
</body>
</html>