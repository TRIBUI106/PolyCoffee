<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Đăng nhập</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous">

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e9fd 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            max-width: 420px;
            width: 100%;
        }

        .card-header {
            background: #5c8aff;
            color: white;
            padding: 24px;
            text-align: center;
            font-weight: 600;
            font-size: 1.5rem;
        }

        .card-body {
            padding: 32px 28px;
        }

        .form-label {
            font-weight: 500;
            color: #444;
            margin-bottom: 8px;
        }

        .form-control {
            padding: 12px 16px;
            border: 1px solid #d1d9e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.2s;
        }

        .form-control:focus {
            border-color: #5c8aff;
            box-shadow: 0 0 0 0.25rem rgba(92, 138, 255, 0.15);
        }

        .btn-primary {
            background-color: #5c8aff;
            border: none;
            padding: 12px;
            font-size: 1.05rem;
            border-radius: 8px;
            transition: background-color 0.2s;
            width: 100%;
        }

        .btn-primary:hover {
            background-color: #4a75e6;
        }

        .error-message {
            color: #e74c3c;
            font-size: 0.95rem;
            margin-top: 12px;
            text-align: center;
        }

        .text-center a {
            color: #5c8aff;
            text-decoration: none;
            font-weight: 500;
        }

        .text-center a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="login-card">
    <div class="card-header">
        Đăng nhập hệ thống
    </div>

    <div class="card-body">
        <form method="post">
            <div class="mb-4">
                <label class="form-label">Email</label>
                <input type="email"
                       name="email"
                       class="form-control"
                       placeholder="example@gmail.com"
                       required
                       autofocus>
            </div>

            <div class="mb-4">
                <label class="form-label">Mật khẩu</label>
                <input type="password"
                       name="password"
                       class="form-control"
                       placeholder="••••••••"
                       required>
            </div>

            <button type="submit" class="btn btn-primary">
                Đăng nhập
            </button>

            <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                ${error}
            </div>
            <% } %>
        </form>

        <!-- Có thể thêm link quên mật khẩu hoặc đăng ký nếu cần -->
        <!--
        <div class="text-center mt-4">
            <small>
                <a href="#">Quên mật khẩu?</a> |
                <a href="register">Đăng ký tài khoản</a>
            </small>
        </div>
        -->
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>