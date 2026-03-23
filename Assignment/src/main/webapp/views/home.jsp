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
    <canvas
      id="canvas-3d"
      class="fixed inset-0 pointer-events-none z-0"
    ></canvas>

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

        <div
          data-aos="fade-down"
          class="inline-flex items-center gap-2 bg-gradient-to-r from-coffee-50 to-orange-50 border border-coffee-200/50 px-5 py-2 rounded-full text-coffee-700 text-xs font-black mb-10 shadow-sm uppercase tracking-widest cursor-default hover:scale-105 transition-transform"
        >
          Trải nghiệm Phục vụ Cà phê Hiện đại
        </div>

        <h1
          data-aos="fade-up"
          data-aos-delay="200"
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
          <span
            class="text-sm font-bold tracking-widest uppercase text-slate-400"
            >Trust Partners</span
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
              class="px-12 py-5 bg-white text-slate-900 rounded-2xl font-black text-xl hover:scale-105 transition-transform shadow-xl"
            >
              Đặt Món Ngay
            </a>
            <a
              href="#"
              class="px-12 py-5 border-2 border-white/20 text-white rounded-2xl font-black text-xl hover:bg-white/10 transition-colors"
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

      // --- 3D Realistic Coffee Cup (Three.js + AnimeJS) ---
      const init3D = () => {
        const canvas = document.getElementById("canvas-3d");
        const scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(
          60,
          window.innerWidth / window.innerHeight,
          0.1,
          1000,
        );
        const renderer = new THREE.WebGLRenderer({
          canvas,
          alpha: true,
          antialias: true,
        });

        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
        renderer.shadowMap.enabled = true;
        renderer.shadowMap.type = THREE.PCFSoftShadowMap;
        renderer.toneMapping = THREE.ACESFilmicToneMapping;
        renderer.toneMappingExposure = 1.2;

        const cupGroup = new THREE.Group();

        // ── 1. Ceramic Material ──────────────────────────────────────────
        const ceramicMaterial = new THREE.MeshPhysicalMaterial({
          color: 0xfaf8f5,
          roughness: 0.08,
          metalness: 0.0,
          clearcoat: 0.95,
          clearcoatRoughness: 0.04,
          reflectivity: 0.85,
        });

        // ── 2. Cup body – dense lathe profile ───────────────────────────
        const cupPoints = [
          new THREE.Vector2(0.0, 0.0), // base centre
          new THREE.Vector2(0.8, 0.0), // base outer flat
          new THREE.Vector2(0.86, 0.06), // base fillet
          new THREE.Vector2(0.92, 0.2), // lower taper start
          new THREE.Vector2(1.02, 0.55),
          new THREE.Vector2(1.14, 1.1),
          new THREE.Vector2(1.26, 1.7),
          new THREE.Vector2(1.36, 2.2),
          new THREE.Vector2(1.42, 2.55),
          new THREE.Vector2(1.46, 2.72), // lip outer edge
          new THREE.Vector2(1.5, 2.76), // lip top
          new THREE.Vector2(1.42, 2.76), // lip inner top
          new THREE.Vector2(1.38, 2.72), // lip inner edge → wall inside
        ];
        const cupGeometry = new THREE.LatheGeometry(cupPoints, 128);
        const cup = new THREE.Mesh(cupGeometry, ceramicMaterial);
        cup.castShadow = true;
        cup.position.y = -1.38;
        cupGroup.add(cup);

        // ── 3. Handle – bezier tube for natural curve ────────────────────
        const handleCurve = new THREE.QuadraticBezierCurve3(
          new THREE.Vector3(1.44, 0.9, 0),
          new THREE.Vector3(2.3, 0.6, 0),
          new THREE.Vector3(1.44, -0.1, 0),
        );
        const handleGeometry = new THREE.TubeGeometry(
          handleCurve,
          48,
          0.1,
          16,
          false,
        );
        const handle = new THREE.Mesh(handleGeometry, ceramicMaterial);
        handle.castShadow = true;
        cupGroup.add(handle);

        // ── 4. Coffee liquid surface ─────────────────────────────────────
        const liquidGeometry = new THREE.CircleGeometry(1.36, 128);
        const liquidMaterial = new THREE.MeshPhysicalMaterial({
          color: 0x120600,
          roughness: 0.03,
          metalness: 0.05,
          reflectivity: 0.95,
        });
        const liquid = new THREE.Mesh(liquidGeometry, liquidMaterial);
        liquid.position.y = 1.36;
        liquid.rotation.x = -Math.PI / 2;
        cupGroup.add(liquid);

        // ── 5. Crema layer (ring) ────────────────────────────────────────
        const cremaGeometry = new THREE.RingGeometry(0.3, 1.28, 128);
        const cremaMaterial = new THREE.MeshStandardMaterial({
          color: 0x7a3d10,
          roughness: 0.95,
          transparent: true,
          opacity: 0.82,
        });
        const crema = new THREE.Mesh(cremaGeometry, cremaMaterial);
        crema.position.y = 1.37;
        crema.rotation.x = -Math.PI / 2;
        cupGroup.add(crema);

        // ── 6. Saucer – concave dish with rim ridge ──────────────────────
        const saucerPoints = [
          new THREE.Vector2(0.0, 0.0),
          new THREE.Vector2(0.6, 0.0),
          new THREE.Vector2(0.95, 0.08),
          new THREE.Vector2(1.2, 0.18), // cup‑rest indent
          new THREE.Vector2(1.5, 0.14),
          new THREE.Vector2(2.0, 0.06),
          new THREE.Vector2(2.6, 0.0),
          new THREE.Vector2(2.9, 0.1), // outer rim start
          new THREE.Vector2(3.1, 0.26), // rim shoulder
          new THREE.Vector2(3.18, 0.34), // rim top
          new THREE.Vector2(3.1, 0.36),
          new THREE.Vector2(2.9, 0.3),
        ];
        const saucerGeometry = new THREE.LatheGeometry(saucerPoints, 128);
        const saucer = new THREE.Mesh(saucerGeometry, ceramicMaterial);
        saucer.castShadow = true;
        saucer.receiveShadow = true;
        saucer.position.y = -1.38;
        cupGroup.add(saucer);

        scene.add(cupGroup);

        // ── 7. Steam – sphere meshes driven by AnimeJS ───────────────────
        const steamParticles = [];
        const steamCount = 28;

        for (let i = 0; i < steamCount; i++) {
          const radius = 0.04 + Math.random() * 0.07;
          const geo = new THREE.SphereGeometry(radius, 8, 8);
          const mat = new THREE.MeshBasicMaterial({
            color: 0xffffff,
            transparent: true,
            opacity: 0,
          });
          const p = new THREE.Mesh(geo, mat);
          const startX = (Math.random() - 0.5) * 1.1;
          const startY = 1.55 + Math.random() * 0.6;
          const startZ = (Math.random() - 0.5) * 1.1;
          p.position.set(startX, startY, startZ);
          p.userData = {
            startX,
            startY,
            startZ,
            riseSpeed: 0.006 + Math.random() * 0.009,
            swayAmp: 0.004 + Math.random() * 0.006,
            swayFreq: 0.8 + Math.random() * 1.2,
            phase: Math.random() * Math.PI * 2,
          };
          cupGroup.add(p);
          steamParticles.push(p);

          // AnimeJS handles the opacity fade loop per particle
          anime({
            targets: p.material,
            opacity: [
              { value: 0, duration: 0 },
              { value: 0.28, duration: 600 + Math.random() * 400 },
              { value: 0, duration: 1200 + Math.random() * 800 },
            ],
            delay: Math.random() * 2400,
            loop: true,
            easing: "easeInOutSine",
          });
        }

        // ── 8. Lighting ──────────────────────────────────────────────────
        scene.add(new THREE.AmbientLight(0xfff5e8, 0.55));

        const keyLight = new THREE.SpotLight(0xffffff, 2.8);
        keyLight.position.set(8, 14, 10);
        keyLight.angle = Math.PI / 7;
        keyLight.penumbra = 0.35;
        keyLight.castShadow = true;
        scene.add(keyLight);

        const fillLight = new THREE.PointLight(0xffd4a0, 0.9);
        fillLight.position.set(-9, 4, 7);
        scene.add(fillLight);

        const rimLight = new THREE.DirectionalLight(0xffccaa, 1.4);
        rimLight.position.set(-3, 9, -10);
        scene.add(rimLight);

        const bounceLight = new THREE.PointLight(0xffeedd, 0.35);
        bounceLight.position.set(0, -6, 6);
        scene.add(bounceLight);

        camera.position.set(0, 2, 10);
        camera.lookAt(0, 0, 0);

        // ── 9. AnimeJS – cup float loop ──────────────────────────────────
        const floatState = { y: 1.0 };
        anime({
          targets: floatState,
          y: [0.7, 1.3],
          duration: 3200,
          direction: "alternate",
          loop: true,
          easing: "easeInOutSine",
        });

        // ── 10. Input state ──────────────────────────────────────────────
        let scrollY = window.scrollY;
        let mouseX = 0;
        let mouseY = 0;
        let curRotX = 0;
        let curRotZ = 0;

        window.addEventListener("scroll", () => {
          scrollY = window.scrollY;
        });
        window.addEventListener("mousemove", (e) => {
          mouseX = e.clientX / window.innerWidth - 0.5;
          mouseY = e.clientY / window.innerHeight - 0.5;
        });

        const clock = new THREE.Clock();

        // ── 11. Render loop ──────────────────────────────────────────────
        const animate = () => {
          requestAnimationFrame(animate);

          const elapsed = clock.getElapsedTime();
          const scrollFactor = scrollY * 0.003;

          // Slow auto‑spin
          cupGroup.rotation.y += 0.0035;

          // Smooth mouse tilt (lerp)
          const targetRotX = Math.sin(scrollFactor) * 0.22 + mouseY * 0.14;
          const targetRotZ = mouseX * 0.14;
          curRotX += (targetRotX - curRotX) * 0.06;
          curRotZ += (targetRotZ - curRotZ) * 0.06;
          cupGroup.rotation.x = curRotX;
          cupGroup.rotation.z = curRotZ;

          // Position: anime float + scroll parallax
          cupGroup.position.y = floatState.y - scrollFactor * 1.6;
          cupGroup.position.x = Math.cos(scrollFactor * 0.5) * 1.4;

          // Steam drift (sway + rise, reset at top)
          steamParticles.forEach((p) => {
            const d = p.userData;
            p.position.y += d.riseSpeed;
            p.position.x =
              d.startX +
              Math.sin(elapsed * d.swayFreq + d.phase) * d.swayAmp * 60;

            if (p.position.y > d.startY + 3.2) {
              p.position.y = d.startY;
              p.position.x = d.startX;
            }
          });

          renderer.render(scene, camera);
        };

        animate();

        window.addEventListener("resize", () => {
          camera.aspect = window.innerWidth / window.innerHeight;
          camera.updateProjectionMatrix();
          renderer.setSize(window.innerWidth, window.innerHeight);
        });
      };

      // --- AnimeJS Micro-Animations ---
      const initAnime = () => {
        // Floating animation for partner icons in Hero
        anime({
          targets: ".mt-20 i",
          translateY: [-8, 8],
          duration: 2200,
          direction: "alternate",
          loop: true,
          easing: "easeInOutSine",
          delay: anime.stagger(240),
        });

        // Pulse ring on feature cards when they enter view
        document
          .querySelectorAll("[data-aos='fade-up'] .w-16")
          .forEach((icon) => {
            icon.addEventListener("mouseenter", () => {
              anime({
                targets: icon,
                scale: [1, 1.18, 1],
                rotate: [0, 8, 0],
                duration: 500,
                easing: "easeOutBack",
              });
            });
          });

        // CTA primary button – magnetic feel
        const primaryCTAs = document.querySelectorAll(
          'a[href*="guest/order"], a[href*="employee/pos"]',
        );
        primaryCTAs.forEach((btn) => {
          btn.addEventListener("mouseenter", () => {
            anime({
              targets: btn,
              scale: 1.05,
              duration: 280,
              easing: "easeOutQuad",
            });
          });
          btn.addEventListener("mouseleave", () => {
            anime({
              targets: btn,
              scale: 1.0,
              duration: 280,
              easing: "easeOutQuad",
            });
          });
        });

        // Review cards staggered entrance
        anime({
          targets: "[data-aos='fade-up']",
          opacity: [0, 1],
          translateY: [30, 0],
          duration: 700,
          delay: anime.stagger(120, { start: 200 }),
          easing: "easeOutCubic",
        });
      };

      window.onload = () => {
        init3D();
        initAnime();
      };
    </script>
  </body>
</html>
