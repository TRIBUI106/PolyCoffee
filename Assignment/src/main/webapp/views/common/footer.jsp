<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <footer class="mt-20 py-20 bg-mocha relative overflow-hidden">
        <!-- Footer Decoration -->
        <div
            class="absolute top-0 left-0 w-full h-px bg-gradient-to-r from-transparent via-coffee-500/30 to-transparent">
        </div>
        <div class="absolute -bottom-24 -left-24 w-96 h-96 bg-coffee-900/50 rounded-full blur-3xl opacity-20"></div>

        <div class="max-w-7xl mx-auto px-6 relative z-10">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-12 mb-20">
                <div class="col-span-1 md:col-span-2">
                    <div class="flex items-center gap-3 mb-8 group">
                        <div
                            class="bg-coffee-700 p-2.5 rounded-2xl group-hover:rotate-12 transition-transform duration-500 shadow-2xl shadow-coffee-700/20">
                            <i class="bi bi-cup-hot-fill text-white text-xl"></i>
                        </div>
                        <span class="text-3xl font-black text-white text-display tracking-tight">Poly<span
                                class="text-coffee-500">Coffee</span></span>
                    </div>
                    <p class="text-white/50 text-lg leading-relaxed max-w-md font-light">
                        Định nghĩa lại nghệ thuật quản lý cà phê số.
                        Nơi tay nghề thủ công hội tụ cùng công nghệ hiệu suất cao.
                    </p>
                    <div class="mt-10 flex items-center gap-6">
                        <a href="#"
                            class="w-12 h-12 rounded-2xl bg-white/5 hover:bg-coffee-700 hover:scale-110 transition-all duration-500 flex items-center justify-center text-white border border-white/10">
                            <i class="bi bi-instagram"></i>
                        </a>
                        <a href="#"
                            class="w-12 h-12 rounded-2xl bg-white/5 hover:bg-coffee-700 hover:scale-110 transition-all duration-500 flex items-center justify-center text-white border border-white/10">
                            <i class="bi bi-twitter-x"></i>
                        </a>
                        <a href="#"
                            class="w-12 h-12 rounded-2xl bg-white/5 hover:bg-coffee-700 hover:scale-110 transition-all duration-500 flex items-center justify-center text-white border border-white/10">
                            <i class="bi bi-threads"></i>
                        </a>
                    </div>
                </div>

                <div>
                    <h4 class="text-white font-bold mb-8 uppercase tracking-[0.2em] text-xs opacity-40">Hệ Sinh Thái</h4>
                    <ul class="space-y-4 text-white/60">
                        <li><a href="${pageContext.request.contextPath}/"
                                class="hover:text-coffee-400 transition-all flex items-center gap-2 group">
                                <span
                                    class="w-1.5 h-1.5 rounded-full bg-coffee-700 scale-0 group-hover:scale-100 transition-transform"></span>
                                Trải Nghiệm Tại Quán
                            </a></li>
                        <li><a href="${pageContext.request.contextPath}/employee/pos"
                                class="hover:text-coffee-400 transition-all flex items-center gap-2 group">
                                <span
                                    class="w-1.5 h-1.5 rounded-full bg-coffee-700 scale-0 group-hover:scale-100 transition-transform"></span>
                                Hệ Thống Smart POS
                            </a></li>
                        <li><a href="#" class="hover:text-coffee-400 transition-all flex items-center gap-2 group">
                                <span
                                    class="w-1.5 h-1.5 rounded-full bg-coffee-700 scale-0 group-hover:scale-100 transition-transform"></span>
                                Mạng Lưới Toàn Cầu
                            </a></li>
                    </ul>
                </div>

                <div>
                    <h4 class="text-white font-bold mb-8 uppercase tracking-[0.2em] text-xs opacity-40">Công Nghệ
                    </h4>
                    <ul class="space-y-4 text-white/60">
                        <li><a href="#" class="hover:text-coffee-400 transition-all flex items-center gap-2 group">
                                <span
                                    class="w-1.5 h-1.5 rounded-full bg-coffee-700 scale-0 group-hover:scale-100 transition-transform"></span>
                                Trung Tâm Phân Tích
                            </a></li>
                        <li><a href="#" class="hover:text-coffee-400 transition-all flex items-center gap-2 group">
                                <span
                                    class="w-1.5 h-1.5 rounded-full bg-coffee-700 scale-0 group-hover:scale-100 transition-transform"></span>
                                Quản Lý Tài Nguyên
                            </a></li>
                        <li><a href="#" class="hover:text-coffee-400 transition-all flex items-center gap-2 group">
                                <span
                                    class="w-1.5 h-1.5 rounded-full bg-coffee-700 scale-0 group-hover:scale-100 transition-transform"></span>
                                Bảo Mật Hệ Thống
                            </a></li>
                    </ul>
                </div>
            </div>

            <div class="pt-12 border-t border-white/5 flex flex-col md:flex-row justify-between items-center gap-6">
                <p class="text-[10px] font-bold tracking-[0.4em] uppercase text-white/30">
                    &copy; 2026 PolyCoffee &bull; YEUMEDEVS-
                </p>
                <div class="flex items-center gap-8 text-[10px] font-bold tracking-[0.2em] uppercase text-white/20">
                    <a href="#" class="hover:text-white transition-colors">Bảo Mật</a>
                    <a href="#" class="hover:text-white transition-colors">Điều Khoản</a>
                    <a href="#" class="hover:text-white transition-colors">Cookies</a>
                </div>
            </div>
        </div>
    </footer>