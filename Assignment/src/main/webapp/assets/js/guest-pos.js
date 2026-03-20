document.addEventListener('DOMContentLoaded', () => {
    const toastContainer = document.getElementById('toastContainer');
    const guestInfoBtn = document.getElementById('guestInfoBtn');
    const guestInfoLabel = document.getElementById('guestInfoLabel');
    const guestModal = document.getElementById('guestModal');
    const guestForm = document.getElementById('guestForm');
    const guestCancel = document.getElementById('guestCancel');

    // -------------------------------------------------
    // 1️⃣ Load stored guest info (if any)
    // -------------------------------------------------
    const storedGuest = JSON.parse(localStorage.getItem('guestInfo') || '{}');
    if (storedGuest.name && storedGuest.phone) {
        guestInfoLabel.textContent = storedGuest.name;
        // Optionally show a welcome toast
        // showToast(`Welcome back, ${storedGuest.name}!`, 'success');
    }

    // -------------------------------------------------
    // 2️⃣ Guest modal handling
    // -------------------------------------------------
    guestInfoBtn.addEventListener('click', () => {
        guestModal.classList.remove('hidden');
        // pre-fill if exists
        const info = JSON.parse(localStorage.getItem('guestInfo') || '{}');
        if (info.name) guestForm.elements['guestName'].value = info.name;
        if (info.phone) guestForm.elements['guestPhone'].value = info.phone;
    });

    guestCancel.addEventListener('click', () => {
        guestModal.classList.add('hidden');
    });

    guestForm.addEventListener('submit', e => {
        e.preventDefault();
        const name = e.target.guestName.value.trim();
        const phone = e.target.guestPhone.value.trim();
        if (name && phone) {
            localStorage.setItem('guestInfo', JSON.stringify({ name, phone }));
            guestInfoLabel.textContent = name;
            showToast(`Saved info for ${name}`, 'success');
            guestModal.classList.add('hidden');
        }
    });

    // close modal if clicked outside inner box
    guestModal.addEventListener('click', e => {
        if (e.target === guestModal) guestModal.classList.add('hidden');
    });

    // -------------------------------------------------
    // 3️⃣ Category lazy‑load
    // -------------------------------------------------
    document.querySelectorAll('aside button[data-cat-id]').forEach(btn => {
        btn.addEventListener('click', () => {
            // highlight active
            document.querySelectorAll('aside button[data-cat-id]').forEach(b => {
                b.classList.remove('bg-indigo-600', 'text-white', 'shadow-md', 'shadow-indigo-200');
                b.classList.add('bg-gray-50', 'text-gray-700');
            });
            btn.classList.add('bg-indigo-600', 'text-white', 'shadow-md', 'shadow-indigo-200');
            btn.classList.remove('bg-gray-50', 'text-gray-700');

            const catId = btn.getAttribute('data-cat-id');
            // Fetch drinks as JSON
            const contextPath = window.location.pathname.replace('/guest/pos', '');
            fetch(`${contextPath}/guest/pos/drinks?catId=${catId}`)
                .then(r => r.json())
                .then(renderDrinks)
                .catch(err => {
                    console.error(err);
                    showToast('Failed to load drinks', 'error');
                });
        });
    });

    function renderDrinks(drinks) {
        const grid = document.getElementById('drinksGrid');
        grid.innerHTML = '';
        const contextPath = window.location.pathname.replace('/guest/pos', '');

        drinks.forEach(d => {
            let imgHtml;
            if (d.image) {
                const imgUrl = d.image.startsWith('http') ? d.image : `${contextPath}/uploads/${d.image}`;
                imgHtml = `<img src="${imgUrl}" alt="${d.name}" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500">`;
            } else {
                imgHtml = `<div class="w-full h-full flex items-center justify-center text-gray-300">
                    <svg class="w-12 h-12" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M13 10V3L4 14h7v7l9-11h-7z"/></svg>
                </div>`;
            }

            const card = document.createElement('div');
            card.className = 'bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all cursor-pointer group flex flex-col overflow-hidden';
            card.onclick = () => addDrink(d.id);
            card.innerHTML = `
                <div class="aspect-square bg-gray-100 relative overflow-hidden">
                    ${imgHtml}
                    <!-- Price overlay -->
                    <div class="absolute bottom-2 right-2 bg-white/90 backdrop-blur-sm text-indigo-700 text-xs font-black px-2 py-1 rounded-lg shadow-sm border border-indigo-100">
                        ${Number(d.price).toLocaleString()}₫
                    </div>
                </div>
                <div class="p-3">
                    <h3 class="font-bold text-sm text-gray-800 line-clamp-2 leading-tight group-hover:text-indigo-600 transition-colors">${d.name}</h3>
                </div>`;
            grid.appendChild(card);
        });
    }

    // -------------------------------------------------
    // 4️⃣ Add drink to bill (guest flow)
    // -------------------------------------------------
    window.addDrink = function (drinkId) {
        const guest = JSON.parse(localStorage.getItem('guestInfo') || '{}');
        if (!guest.name || !guest.phone) {
            showToast('Please enter your name & phone first', 'warning');
            guestModal.classList.remove('hidden');
            return;
        }
        const contextPath = window.location.pathname.replace('/guest/pos', '');
        const url = new URL(`${window.location.protocol}//${window.location.host}${contextPath}/guest/pos/add`);
        url.searchParams.set('drinkId', drinkId);
        url.searchParams.set('guestName', guest.name);
        url.searchParams.set('guestPhone', guest.phone);

        window.location.href = url.toString();
    };

    // -------------------------------------------------
    // 5️⃣ Toast helper (Client-side)
    // -------------------------------------------------
    window.showToast = function (message, type = 'success') {
        const toast = document.createElement('div');
        let bgStyle, icon;

        if (type === 'error') {
            bgStyle = 'bg-red-500 text-white';
            icon = `<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>`;
        } else if (type === 'warning') {
            bgStyle = 'bg-amber-500 text-white';
            icon = `<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/></svg>`;
        } else {
            bgStyle = 'bg-green-500 text-white';
            icon = `<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/></svg>`;
        }

        toast.className = `${bgStyle} px-4 py-3 rounded-xl shadow-lg font-bold flex items-center gap-3 transform transition-all duration-300 translate-x-full opacity-0`;
        toast.innerHTML = `${icon} <span>${message}</span>`;
        toastContainer.appendChild(toast);

        // Trigger animation
        requestAnimationFrame(() => {
            toast.classList.remove('translate-x-full', 'opacity-0');
        });

        setTimeout(() => {
            toast.classList.add('translate-x-full', 'opacity-0');
            toast.addEventListener('transitionend', () => toast.remove());
        }, 3000);
    };

    // -------------------------------------------------
    // 6️⃣ Amount filter (syncing UI elements, if they exist on employee page mostly)
    // In Guest POS we might not list bills, but if we do...
    // -------------------------------------------------
    const amountInput = document.getElementById('amountInput');
    const amountRange = document.getElementById('amountRange');

    if (amountInput && amountRange) {
        amountInput.addEventListener('input', () => {
            amountRange.value = amountInput.value || 0;
            // logic to filter list if any
        });
        amountRange.addEventListener('input', () => {
            amountInput.value = amountRange.value;
            // filter logic
        });
    }

});
