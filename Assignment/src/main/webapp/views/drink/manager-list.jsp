<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html class="h-full">
<head>
    <title>Danh Sách Đồ Uống - PolyCoffee</title>
</head>
<body class="bg-cream font-sans min-h-full">
    <jsp:include page="../common/header.jsp" />

    <main class="max-w-7xl mx-auto px-4 py-12">
        <div class="flex flex-col md:flex-row md:items-end justify-between gap-6 mb-12">
            <div>
                <h1 class="text-4xl font-bold text-mocha mb-2">Thực Đơn Cửa Hàng</h1>
                <p class="text-mocha/40 font-medium">Quản lý giá cả, các món nước và hình ảnh hiển thị</p>
            </div>
            <a href="${pageContext.request.contextPath}/manager/drinks/form" class="btn-coffee py-4 flex items-center gap-2 group">
                <i class="bi bi-plus-circle group-hover:rotate-90 transition-transform"></i>
                Thêm Món Mới
            </a>
        </div>

        <div class="glass overflow-hidden rounded-[2.5rem]">
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="bg-white/50 border-b border-coffee-50">
                            <th class="px-10 py-6 text-[10px] font-extrabold text-mocha/30 uppercase tracking-[0.2em]">Thông Tin Sản Phẩm</th>
                            <th class="px-6 py-6 text-[10px] font-extrabold text-mocha/30 uppercase tracking-[0.2em]">Phân Loại</th>
                            <th class="px-6 py-6 text-[10px] font-extrabold text-mocha/30 uppercase tracking-[0.2em]">Đơn Giá</th>
                            <th class="px-6 py-6 text-[10px] font-extrabold text-mocha/30 uppercase tracking-[0.2em] text-center">Trạng Thái</th>
                            <th class="px-10 py-6 text-[10px] font-extrabold text-mocha/30 uppercase tracking-[0.2em] text-right">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-coffee-50/50">
                        <c:forEach var="d" items="${drinks}">
                            <tr class="group hover:bg-white/30 transition-colors">
                                <td class="px-10 py-6">
                                    <div class="flex items-center gap-6">
                                        <div class="w-16 h-16 rounded-2xl glass overflow-hidden flex-shrink-0 bg-white">
                                            <c:choose>
                                                <c:when test="${not empty d.image}">
                                                    <c:set var="imgUrl" value="${fn:startsWith(d.image, 'http') ? d.image : pageContext.request.contextPath.concat('/uploads/').concat(d.image)}" />
                                                    <img src="${imgUrl}" class="w-full h-full object-cover">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="w-full h-full flex items-center justify-center text-latte text-2xl">
                                                        <i class="bi bi-image"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div>
                                            <div class="font-bold text-mocha text-lg leading-tight mb-1">${d.name}</div>
                                            <div class="text-xs font-medium text-mocha/40 line-clamp-1 max-w-[200px]">${d.description}</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-6">
                                    <span class="bg-coffee-50 text-coffee-700 text-[10px] font-black px-3 py-1.5 rounded-xl border border-coffee-100 uppercase italic">
                                        ${d.category.name}
                                    </span>
                                </td>
                                <td class="px-6 py-6">
                                    <div class="font-black text-mocha"><fmt:formatNumber value="${d.price}" pattern="#,###"/> <span class="text-[10px] text-mocha/30 ml-0.5">VNĐ</span></div>
                                </td>
                                <td class="px-6 py-6 text-center">
                                    <span class="inline-flex items-center gap-2 px-3 py-1 rounded-full text-[10px] font-bold ${d.active ? 'bg-emerald-50 text-emerald-600 border border-emerald-100' : 'bg-mocha/5 text-mocha/30 border border-mocha/10'}">
                                        <span class="w-1.5 h-1.5 rounded-full ${d.active ? 'bg-emerald-600' : 'bg-mocha/30'}"></span>
                                        ${d.active ? 'ĐANG BÁN' : 'TẠM NGƯNG'}
                                    </span>
                                </td>
                                <td class="px-10 py-6 text-right">
                                    <div class="flex items-center justify-end gap-3 opacity-0 group-hover:opacity-100 transition-all translate-x-4 group-hover:translate-x-0">
                                        <a href="${pageContext.request.contextPath}/manager/drinks/form?id=${d.id}" 
                                           class="w-10 h-10 flex items-center justify-center rounded-2xl bg-white text-mocha hover:bg-coffee-700 hover:text-white shadow-sm border border-coffee-50 transition-all">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/manager/drinks/delete?id=${d.id}" 
                                           onclick="return confirm('Bạn có muốn xoá món này khỏi thực đơn?')"
                                           class="w-10 h-10 flex items-center justify-center rounded-2xl bg-white text-red-500 hover:bg-red-500 hover:text-white shadow-sm border border-coffee-50 transition-all">
                                            <i class="bi bi-trash3"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <c:if test="${empty drinks}">
                <div class="py-32 text-center opacity-30">
                    <i class="bi bi-inbox text-5xl block mb-4"></i>
                    <p class="font-bold">Chưa có đồ uống nào được tạo.</p>
                </div>
            </c:if>
        </div>
    </main>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
