
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.User" %>

<%
    User loggedInUser = (User) session.getAttribute("user");
%>

<nav class="navbar">

    <div class="navbar-container">

        <!-- Logo -->
        <a href="<%= request.getContextPath() %>/restaurant"
           class="logo">
            Foodwala
        </a>

        <!-- Navigation -->
        <div class="nav-links">

            <a href="<%= request.getContextPath() %>/restaurant">
                Restaurants
            </a>

            <a href="<%= request.getContextPath() %>/cart"
               class="cart-link">
                🛒 Cart
            </a>

            <% if (loggedInUser == null) { %>

                <!-- Guest User -->
                <a href="<%= request.getContextPath() %>/login.jsp">
                    Login
                </a>

                <a href="<%= request.getContextPath() %>/signup.jsp"
                   class="signup-link">
                    Sign Up
                </a>

            <% } else { %>

                <!-- Logged-in User -->
                <a href="<%= request.getContextPath() %>/orders"
                   class="orders-link">
                    My Orders
                </a>
                
				<a href="<%= request.getContextPath() %>/profile"
				   class="profile-link">
				    My Profile
				</a>
				                

                <span class="welcome-user">
                    Hi, <%= loggedInUser.getUsername() %>
                </span>

                <a href="<%= request.getContextPath() %>/logout"
                   class="logout-link">
                    Logout
                </a>

            <% } %>

        </div>

    </div>

</nav>

<style>
    * {
        box-sizing: border-box;
    }

    .navbar {
        width: 100%;
        background: #ffffff;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        position: sticky;
        top: 0;
        z-index: 1000;
    }

    .navbar-container {
        width: 90%;
        max-width: 1250px;
        margin: auto;
        min-height: 70px;

        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .logo {
        text-decoration: none;
        font-size: 28px;
        font-weight: 800;

        background: linear-gradient(
            135deg,
            #ff6b35,
            #ff3d00
        );

        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        flex-shrink: 0;
    }

    .nav-links {
        display: flex;
        align-items: center;
        gap: 25px;
    }

    .nav-links a {
        text-decoration: none;
        color: #1e293b;
        font-size: 15px;
        font-weight: 600;
        transition: all 0.25s ease;
        white-space: nowrap;
    }

    .nav-links a:hover {
        color: #ff4d1f;
    }

    .cart-link {
        padding: 10px 18px;
        border-radius: 10px;
        color: white !important;

        background: linear-gradient(
            135deg,
            #ff6b35,
            #ff3d00
        );

        box-shadow: 0 5px 15px rgba(255, 61, 0, 0.25);
    }

    .cart-link:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(255, 61, 0, 0.3);
    }

    .orders-link {
        padding: 10px 14px;
        border: 1px solid #ffe0d5;
        border-radius: 10px;
        background: #fff7f3;
    }

    .orders-link:hover {
        background: #ffede5;
    }

    .signup-link {
        padding: 10px 16px;
        border: 2px solid #ff4d1f;
        border-radius: 10px;
        color: #ff4d1f !important;
    }

    .signup-link:hover {
        background: #ff4d1f;
        color: white !important;
    }

    .welcome-user {
        color: #1e293b;
        font-size: 15px;
        font-weight: 600;
        white-space: nowrap;
    }

    .logout-link {
        padding: 10px 16px;
        border-radius: 10px;
        background: #1e293b;
        color: white !important;
    }

    .logout-link:hover {
        background: #334155;
    }

    @media (max-width: 900px) {
        .navbar-container {
            width: 94%;
            flex-wrap: wrap;
            gap: 12px;
            padding: 12px 0;
        }

        .nav-links {
            gap: 14px;
            flex-wrap: wrap;
        }
    }

    @media (max-width: 650px) {
        .navbar-container {
            width: 92%;
        }

        .logo {
            font-size: 23px;
        }

        .nav-links {
            gap: 12px;
        }

        .nav-links a {
            font-size: 13px;
        }

        .cart-link {
            padding: 8px 12px;
        }

        .signup-link,
        .logout-link,
        .orders-link {
            padding: 8px 10px;
        }

        .welcome-user {
            font-size: 13px;
        }
    }
    
	.profile-link {
	    padding: 10px 14px;
	    border: 1px solid #dbeafe;
	    border-radius: 10px;
	    background: #eff6ff;
	}
	
	.profile-link:hover {
	    background: #dbeafe;
	}
	    
</style>
