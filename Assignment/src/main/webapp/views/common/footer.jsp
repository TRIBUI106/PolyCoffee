<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<footer class="mt-20 py-16 bg-gray-900 border-t border-gray-800">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-12 mb-16">
            <div class="col-span-1 md:col-span-2">
                <div class="flex items-center gap-3 mb-6">
                    <div class="bg-coffee-600 p-2 rounded-xl shadow-lg">
                        <i class="bi bi-cup-hot-fill text-white text-xl"></i>
                    </div>
                    <span class="text-2xl font-bold text-white tracking-tight">Poly<span class="text-coffee-500">Coffee</span></span>
                </div>
                <p class="text-gray-400 text-sm leading-relaxed max-w-sm">
                    <fmt:message key="footer.desc"/>
                </p>
                <div class="mt-8 flex items-center gap-5">
                    <a href="#" class="w-10 h-10 rounded-lg bg-gray-800 hover:bg-gray-700 text-gray-400 hover:text-white flex items-center justify-center transition-all border border-gray-700">
                        <i class="bi bi-facebook"></i>
                    </a>
                    <a href="#" class="w-10 h-10 rounded-lg bg-gray-800 hover:bg-gray-700 text-gray-400 hover:text-white flex items-center justify-center transition-all border border-gray-700">
                        <i class="bi bi-instagram"></i>
                    </a>
                    <a href="#" class="w-10 h-10 rounded-lg bg-gray-800 hover:bg-gray-700 text-gray-400 hover:text-white flex items-center justify-center transition-all border border-gray-700">
                        <i class="bi bi-twitter-x"></i>
                    </a>
                </div>
            </div>

            <div>
                <h4 class="text-white font-bold mb-6 text-xs uppercase tracking-widest bg-gray-800/50 inline-block px-3 py-1 rounded-md border border-gray-700/50"><fmt:message key="footer.eco"/></h4>
                <ul class="space-y-3.5 text-sm">
                    <li><a href="${pageContext.request.contextPath}/" class="text-gray-400 hover:text-coffee-500 transition-colors flex items-center gap-2">
                            <fmt:message key="footer.eco.home"/>
                        </a></li>
                    <li><a href="${pageContext.request.contextPath}/employee/pos" class="text-gray-400 hover:text-coffee-500 transition-colors flex items-center gap-2">
                            <fmt:message key="footer.eco.pos"/>
                        </a></li>
                    <li><a href="#" class="text-gray-400 hover:text-coffee-500 transition-colors flex items-center gap-2">
                            <fmt:message key="footer.eco.global"/>
                        </a></li>
                </ul>
            </div>

            <div>
                <h4 class="text-white font-bold mb-6 text-xs uppercase tracking-widest bg-gray-800/50 inline-block px-3 py-1 rounded-md border border-gray-700/50"><fmt:message key="footer.tech"/></h4>
                <ul class="space-y-3.5 text-sm">
                    <li><a href="#" class="text-gray-400 hover:text-coffee-500 transition-colors flex items-center gap-2">
                            <fmt:message key="footer.tech.analytics"/>
                        </a></li>
                    <li><a href="#" class="text-gray-400 hover:text-coffee-500 transition-colors flex items-center gap-2">
                            <fmt:message key="footer.tech.resources"/>
                        </a></li>
                    <li><a href="#" class="text-gray-400 hover:text-coffee-500 transition-colors flex items-center gap-2">
                            <fmt:message key="footer.tech.security"/>
                        </a></li>
                </ul>
            </div>
        </div>

        <div class="pt-10 border-t border-gray-800 flex flex-col md:flex-row justify-between items-center gap-6">
            <p class="text-[10px] font-bold tracking-widest uppercase text-gray-500">
                &copy; 2026 PolyCoffee &bull; YEUMEDEVS
            </p>
            <div class="flex items-center gap-6 text-[10px] font-bold tracking-widest uppercase text-gray-500">
                <a href="#" class="hover:text-white transition-colors"><fmt:message key="footer.sec.privacy"/></a>
                <a href="#" class="hover:text-white transition-colors"><fmt:message key="footer.sec.terms"/></a>
                <a href="#" class="hover:text-white transition-colors"><fmt:message key="footer.sec.cookies"/></a>
            </div>
        </div>
    </div>
</footer>ookies</a>
                </div>
            </div>
        </div>
    </footer>