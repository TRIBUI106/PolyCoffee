<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html class="h-full">
<head>
    <title>Danh Sách Nhân Viên - PolyCoffee</title>
</head>
<body class="bg-cream font-sans min-h-full">
    <jsp:include page="../common/header.jsp" />

    <main class="max-w-7xl mx-auto px-4 py-12">
        <div class="flex flex-col md:flex-row md:items-end justify-between gap-6 mb-16">
            <div>
                <h1 class="text-4xl font-extrabold text-mocha mb-2">Danh Sách Nhân Viên</h1>
                <p class="text-latte font-bold text-xs tracking-widest uppercase">Trung Tâm Quản Lý Nhân Sự</p>
            </div>
            <a href="${pageContext.request.contextPath}/manager/staff/form" class="btn-coffee py-4 flex items-center gap-2 group">
                <i class="bi bi-person-plus group-hover:scale-125 transition-transform"></i>
                Tuyển Thành Viên Mới
            </a>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <c:forEach var="s" items="${staffList}">
                <div class="group glass p-8 rounded-[2.5rem] bg-white transition-all hover:-translate-y-2 hover:shadow-2xl hover:shadow-coffee-700/5 border-transparent hover:border-coffee-100">
                    <div class="flex items-start justify-between mb-8">
                        <div class="w-16 h-16 rounded-[1.25rem] bg-coffee-50 flex items-center justify-center text-coffee-700 text-2xl font-black shadow-inner">
                            ${s.fullName.substring(0, 1)}
                        </div>
                        <div class="flex flex-col items-end">
                            <span class="px-3 py-1 rounded-full text-[10px] font-black border ${s.active ? 'bg-green-50 text-green-600 border-green-100' : 'bg-red-50 text-red-600 border-red-100'}">
                                ${s.active ? 'HOẠT ĐỘNG' : 'ĐÃ KHÓA'}
                            </span>
                            <span class="text-[10px] font-bold text-mocha/20 mt-2 uppercase tracking-tighter">ID: #0${s.id}</span>
                        </div>
                    </div>

                    <div class="mb-8">
                        <h3 class="text-xl font-bold text-mocha mb-1 group-hover:text-coffee-700 transition-colors">${s.fullName}</h3>
                        <p class="text-mocha/40 text-sm font-medium flex items-center gap-2">
                            <i class="bi bi-envelope text-latte"></i> ${s.email}
                        </p>
                        <p class="text-mocha/40 text-sm font-medium flex items-center gap-2 mt-1">
                            <i class="bi bi-telephone text-latte"></i> ${s.phone}
                        </p>
                    </div>

                    <div class="pt-6 border-t border-coffee-50 flex items-center justify-between">
                        <div class="flex gap-2">
                            <a href="${pageContext.request.contextPath}/manager/staff/form?id=${s.id}" class="w-10 h-10 rounded-xl bg-coffee-50 text-coffee-700 hover:bg-coffee-700 hover:text-white flex items-center justify-center transition-all shadow-sm">
                                <i class="bi bi-pencil-square"></i>
                            </a>
                        </div>
                        <c:choose>
                            <c:when test="${s.active}">
                                <a href="${pageContext.request.contextPath}/manager/staff/status?id=${s.id}&active=0" 
                                   class="btn-soft px-4 py-2 text-xs border-red-100 text-red-600 hover:bg-red-500 hover:text-white hover:border-red-500">
                                   Khóa Tài Khoản
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/manager/staff/status?id=${s.id}&active=1" 
                                   class="btn-coffee px-4 py-2 text-xs bg-emerald-600 hover:bg-emerald-700">
                                   Mở Khóa
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty staffList}">
            <div class="py-40 text-center text-mocha/20">
                <i class="bi bi-people text-6xl block mb-4"></i>
                <p class="font-bold">Không tìm thấy nhân viên nào trong hệ thống.</p>
            </div>
        </c:if>
    </main>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
