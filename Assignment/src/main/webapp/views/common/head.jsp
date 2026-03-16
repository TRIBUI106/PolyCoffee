<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script src="https://cdn.tailwindcss.com"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<script>
    tailwind.config = {
        theme: {
            extend: {
                colors: {
                    coffee: { 
                        50: '#fdf8f6', 
                        100: '#f2e8e5', 
                        200: '#EADBC8', 
                        500: '#c67f63', 
                        600: '#b95d3b',
                        700: '#6F4E37', 
                        800: '#5D4037', 
                        900: '#3E2723' 
                    },
                    mocha: '#2D2424',
                    cream: '#FDF7E4',
                },
                fontFamily: {
                    sans: ['Inter', 'sans-serif'],
                }
            }
        }
    }
</script>

<style type="text/tailwindcss">
    @layer components {
        .btn-coffee {
            @apply bg-coffee-700 text-white px-6 py-2 rounded-lg font-medium transition-colors hover:bg-coffee-800 active:bg-coffee-900 shadow-sm flex items-center gap-2;
        }
        .btn-soft {
            @apply bg-white text-coffee-800 border border-gray-200 px-6 py-2 rounded-lg font-medium transition-colors hover:bg-gray-50 active:bg-gray-100 shadow-sm flex items-center gap-2;
        }
        .nav-link-custom {
            @apply text-gray-600 hover:text-coffee-700 font-medium px-4 py-2 transition-colors relative flex items-center gap-1.5 rounded-lg hover:bg-gray-50;
        }
        .nav-link-active {
            @apply text-coffee-700 bg-coffee-50;
        }
        .dropdown-luxury {
            @apply absolute top-[calc(100%+0.5rem)] left-0 w-56 bg-white border border-gray-100 rounded-xl p-2 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200 shadow-lg z-50;
        }
        .dropdown-item {
            @apply flex items-center gap-3 px-3 py-2 hover:bg-gray-50 rounded-lg text-gray-700 text-sm transition-colors;
        }
    }
</style>
