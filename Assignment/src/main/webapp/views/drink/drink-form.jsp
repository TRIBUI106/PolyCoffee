<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html class="h-full">
<head>
    <title>${drink == null ? 'Món Mới' : 'Cập Nhật Món'} - PolyCoffee</title>
</head>
<body class="bg-cream font-sans min-h-full">
    <jsp:include page="../common/header.jsp" />

    <main class="max-w-4xl mx-auto px-4 py-16">
        <div class="flex items-center justify-between mb-12">
            <a href="${pageContext.request.contextPath}/manager/drinks" class="group flex items-center gap-3 text-mocha/40 hover:text-coffee-700 transition-colors font-bold text-sm tracking-widest uppercase">
                <i class="bi bi-arrow-left-circle transition-transform group-hover:-translate-x-1"></i>
                Danh Sách Món
            </a>
            <div class="text-right">
                <h1 class="text-3xl font-black text-mocha">${drink == null ? 'THÊM SẢN PHẨM MỚI' : 'CẬP NHẬT SẢN PHẨM'}</h1>
                <p class="text-latte font-bold text-xs mt-1 tracking-widest uppercase">Hệ Thống Quản Lý Thực Đơn</p>
            </div>
        </div>

        <div class="glass p-12 rounded-[3rem]">
            <form action="${pageContext.request.contextPath}/manager/drinks/save" method="post" enctype="multipart/form-data" class="grid grid-cols-1 md:grid-cols-2 gap-10">
                <input type="hidden" name="id" value="${drink.id}">
                
                <!-- Left: Info -->
                <div class="space-y-8">
                    <div>
                        <label class="block text-[10px] font-black text-mocha/30 uppercase tracking-[0.3em] mb-3">Tên Thuơng Hiệu Món</label>
                        <input type="text" name="name" value="${drink.name}" required placeholder="VD: Cà Phê Sữa Đá"
                               class="w-full bg-white/50 border border-coffee-100 px-6 py-5 rounded-[1.5rem] focus:ring-4 focus:ring-coffee-700/5 focus:border-coffee-700 outline-none transition-all placeholder:text-mocha/10 font-bold text-lg text-mocha">
                    </div>

                    <div class="grid grid-cols-2 gap-6">
                        <div>
                            <label class="block text-[10px] font-black text-mocha/30 uppercase tracking-[0.3em] mb-3">Danh Mục Thực Đơn</label>
                            <select name="categoryId" class="w-full bg-white/50 border border-coffee-100 px-6 py-5 rounded-[1.5rem] outline-none appearance-none font-bold text-mocha cursor-pointer hover:bg-white" required>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}" ${drink.category.id == cat.id ? 'selected' : ''}>${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div>
                            <label class="block text-[10px] font-black text-mocha/30 uppercase tracking-[0.3em] mb-3">Đơn Giá Cơ Bản</label>
                            <div class="relative">
                                <input type="number" name="price" value="${drink.price}" required placeholder="0"
                                       class="w-full bg-white/50 border border-coffee-100 px-6 py-5 rounded-[1.5rem] outline-none font-black text-coffee-700 text-lg">
                                <span class="absolute right-6 top-1/2 -translate-y-1/2 text-mocha/20 font-bold">đ</span>
                            </div>
                        </div>
                    </div>

                    <div>
                        <label class="block text-[10px] font-black text-mocha/30 uppercase tracking-[0.3em] mb-3">Mô tả Hương Vị / Chi Tiết</label>
                        <textarea name="description" class="w-full bg-white/50 border border-coffee-100 px-6 py-5 rounded-[1.5rem] outline-none min-h-[160px] font-medium text-mocha resize-none" placeholder="Mô tả hương vị đậm đà của cà phê nguyên chất...">${drink.description}</textarea>
                    </div>
                </div>

                <!-- Right: Visuals -->
                <div class="space-y-8">
                    <div>
                        <label class="block text-[10px] font-black text-mocha/30 uppercase tracking-[0.3em] mb-3">Hình Ảnh Hiển Thị</label>
                        <div class="relative border-2 border-dashed border-coffee-100 rounded-[2rem] p-1.5 flex flex-col items-center justify-center min-h-[300px] bg-coffee-50/20 group hover:border-coffee-700 hover:bg-white transition-all">
                            <input type="file" name="image" class="absolute inset-0 w-full h-full opacity-0 cursor-pointer z-10" accept="image/*">
                            
                            <c:choose>
                                <c:when test="${not empty drink.image}">
                                    <c:set var="imgUrl" value="${fn:startsWith(drink.image, 'http') ? drink.image : pageContext.request.contextPath.concat('/uploads/').concat(drink.image)}" />
                                    <img src="${imgUrl}" class="w-full h-[280px] object-cover rounded-[1.75rem]">
                                    <div class="absolute inset-x-0 bottom-4 px-4">
                                        <div class="glass py-3 px-6 rounded-2xl text-center text-[10px] font-bold text-coffee-700 border-coffee-100 shadow-xl tracking-widest">ĐỔI ẢNH MỚI</div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center p-8">
                                        <div class="w-16 h-16 bg-white rounded-full flex items-center justify-center text-latte text-2xl mb-4 mx-auto shadow-sm group-hover:scale-110 transition-transform">
                                            <i class="bi bi-cloud-arrow-up"></i>
                                        </div>
                                        <p class="font-bold text-mocha">Thả ảnh sản phẩm vào đây</p>
                                        <p class="text-[10px] font-bold text-mocha/30 tracking-widest mt-2 uppercase">HOẶC BẤM ĐỂ TẢI LÊN</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <p class="text-center text-[10px] mt-2 font-bold text-mocha/30 uppercase">Sử dụng ảnh vuông chuẩn để đạt hiệu quả MinIO Tốt Nhất</p>
                    </div>

                    <div class="bg-white/40 p-6 rounded-[2rem] border border-coffee-50">
                        <label class="block text-[10px] font-black text-mocha/30 uppercase tracking-[0.3em] mb-6">Trạng Thái Kinh Doanh</label>
                        <div class="flex items-center justify-between">
                            <div>
                                <h4 class="font-bold text-mocha text-sm">Hiển thị bán hàng</h4>
                                <p class="text-[10px] font-medium text-mocha/40 mt-1">Sản phẩm sẽ hiện diện trên giao diện POS</p>
                            </div>
                            <div class="relative inline-block w-14 h-8">
                                <input type="checkbox" name="active" value="1" ${drink.active || drink == null ? 'checked' : ''} class="peer opacity-0 w-full h-full cursor-pointer absolute z-10">
                                <div class="w-full h-full bg-mocha/10 rounded-full transition-colors peer-checked:bg-coffee-700"></div>
                                <div class="absolute w-6 h-6 bg-white rounded-full top-1 left-1 transition-all peer-checked:translate-x-6 shadow-sm"></div>
                            </div>
                        </div>
                    </div>

                    <div class="pt-4 flex gap-4">
                        <button type="submit" class="flex-grow btn-coffee py-5 text-lg shadow-2xl shadow-coffee-700/20 font-black tracking-wide">
                            LƯU HỒ SƠ
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </main>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
