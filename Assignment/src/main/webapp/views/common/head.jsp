<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

            <!-- CSS Frameworks & Icons (CDN) -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
                rel="stylesheet" />
            <script src="https://cdn.tailwindcss.com"></script>

            <!-- Google Fonts (Inter & Outfit) -->
            <link
                href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Outfit:wght@300;400;500;600;700;800&display=swap"
                rel="stylesheet" />

            <!-- Animation Libraries -->
            <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
            <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/3.2.1/anime.min.js"></script>

            <!-- Core JS Dependencies (CDN) -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>

            <!-- Global Tailwind Configuration -->
            <script>
                tailwind.config = {
                    theme: {
                        extend: {
                            colors: {
                                coffee: {
                                    50: '#fdf8f6', 100: '#f2e8e5', 200: '#EADBC8',
                                    500: '#c67f63', 600: '#b95d3b', 700: '#6F4E37',
                                    800: '#5D4037', 900: '#3E2723'
                                },
                                pos: {
                                    bg: '#f0f2f5', panel: '#ffffff', border: '#e1e4e8',
                                    text: '#1f2937', muted: '#6b7280', accent: '#0088ff',
                                    success: '#10b981', danger: '#ef4444'
                                },
                                mocha: '#2D2424',
                                cream: '#FDF7E4',
                            },
                            fontFamily: {
                                sans: ['Inter', 'Outfit', 'sans-serif'],
                                outfit: ['Outfit', 'sans-serif']
                            },
                            boxShadow: { 'pos': '0 0 10px rgba(0,0,0,0.05)' }
                        }
                    }
                }
            </script>

            <!-- Global Component Styles (Tailwind) -->
            <style type="text/tailwindcss">
                @layer components {
        .btn-coffee { @apply bg-coffee-700 text-white px-6 py-2 rounded-lg font-medium transition-colors hover:bg-coffee-800 active:bg-coffee-900 shadow-sm flex items-center gap-2; }
        .btn-soft { @apply bg-white text-coffee-800 border border-gray-200 px-6 py-2 rounded-lg font-medium transition-colors hover:bg-gray-50 active:bg-gray-100 shadow-sm flex items-center gap-2; }
        .nav-link-custom { @apply text-gray-600 hover:text-coffee-700 font-medium px-4 py-2 transition-colors relative flex items-center gap-1.5 rounded-lg hover:bg-gray-50; }
        .nav-link-active { @apply text-coffee-700 bg-coffee-50; }
        .dropdown-luxury { @apply absolute top-[calc(100%+0.5rem)] left-0 w-56 bg-white border border-gray-100 rounded-xl p-2 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200 shadow-lg z-50; }
        .dropdown-item { @apply flex items-center gap-3 px-3 py-2 hover:bg-gray-50 rounded-lg text-gray-700 text-sm transition-colors; }
        
        /* POS Scroll Overrides */
        .hide-scroll::-webkit-scrollbar { display: none; }
        .hide-scroll { -ms-overflow-style: none; scrollbar-width: none; }
    }

    body {
        @apply font-sans;
        -webkit-tap-highlight-color: transparent;
    }
</style>