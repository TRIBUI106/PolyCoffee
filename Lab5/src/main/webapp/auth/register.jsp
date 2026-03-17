<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Đăng ký</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous">
</head>
<body>
<div class="login-card">
    <div class="card-header">
        Đăng Ký tài khoản
    </div>

    <div class="card-body">
        <form method="post">
            <div class="mb-4">
                <label class="form-label">Username</label>
                <input type="username"
                       name="usernaem"
                       class="form-control"
                       placeholder="nguyenvana123"
                       required>
            </div>
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
                Đăng ký
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