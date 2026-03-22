document.addEventListener("DOMContentLoaded", () => {
  // -------------------------------------------------
  // Core Elements
  // -------------------------------------------------
  const guestModal = document.getElementById("guestModal");
  const guestForm = document.getElementById("guestForm");
  const guestInfoBtn = document.getElementById("guestInfoBtn");
  const guestInfoLabel = document.getElementById("guestInfoLabel");

  const drinkModal = document.getElementById("drinkModal");
  const cartModal = document.getElementById("cartModal");
  const paymentModal = document.getElementById("paymentModal");

  // -------------------------------------------------
  // 1️⃣ Cart & LocalStorage
  // -------------------------------------------------
  let cart = JSON.parse(localStorage.getItem("cart") || "[]");
  let currentDrink = null;
  let modalQty = 1;

  updateUI();

  // -------------------------------------------------
  // 2️⃣ Guest Profile
  // -------------------------------------------------
  const storedGuest = JSON.parse(localStorage.getItem("guestInfo") || "{}");
  if (storedGuest.name && storedGuest.phone) {
    guestInfoLabel.textContent = storedGuest.name;
  }

  guestInfoBtn.addEventListener("click", () => {
    const info = JSON.parse(localStorage.getItem("guestInfo") || "{}");
    if (info.name) guestForm.elements["guestName"].value = info.name;
    if (info.phone) guestForm.elements["guestPhone"].value = info.phone;
    guestModal.classList.remove("hidden");
  });

  guestForm.addEventListener("submit", (e) => {
    e.preventDefault();
    const name = e.target.guestName.value.trim();
    const phone = e.target.guestPhone.value.trim();
    localStorage.setItem("guestInfo", JSON.stringify({ name, phone }));
    guestInfoLabel.textContent = name;
    guestModal.classList.add("hidden");
  });

  // -------------------------------------------------
  // 3️⃣ Drink Selection & Modal
  // -------------------------------------------------
  document.querySelectorAll(".drink-card").forEach((card) => {
    card.addEventListener("click", () => {
      currentDrink = {
        id: parseInt(card.dataset.id),
        name: card.dataset.name,
        price: parseInt(card.dataset.price),
        image: card.dataset.image,
      };
      openDrinkModal();
    });
  });

  window.changeModalQty = (delta) => {
    modalQty = Math.max(1, modalQty + delta);
    document.getElementById("modalQty").textContent = modalQty;
  };

  function openDrinkModal() {
    document.getElementById("modalDrinkName").textContent = currentDrink.name;
    document.getElementById("modalDrinkPrice").textContent =
      currentDrink.price.toLocaleString() + "₫";
    document.getElementById("modalQty").textContent = "1";
    document.getElementById("modalNote").value = "";
    modalQty = 1;

    const imgDiv = document.getElementById("modalDrinkImage");
    if (currentDrink.image) {
      const url = currentDrink.image.startsWith("http")
        ? currentDrink.image
        : `${contextPath}/uploads/${currentDrink.image}`;
      imgDiv.innerHTML = `<img src="${url}" class="w-full h-full object-cover">`;
    } else {
      imgDiv.innerHTML = `<div class="w-full h-full flex items-center justify-center text-gray-300">
                <svg class="w-10 h-10" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M13 10V3L4 14h7v7l9-11h-7z"/></svg>
            </div>`;
    }

    drinkModal.classList.remove("hidden");
  }

  document
    .getElementById("closeDrinkModal")
    .addEventListener("click", () => drinkModal.classList.add("hidden"));
  document.getElementById("addToCartBtn").addEventListener("click", () => {
    const note = document.getElementById("modalNote").value.trim();
    const existing = cart.find(
      (item) => item.id === currentDrink.id && item.note === note,
    );

    if (existing) {
      existing.quantity += modalQty;
    } else {
      cart.push({ ...currentDrink, quantity: modalQty, note });
    }

    localStorage.setItem("cart", JSON.stringify(cart));
    drinkModal.classList.add("hidden");
    updateUI();
    showToast(`Added ${modalQty}x ${currentDrink.name}`);
  });

  // -------------------------------------------------
  // 4️⃣ Cart Logic
  // -------------------------------------------------
  document.getElementById("viewCartBtn").addEventListener("click", () => {
    renderCart();
    cartModal.classList.remove("hidden");
  });

  document
    .getElementById("closeCartModal")
    .addEventListener("click", () => cartModal.classList.add("hidden"));

  function renderCart() {
    const container = document.getElementById("cartItemsList");
    container.innerHTML = "";
    let total = 0;

    cart.forEach((item, index) => {
      total += item.price * item.quantity;
      const el = document.createElement("div");
      el.className =
        "flex items-center gap-4 bg-gray-50 p-4 rounded-2xl relative";
      el.innerHTML = `
                <div class="w-16 h-16 rounded-xl overflow-hidden bg-white shrink-0">
                    <img src="${item.image ? (item.image.startsWith("http") ? item.image : contextPath + "/uploads/" + item.image) : ""}" class="w-full h-full object-cover">
                </div>
                <div class="flex-grow">
                    <h4 class="font-bold text-gray-900 text-sm">${item.name}</h4>
                    <p class="text-[10px] text-gray-400 font-bold uppercase truncate">${item.note || "No notes"}</p>
                    <div class="flex items-center justify-between mt-2">
                        <span class="text-indigo-600 font-black text-sm">${(item.price * item.quantity).toLocaleString()}₫</span>
                        <div class="flex items-center gap-3">
                            <button onclick="updateCartQty(${index}, -1)" class="w-7 h-7 bg-white rounded-lg flex items-center justify-center text-gray-400 border border-gray-100"><svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M20 12H4"/></svg></button>
                            <span class="text-sm font-black">${item.quantity}</span>
                            <button onclick="updateCartQty(${index}, 1)" class="w-7 h-7 bg-indigo-600 rounded-lg flex items-center justify-center text-white"><svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M12 4v16m8-8H4"/></svg></button>
                        </div>
                    </div>
                </div>
                <button onclick="removeFromCart(${index})" class="absolute -top-2 -right-2 w-6 h-6 bg-red-100 text-red-600 rounded-full flex items-center justify-center text-xs shadow-sm"><svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M6 18L18 6M6 6l12 12"/></svg></button>
            `;
      container.appendChild(el);
    });

    document.getElementById("finalTotal").textContent =
      total.toLocaleString() + "₫";
    if (cart.length === 0) {
      container.innerHTML = `<div class="text-center py-10"><p class="text-gray-400 font-bold">Your cart is empty</p></div>`;
      document.getElementById("checkoutBtn").disabled = true;
      document.getElementById("checkoutBtn").classList.add("opacity-50");
    } else {
      document.getElementById("checkoutBtn").disabled = false;
      document.getElementById("checkoutBtn").classList.remove("opacity-50");
    }
  }

  window.updateCartQty = (index, delta) => {
    cart[index].quantity = Math.max(1, cart[index].quantity + delta);
    localStorage.setItem("cart", JSON.stringify(cart));
    renderCart();
    updateUI();
  };

  window.removeFromCart = (index) => {
    cart.splice(index, 1);
    localStorage.setItem("cart", JSON.stringify(cart));
    renderCart();
    updateUI();
  };

  function updateUI() {
    const count = cart.reduce((acc, item) => acc + item.quantity, 0);
    const total = cart.reduce(
      (acc, item) => acc + item.price * item.quantity,
      0,
    );

    document.getElementById("cartCountBadge").textContent = count;
    document.getElementById("cartTotalDisplay").textContent =
      total.toLocaleString() + "₫";

    const bar = document.getElementById("bottomCartBar");
    if (count > 0) bar.classList.remove("translate-y-full");
    else bar.classList.add("translate-y-full");
  }

  // 5️⃣ Category Filtering (Client-side)
  // -------------------------------------------------
  document.querySelectorAll(".category-btn").forEach((btn) => {
    btn.addEventListener("click", () => {
      document.querySelectorAll(".category-btn").forEach((b) => {
        b.classList.remove("active-category", "bg-indigo-600", "text-white");
        b.classList.add("text-gray-500", "bg-gray-50");
      });

      btn.classList.add("active-category", "bg-indigo-600", "text-white");
      btn.classList.remove("text-gray-500", "bg-gray-50");

      const catId = btn.dataset.catId;
      document.querySelectorAll(".drink-card").forEach((card) => {
        if (catId === "0" || card.dataset.catId === catId) {
          card.style.display = "block";
        } else {
          card.style.display = "none";
        }
      });
    });
  });

  function renderGrid(drinks) {
    const grid = document.getElementById("drinksGrid");
    grid.innerHTML = "";
    drinks.forEach((d) => {
      const card = document.createElement("div");
      card.className =
        "bg-white rounded-3xl p-3 border border-gray-100 shadow-sm hover:shadow-xl transition-all cursor-pointer group active:scale-95 drink-card";
      card.dataset.id = d.id;
      card.dataset.name = d.name;
      card.dataset.price = d.price;
      card.dataset.image = d.image;

      const imgUrl = d.image
        ? d.image.startsWith("http")
          ? d.image
          : `${contextPath}/uploads/${d.image}`
        : "";
      const imgHtml = d.image
        ? `<img src="${imgUrl}" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">`
        : `<div class="w-full h-full flex items-center justify-center text-gray-300"><svg class="w-10 h-10" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M13 10V3L4 14h7v7l9-11h-7z"/></svg></div>`;

      card.innerHTML = `
                <div class="aspect-square rounded-2xl bg-gray-100 mb-3 overflow-hidden relative">
                    ${imgHtml}
                    <div class="absolute bottom-2 right-2 bg-indigo-600/90 backdrop-blur-md px-2 py-1 rounded-lg text-white font-black text-[10px] shadow-sm">
                        ${d.price.toLocaleString()}₫
                    </div>
                </div>
                <h3 class="font-bold text-sm text-gray-900 line-clamp-2 leading-tight">${d.name}</h3>
            `;
      card.addEventListener("click", () => {
        currentDrink = {
          id: d.id,
          name: d.name,
          price: d.price,
          image: d.image,
        };
        openDrinkModal();
      });
      grid.appendChild(card);
    });
  }

  // -------------------------------------------------
  // 6️⃣ Checkout & Payment (VietQR)
  // -------------------------------------------------
  document.getElementById("checkoutBtn").addEventListener("click", () => {
    const info = JSON.parse(localStorage.getItem("guestInfo") || "{}");
    if (!info.name || !info.phone) {
      showToast("Please enter your info first!", "error");
      guestModal.classList.remove("hidden");
      cartModal.classList.add("hidden");
      return;
    }

    const payload = {
      guestName: info.name,
      guestPhone: info.phone,
      items: cart.map((item) => ({
        drinkId: item.id,
        quantity: item.quantity,
        note: item.note,
      })),
    };

    fetch(`${contextPath}/guest/pos/checkout`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload),
    })
      .then((r) => r.json())
      .then((res) => {
        if (res.success) {
          cart = [];
          localStorage.setItem("cart", "[]");
          updateUI();
          cartModal.classList.add("hidden");

          // Show Payment
          document.getElementById("paymentBillCode").textContent = res.billCode;
          // VietQR logic: https://vietqr.net/portal/qr-api
          // img.vietqr.io/image/<BANK_ID>-<ACCOUNT_NO>-<TEMPLATE>.jpg?amount=<AMOUNT>&addInfo=<DESCRIPTION>&accountName=<NAME>
          const bankId = "MB"; // Example: MB Bank
          const accountNo = "0901234567"; // Your account
          const accountName = "BUI DUC TRI";
          const vietqrUrl = `https://img.vietqr.io/image/${bankId}-${accountNo}-compact.jpg?amount=${res.total}&addInfo=${res.billCode}&accountName=${accountName}`;

          document.getElementById("vietqrImg").src = vietqrUrl;
          paymentModal.classList.remove("hidden");
        } else {
          showToast(res.message, "error");
        }
      });
  });

  window.showToast = (msg, type = "success") => {
    const toast = document.createElement("div");
    toast.className = `fixed top-20 right-5 z-[300] bg-gray-900 text-white px-6 py-4 rounded-2xl shadow-2xl font-bold transition-all transform translate-x-full opacity-0`;
    toast.textContent = msg;
    document.body.appendChild(toast);

    requestAnimationFrame(() => {
      toast.classList.remove("translate-x-full", "opacity-0");
    });

    setTimeout(() => {
      toast.classList.add("translate-x-full", "opacity-0");
      setTimeout(() => toast.remove(), 300);
    }, 3000);
  };
});
