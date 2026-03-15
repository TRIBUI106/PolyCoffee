<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html class="h-full">
<head>
    <title>${staff == null ? 'Tuyển Nhân Viên' : 'Hồ Sơ Nhân Viên'} - PolyCoffee</title>
</head>
<body class="bg-cream font-sans min-h-full">
    <jsp:include page="../common/header.jsp" />

    <main class="max-w-4xl mx-auto px-4 py-16">
        <div class="flex items-center justify-between mb-12">
            <a href="${pageContext.request.contextPath}/manager/staff" class="group flex items-center gap-3 text-mocha/40 hover:text-coffee-700 transition-colors font-bold text-sm tracking-widest uppercase">
                <i class="bi bi-arrow-left-circle transition-transform group-hover:-translate-x-1"></i>
                Chỉ Mục Nhân Viên
            </a>
            <div class="text-right">
                <h1 class="text-3xl font-black text-mocha tracking-tighter italic">${staff == null ? 'Tuyển Nhân Lực' : 'Hồ Sơ Cá Nhân'}</h1>
                <p class="text-latte font-black text-[10px] tracking-[0.4em] uppercase mt-1">Hệ Thống Quản Lý Nhân Sự</p>
            </div>
        </div>

        <div class="glass p-12 rounded-[3.5rem] bg-white relative overflow-hidden">
            <!-- Decorative Icon -->
            <div class="absolute -top-10 -right-10 text-[120px] text-coffee-50 opacity-10 pointer-events-none">
                <i class="bi bi-person-badge"></i>
            </div>

            <c:if test="${not empty error}">
                <div class="bg-red-50 text-red-500 p-5 rounded-2xl text-sm font-black mb-10 border border-red-100 flex items-center gap-3 shadow-sm">
                    <i class="bi bi-exclamation-octagon text-lg"></i>
                    ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/manager/staff/save" method="post" class="space-y-10 relative">
                <input type="hidden" name="id" value="${staff.id}">
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-10">
                    <!-- Primary Identity -->
                    <div class="space-y-8">
                        <div>
                            <label class="block text-[10px] font-black text-mocha/20 uppercase tracking-[0.3em] mb-3 ml-1">Họ Tên Pháp Lý</label>
                            <input type="text" name="fullName" value="${staff.fullName}" required placeholder="Họ và Tên"
                                   class="w-full bg-coffee-50/50 border-0 px-6 py-5 rounded-[1.5rem] focus:ring-4 focus:ring-coffee-700/5 focus:bg-white outline-none transition-all placeholder:text-mocha/10 font-bold text-mocha">
                        </div>

                        <div>
                            <label class="block text-[10px] font-black text-mocha/20 uppercase tracking-[0.3em] mb-3 ml-1">Kênh Liên Lạc (Số Điện Thoại)</label>
                            <input type="text" name="phone" value="${staff.phone}" required pattern="0[0-9]{9}" placeholder="0987 654 321"
                                   class="w-full bg-coffee-50/50 border-0 px-6 py-5 rounded-[1.5rem] focus:ring-4 focus:ring-coffee-700/5 focus:bg-white outline-none transition-all placeholder:text-mocha/10 font-black text-mocha tracking-widest">
                        </div>
                    </div>

                    <!-- System Access -->
                    <div class="space-y-8">
                        <c:if test="${staff == null}">
                            <div>
                                <label class="block text-[10px] font-black text-mocha/20 uppercase tracking-[0.3em] mb-3 ml-1">Email Công Sở</label>
                                <input type="email" name="email" value="${staff.email}" required placeholder="staff@polycoffee.com"
                                       class="w-full bg-coffee-50/50 border-0 px-6 py-5 rounded-[1.5rem] focus:ring-4 focus:ring-coffee-700/5 focus:bg-white outline-none transition-all placeholder:text-mocha/10 font-bold text-mocha">
                            </div>
                            <div>
                                <label class="block text-[10px] font-black text-mocha/20 uppercase tracking-[0.3em] mb-3 ml-1">Mật Khẩu Phân Bổ</label>
                                <input type="password" name="password" required placeholder="Tối thiểu 6 ký tự" minlength="6"
                                       class="w-full bg-coffee-50/50 border-0 px-6 py-5 rounded-[1.5rem] focus:ring-4 focus:ring-coffee-700/5 focus:bg-white outline-none transition-all placeholder:text-mocha/10 font-medium text-mocha">
                            </div>
                        </c:if>
                        
                        <c:if test="${staff != null}">
                            <div class="p-8 rounded-[2.5rem] bg-coffee-50/30 border border-coffee-50 flex flex-col justify-center h-full">
                                <div class="text-[10px] font-bold text-latte uppercase tracking-widest mb-1 italic">Ghi Chú Bảo Mật</div>
                                <p class="text-xs text-mocha/40 font-medium italic leading-relaxed">Thông tin đăng nhập hệ thống (email/mật khẩu) chỉ có thể được thay đổi bởi chủ sở hữu hồ sơ nhằm tăng cường bảo mật nghiêm ngặt.</p>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Footer Operations -->
                <div class="pt-10 border-t border-coffee-50 flex flex-col md:flex-row items-center justify-between gap-8">
                    <div class="flex items-center gap-6">
                        <span class="text-[10px] font-black text-mocha/30 uppercase tracking-[0.2em]">Trạng Thái Mở Số</span>
                        <div class="flex gap-4">
                            <label class="flex items-center gap-3 cursor-pointer group">
                                <input type="radio" name="active" value="1" ${staff.active || staff == null ? 'checked' : ''} class="peer hidden">
                                <div class="w-5 h-5 rounded-full border-2 border-coffee-100 peer-checked:border-coffee-700 peer-checked:bg-coffee-700 transition-all flex items-center justify-center">
                                    <div class="w-1.5 h-1.5 rounded-full bg-white opacity-0 peer-checked:opacity-100 transition-opacity"></div>
                                </div>
                                <span class="text-sm font-bold text-mocha/40 peer-checked:text-mocha group-hover:text-mocha transition-colors italic">Đang Hoạt Động</span>
                            </label>
                            <label class="flex items-center gap-3 cursor-pointer group">
                                <input type="radio" name="active" value="0" ${not staff.active && staff != null ? 'checked' : ''} class="peer hidden">
                                <div class="w-5 h-5 rounded-full border-2 border-coffee-100 peer-checked:border-mocha peer-checked:bg-mocha transition-all flex items-center justify-center">
                                    <div class="w-1.5 h-1.5 rounded-full bg-white opacity-0 peer-checked:opacity-100 transition-opacity"></div>
                                </div>
                                <span class="text-sm font-bold text-mocha/40 peer-checked:text-mocha group-hover:text-mocha transition-colors italic">Khóa Truy Cập</span>
                            </label>
                        </div>
                    </div>

                    <div class="flex gap-4 w-full md:w-auto">
                        <button type="submit" class="flex-grow md:flex-none btn-coffee py-5 px-10 text-lg shadow-2xl shadow-coffee-700/20">
                            Xác Nhận Cập Nhật Cấu Trúc Hồ Sơ
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </main>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
