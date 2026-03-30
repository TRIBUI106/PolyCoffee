<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Quản Lý Bàn - PolyCoffee</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Outfit', sans-serif; background-color: #f8fafc; }
    </style>
</head>
<body class="min-h-screen">
    <%@ include file="../common/header.jsp" %>
    
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <div class="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-8">
            <div>
                <h1 class="text-3xl font-black text-gray-900 tracking-tight">Quản Lý Bàn</h1>
                <p class="text-gray-500 font-medium">Tạo và quản lý bàn & mã QR cho quán cà phê</p>
            </div>
            <div class="flex flex-col sm:flex-row gap-4 items-center w-full md:w-auto">
                <div class="relative w-full sm:w-64">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <svg class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/></svg>
                    </div>
                    <input type="text" id="searchInput" placeholder="Tìm bàn..." class="w-full bg-white border border-gray-200 text-gray-900 text-sm rounded-xl focus:ring-indigo-500 focus:border-indigo-500 block pl-10 p-2.5 transition-colors shadow-sm">
                </div>
                <button onclick="document.getElementById('tableModal').classList.remove('hidden')"
                        class="w-full sm:w-auto bg-indigo-600 hover:bg-indigo-700 text-white px-6 py-2.5 rounded-xl font-bold shadow-lg shadow-indigo-200 transition-all transform active:scale-95 flex items-center justify-center gap-2">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/></svg>
                    Tạo Bàn Mới
                </button>
            </div>
        </div>

        <div id="tableGrid" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            <c:forEach var="t" items="${tables}">
                <div class="bg-white rounded-3xl border border-gray-100 p-6 shadow-sm hover:shadow-xl transition-all group">
                    <div class="flex items-start justify-between mb-4">
                        <div class="w-12 h-12 bg-indigo-50 text-indigo-600 rounded-2xl flex items-center justify-center font-black text-xl">
                            ${t.code}
                        </div>
                        <div class="flex gap-2">
                             <button data-id="${t.id}" data-name="${t.tableNumber}" data-code="${t.code}"
                                     onclick="editTable(this)"
                                     class="p-2 text-gray-400 hover:text-indigo-600 transition-colors">
                                 <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2v-5M16.5 3.5a2.121 2.121 0 113 3L13 19l-4 1 1-4L16.5 3.5z"/></svg>
                             </button>
                             <a href="${pageContext.request.contextPath}/manager/tables/delete?id=${t.id}" 
                                onclick="return confirm('Bạn có chắc chắn muốn xoá bàn này?')"
                                class="p-2 text-gray-400 hover:text-red-600 transition-colors">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg>
                             </a>
                        </div>
                    </div>
                    
                    <h3 class="text-xl font-bold text-gray-900 mb-1">${t.tableNumber}</h3>
                    <p class="text-sm text-gray-500 mb-4 font-medium">Mã Theo Dõi: <span class="text-indigo-600 font-bold">${t.code}</span></p>

                    <div class="bg-gray-50 rounded-2xl p-4 flex flex-col items-center">
                        <c:set var="selfOrderUrl" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/guest/order?tableId=${t.id}" />
                        <c:url var="qrUrl" value="https://api.qrserver.com/v1/create-qr-code/">
                            <c:param name="size" value="200x200" />
                            <c:param name="data" value="${selfOrderUrl}" />
                        </c:url>
                        <img src="${qrUrl}" alt="QR Code" class="w-32 h-32 mb-3 bg-white p-2 rounded-xl border border-gray-100">
                        <p class="text-[10px] text-gray-400 font-bold uppercase tracking-widest mb-2">Quét Để Đặt Món</p>
                        <button onclick="printQR('${qrUrl}', '${t.tableNumber}', '${selfOrderUrl}')"
                                class="w-full py-2.5 bg-white border border-gray-200 text-gray-700 text-sm font-bold rounded-xl hover:bg-gray-50 transition-all">
                            In Nhãn
                        </button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>

    <!-- Modal -->
    <div id="tableModal" class="fixed inset-0 bg-black/40 backdrop-blur-sm flex items-center justify-center z-50 hidden">
        <div class="bg-white rounded-3xl shadow-2xl w-full max-w-md p-8 mx-4 transform transition-all animate-popIn">
            <h2 id="modalTitle" class="text-2xl font-black text-gray-900 mb-1">Tạo Bàn Mới</h2>
            <p class="text-gray-500 font-medium mb-6">Đặt số và mã riêng cho bàn</p>
            
            <form action="${pageContext.request.contextPath}/manager/tables/save" method="POST" class="space-y-4">
                <input type="hidden" name="id" id="tableId">
                <div>
                    <label class="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-1 px-1">Tên/Số Bàn</label>
                    <input type="text" name="name" id="tableName" required placeholder="VD: Bàn 01"
                           class="w-full bg-gray-50 border border-gray-200 rounded-2xl py-3 px-4 text-sm font-semibold focus:bg-white focus:outline-none focus:ring-2 focus:ring-indigo-500 transition-all"/>
                </div>
                <div>
                    <label class="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-1 px-1">Mã Theo Dõi</label>
                    <input type="text" name="code" id="tableCode" required placeholder="VD: B01"
                           class="w-full bg-gray-50 border border-gray-200 rounded-2xl py-3 px-4 text-sm font-semibold focus:bg-white focus:outline-none focus:ring-2 focus:ring-indigo-500 transition-all uppercase"/>
                </div>
                <div class="flex gap-3 pt-4">
                    <button type="button" onclick="document.getElementById('tableModal').classList.add('hidden')"
                            class="flex-1 py-3 bg-white border border-gray-200 text-gray-700 rounded-2xl font-bold hover:bg-gray-50 transition-colors">Huỷ</button>
                    <button type="submit"
                            class="flex-1 py-3 bg-indigo-600 text-white rounded-2xl font-bold hover:bg-indigo-700 shadow-lg shadow-indigo-100 transition-all">Lưu Bàn</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function editTable(btn) {
            const id = btn.dataset.id;
            const name = btn.dataset.name;
            const code = btn.dataset.code;
            document.getElementById('modalTitle').innerText = 'Cập Nhật Bàn';
            document.getElementById('tableId').value = id;
            document.getElementById('tableName').value = name;
            document.getElementById('tableCode').value = code;
            document.getElementById('tableModal').classList.remove('hidden');
        }
        
        function printQR(url, name, orderUrl) {
            const win = window.open('', '_blank');
            win.document.write(`
                <html>
                <body style="text-align: center; font-family: sans-serif; padding: 40px;">
                    <h1 style="font-size: 32px; margin-bottom: 20px;">${name}</h1>
                    <img src="${url}" style="width: 300px; height: 300px; border: 1px solid #eee; padding: 20px; border-radius: 20px;">
                    <p style="margin-top: 20px; font-weight: bold; color: #6366f1;">QUÉT ĐỂ ĐẶT MÓN</p>
                    <p style="font-size: 12px; color: #888; word-break: break-all;">${orderUrl || ''}</p>
                    <script>window.onload = () => { window.print(); window.close(); }<\/script>
                </body>
                </html>
            `);
        }
        
        // Search functionality
        document.getElementById('searchInput').addEventListener('input', function(e) {
            const query = e.target.value.toLowerCase();
            const cards = document.querySelectorAll('#tableGrid > div');
            cards.forEach(card => {
                const text = card.innerText.toLowerCase();
                card.style.display = text.includes(query) ? 'block' : 'none';
            });
        });
    </script>
</body>
</html>
