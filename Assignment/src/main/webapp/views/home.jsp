<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib uri="jakarta.tags.core" prefix="c" %> <%@
taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<fmt:setLocale value="${empty sessionScope.lang ? 'vi' : sessionScope.lang}" />
<fmt:setBundle basename="messages" />

<!DOCTYPE html>
<html
  lang="${empty sessionScope.lang ? 'vi' : sessionScope.lang}"
  class="h-full scroll-smooth"
>
  <head>
    <title><fmt:message key="app.name" /> - PolyCoffee</title>
    <jsp:include page="/views/common/head.jsp" />
    <script src="https://unpkg.com/lucide@latest"></script>
    <!-- Animation Libraries -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet" />
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/3.2.1/anime.min.js"></script>
    <!-- Three.js for 3D -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
  </head>

  <body
    class="bg-white font-sans min-h-screen flex flex-col overflow-x-hidden selection:bg-coffee-200 selection:text-coffee-900 text-slate-900 antialiased"
  >
    <!-- 3D Background Canvas -->
    <div data-aos="zoom-in" data-aos-delay="100">
      <canvas
        id="canvas-3d"
        class="fixed inset-0 pointer-events-none z-0"
      ></canvas>
    </div>

    <!-- Premium Background Effects -->
    <div class="fixed inset-0 pointer-events-none overflow-hidden z-[1]">
      <div
        class="absolute -top-[10%] -left-[10%] w-[50vw] h-[50vh] bg-coffee-100/40 rounded-full blur-[120px] mix-blend-multiply"
      ></div>
      <div
        class="absolute top-[30%] -right-[10%] w-[40vw] h-[60vh] bg-orange-50/50 rounded-full blur-[100px] mix-blend-multiply"
      ></div>
    </div>

    <div
      class="relative z-50 shadow-sm border-b border-gray-100/50 bg-white/80 backdrop-blur-xl"
    >
      <jsp:include page="/views/common/header.jsp" />
    </div>

    <main class="flex-grow flex flex-col relative z-20">
      <!-- Hero Section -->
      <section
        class="max-w-[85rem] mx-auto px-6 py-24 md:py-48 w-full flex flex-col items-center text-center relative overflow-hidden"
      >
        <div
          class="absolute inset-0 bg-[url('https://grainy-gradients.vercel.app/noise.svg')] opacity-20 mix-blend-overlay pointer-events-none"
        ></div>

        <!-- <div
          data-aos="fade-down"
          class="inline-flex items-center gap-2 bg-gradient-to-r from-coffee-50 to-orange-50 border border-coffee-200/50 px-5 py-2 rounded-full text-coffee-700 text-xs font-black mb-10 shadow-sm uppercase tracking-widest cursor-default hover:scale-105 transition-transform"
        >
          Trải nghiệm Phục vụ Cà phê Hiện đại
        </div> -->

        <h1
          data-aos="fade-up"
          data-aos-delay="100"
          class="text-6xl md:text-[6.5rem] font-black text-slate-900 mb-8 leading-[1.05] tracking-tighter"
        >
          Nâng Tầm Kết Nối <br />
          Đậm Vị
          <span
            class="bg-gradient-to-r from-coffee-600 to-orange-500 bg-clip-text text-transparent drop-shadow-sm"
            >Sáng Tạo</span
          >.
        </h1>

        <p
          data-aos="fade-up"
          data-aos-delay="400"
          class="text-slate-500 text-xl max-w-2xl mx-auto mb-14 leading-relaxed font-medium"
        >
          Sự hòa quyện giữa hương vị truyền thống và nền tảng công nghệ số, mang
          đến trải nghiệm thưởng thức cà phê tinh tế bậc nhất.
        </p>

        <div
          data-aos="fade-up"
          data-aos-delay="600"
          class="flex flex-col sm:flex-row gap-5 justify-center items-center w-full sm:w-auto"
        >
          <c:choose>
            <c:when test="${empty sessionScope.user}">
              <a
                href="${pageContext.request.contextPath}/guest/order"
                class="group relative inline-flex items-center justify-center gap-3 bg-slate-900 text-white px-10 py-4 rounded-2xl font-bold shadow-[0_8px_30px_rgb(15,23,42,0.2)] hover:shadow-[0_8px_30px_rgb(15,23,42,0.3)] hover:-translate-y-1 transition-all duration-300 w-full sm:w-auto text-lg overflow-hidden"
              >
                <div
                  class="absolute inset-0 w-full h-full bg-gradient-to-r from-transparent via-white/10 to-transparent -translate-x-[150%] skew-x-[-20deg] group-hover:animate-[shimmer_1.5s_infinite]"
                ></div>
                <span>Bắt Đầu Thưởng Thức</span>
                <i
                  data-lucide="arrow-right"
                  class="w-5 h-5 group-hover:translate-x-1 transition-transform"
                ></i>
              </a>
            </c:when>
            <c:otherwise>
              <a
                href="${pageContext.request.contextPath}/employee/pos"
                class="group relative inline-flex items-center justify-center gap-3 bg-slate-900 text-white px-10 py-4 rounded-2xl font-bold shadow-[0_8px_30px_rgb(15,23,42,0.2)] hover:shadow-[0_8px_30px_rgb(15,23,42,0.3)] hover:-translate-y-1 transition-all duration-300 w-full sm:w-auto text-lg overflow-hidden"
              >
                <div
                  class="absolute inset-0 w-full h-full bg-gradient-to-r from-transparent via-white/10 to-transparent -translate-x-[150%] skew-x-[-20deg] group-hover:animate-[shimmer_1.5s_infinite]"
                ></div>
                <span>Truy Cập Hệ Thống POS</span>
                <i
                  data-lucide="layout-dashboard"
                  class="w-5 h-5 group-hover:scale-110 transition-transform"
                ></i>
              </a>
            </c:otherwise>
          </c:choose>
          <a
            href="#about"
            class="group bg-white hover:bg-slate-50 text-slate-700 border border-gray-200 px-10 py-4 rounded-2xl font-bold shadow-sm hover:shadow-md transition-all duration-300 flex items-center justify-center gap-2 w-full sm:w-auto text-lg hover:-translate-y-0.5"
          >
            Câu Chuyện PolyCoffee
            <i
              data-lucide="chevron-down"
              class="w-5 h-5 text-slate-400 group-hover:translate-y-1 transition-transform"
            ></i>
          </a>
        </div>

        <div
          class="mt-20 flex items-center justify-center gap-8 opacity-60 grayscale filter hover:grayscale-0 transition-all duration-500"
        >
          <i data-lucide="coffee" class="w-8 h-8 text-coffee-600"></i>
          <i data-lucide="croissant" class="w-8 h-8 text-amber-600"></i>
          <i data-lucide="cup-soda" class="w-8 h-8 text-rose-500"></i>
        </div>
      </section>

      <!-- About Section -->
      <section id="about" class="py-24 relative overflow-hidden">
        <div
          class="max-w-7xl mx-auto px-6 grid md:grid-cols-2 gap-16 items-center"
        >
          <div data-aos="fade-right">
            <span
              class="text-coffee-600 font-black uppercase tracking-[0.2em] text-sm mb-4 block"
              >Hành trình hương vị</span
            >
            <h2
              class="text-4xl md:text-5xl font-black text-slate-900 mb-8 leading-tight"
            >
              Cội nguồn của từng hạt cà phê tinh tuyển.
            </h2>
            <p class="text-slate-500 text-lg mb-8 leading-relaxed font-medium">
              Chúng tôi tin rằng mỗi tách cà phê không chỉ là thức uống, mà là
              một tác phẩm nghệ thuật khởi nguồn từ những vùng cao nguyên trù
              phú. Từng công đoạn từ canh tác đến rang xay đều được kiểm soát
              nghiêm ngặt bằng công nghệ hiện đại.
            </p>
            <div class="grid grid-cols-2 gap-6">
              <div
                class="p-6 bg-coffee-50/50 rounded-2xl border border-coffee-100"
              >
                <div class="text-coffee-600 font-black text-3xl mb-2">100%</div>
                <div class="text-slate-600 font-bold text-sm uppercase">
                  Nguyên bản
                </div>
              </div>
              <div
                class="p-6 bg-orange-50/50 rounded-2xl border border-orange-100"
              >
                <div class="text-orange-600 font-black text-3xl mb-2">24/7</div>
                <div class="text-slate-600 font-bold text-sm uppercase">
                  Phục vụ tận tâm
                </div>
              </div>
            </div>
          </div>
          <div
            class="relative h-[400px] md:h-[600px] rounded-[3rem] overflow-hidden group shadow-2xl"
            data-aos="zoom-in"
            data-aos-delay="200"
          >
            <img
              src="https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?q=80&w=2070&auto=format&fit=crop"
              alt="Coffee Craft"
              class="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
            />
            <div
              class="absolute inset-0 bg-gradient-to-t from-slate-900/40 to-transparent"
            ></div>
          </div>
        </div>
      </section>

      <!-- Features Grid -->
      <section
        id="features"
        class="bg-slate-50 py-32 border-y border-gray-100 relative"
      >
        <div class="max-w-7xl mx-auto px-6 h-full flex flex-col items-center">
          <div class="text-center mb-24" data-aos="fade-up">
            <h2
              class="text-4xl md:text-6xl font-black text-slate-900 mb-6 tracking-tight"
            >
              Công Nghệ Đi Đầu
            </h2>
            <p class="text-slate-500 text-xl max-w-2xl mx-auto font-medium">
              Một hệ sinh thái thông minh, an toàn và tinh tế, giúp bạn kết nối
              với khách hàng theo cách hoàn toàn mới.
            </p>
          </div>

          <div class="grid grid-cols-1 md:grid-cols-3 gap-10 w-full">
            <!-- Feature 1 -->
            <div
              data-aos="fade-up"
              data-aos-delay="100"
              class="bg-white p-12 rounded-[2.5rem] border border-gray-100 shadow-[0_4px_20px_rgb(0,0,0,0.02)] hover:shadow-[0_20px_60px_rgb(0,0,0,0.08)] hover:-translate-y-2 transition-all duration-500 group"
            >
              <div
                class="w-16 h-16 bg-gradient-to-br from-amber-100 to-amber-50 rounded-2xl flex items-center justify-center text-amber-600 mb-10 border border-amber-100/50 group-hover:scale-110 group-hover:rotate-6 transition-transform"
              >
                <i data-lucide="zap" class="w-8 h-8 fill-amber-500/20"></i>
              </div>
              <h3
                class="text-2xl font-black text-slate-900 mb-5 tracking-tight"
              >
                Tốc Độ Phản Hồi
              </h3>
              <p class="text-slate-500 leading-relaxed font-semibold">
                Tối ưu hóa quy trình order chỉ trong 3 bước, giúp nhân viên phục
                vụ nhanh chóng ngay cả giờ cao điểm.
              </p>
            </div>

            <!-- Feature 2 -->
            <div
              data-aos="fade-up"
              data-aos-delay="200"
              class="bg-white p-12 rounded-[2.5rem] border border-gray-100 shadow-[0_4px_20px_rgb(0,0,0,0.02)] hover:shadow-[0_20px_60px_rgb(0,0,0,0.08)] hover:-translate-y-2 transition-all duration-500 group"
            >
              <div
                class="w-16 h-16 bg-gradient-to-br from-blue-100 to-blue-50 rounded-2xl flex items-center justify-center text-blue-600 mb-10 border border-blue-100/50 group-hover:scale-110 group-hover:rotate-6 transition-transform"
              >
                <i
                  data-lucide="bar-chart-3"
                  class="w-8 h-8 fill-blue-500/20"
                ></i>
              </div>
              <h3
                class="text-2xl font-black text-slate-900 mb-5 tracking-tight"
              >
                Dữ Liệu Thời Gian Thực
              </h3>
              <p class="text-slate-500 leading-relaxed font-semibold">
                Báo cáo doanh số và tồn kho được cập nhật ngay lập tức, hỗ trợ
                đưa ra các quyết định kinh doanh chính xác.
              </p>
            </div>

            <!-- Feature 3 -->
            <div
              data-aos="fade-up"
              data-aos-delay="300"
              class="bg-white p-12 rounded-[2.5rem] border border-gray-100 shadow-[0_4px_20px_rgb(0,0,0,0.02)] hover:shadow-[0_20px_60px_rgb(0,0,0,0.08)] hover:-translate-y-2 transition-all duration-500 group"
            >
              <div
                class="w-16 h-16 bg-gradient-to-br from-emerald-100 to-emerald-50 rounded-2xl flex items-center justify-center text-emerald-600 mb-10 border border-emerald-100/50 group-hover:scale-110 group-hover:rotate-6 transition-transform"
              >
                <i
                  data-lucide="shield-check"
                  class="w-8 h-8 fill-emerald-500/20"
                ></i>
              </div>
              <h3
                class="text-2xl font-black text-slate-900 mb-5 tracking-tight"
              >
                An Toàn Tuyệt Đối
              </h3>
              <p class="text-slate-500 leading-relaxed font-semibold">
                Hệ thống phân quyền chi tiết và lớp bảo mật đa tầng, đảm bảo mọi
                giao dịch đều minh bạch và an toàn.
              </p>
            </div>
          </div>
        </div>
      </section>

      <!-- Testimonials Section -->
      <section id="reviews" class="py-24 bg-white relative">
        <div class="max-w-7xl mx-auto px-6">
          <div
            class="flex flex-col md:flex-row justify-between items-end mb-16 gap-8"
          >
            <div data-aos="fade-right">
              <span
                class="text-coffee-600 font-black uppercase tracking-[0.2em] text-sm mb-4 block"
                >Đánh giá khách hàng</span
              >
              <h2
                class="text-4xl md:text-5xl font-black text-slate-900 leading-tight"
              >
                Cảm hứng từ <br />
                cộng đồng yêu cà phê.
              </h2>
            </div>
            <div data-aos="fade-left" class="flex gap-4">
              <button
                class="w-12 h-12 rounded-full border border-gray-200 flex items-center justify-center hover:bg-slate-50 transition-colors shadow-sm"
              >
                <i
                  data-lucide="chevron-left"
                  class="w-6 h-6 text-slate-400"
                ></i>
              </button>
              <button
                class="w-12 h-12 rounded-full bg-slate-900 flex items-center justify-center hover:bg-slate-800 transition-colors shadow-lg"
              >
                <i data-lucide="chevron-right" class="w-6 h-6 text-white"></i>
              </button>
            </div>
          </div>

          <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <!-- Review 1 -->
            <div
              data-aos="fade-up"
              data-aos-delay="100"
              class="p-8 rounded-[2.5rem] bg-slate-50 border border-slate-100 hover:bg-white hover:shadow-xl transition-all duration-500 group"
            >
              <div class="flex gap-1 mb-6 text-amber-500">
                <i data-lucide="star" class="w-5 h-5 fill-amber-500"></i>
                <i data-lucide="star" class="w-5 h-5 fill-amber-500"></i>
                <i data-lucide="star" class="w-5 h-5 fill-amber-500"></i>
                <i data-lucide="star" class="w-5 h-5 fill-amber-500"></i>
                <i data-lucide="star" class="w-5 h-5 fill-amber-500"></i>
              </div>
              <p class="text-slate-600 text-lg mb-8 font-medium italic">
                "Hương vị cà phê thực sự khác biệt, đậm đà và nguyên bản. Không
                gian thiết kế tinh tế giúp mình giải tỏa mọi áp lực sau giờ
                làm."
              </p>
              <div class="flex items-center gap-4">
                <div
                  class="w-12 h-12 rounded-full bg-coffee-200 overflow-hidden"
                >
                  <img src="https://i.pravatar.cc/150?u=1" alt="User" />
                </div>
                <div>
                  <h4 class="font-black text-slate-900">Minh Anh</h4>
                  <p class="text-slate-400 text-sm">Gourmet Lover</p>
                </div>
              </div>
            </div>

            <!-- Review 2 -->
            <div
              data-aos="fade-up"
              data-aos-delay="200"
              class="p-8 rounded-[2.5rem] bg-slate-50 border border-slate-100 hover:bg-white hover:shadow-xl transition-all duration-500 group"
            >
              <div class="flex gap-1 mb-6 text-amber-500">
                <i data-lucide="star" class="w-5 h-5 fill-amber-500"></i>
                <i data-lucide="star" class="w-5 h-5 fill-amber-500"></i>
                <i data-lucide="star" class="w-5 h-5 fill-amber-500"></i>
                <i data-lucide="star" class="w-5 h-5 fill-amber-500"></i>
                <i data-lucide="star" class="w-5 h-5 fill-amber-500"></i>
              </div>
              <p class="text-slate-600 text-lg mb-8 font-medium italic">
                "Hệ thống order tại bàn rất tiện lợi, không phải đợi lâu. Nhân
                viên phục vụ chuyên nghiệp và cực kỳ thân thiện."
              </p>
              <div class="flex items-center gap-4">
                <div
                  class="w-12 h-12 rounded-full bg-coffee-200 overflow-hidden"
                >
                  <img src="https://i.pravatar.cc/150?u=2" alt="User" />
                </div>
                <div>
                  <h4 class="font-black text-slate-900">Khánh Linh</h4>
                  <p class="text-slate-400 text-sm">Tech Enthusiast</p>
                </div>
              </div>
            </div>

            <!-- Review 3 -->
            <div
              data-aos="fade-up"
              data-aos-delay="300"
              class="p-8 rounded-[2.5rem] bg-slate-50 border border-slate-100 hover:bg-white hover:shadow-xl transition-all duration-500 group"
            >
              <div class="flex gap-1 mb-6 text-amber-500">
                <i data-lucide="star" class="w-5 h-5 fill-amber-500"></i>
                <i data-lucide="star" class="w-5 h-5 fill-amber-500"></i>
                <i data-lucide="star" class="w-5 h-5 fill-amber-500"></i>
                <i data-lucide="star" class="w-5 h-5 fill-amber-500"></i>
                <i data-lucide="star" class="w-5 h-5 fill-amber-500"></i>
              </div>
              <p class="text-slate-600 text-lg mb-8 font-medium italic">
                "Món Signature Cold Brew ở đây đỉnh thực sự. Rất phù hợp để ngồi
                làm việc hoặc tiếp khách hàng đối tác."
              </p>
              <div class="flex items-center gap-4">
                <div
                  class="w-12 h-12 rounded-full bg-coffee-200 overflow-hidden"
                >
                  <img src="https://i.pravatar.cc/150?u=3" alt="User" />
                </div>
                <div>
                  <h4 class="font-black text-slate-900">Tuấn Hải</h4>
                  <p class="text-slate-400 text-sm">Digital Nomad</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- CTA Section -->
      <section
        class="py-32 relative overflow-hidden flex items-center justify-center"
      >
        <div class="absolute inset-0 bg-slate-900 overflow-hidden">
          <div
            class="absolute top-0 right-0 w-[60vw] h-[60vw] bg-coffee-800/20 rounded-full blur-[120px] -translate-y-1/2 translate-x-1/2"
          ></div>
          <div
            class="absolute bottom-0 left-0 w-[40vw] h-[40vw] bg-orange-800/20 rounded-full blur-[100px] translate-y-1/2 -translate-x-1/2"
          ></div>
        </div>

        <div
          class="relative z-10 max-w-4xl mx-auto px-6 text-center"
          data-aos="zoom-in"
        >
          <h2
            class="text-5xl md:text-7xl font-black text-white mb-10 leading-none"
          >
            Cùng viết tiếp câu chuyện <br />
            của bạn.
          </h2>
          <div class="flex flex-col sm:flex-row gap-6 justify-center">
            <a
              href="${pageContext.request.contextPath}/guest/order"
              class="px-12 py-4 bg-white text-slate-900 rounded-2xl font-black text-xl hover:scale-105 transition-transform shadow-xl"
            >
              Đặt Món Ngay
            </a>
            <a
              href="#"
              class="px-12 py-4 border-2 border-white/20 text-white rounded-2xl font-black text-xl hover:bg-white/10 transition-colors"
            >
              Liên Hệ Hợp Tác
            </a>
          </div>
        </div>
      </section>
    </main>

    <div class="relative z-50 bg-slate-900">
      <jsp:include page="/views/common/footer.jsp" />
    </div>

    <style>
      body {
        scroll-behavior: smooth;
      }
      @keyframes shimmer {
        0% {
          transform: translateX(-150%) skewX(-20deg);
        }
        100% {
          transform: translateX(200%) skewX(-20deg);
        }
      }
      canvas {
        display: block;
      }
    </style>

    <script>
      // Initialize Libraries
      lucide.createIcons();
      AOS.init({
        duration: 1000,
        once: false,
        mirror: true,
      });

      // --- 3D Coffee Scene (Three.js + AnimeJS) ---
      const init3D = () => {
        const canvas = document.getElementById("canvas-3d");

        // ── Scene ─────────────────────────────────────────────────────────
        const scene = new THREE.Scene();
        scene.fog = new THREE.FogExp2(0x06020a, 0.026);

        const camera = new THREE.PerspectiveCamera(
          55, window.innerWidth / window.innerHeight, 0.1, 200,
        );
        const renderer = new THREE.WebGLRenderer({ canvas, alpha: true, antialias: true });
        renderer.shadowMap.enabled = true;
        renderer.shadowMap.type = THREE.PCFSoftShadowMap;
        renderer.toneMapping = THREE.ACESFilmicToneMapping;
        renderer.toneMappingExposure = 1.1;

        // ── Responsive config ─────────────────────────────────────────────
        const getConfig = () => {
          const w = window.innerWidth;
          if (w < 640)  return { camZ: 14, startX:  0.0, startY: -1.2, landX:  0.0, landY: -5.5, scale: 0.52, beanDist: 2.6 };
          if (w < 1024) return { camZ: 13, startX:  1.6, startY:  0.5, landX:  2.8, landY: -5.0, scale: 0.78, beanDist: 3.2 };
                        return { camZ: 11, startX:  3.2, startY:  0.8, landX:  4.8, landY: -5.5, scale: 1.00, beanDist: 3.8 };
        };
        let cfg = getConfig();

        camera.position.set(0, 2.5, cfg.camZ);
        camera.lookAt(0, 0, 0);
        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));

        // ── Latte-art canvas texture ──────────────────────────────────────
        const latteCanvas = document.createElement("canvas");
        latteCanvas.width = latteCanvas.height = 512;
        const lc = latteCanvas.getContext("2d");
        lc.fillStyle = "#060200";
        lc.fillRect(0, 0, 512, 512);

        const cremaGrad = lc.createRadialGradient(256, 256, 8, 256, 256, 248);
        cremaGrad.addColorStop(0,    "rgba(210,135,42,1)");
        cremaGrad.addColorStop(0.28, "rgba(155,82,22,1)");
        cremaGrad.addColorStop(0.62, "rgba(75,32,8,1)");
        cremaGrad.addColorStop(1,    "rgba(14,5,1,0)");
        lc.fillStyle = cremaGrad;
        lc.beginPath(); lc.arc(256, 256, 248, 0, Math.PI * 2); lc.fill();

        for (let i = 0; i < 10; i++) {
          const a = (i / 10) * Math.PI * 2;
          const cx = 256 + Math.cos(a) * 95, cy = 256 + Math.sin(a) * 95;
          const lg = lc.createRadialGradient(cx, cy, 0, cx, cy, 40);
          lg.addColorStop(0,   "rgba(255,238,185,0.8)");
          lg.addColorStop(0.5, "rgba(195,140,70,0.35)");
          lg.addColorStop(1,   "rgba(150,95,30,0)");
          lc.fillStyle = lg;
          lc.beginPath(); lc.ellipse(cx, cy, 32, 18, a + Math.PI / 2, 0, Math.PI * 2); lc.fill();
        }
        lc.beginPath();
        lc.strokeStyle = "rgba(245,210,155,0.55)"; lc.lineWidth = 2.2;
        for (let t = 0.15; t < Math.PI * 5; t += 0.04) {
          const r = 18 * t * 0.22;
          const x = 256 + r * Math.cos(-t), y = 256 + r * Math.sin(-t);
          t < 0.2 ? lc.moveTo(x, y) : lc.lineTo(x, y);
        }
        lc.stroke();
        const cg = lc.createRadialGradient(256, 256, 0, 256, 256, 55);
        cg.addColorStop(0, "rgba(255,245,210,0.55)"); cg.addColorStop(1, "rgba(0,0,0,0)");
        lc.fillStyle = cg; lc.beginPath(); lc.arc(256, 256, 55, 0, Math.PI * 2); lc.fill();
        const latteTexture = new THREE.CanvasTexture(latteCanvas);

        // ── Materials ─────────────────────────────────────────────────────
        const ceramicMat = new THREE.MeshPhysicalMaterial({
          color: 0xf8f5f0, roughness: 0.06, metalness: 0.0,
          clearcoat: 1.0, clearcoatRoughness: 0.03, reflectivity: 0.9,
        });
        const beanMat = new THREE.MeshPhysicalMaterial({
          color: 0x221004, roughness: 0.48, metalness: 0.04,
          clearcoat: 0.4, clearcoatRoughness: 0.18,
        });

        // ── Cup group ─────────────────────────────────────────────────────
        const cupGroup = new THREE.Group();

        const cupPts = [
          new THREE.Vector2(0.00, 0.00), new THREE.Vector2(0.78, 0.00),
          new THREE.Vector2(0.85, 0.06), new THREE.Vector2(0.91, 0.20),
          new THREE.Vector2(1.00, 0.50), new THREE.Vector2(1.13, 1.05),
          new THREE.Vector2(1.25, 1.60), new THREE.Vector2(1.35, 2.10),
          new THREE.Vector2(1.42, 2.50), new THREE.Vector2(1.46, 2.68),
          new THREE.Vector2(1.50, 2.74), new THREE.Vector2(1.54, 2.78),
          new THREE.Vector2(1.46, 2.78), new THREE.Vector2(1.38, 2.70),
        ];
        const cupMesh = new THREE.Mesh(new THREE.LatheGeometry(cupPts, 128), ceramicMat);
        cupMesh.castShadow = true; cupMesh.position.y = -1.39;
        cupGroup.add(cupMesh);

        const hCurve = new THREE.QuadraticBezierCurve3(
          new THREE.Vector3(1.43, 0.92, 0), new THREE.Vector3(2.32, 0.50, 0), new THREE.Vector3(1.43, -0.10, 0),
        );
        const handleMesh = new THREE.Mesh(new THREE.TubeGeometry(hCurve, 48, 0.092, 16, false), ceramicMat);
        handleMesh.castShadow = true; cupGroup.add(handleMesh);

        const liquidMesh = new THREE.Mesh(
          new THREE.CircleGeometry(1.34, 128),
          new THREE.MeshPhysicalMaterial({ map: latteTexture, roughness: 0.04, metalness: 0.04, reflectivity: 0.92 }),
        );
        liquidMesh.rotation.x = -Math.PI / 2; liquidMesh.position.y = 1.38;
        cupGroup.add(liquidMesh);

        const sPts = [
          new THREE.Vector2(0.00, 0.00), new THREE.Vector2(0.52, 0.00),
          new THREE.Vector2(0.82, 0.07), new THREE.Vector2(1.12, 0.17),
          new THREE.Vector2(1.48, 0.13), new THREE.Vector2(2.08, 0.05),
          new THREE.Vector2(2.62, 0.00), new THREE.Vector2(2.92, 0.13),
          new THREE.Vector2(3.12, 0.29), new THREE.Vector2(3.20, 0.40),
          new THREE.Vector2(3.12, 0.42), new THREE.Vector2(2.92, 0.33),
        ];
        const saucerMesh = new THREE.Mesh(new THREE.LatheGeometry(sPts, 128), ceramicMat);
        saucerMesh.castShadow = true; saucerMesh.receiveShadow = true; saucerMesh.position.y = -1.39;
        cupGroup.add(saucerMesh);

        scene.add(cupGroup);

        // ── Coffee beans ──────────────────────────────────────────────────
        const beans = [];
        for (let i = 0; i < 14; i++) {
          const geo = new THREE.SphereGeometry(0.19, 16, 12);
          geo.applyMatrix4(new THREE.Matrix4().makeScale(1, 0.58, 0.46));
          const bean = new THREE.Mesh(geo, beanMat);
          const angle = (i / 14) * Math.PI * 2;
          const dist  = cfg.beanDist + Math.random() * 1.4;
          const ht    = (Math.random() - 0.5) * 4;
          bean.position.set(Math.cos(angle) * dist, ht, Math.sin(angle) * dist * 0.55 - 1);
          bean.rotation.set(Math.random() * Math.PI, angle, Math.random() * Math.PI);
          bean.userData = {
            angle, dist, ht,
            speed: 0.003 + Math.random() * 0.004,
            bobAmp: 0.14 + Math.random() * 0.18,
            bobFreq: 0.5 + Math.random() * 0.9,
            phase: Math.random() * Math.PI * 2,
          };
          scene.add(bean); beans.push(bean);
          bean.scale.set(0, 0, 0);
          anime({ targets: bean.scale, x: 1, y: 1, z: 1, duration: 700, delay: 300 + i * 70, easing: "easeOutBack" });
        }

        // ── Steam sprites ─────────────────────────────────────────────────
        const steamSprite = (() => {
          const sc = document.createElement("canvas"); sc.width = sc.height = 64;
          const sx = sc.getContext("2d");
          const g = sx.createRadialGradient(32, 32, 0, 32, 32, 32);
          g.addColorStop(0, "rgba(255,255,255,1)"); g.addColorStop(0.4, "rgba(255,255,255,0.3)"); g.addColorStop(1, "rgba(255,255,255,0)");
          sx.fillStyle = g; sx.beginPath(); sx.arc(32, 32, 32, 0, Math.PI * 2); sx.fill();
          return new THREE.CanvasTexture(sc);
        })();

        const steamParticles = [];
        for (let i = 0; i < 36; i++) {
          const mat = new THREE.SpriteMaterial({ map: steamSprite, transparent: true, opacity: 0, blending: THREE.AdditiveBlending, depthWrite: false });
          const sp = new THREE.Sprite(mat);
          const sc = 0.14 + Math.random() * 0.26;
          sp.scale.set(sc, sc, 1);
          const sx = (Math.random() - 0.5) * 0.85, sy = 1.55 + Math.random() * 0.55;
          sp.position.set(sx, sy, (Math.random() - 0.5) * 0.85);
          sp.userData = { sx, sy, rise: 0.007 + Math.random() * 0.009, swayAmp: 0.003 + Math.random() * 0.005, swayFreq: 1.0 + Math.random() * 1.4, phase: Math.random() * Math.PI * 2 };
          cupGroup.add(sp); steamParticles.push(sp);
          anime({ targets: mat, opacity: [{ value: 0, duration: 0 }, { value: 0.38, duration: 550 + Math.random() * 400 }, { value: 0, duration: 1100 + Math.random() * 700 }], delay: Math.random() * 2600, loop: true, easing: "easeInOutSine" });
        }

        // ── Particle starfield ────────────────────────────────────────────
        const bgCount = 900;
        const bgPos = new Float32Array(bgCount * 3), bgCol = new Float32Array(bgCount * 3);
        for (let i = 0; i < bgCount; i++) {
          bgPos[i*3] = (Math.random()-0.5)*80; bgPos[i*3+1] = (Math.random()-0.5)*50; bgPos[i*3+2] = (Math.random()-0.5)*40-15;
          const t = Math.random();
          bgCol[i*3] = 0.38+t*0.38; bgCol[i*3+1] = 0.18+t*0.18; bgCol[i*3+2] = 0.04+t*0.04;
        }
        const bgGeo = new THREE.BufferGeometry();
        bgGeo.setAttribute("position", new THREE.BufferAttribute(bgPos, 3));
        bgGeo.setAttribute("color",    new THREE.BufferAttribute(bgCol, 3));
        const bgMesh = new THREE.Points(bgGeo, new THREE.PointsMaterial({ size: 0.055, vertexColors: true, transparent: true, opacity: 0.55, blending: THREE.AdditiveBlending, depthWrite: false, sizeAttenuation: true }));
        scene.add(bgMesh);

        // ── Lighting ──────────────────────────────────────────────────────
        scene.add(new THREE.AmbientLight(0xfff3e0, 0.5));
        const key = new THREE.SpotLight(0xffffff, 3.6);
        key.position.set(7, 16, 11); key.angle = Math.PI / 6.5; key.penumbra = 0.4;
        key.castShadow = true; key.shadow.mapSize.width = key.shadow.mapSize.height = 2048;
        scene.add(key);
        const fill = new THREE.PointLight(0xff9050, 1.3); fill.position.set(-11, 3, 9); scene.add(fill);
        const rim  = new THREE.DirectionalLight(0xffc875, 1.8); rim.position.set(-5, 12, -13); scene.add(rim);
        const under = new THREE.PointLight(0xff6622, 0.45); under.position.set(0, -9, 5); scene.add(under);

        // ── AnimeJS entry spin-in ─────────────────────────────────────────
        cupGroup.scale.setScalar(0.01);
        cupGroup.rotation.y = -Math.PI * 1.5;
        anime.timeline({ easing: "easeOutExpo" })
          .add({ targets: cupGroup.scale,    x: cfg.scale, y: cfg.scale, z: cfg.scale, duration: 1600 })
          .add({ targets: cupGroup.rotation, y: 0,                                     duration: 1600 }, 0);

        // AnimeJS idle float (drives base Y)
        const fl = { y: cfg.startY };
        anime({ targets: fl, y: [cfg.startY - 0.25, cfg.startY + 0.25], duration: 3400, direction: "alternate", loop: true, easing: "easeInOutSine" });

        // ── Scroll / mouse state ──────────────────────────────────────────
        let scrollY = window.scrollY, mouseX = 0, mouseY = 0, rotX = 0, rotZ = 0;
        window.addEventListener("scroll",    () => { scrollY = window.scrollY; });
        window.addEventListener("mousemove", (e) => {
          mouseX = e.clientX / window.innerWidth  - 0.5;
          mouseY = e.clientY / window.innerHeight - 0.5;
        });

        // Hero section bottom edge (fall endpoint)
        const heroEl = document.querySelector("main > section:first-child");

        const clock = new THREE.Clock();

        // ── Render loop ───────────────────────────────────────────────────
        const renderLoop = () => {
          requestAnimationFrame(renderLoop);
          const elapsed = clock.getElapsedTime();

          // Scroll progress through hero → gravity fall to image
          const heroH = heroEl ? heroEl.offsetHeight : window.innerHeight;
          const rawProg = Math.min(1, Math.max(0, scrollY / heroH));
          // Gravity easing: slow at top, accelerate downward, ease-out at landing
          const gravProg = rawProg < 0.7
            ? (rawProg / 0.7) * (rawProg / 0.7) * 0.7          // ease-in phase
            : 0.7 + (rawProg - 0.7) / 0.3 * 0.3;               // ease-out landing

          // Cup position: lerp from start → land driven by gravity progress
          const cupX = cfg.startX + (cfg.landX - cfg.startX) * gravProg;
          const cupY = fl.y       + (cfg.landY  - fl.y)      * gravProg;

          cupGroup.position.x = cupX;
          cupGroup.position.y = cupY;

          // Gentle spin slows as cup falls
          cupGroup.rotation.y += 0.0038 * (1 - gravProg * 0.7);

          // Mouse tilt (reduced while falling)
          rotX += (mouseY * 0.12 * (1 - gravProg * 0.5) - rotX) * 0.055;
          rotZ += (mouseX * 0.12 * (1 - gravProg * 0.5) - rotZ) * 0.055;
          cupGroup.rotation.x = rotX;
          cupGroup.rotation.z = rotZ;

          // Scale: subtly shrink as it "lands" (depth illusion)
          const landScale = cfg.scale * (1 - gravProg * 0.12);
          cupGroup.scale.setScalar(Math.max(landScale, cfg.scale * 0.88));

          // Steam fades out as cup lands
          cupGroup.children.forEach((child) => {
            if (child instanceof THREE.Sprite) child.material.opacity *= (1 - gravProg * 0.8);
          });

          // Beans orbit + bob
          beans.forEach((b) => {
            const d = b.userData;
            d.angle += d.speed;
            b.position.x = Math.cos(d.angle) * d.dist + cupX;
            b.position.z = Math.sin(d.angle) * d.dist * 0.55 - 1;
            b.position.y = cupY + d.ht + Math.sin(elapsed * d.bobFreq + d.phase) * d.bobAmp;
            b.rotation.y += d.speed * 1.6; b.rotation.x += d.speed * 0.4;
          });

          // Steam wisp drift
          steamParticles.forEach((p) => {
            const d = p.userData;
            p.position.y += d.rise;
            p.position.x = d.sx + Math.sin(elapsed * d.swayFreq + d.phase) * d.swayAmp * 55;
            if (p.position.y > d.sy + 3.8) p.position.y = d.sy;
          });

          bgMesh.rotation.y += 0.00028;
          renderer.render(scene, camera);
        };

        renderLoop();

        // ── Resize handler ────────────────────────────────────────────────
        window.addEventListener("resize", () => {
          cfg = getConfig();
          camera.aspect = window.innerWidth / window.innerHeight;
          camera.position.z = cfg.camZ;
          camera.updateProjectionMatrix();
          renderer.setSize(window.innerWidth, window.innerHeight);
          // Re-target float base
          fl.y = cfg.startY;
        });
      };

      // --- AnimeJS Micro-Animations ---
      const initAnime = () => {
        anime({
          targets: ".mt-20 i", translateY: [-8, 8],
          duration: 2200, direction: "alternate", loop: true,
          easing: "easeInOutSine", delay: anime.stagger(240),
        });

        document.querySelectorAll(".w-16.h-16").forEach((icon) => {
          icon.addEventListener("mouseenter", () =>
            anime({ targets: icon, scale: [1, 1.2, 1], rotate: [0, 8, 0], duration: 480, easing: "easeOutBack" })
          );
        });

        document.querySelectorAll('a[href*="guest/order"], a[href*="employee/pos"]').forEach((btn) => {
          btn.addEventListener("mouseenter", () =>
            anime({ targets: btn, scale: 1.05, duration: 260, easing: "easeOutQuad" })
          );
          btn.addEventListener("mouseleave", () =>
            anime({ targets: btn, scale: 1,    duration: 260, easing: "easeOutQuad" })
          );
        });
      };

      window.onload = () => {
        init3D();
        initAnime();
      };
    </script>
  </body>
</html>
