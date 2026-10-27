<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Sign Up - Foodwala</title>

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

            padding: 40px 20px;
        }

        .signup-container {
            width: 450px;

            background: white;

            padding: 40px;

            border-radius: 20px;

            box-shadow:
                0 10px 30px rgba(0, 0, 0, 0.12);
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
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;

            margin-bottom: 8px;

            font-weight: 600;

            color: #1e293b;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;

            padding: 13px 15px;

            border: 1px solid #cbd5e1;

            border-radius: 10px;

            font-size: 15px;

            outline: none;
        }

        .form-group textarea {
            resize: vertical;

            min-height: 90px;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            border-color: #ff5722;
        }

        .signup-btn {
            width: 100%;

            padding: 13px;

            border: none;

            border-radius: 10px;

            background: linear-gradient(
                135deg,
                #ff6b35,
                #ff3d00
            );

            color: white;

            font-size: 16px;

            font-weight: bold;

            cursor: pointer;
        }

        .signup-btn:hover {
            opacity: 0.9;
        }

        .login-text {
            text-align: center;

            margin-top: 25px;

            color: #64748b;
        }

        .login-text a {
            color: #ff5722;

            text-decoration: none;

            font-weight: 600;
        }

        .login-text a:hover {
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

    <div class="signup-container">

        <div class="logo">
            Foodwala
        </div>

        <p class="subtitle">
            Create your Foodwala account
        </p>

        <!-- Message area -->
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

        <form action="<%= request.getContextPath() %>/signup"
              method="post">

            <!-- Username -->

            <div class="form-group">

                <label for="username">
                    Username
                </label>

                <input
                    type="text"
                    id="username"
                    name="username"
                    placeholder="Enter your username"
                    required
                >

            </div>


            <!-- Email -->

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


            <!-- Password -->

            <div class="form-group">

                <label for="password">
                    Password
                </label>

                <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="Create a password"
                    required
                >

            </div>


            <!-- Phone -->

            <div class="form-group">

                <label for="phone">
                    Phone
                </label>

                <input
                    type="tel"
                    id="phone"
                    name="phone"
                    placeholder="Enter your phone number"
                    required
                >

            </div>


            <!-- Address -->

            <div class="form-group">

                <label for="address">
                    Address
                </label>

                <textarea
                    id="address"
                    name="address"
                    placeholder="Enter your delivery address"
                    required
                ></textarea>

            </div>


            <!-- Submit -->

          <button type="submit" class="signup-btn">
		    Create Account
		</button>

        </form>


        <div class="login-text">

            Already have an account?

            <a href="<%= request.getContextPath() %>/login.jsp">
                Login
            </a>

        </div>

    </div>

</body>

</html>