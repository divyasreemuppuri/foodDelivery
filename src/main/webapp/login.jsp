<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>Login - Foodwala</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: #f8f9fc;
        }

        .login-container {
            width: 400px;
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.12);
        }

        .logo {
            text-align: center;
            margin-bottom: 10px;
            color: #ff5722;
            font-size: 32px;
            font-weight: bold;
        }

        .subtitle {
            text-align: center;
            color: #64748b;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #1e293b;
        }

        .form-group input {
            width: 100%;
            padding: 13px 15px;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            font-size: 15px;
            outline: none;
        }

        .form-group input:focus {
            border-color: #ff5722;
        }

        .login-btn {
            width: 100%;
            padding: 13px;
            border: none;
            border-radius: 10px;
            background: linear-gradient(135deg, #ff6b35, #ff3d00);
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .login-btn:hover {
            opacity: 0.9;
        }

        .signup-text {
            text-align: center;
            margin-top: 25px;
            color: #64748b;
        }

        .signup-text a {
            color: #ff5722;
            text-decoration: none;
            font-weight: 600;
        }

        .signup-text a:hover {
            text-decoration: underline;
        }

        .message {
            text-align: center;
            margin-bottom: 15px;
            color: #dc2626;
        }

    </style>

</head>

<body>

    <div class="login-container">

        <div class="logo">
            Foodwala
        </div>

        <p class="subtitle">
            Login to continue ordering
        </p>

        <!-- Error / success message will be displayed here later -->
        <%
            String message = request.getParameter("message");

            if (message != null) {
        %>
            <div class="message">
                <%= message %>
            </div>
        <%
            }
        %>

        <form action="<%= request.getContextPath() %>/login" method="post">

            <div class="form-group">

                <label for="email">
                    Email
                </label>

                <input
                    type="email"
                    id="email"
                    name="email"
                    placeholder="Enter your email"
                    required
                >

            </div>

            <div class="form-group">

                <label for="password">
                    Password
                </label>

                <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="Enter your password"
                    required
                >

            </div>

            <button type="submit" class="login-btn">
                Login
            </button>

        </form>

        <div class="signup-text">

            Don't have an account?

           <a href="<%= request.getContextPath() %>/signup.jsp">
			    Create Account
			</a>

        </div>

    </div>

</body>
</html>