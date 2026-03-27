<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

      <fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
      <fmt:setBundle basename="messages" />

      <!DOCTYPE html>
      <html lang="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" class="h-full scroll-smooth">

      <head>
        <title>
          <fmt:message key="app.name" /> - PolyCoffee
        </title>
        <jsp:include page="/views/common/head.jsp" />
        <!-- Premium Fonts -->
        <link
          href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
          rel="stylesheet" />

        <script src="https://unpkg.com/lucide@latest"></script>

        <style type="text/tailwindcss">
          @layer theme {
        .font-serif-majestic {
          font-family: "Cormorant Garamond", serif;
        }
      }
      @layer utilities {
        .bg-nocturnal {
          background-color: #0d0705;
        }
        .text-amber-glow {
          @apply text-amber-500;
          text-shadow: 0 0 20px rgba(245, 158, 11, 0.4);
        }
        .glass-card-deep {
          @apply bg-white/5 backdrop-blur-[40px] border border-white/10;
          box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.82);
        }
        .text-balance {
          text-wrap: balance;
        }
      }
    </style>
      </head>

      <body
        class="bg-nocturnal font-sans min-h-screen flex flex-col overflow-x-hidden selection:bg-amber-500/30 selection:text-white text-slate-200 antialiased">
        <!-- Cinematic Texture Overlay -->
        <div class="fixed inset-0 pointer-events-none z-[100] opacity-[0.03] mix-blend-overlay">
          <svg viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
            <filter id="noiseFilter">
              <feTurbulence type="fractalNoise" baseFrequency="0.65" numOctaves="3" stitchTiles="stitch" />
            </filter>
            <rect width="100%" height="100%" filter="url(#noiseFilter)" />
          </svg>
        </div>

        <!-- 3D Background Canvas -->
        <div class="fixed inset-0 pointer-events-none z-0">
          <canvas id="canvas-3d" class="w-full h-full"></canvas>
        </div>

        <!-- Premium Background Glows -->
        <div class="fixed inset-0 pointer-events-none overflow-hidden z-[1]">
          <div class="absolute top-[-10%] left-[-10%] w-[60vw] h-[60vh] bg-amber-900/20 rounded-full blur-[120px]">
          </div>
          <div class="absolute bottom-[20%] right-[-5%] w-[50vw] h-[50vh] bg-orange-900/10 rounded-full blur-[100px]">
          </div>
        </div>

        <div class="relative z-50 border-b border-white/5 bg-black/20 backdrop-blur-md">
          <jsp:include page="/views/common/header.jsp" />
        </div>

        <main class="flex-grow flex flex-col relative z-20">
          <!-- Hero Section -->
          <section class="min-h-[100vh] flex flex-col items-center justify-center text-center px-6 relative">
            <div class="max-w-5xl mx-auto py-20">
              <!-- <div
            data-aos="fade-down"
            class="inline-flex items-center gap-2 bg-white/5 border border-white/10 px-4 py-1.5 rounded-full text-amber-500/80 text-[10px] uppercase tracking-[0.3em] font-bold mb-8 backdrop-blur-sm"
          >
            <span class="relative flex h-2 w-2">
              <span
                class="relative inline-flex rounded-full h-2 w-2 bg-amber-500"
              ></span>
            </span>
            Hành Trình Hương Vị Thủ Công
          </div> -->

              <h1 class="text-7xl md:text-[9rem] font-serif-majestic text-white tracking-tighter mb-2 select-none"
                id="hero-title">
                Đậm Vị <br />
                <span class="text-amber-glow italic">Nghệ Thuật</span>
              </h1>

              <p data-aos="fade-up" data-aos-delay="400"
                class="text-slate-400 text-xl md:text-2xl max-w-2xl mx-auto mb-16 leading-relaxed font-light font-outfit text-balance">
                Khám phá sự giao thoa hoàn hảo giữa kỹ thuật rang xay truyền thống
                và trải nghiệm không gian công nghệ hiện đại.
              </p>

              <div data-aos="fade-up" data-aos-delay="600"
                class="flex flex-col sm:flex-row gap-6 justify-center items-center">
                <c:choose>
                  <c:when test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/guest/order"
                      class="group relative px-12 py-3 bg-amber-600 text-white rounded-full font-bold text-lg overflow-hidden transition-all hover:bg-amber-500 hover:scale-105 active:scale-95 shadow-[0_0_30px_rgba(217,119,6,0.2)]">
                      <span class="relative z-10 flex items-center gap-2">
                        Bắt Đầu Thưởng Thức
                        <i data-lucide="arrow-right" class="w-5 h-5 group-hover:translate-x-1 transition-transform"></i>
                      </span>
                      <div
                        class="absolute inset-0 bg-gradient-to-r from-amber-400/0 via-white/20 to-amber-400/0 -translate-x-[100%] group-hover:translate-x-[100%] transition-transform duration-700">
                      </div>
                    </a>
                  </c:when>
                  <c:otherwise>
                    <a href="${pageContext.request.contextPath}/employee/pos"
                      class="group relative px-12 py-3 bg-white text-black rounded-full font-bold text-lg overflow-hidden transition-all hover:scale-105 active:scale-95 shadow-xl">
                      <span class="relative z-10 flex items-center gap-2">
                        Truy Cập POS
                        <i data-lucide="layout-dashboard" class="w-5 h-5"></i>
                      </span>
                    </a>
                  </c:otherwise>
                </c:choose>

                <a href="#about"
                  class="px-12 py-3 bg-white/5 hover:bg-white/10 text-white border border-white/10 rounded-full font-bold text-lg transition-all backdrop-blur-md">
                  Tìm hiểu thêm
                </a>
              </div>
            </div>

            <!-- Scroll Indicator -->
            <div class="absolute bottom-2 left-1/2 -translate-x-1/2 flex flex-col items-center gap-4 opacity-40">
              <div class="w-[1px] h-20 bg-gradient-to-b from-white to-transparent"></div>
              <span class="text-[10px] tracking-[0.4em] uppercase font-bold vertical-rl">Scroll</span>
            </div>
          </section>

          <!-- About Section -->
          <section id="about" class="py-32 relative overflow-hidden bg-black/40">
            <div class="max-w-7xl mx-auto px-6 grid lg:grid-cols-2 gap-24 items-center">
              <div data-aos="fade-right">
                <span class="text-amber-500 font-bold uppercase tracking-[0.4em] text-xs mb-6 block">Kỹ Nghệ Rang
                  Xay</span>
                <h2 class="text-5xl md:text-7xl font-serif-majestic text-white mb-10 leading-none">
                  Tuyển chọn từ những <br />
                  <span class="italic text-amber-glow">Cao Nguyên</span> trù phú.
                </h2>
                <p class="text-slate-400 text-lg mb-10 leading-relaxed font-light">
                  Chúng tôi không chỉ pha chế cà phê, chúng tôi kể câu chuyện về đất
                  trời và con người qua từng giọt đắng tinh túy. Mỗi hạt cà phê đều
                  được nâng niu và kiểm soát bằng hệ thống cảm biến nhiệt độ thông
                  minh.
                </p>
                <div class="grid grid-cols-2 gap-8">
                  <div class="p-8 glass-card-deep rounded-3xl group hover:-translate-y-2 transition-transform">
                    <div class="text-amber-500 font-serif-majestic text-4xl mb-2">
                      100%
                    </div>
                    <div class="text-slate-300 font-bold text-[10px] uppercase tracking-widest">
                      Arabica Nguyên Bản
                    </div>
                  </div>
                  <div class="p-8 glass-card-deep rounded-3xl group hover:-translate-y-2 transition-transform">
                    <div class="text-amber-500 font-serif-majestic text-4xl mb-2">
                      Artisan
                    </div>
                    <div class="text-slate-300 font-bold text-[10px] uppercase tracking-widest">
                      Rang Củi Truyền Thống
                    </div>
                  </div>
                </div>
              </div>
              <div class="relative group" data-aos="zoom-in">
                <div
                  class="absolute -inset-4 bg-amber-500/10 blur-3xl rounded-full opacity-50 group-hover:opacity-100 transition-opacity">
                </div>
                <div class="relative aspect-[4/5] rounded-[4rem] overflow-hidden shadow-2xl">
                  <img
                    src="https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?q=80&w=2070&auto=format&fit=crop"
                    alt="Coffee Craft"
                    class="absolute inset-0 w-full h-full object-cover transition-transform duration-1000 group-hover:scale-110" />
                  <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent"></div>
                  <div class="absolute bottom-10 left-10 right-10">
                    <p class="text-white text-sm font-medium italic opacity-70">
                      "Nghệ thuật bắt nguồn từ sự tĩnh lặng và kiên nhẫn."
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </section>

          <!-- Features Grid (Bento Style) -->
          <section id="features" class="py-32 relative">
            <div class="max-w-7xl mx-auto px-6">
              <div class="text-center mb-24" data-aos="fade-up">
                <h2 class="text-5xl md:text-7xl font-serif-majestic text-white mb-6">
                  Trải Nghiệm
                  <span class="italic text-amber-glow">Không Giới Hạn</span>
                </h2>
                <p class="text-slate-400 text-xl max-w-2xl mx-auto font-light">
                  Tận hưởng tiện ích công nghệ đỉnh cao trong không gian đậm chất
                  thủ công.
                </p>
              </div>

              <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <!-- Large Feature -->
                <div data-aos="fade-up"
                  class="md:col-span-2 p-12 glass-card-deep rounded-[3rem] group relative overflow-hidden">
                  <div class="absolute top-0 right-0 p-10 opacity-10 group-hover:opacity-20 transition-opacity">
                    <i data-lucide="zap" class="w-48 h-48 text-amber-500"></i>
                  </div>
                  <div class="relative z-10 h-full flex flex-col justify-between min-h-[300px]">
                    <div>
                      <div
                        class="w-14 h-14 bg-amber-500/20 rounded-2xl flex items-center justify-center text-amber-500 mb-8 border border-amber-500/20">
                        <i data-lucide="zap" class="w-7 h-7"></i>
                      </div>
                      <h3 class="text-3xl font-serif-majestic text-white mb-4">
                        Tốc Độ & Chính Xác
                      </h3>
                      <p class="text-slate-400 text-lg max-w-md leading-relaxed">
                        Hệ thống gọi món tại bàn giúp bạn tận hưởng trọn vẹn từng
                        khoảnh khắc mà không cần chờ đợi lâu tại quầy.
                      </p>
                    </div>
                  </div>
                </div>

                <!-- Vertical Feature -->
                <div data-aos="fade-up" data-aos-delay="100"
                  class="p-12 glass-card-deep rounded-[3rem] flex flex-col justify-between">
                  <div>
                    <div
                      class="w-14 h-14 bg-blue-500/20 rounded-2xl flex items-center justify-center text-blue-400 mb-8 border border-blue-500/20">
                      <i data-lucide="bar-chart-3" class="w-7 h-7"></i>
                    </div>
                    <h3 class="text-3xl font-serif-majestic text-white mb-4">
                      Thống Kê <br />Thông Minh
                    </h3>
                    <p class="text-slate-400 leading-relaxed">
                      Theo dõi sở thích và thói quen thưởng thức để nhận những ưu
                      đãi riêng biệt.
                    </p>
                  </div>
                  <div class="mt-8 pt-8 border-t border-white/5">
                    <div class="flex items-center gap-3">
                      <div class="w-10 h-10 rounded-full bg-blue-500/10 flex items-center justify-center">
                        <i data-lucide="trending-up" class="w-4 h-4 text-blue-400"></i>
                      </div>
                      <span class="text-xs text-blue-400 font-bold uppercase tracking-widest">Tăng trải nghiệm người
                        dùng</span>
                    </div>
                  </div>
                </div>

                <!-- Small Feature -->
                <div data-aos="fade-up" data-aos-delay="200" class="p-12 glass-card-deep rounded-[3rem]">
                  <div
                    class="w-14 h-14 bg-emerald-500/20 rounded-2xl flex items-center justify-center text-emerald-400 mb-8 border border-emerald-500/20">
                    <i data-lucide="shield-check" class="w-7 h-7"></i>
                  </div>
                  <h3 class="text-3xl font-serif-majestic text-white mb-4">
                    An Tâm Tuyệt Đối
                  </h3>
                  <p class="text-slate-400 leading-relaxed">
                    Bảo mật giao dịch đa tầng, minh bạch trong từng hóa đơn và điểm
                    thưởng tích lũy.
                  </p>
                </div>

                <!-- Large Feature Image -->
                <div data-aos="fade-up" data-aos-delay="300"
                  class="md:col-span-2 rounded-[3rem] overflow-hidden relative group aspect-[21/9]">
                  <img
                    src="https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=2000&auto=format&fit=crop"
                    class="absolute inset-0 w-full h-full object-cover grayscale opacity-50 group-hover:grayscale-0 group-hover:scale-105 transition-all duration-700" />
                  <div class="absolute inset-0 bg-gradient-to-r from-black/80 to-transparent flex items-center px-12">
                    <div class="max-w-sm">
                      <h4 class="text-white text-2xl font-serif-majestic mb-4">
                        Chất Lượng Là Kim Chỉ Nam
                      </h4>
                      <p class="text-slate-400 text-sm">
                        Mọi quy trình đều hướng tới sự hài lòng của thực khách khó
                        tính nhất.
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </section>

          <!-- Testimonials -->
          <section id="reviews" class="py-32 relative bg-black/40">
            <div class="max-w-7xl mx-auto px-6">
              <div class="flex flex-col md:flex-row justify-between items-end mb-24 gap-8">
                <div data-aos="fade-right">
                  <span class="text-amber-500 font-bold uppercase tracking-[0.4em] text-xs mb-6 block">Tiếng nói cộng
                    đồng</span>
                  <h2 class="text-5xl md:text-7xl font-serif-majestic text-white leading-none">
                    Cảm hứng từ <br />
                    <span class="italic text-amber-glow">Sự Hài Lòng</span>.
                  </h2>
                </div>
              </div>

              <div class="grid grid-cols-1 md:grid-cols-3 gap-12">
                <!-- Review 1 -->
                <div data-aos="fade-up"
                  class="p-10 rounded-[3rem] glass-card-deep group hover:-translate-y-4 transition-all duration-500">
                  <div class="flex gap-1 mb-8 text-amber-500/40">
                    <i data-lucide="star" class="w-4 h-4 fill-amber-500"></i>
                    <i data-lucide="star" class="w-4 h-4 fill-amber-500"></i>
                    <i data-lucide="star" class="w-4 h-4 fill-amber-500"></i>
                    <i data-lucide="star" class="w-4 h-4 fill-amber-500"></i>
                    <i data-lucide="star" class="w-4 h-4 fill-amber-500"></i>
                  </div>
                  <p class="text-slate-300 text-xl mb-10 font-light italic leading-relaxed">
                    "Hương vị cà phê thực sự khác biệt, đậm đà và nguyên bản. Không
                    gian thiết kế tinh tế giúp mình giải tỏa mọi áp lực."
                  </p>
                  <div class="flex items-center gap-4 pt-8 border-t border-white/5">
                    <div
                      class="w-12 h-12 rounded-full bg-amber-500/20 overflow-hidden grayscale group-hover:grayscale-0 transition-all">
                      <img src="https://i.pravatar.cc/150?u=1" alt="User" />
                    </div>
                    <div>
                      <h4 class="font-bold text-white">Minh Anh</h4>
                      <p class="text-slate-500 text-[10px] uppercase tracking-widest">
                        Gourmet Lover
                      </p>
                    </div>
                  </div>
                </div>

                <!-- Review 2 -->
                <div data-aos="fade-up" data-aos-delay="100"
                  class="p-10 rounded-[3rem] glass-card-deep mt-12 md:mt-0 group hover:-translate-y-4 transition-all duration-500 border-amber-500/20">
                  <div class="flex gap-1 mb-8 text-amber-500/40">
                    <i data-lucide="star" class="w-4 h-4 fill-amber-500"></i>
                    <i data-lucide="star" class="w-4 h-4 fill-amber-500"></i>
                    <i data-lucide="star" class="w-4 h-4 fill-amber-500"></i>
                    <i data-lucide="star" class="w-4 h-4 fill-amber-500"></i>
                    <i data-lucide="star" class="w-4 h-4 fill-amber-500"></i>
                  </div>
                  <p class="text-slate-300 text-xl mb-10 font-light italic leading-relaxed">
                    "Hệ thống order tại bàn rất tiện lợi, không phải đợi lâu. Nhân
                    viên phục vụ chuyên nghiệp và cực kỳ thân thiện."
                  </p>
                  <div class="flex items-center gap-4 pt-8 border-t border-white/5">
                    <div
                      class="w-12 h-12 rounded-full bg-amber-500/20 overflow-hidden grayscale group-hover:grayscale-0 transition-all">
                      <img src="https://i.pravatar.cc/150?u=2" alt="User" />
                    </div>
                    <div>
                      <h4 class="font-bold text-white">Khánh Linh</h4>
                      <p class="text-slate-500 text-[10px] uppercase tracking-widest">
                        Tech Enthusiast
                      </p>
                    </div>
                  </div>
                </div>

                <!-- Review 3 -->
                <div data-aos="fade-up" data-aos-delay="200"
                  class="p-10 rounded-[3rem] glass-card-deep group hover:-translate-y-4 transition-all duration-500">
                  <div class="flex gap-1 mb-8 text-amber-500/40">
                    <i data-lucide="star" class="w-4 h-4 fill-amber-500"></i>
                    <i data-lucide="star" class="w-4 h-4 fill-amber-500"></i>
                    <i data-lucide="star" class="w-4 h-4 fill-amber-500"></i>
                    <i data-lucide="star" class="w-4 h-4 fill-amber-500"></i>
                    <i data-lucide="star" class="w-4 h-4 fill-amber-500"></i>
                  </div>
                  <p class="text-slate-300 text-xl mb-10 font-light italic leading-relaxed">
                    "Món Signature Cold Brew ở đây đỉnh thực sự. Rất phù hợp để ngồi
                    làm việc hoặc tiếp khách hàng đối tác."
                  </p>
                  <div class="flex items-center gap-4 pt-8 border-t border-white/5">
                    <div
                      class="w-12 h-12 rounded-full bg-amber-500/20 overflow-hidden grayscale group-hover:grayscale-0 transition-all">
                      <img src="https://i.pravatar.cc/150?u=3" alt="User" />
                    </div>
                    <div>
                      <h4 class="font-bold text-white">Tuấn Hải</h4>
                      <p class="text-slate-500 text-[10px] uppercase tracking-widest">
                        Digital Nomad
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </section>

          <!-- CTA Section -->
          <section class="py-48 relative overflow-hidden flex items-center justify-center">
            <div class="absolute inset-0 bg-black">
              <div
                class="absolute top-0 right-0 w-[80vw] h-[80vw] bg-amber-900/10 rounded-full blur-[120px] -translate-y-1/2 translate-x-1/2">
              </div>
              <div
                class="absolute bottom-0 left-0 w-[60vw] h-[60vw] bg-amber-600/5 rounded-full blur-[100px] translate-y-1/2 -translate-x-1/2">
              </div>
            </div>

            <div class="relative z-10 max-w-5xl mx-auto px-6 text-center" data-aos="zoom-in">
              <h2 class="text-6xl md:text-[8rem] font-serif-majestic text-white mb-16 leading-none tracking-tighter">
                Trải nghiệm <br />
                <span class="italic text-amber-glow">Sự Khác Biệt</span>.
              </h2>
              <div class="flex flex-col sm:flex-row gap-8 justify-center items-center">
                <a href="${pageContext.request.contextPath}/guest/order"
                  class="px-16 py-6 bg-amber-600 text-white rounded-full font-black text-2xl hover:bg-amber-500 hover:scale-110 transition-all shadow-[0_0_50px_rgba(217,119,6,0.2)]">
                  Đặt Món Ngay
                </a>
                <a href="#"
                  class="px-16 py-6 border border-white/20 text-white rounded-full font-bold text-xl hover:bg-white/10 transition-all backdrop-blur-md">
                  Hợp Tác Kinh Doanh
                </a>
              </div>
              <p class="mt-16 text-slate-500 text-sm uppercase tracking-[0.5em] font-bold">
                PolyCoffee &middot; Est 2026
              </p>
            </div>
          </section>
        </main>

        <div class="relative z-50 bg-slate-900">
          <jsp:include page="/views/common/footer.jsp" />
        </div>

        <script>
          lucide.createIcons();
          AOS.init({ duration: 1000, once: false, mirror: true });

          // Hero title scroll parallax (vanilla)
          const _heroTitle = document.getElementById('hero-title');
          if (_heroTitle) {
            window.addEventListener('scroll', () => {
              const prog = Math.min(1, window.scrollY / window.innerHeight);
              _heroTitle.style.transform = `translateY(${-prog * 50}px) scale(${1 - prog * 0.1})`;
              _heroTitle.style.opacity = 1 - prog * 0.5;
            }, { passive: true });
          }

          // Card tilt effect (vanilla)
          document.querySelectorAll('.glass-card-deep').forEach(card => {
            card.addEventListener('mouseenter', () => { card.style.transition = 'none'; });
            card.addEventListener('mousemove', e => {
              const r = card.getBoundingClientRect();
              const rotX = (e.clientY - r.top - r.height / 2) / 20;
              const rotY = (r.width / 2 - (e.clientX - r.left)) / 20;
              card.style.transform = `perspective(800px) rotateX(${rotX}deg) rotateY(${rotY}deg)`;
            });
            card.addEventListener('mouseleave', () => {
              card.style.transition = 'transform 0.5s ease-out';
              card.style.transform = 'perspective(800px) rotateX(0deg) rotateY(0deg)';
            });
          });

          // Lightweight Canvas 2D coffee scene (replaces Three.js + GSAP)
          const init3D = () => {
            const canvas = document.getElementById('canvas-3d');
            if (!canvas) return;
            const ctx = canvas.getContext('2d');

            const resize = () => {
              canvas.width = window.innerWidth;
              canvas.height = window.innerHeight;
            };
            resize();
            window.addEventListener('resize', resize, { passive: true });

            const getCfg = () => {
              const w = canvas.width, h = canvas.height;
              if (w < 640) return { cx: w * 0.5, bcy: h * 0.32, scale: 0.52, beanR: 100 };
              if (w < 1024) return { cx: w * 0.62, bcy: h * 0.34, scale: 0.75, beanR: 135 };
              return { cx: w * 0.73, bcy: h * 0.36, scale: 1.05, beanR: 165 };
            };
            let cfg = getCfg();
            window.addEventListener('resize', () => { cfg = getCfg(); }, { passive: true });

            let scrollY = 0;
            window.addEventListener('scroll', () => { scrollY = window.scrollY; }, { passive: true });

            // Stars
            const stars = Array.from({ length: 300 }, () => ({
              x: Math.random(), y: Math.random(),
              r: Math.random() * 1.1 + 0.2,
              a: 0.07 + Math.random() * 0.32,
              drift: (Math.random() - 0.5) * 0.00011
            }));

            // Coffee beans
            const beans = Array.from({ length: 14 }, (_, i) => ({
              angle: (i / 14) * Math.PI * 2,
              distMult: 0.88 + Math.random() * 0.38,
              yOff: (Math.random() - 0.5) * 0.1,
              speed: 0.0038 + Math.random() * 0.0032,
              size: 0.048 + Math.random() * 0.024,
              rot: Math.random() * Math.PI
            }));

            const drawBean = (x, y, s, rot) => {
              ctx.save();
              ctx.translate(x, y);
              ctx.rotate(rot);
              ctx.shadowColor = 'rgba(0,0,0,0.5)';
              ctx.shadowBlur = s * 0.4;
              const g = ctx.createRadialGradient(-s * 0.28, -s * 0.2, 0, 0, 0, s);
              g.addColorStop(0, '#8d6e63');
              g.addColorStop(0.65, '#5d4037');
              g.addColorStop(1, '#3e2723');
              ctx.fillStyle = g;
              ctx.beginPath();
              ctx.ellipse(0, 0, s, s * 0.62, 0, 0, Math.PI * 2);
              ctx.fill();
              ctx.shadowBlur = 0;
              ctx.beginPath();
              ctx.moveTo(-s * 0.75, 0);
              ctx.bezierCurveTo(-s * 0.25, -s * 0.28, s * 0.25, -s * 0.28, s * 0.75, 0);
              ctx.strokeStyle = 'rgba(25,8,4,0.72)';
              ctx.lineWidth = s * 0.13;
              ctx.stroke();
              ctx.restore();
            };

            const drawCup = (cx, cy, sc) => {
              const S = sc * 52;
              const rimR = S * 1.5;
              const botR = S * 0.78;
              const cupH = S * 2.78;
              const rimY = cy - S * 0.1;
              const botY = rimY + cupH;
              const saucerY = botY + S * 0.12;

              // Saucer
              ctx.save();
              ctx.shadowColor = 'rgba(0,0,0,0.65)';
              ctx.shadowBlur = S * 0.85;
              const sGrad = ctx.createLinearGradient(cx - S * 2.4, saucerY, cx + S * 2.4, saucerY);
              sGrad.addColorStop(0, '#141414');
              sGrad.addColorStop(0.42, '#2a2a2a');
              sGrad.addColorStop(0.58, '#303030');
              sGrad.addColorStop(1, '#0e0e0e');
              ctx.fillStyle = sGrad;
              ctx.beginPath();
              ctx.ellipse(cx, saucerY, S * 2.35, S * 0.3, 0, 0, Math.PI * 2);
              ctx.fill();
              ctx.restore();

              // Cup body
              ctx.save();
              ctx.shadowColor = 'rgba(245,158,11,0.1)';
              ctx.shadowBlur = S * 1.6;
              const bGrad = ctx.createLinearGradient(cx - rimR, 0, cx + rimR, 0);
              bGrad.addColorStop(0, '#111');
              bGrad.addColorStop(0.25, '#252525');
              bGrad.addColorStop(0.52, '#1c1c1c');
              bGrad.addColorStop(0.75, '#181818');
              bGrad.addColorStop(1, '#0a0a0a');
              ctx.fillStyle = bGrad;
              ctx.beginPath();
              ctx.moveTo(cx - botR, botY);
              ctx.lineTo(cx - rimR, rimY + S * 0.5);
              ctx.quadraticCurveTo(cx - rimR - S * 0.06, rimY + S * 0.2, cx - rimR + S * 0.04, rimY);
              ctx.lineTo(cx + rimR - S * 0.04, rimY);
              ctx.quadraticCurveTo(cx + rimR + S * 0.06, rimY + S * 0.2, cx + rimR, rimY + S * 0.5);
              ctx.lineTo(cx + botR, botY);
              ctx.closePath();
              ctx.fill();
              ctx.restore();

              // Rim ellipse
              ctx.save();
              const rGrad = ctx.createLinearGradient(cx - rimR, rimY - S * 0.22, cx + rimR, rimY + S * 0.22);
              rGrad.addColorStop(0, '#202020');
              rGrad.addColorStop(0.5, '#3c3c3c');
              rGrad.addColorStop(1, '#161616');
              ctx.fillStyle = rGrad;
              ctx.beginPath();
              ctx.ellipse(cx, rimY, rimR, S * 0.22, 0, 0, Math.PI * 2);
              ctx.fill();
              ctx.restore();

              // Coffee liquid
              ctx.save();
              const lGrad = ctx.createRadialGradient(cx - S * 0.3, rimY - S * 0.06, 0, cx, rimY, S * 1.2);
              lGrad.addColorStop(0, '#a07850');
              lGrad.addColorStop(0.4, '#6b4226');
              lGrad.addColorStop(1, '#1a0c07');
              ctx.fillStyle = lGrad;
              ctx.beginPath();
              ctx.ellipse(cx, rimY, rimR - S * 0.12, S * 0.18, 0, 0, Math.PI * 2);
              ctx.fill();
              // Crema highlight
              ctx.fillStyle = 'rgba(255,215,150,0.06)';
              ctx.beginPath();
              ctx.ellipse(cx - S * 0.35, rimY - S * 0.04, S * 0.45, S * 0.065, -0.3, 0, Math.PI * 2);
              ctx.fill();
              ctx.restore();

              // Handle
              ctx.save();
              ctx.shadowColor = 'rgba(0,0,0,0.4)';
              ctx.shadowBlur = S * 0.22;
              ctx.strokeStyle = '#181818';
              ctx.lineWidth = S * 0.19;
              ctx.lineCap = 'round';
              const hTop = rimY + cupH * 0.28;
              const hBot = rimY + cupH * 0.72;
              const hOut = cx + rimR + S * 0.95;
              ctx.beginPath();
              ctx.moveTo(cx + botR * 0.9, hTop);
              ctx.bezierCurveTo(hOut, hTop, hOut, hBot, cx + botR * 0.9, hBot);
              ctx.stroke();
              ctx.strokeStyle = '#2c2c2c';
              ctx.lineWidth = S * 0.08;
              ctx.shadowBlur = 0;
              ctx.beginPath();
              ctx.moveTo(cx + botR * 0.88, hTop + S * 0.04);
              ctx.bezierCurveTo(hOut - S * 0.1, hTop + S * 0.04, hOut - S * 0.1, hBot - S * 0.04, cx + botR * 0.88, hBot - S * 0.04);
              ctx.stroke();
              ctx.restore();
            };

            let t = 0;
            const animate = () => {
              requestAnimationFrame(animate);
              const W = canvas.width, H = canvas.height;
              ctx.clearRect(0, 0, W, H);
              t += 0.012;

              const rawProg = Math.min(1, scrollY / (H * 0.8));
              const gravProg = rawProg < 0.7
                ? (rawProg / 0.7) ** 2 * 0.7
                : 0.7 + ((rawProg - 0.7) / 0.3) * 0.3;

              // Stars
              stars.forEach(star => {
                star.x = ((star.x + star.drift) + 1) % 1;
                ctx.beginPath();
                ctx.arc(star.x * W, star.y * H, star.r, 0, Math.PI * 2);
                ctx.fillStyle = `rgba(245,158,11,${star.a})`;
                ctx.fill();
              });

              // Cup position
              const { cx, bcy, scale, beanR } = cfg;
              const floatY = Math.sin(t * 0.55) * 7;
              const cy = bcy + floatY + H * gravProg * 0.4;

              // Beans orbit
              beans.forEach(b => {
                b.angle += b.speed * (1 - gravProg * 0.5);
                b.rot += 0.011;
                const bx = cx + Math.cos(b.angle) * beanR * b.distMult;
                const by = cy + b.yOff * H + Math.sin(t + b.angle) * 11;
                drawBean(bx, by, b.size * (scale * 52), b.rot);
              });

              drawCup(cx, cy, scale);
            };
            animate();
          };

          window.onload = () => { init3D(); };
        </script>
      </body>

      </html>