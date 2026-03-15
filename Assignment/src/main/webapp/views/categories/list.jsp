<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html class="h-full">
<head>
    <title>Danh Mục Đồ Uống - PolyCoffee Hub</title>
</head>
<body class="bg-cream font-sans min-h-full">
    <jsp:include page="../common/header.jsp" />

    <main class="max-w-7xl mx-auto px-4 py-12">
        <div class="mb-12">
            <h1 class="text-4xl font-bold text-mocha mb-2">Quản Lý Danh Mục</h1>
            <p class="text-mocha/40 font-medium">Phân loại các nhóm thực đơn phục vụ tại cửa hàng</p>
        </div>
        
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-10">
            <!-- Form Card (4 cols) -->
            <div class="lg:col-span-4">
                <div class="glass p-8 rounded-[2rem] sticky top-32">
                    <h2 class="text-xl font-bold text-mocha mb-6 flex items-center gap-2">
                        <span class="w-1.5 h-6 bg-coffee-700 rounded-full"></span>
                        ${category == null ? 'Thêm Danh Mục Mới' : 'Cập Nhật Danh Mục'}
                    </h2>
                    
                    <form action="${pageContext.request.contextPath}/manager/categories/save" method="post" class="space-y-6">
                        <input type="hidden" name="id" value="${category.id}">
                        <div>
                            <label class="block text-[10px] font-bold text-mocha/30 uppercase tracking-[0.2em] mb-2">Tên Phân Loại</label>
                            <input type="text" name="name" value="${category.name}" required placeholder="VD: Cà phê truyền thống"
                                   class="w-full bg-white/50 border border-coffee-100 px-5 py-4 rounded-2xl focus:ring-2 focus:ring-coffee-700/10 focus:border-coffee-700 outline-none transition-all placeholder:text-mocha/20 font-medium capitalize">
                        </div>
                        
                        <div class="flex flex-col gap-3 pt-2">
                            <button type="submit" class="btn-coffee py-4 shadow-xl">
                                ${category == null ? 'LƯU DANH MỤC' : 'CẬP NHẬT'}
                            </button>
                            <c:if test="${category != null}">
                                <a href="${pageContext.request.contextPath}/manager/categories" 
                                   class="btn-soft py-4 text-center">Huỷ Chỉnh Sửa</a>
                            </c:if>
                        </div>
                    </form>
                </div>
            </div>

            <!-- List Space (8 cols) -->
            <div class="lg:col-span-8 flex flex-col gap-6">
                <!-- Count Card -->
                <div class="glass p-6 rounded-3xl flex items-center justify-between bg-white/40">
                    <div class="flex items-center gap-4">
                        <div class="bg-coffee-50 p-3 rounded-2xl text-coffee-700">
                            <i class="bi bi-collection text-2xl"></i>
                        </div>
                        <div>
                            <div class="text-[10px] font-bold text-mocha/30 uppercase tracking-widest">Đang Kích Hoạt</div>
                            <div class="text-2xl font-bold text-mocha">0<c:out value="${categories.size()}"/> Nhóm</div>
                        </div>
                    </div>
                </div>

                <!-- Table Container -->
                <div class="glass overflow-hidden rounded-[2rem]">
                    <div class="overflow-x-auto">
                        <table class="w-full text-left border-collapse">
                            <thead>
                                <tr class="bg-white/50 border-b border-coffee-50">
                                    <th class="px-8 py-5 text-[10px] font-bold text-mocha/30 uppercase tracking-widest">Mã NHÓM</th>
                                    <th class="px-6 py-5 text-[10px] font-bold text-mocha/30 uppercase tracking-widest">Tên Định Danh</th>
                                    <th class="px-6 py-5 text-[10px] font-bold text-mocha/30 uppercase tracking-widest text-center">Trạng Thái</th>
                                    <th class="px-8 py-5 text-[10px] font-bold text-mocha/30 uppercase tracking-widest text-right">Tùy Chọn</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-coffee-50/50">
                                <c:forEach var="cat" items="${categories}">
                                    <tr class="group hover:bg-white/30 transition-colors">
                                        <td class="px-8 py-6">
                                            <span class="bg-coffee-50 text-coffee-700 text-[10px] font-black px-2 py-1 rounded-md">ID-${cat.id}</span>
                                        </td>
                                        <td class="px-6 py-6">
                                            <div class="font-bold text-mocha">${cat.name}</div>
                                            <div class="text-[10px] font-medium text-mocha/30 italic">Nhóm thực đơn nhóm</div>
                                        </td>
                                        <td class="px-6 py-6 text-center">
                                            <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-[10px] font-bold border ${cat.active ? 'bg-green-50 text-green-600 border-green-100' : 'bg-red-50 text-red-600 border-red-100'}">
                                                <span class="w-1 h-1 rounded-full ${cat.active ? 'bg-green-600' : 'bg-red-600'}"></span>
                                                ${cat.active ? 'HIỆN THỊ' : 'TẠM TẮT'}
                                            </span>
                                        </td>
                                        <td class="px-8 py-6 text-right">
                                            <div class="flex items-center justify-end gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                                                <a href="?id=${cat.id}" class="w-9 h-9 flex items-center justify-center rounded-xl bg-blue-50 text-blue-600 hover:bg-blue-600 hover:text-white transition-all shadow-sm">
                                                    <i class="bi bi-pencil-square"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/manager/categories/delete?id=${cat.id}" 
                                                   onclick="return confirm('Bạn có chắc xoá danh mục này?')"
                                                   class="w-9 h-9 flex items-center justify-center rounded-xl bg-red-50 text-red-600 hover:bg-red-600 hover:text-white transition-all shadow-sm">
                                                    <i class="bi bi-trash3"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
