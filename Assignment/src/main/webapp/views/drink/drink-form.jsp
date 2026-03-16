<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html class="h-full bg-gray-50">
<head>
    <title><fmt:message key="${drink == null ? 'admin.drink.form.title.add' : 'admin.drink.form.title.edit'}"/> - PolyCoffee</title>
</head>
<body class="bg-gray-50 font-sans min-h-screen text-gray-800">
    <jsp:include page="../common/header.jsp" />

    <main class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <div class="flex items-center justify-between mb-8">
            <a href="${pageContext.request.contextPath}/manager/drinks" class="group flex items-center gap-2 text-gray-500 hover:text-coffee-700 transition-colors font-semibold text-sm tracking-wide">
                <i class="bi bi-arrow-left transition-transform group-hover:-translate-x-1"></i>
                <fmt:message key="admin.drink.form.back"/>
            </a>
            <div class="text-right">
                <h1 class="text-2xl font-bold text-gray-900"><fmt:message key="${drink == null ? 'admin.drink.form.title.add' : 'admin.drink.form.title.edit'}"/></h1>
                <p class="text-gray-500 font-medium text-xs mt-1 tracking-widest uppercase"><fmt:message key="admin.drink.form.subtitle"/></p>
            </div>
        </div>

        <div class="bg-white p-8 sm:p-10 rounded-2xl shadow-sm border border-gray-200">
            <form action="${pageContext.request.contextPath}/manager/drinks/save" method="post" enctype="multipart/form-data" class="grid grid-cols-1 md:grid-cols-2 gap-10">
                <input type="hidden" name="id" value="${drink.id}">
                
                <!-- Left: Info -->
                <div class="space-y-6">
                    <div>
                        <label class="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-2"><fmt:message key="admin.drink.form.name"/></label>
                        <input type="text" name="name" value="${drink.name}" required placeholder="<fmt:message key="admin.drink.form.name.ph"/>"
                               class="w-full bg-gray-50 border border-gray-200 px-5 py-3.5 rounded-xl focus:ring-2 focus:ring-coffee-500/20 focus:border-coffee-500 focus:bg-white outline-none transition-all font-semibold text-gray-900">
                    </div>

                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-2"><fmt:message key="admin.drink.form.cat"/></label>
                            <select name="categoryId" class="w-full bg-gray-50 border border-gray-200 px-5 py-3.5 rounded-xl outline-none appearance-none font-semibold text-gray-900 focus:border-coffee-500 focus:bg-white transition-colors cursor-pointer" required>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}" ${drink.category.id == cat.id ? 'selected' : ''}>${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div>
                            <label class="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-2"><fmt:message key="admin.drink.form.price"/></label>
                            <div class="relative">
                                <input type="number" name="price" value="${drink.price}" required placeholder="0"
                                       class="w-full bg-gray-50 border border-gray-200 px-5 py-3.5 rounded-xl outline-none focus:border-coffee-500 focus:bg-white transition-colors font-bold text-coffee-700 text-lg">
                                <span class="absolute right-5 top-1/2 -translate-y-1/2 text-gray-400 font-bold">VNĐ</span>
                            </div>
                        </div>
                    </div>

                    <div>
                        <label class="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-2"><fmt:message key="admin.drink.form.desc"/></label>
                        <textarea name="description" class="w-full bg-gray-50 border border-gray-200 px-5 py-4 rounded-xl outline-none focus:border-coffee-500 focus:bg-white transition-colors min-h-[140px] font-medium text-gray-700 resize-none" placeholder="<fmt:message key="admin.drink.form.desc.ph"/>">${drink.description}</textarea>
                    </div>
                </div>

                <!-- Right: Visuals -->
                <div class="space-y-6">
                    <div>
                        <label class="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-2"><fmt:message key="admin.drink.form.img"/></label>
                        <div class="relative border-2 border-dashed border-gray-300 rounded-xl p-2 flex flex-col items-center justify-center min-h-[260px] bg-gray-50 group hover:border-coffee-500 hover:bg-white transition-all">
                            <input type="file" name="image" class="absolute inset-0 w-full h-full opacity-0 cursor-pointer z-10" accept="image/*">
                            
                            <c:choose>
                                <c:when test="${not empty drink.image}">
                                    <c:set var="imgUrl" value="${fn:startsWith(drink.image, 'http') ? drink.image : pageContext.request.contextPath.concat('/uploads/').concat(drink.image)}" />
                                    <img src="${imgUrl}" class="w-full h-[240px] object-cover rounded-lg">
                                    <div class="absolute inset-x-0 bottom-4 px-4 pointer-events-none">
                                        <div class="bg-gray-900/80 backdrop-blur text-white py-2.5 px-4 rounded-lg text-center text-xs font-semibold shadow-sm tracking-wider"><fmt:message key="admin.drink.form.img.change"/></div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center p-6">
                                        <div class="w-14 h-14 bg-white border border-gray-200 rounded-full flex items-center justify-center text-gray-400 text-xl mb-4 mx-auto shadow-sm group-hover:scale-110 group-hover:text-coffee-600 transition-all">
                                            <i class="bi bi-cloud-arrow-up"></i>
                                        </div>
                                        <p class="font-semibold text-gray-700"><fmt:message key="admin.drink.form.img.drop"/></p>
                                        <p class="text-[10px] font-bold text-gray-400 tracking-widest mt-1.5 uppercase"><fmt:message key="admin.drink.form.img.click"/></p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <p class="text-center text-xs mt-2 text-gray-500"><fmt:message key="admin.drink.form.img.note"/></p>
                    </div>

                    <div class="bg-gray-50 p-5 rounded-xl border border-gray-200">
                        <label class="block text-xs font-bold text-gray-500 uppercase tracking-wider mb-4"><fmt:message key="admin.drink.form.status"/></label>
                        <div class="flex items-center justify-between">
                            <div>
                                <h4 class="font-bold text-gray-900 text-sm"><fmt:message key="admin.drink.form.status.show"/></h4>
                                <p class="text-xs text-gray-500 mt-0.5"><fmt:message key="admin.drink.form.status.desc"/></p>
                            </div>
                            <div class="relative inline-block w-12 h-6">
                                <input type="checkbox" name="active" value="1" ${drink.active || drink == null ? 'checked' : ''} class="peer opacity-0 w-full h-full cursor-pointer absolute z-10">
                                <div class="w-full h-full bg-gray-300 rounded-full transition-colors peer-checked:bg-coffee-600"></div>
                                <div class="absolute w-4 h-4 bg-white rounded-full top-1 left-1 transition-all peer-checked:translate-x-6 shadow-sm"></div>
                            </div>
                        </div>
                    </div>

                    <div class="pt-4 flex gap-4">
                        <button type="submit" class="flex-grow bg-coffee-700 hover:bg-coffee-800 text-white font-bold py-4 rounded-xl text-lg shadow-sm transition-colors">
                            <fmt:message key="admin.drink.form.btn.save"/>
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </main>

    <jsp:include page="../common/footer.jsp" />
</body>
</html>
