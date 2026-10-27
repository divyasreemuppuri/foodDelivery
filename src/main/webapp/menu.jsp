<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List, java.util.Map, com.tap.model.Menu, com.tap.model.Cart, com.tap.model.CartItem"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Foodwala | Menu</title>

    <style>

        /* =========================
           RESET
        ========================= */

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f8f9fc;
            color: #1e293b;
            min-height: 100vh;
        }


        /* =========================
           HEADER
        ========================= */

        .header {
            background: linear-gradient(135deg, #ff6b35, #ff3d00);
            color: white;
            padding: 55px 20px 70px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .header::before {
            content: "";
            position: absolute;
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.08);
            top: -120px;
            left: -80px;
        }

        .header::after {
            content: "";
            position: absolute;
            width: 400px;
            height: 400px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.06);
            bottom: -250px;
            right: -100px;
        }

        .header-content {
            position: relative;
            z-index: 2;
            animation: headerFade 0.8s ease forwards;
        }

        .header h1 {
            font-size: 42px;
            font-weight: 800;
            margin-bottom: 12px;
            letter-spacing: -1px;
        }

        .header p {
            font-size: 17px;
            opacity: 0.92;
        }


        /* =========================
           MAIN CONTAINER
        ========================= */

        .container {
            width: 90%;
            max-width: 1250px;
            margin: -35px auto 60px;
            position: relative;
            z-index: 5;
        }


        /* =========================
           MENU GRID
        ========================= */

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 28px;
        }
        /* =========================
		   QUANTITY CONTROL
		========================= */
		
		.quantity-control {
		    display: flex;
		    align-items: center;
		    justify-content: center;
		
		    width: 100%;
		    margin-top: 18px;
		
		    background: linear-gradient(
		        135deg,
		        #ff6b35,
		        #ff3d00
		    );
		
		    border-radius: 10px;
		    overflow: hidden;
		
		    box-shadow:
		        0 5px 15px rgba(255, 61, 0, 0.2);
		}
		
		.quantity-control form {
		    flex: 1;
		}
		
		.quantity-btn {
		    width: 100%;
		    height: 44px;
		
		    border: none;
		    background: transparent;
		
		    color: white;
		
		    font-size: 22px;
		    font-weight: 700;
		
		    cursor: pointer;
		
		    transition: background 0.2s ease;
		}
		
		.quantity-btn:hover {
		    background: rgba(255, 255, 255, 0.15);
		}
		
		.quantity {
		    min-width: 45px;
		
		    text-align: center;
		
		    color: white;
		
		    font-size: 16px;
		    font-weight: 700;
		}


        /* =========================
           MENU CARD
        ========================= */

        .menu-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;

            box-shadow:
                0 10px 30px rgba(15, 23, 42, 0.08);

            transition:
                transform 0.35s ease,
                box-shadow 0.35s ease;

            animation: cardAppear 0.7s ease forwards;

            opacity: 0;
        }

        .menu-card:nth-child(1) {
            animation-delay: 0.1s;
        }

        .menu-card:nth-child(2) {
            animation-delay: 0.15s;
        }

        .menu-card:nth-child(3) {
            animation-delay: 0.2s;
        }

        .menu-card:nth-child(4) {
            animation-delay: 0.25s;
        }

        .menu-card:nth-child(5) {
            animation-delay: 0.3s;
        }

        .menu-card:nth-child(6) {
            animation-delay: 0.35s;
        }

        .menu-card:nth-child(7) {
            animation-delay: 0.4s;
        }

        .menu-card:nth-child(8) {
            animation-delay: 0.45s;
        }

        .menu-card:nth-child(9) {
            animation-delay: 0.5s;
        }

        .menu-card:nth-child(10) {
            animation-delay: 0.55s;
        }

        .menu-card:nth-child(11) {
            animation-delay: 0.6s;
        }

        .menu-card:nth-child(12) {
            animation-delay: 0.65s;
        }

        .menu-card:nth-child(13) {
            animation-delay: 0.7s;
        }

        .menu-card:nth-child(14) {
            animation-delay: 0.75s;
        }

        .menu-card:nth-child(15) {
            animation-delay: 0.8s;
        }

        .menu-card:hover {
            transform: translateY(-10px);

            box-shadow:
                0 20px 45px rgba(15, 23, 42, 0.15);
        }


        /* =========================
           MENU IMAGE
        ========================= */

        .image-container {
            height: 220px;
            overflow: hidden;
            position: relative;
        }

        .menu-image {
            width: 100%;
            height: 100%;
            object-fit: cover;

            transition:
                transform 0.5s ease;
        }

        .menu-card:hover .menu-image {
            transform: scale(1.08);
        }

        .image-container::after {
            content: "";

            position: absolute;
            inset: 0;

            background: linear-gradient(
                to top,
                rgba(0, 0, 0, 0.35),
                transparent 55%
            );

            pointer-events: none;
        }


        /* =========================
           CARD CONTENT
        ========================= */

        .card-content {
            padding: 22px;
        }

        .menu-name {
            font-size: 21px;
            font-weight: 700;

            color: #111827;

            margin-bottom: 9px;
        }

        .description {
            color: #64748b;

            font-size: 14px;

            line-height: 1.6;

            min-height: 45px;

            margin-bottom: 18px;
        }


        /* =========================
           PRICE + AVAILABILITY
        ========================= */

        .menu-info {
            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 10px;

            padding-top: 14px;

            border-top: 1px solid #e5e7eb;
        }

        .price {
            font-size: 20px;

            font-weight: 800;

            color: #ff4d1f;
        }

        .availability {
            padding: 6px 10px;

            border-radius: 7px;

            font-size: 13px;

            font-weight: 700;
        }

        .available {
            background: #dcfce7;

            color: #15803d;
        }

        .unavailable {
            background: #fee2e2;

            color: #dc2626;
        }


        /* =========================
           ADD TO CART BUTTON
        ========================= */

        .add-cart {
            display: block;

            width: 100%;

            margin-top: 18px;

            padding: 12px 18px;

            border: none;

            border-radius: 10px;

            background:
                linear-gradient(
                    135deg,
                    #ff6b35,
                    #ff3d00
                );

            color: white;

            font-size: 15px;

            font-weight: 600;

            cursor: pointer;

            text-align: center;

            transition:
                transform 0.25s ease,
                box-shadow 0.25s ease;
        }

        .add-cart:hover {
            transform: translateY(-2px);

            box-shadow:
                0 8px 20px rgba(255, 61, 0, 0.3);
        }


        /* =========================
           EMPTY STATE
        ========================= */

        .empty-message {
            background: white;

            padding: 60px 30px;

            border-radius: 20px;

            text-align: center;

            box-shadow:
                0 10px 30px rgba(15, 23, 42, 0.08);
        }

        .empty-message h2 {
            margin-bottom: 10px;

            color: #1e293b;
        }

        .empty-message p {
            color: #64748b;
        }


        /* =========================
           ANIMATIONS
        ========================= */

        @keyframes cardAppear {

            from {
                opacity: 0;

                transform:
                    translateY(35px);
            }

            to {
                opacity: 1;

                transform:
                    translateY(0);
            }

        }

        @keyframes headerFade {

            from {
                opacity: 0;

                transform:
                    translateY(-20px);
            }

            to {
                opacity: 1;

                transform:
                    translateY(0);
            }

        }


        /* =========================
           TABLET
        ========================= */

        @media (max-width: 1000px) {

            .menu-grid {
                grid-template-columns:
                    repeat(2, 1fr);
            }

            .header h1 {
                font-size: 36px;
            }

        }


        /* =========================
           MOBILE
        ========================= */

        @media (max-width: 650px) {

            .header {
                padding:
                    45px 20px 65px;
            }

            .header h1 {
                font-size: 30px;
            }

            .header p {
                font-size: 15px;
            }

            .container {
                width: 92%;
            }

            .menu-grid {
                grid-template-columns: 1fr;

                gap: 22px;
            }

            .image-container {
                height: 210px;
            }

        }

    </style>

</head>


<body>

	<%@ include file="components/navbar.jsp" %>
    <!-- =========================
         HEADER
    ========================== -->

    <header class="header">

        <div class="header-content">

            <h1>Explore Our Menu</h1>

            <p>
                Delicious dishes prepared specially for you
            </p>

        </div>

    </header>


    <!-- =========================
         MAIN CONTENT
    ========================== -->

    <main class="container">

        <div class="menu-grid">

            <%

                List<Menu> menuList =
                    (List<Menu>) request.getAttribute("allMenu");
                Cart cart = (Cart) session.getAttribute("cart");

                if (menuList != null && !menuList.isEmpty()) {

                    for (Menu menu : menuList) {

            %>


            <!-- =========================
                 MENU CARD
            ========================== -->

            <div class="menu-card">


                <!-- Menu Image -->

                <div class="image-container">

                    <img
                        class="menu-image"
                        src="<%= request.getContextPath() + menu.getImagePath() %>"
                        alt="<%= menu.getItemName() %>"
                    >

                </div>


                <!-- Menu Details -->

                <div class="card-content">


                    <h2 class="menu-name">

                        <%= menu.getItemName() %>

                    </h2>


                    <p class="description">

                        <%= menu.getDescription() %>

                    </p>


                    <div class="menu-info">


                        <span class="price">

                            ₹<%= menu.getPrice() %>

                        </span>


                        <%

                            if (menu.isAvailable()) {

                        %>

                            <span class="availability available">

                                Available

                            </span>

                        <%

                            } else {

                        %>

                            <span class="availability unavailable">

                                Unavailable

                            </span>

                        <%

                            }

                        %>


                    </div>

	
            <%
			    int quantity = 0;
			
			    if (cart != null && cart.getItems().containsKey(menu.getMenuId())) {
			
			        CartItem cartItem = cart.getItems().get(menu.getMenuId());
			
			        quantity = cartItem.getQuantity();
			    }
			%>
			
			<% if (menu.isAvailable()) { %>
			
			    <% if (quantity == 0) { %>
			
			        <!-- ADD TO CART -->
			
			        <form action="<%= request.getContextPath() %>/cart" method="post">
			
			            <input type="hidden"
			                   name="action"
			                   value="add">
			
			            <input type="hidden"
			                   name="menuId"
			                   value="<%= menu.getMenuId() %>">
			
			            <input type="hidden"
			                   name="restaurantId"
			                   value="<%= menu.getRestaurantId() %>">
			
			            <button
			                class="add-cart"
			                type="submit">
			                Add to Cart
			            </button>
			
			        </form>
			
			    <% } else { %>
			
			        <!-- QUANTITY CONTROL -->
			
			        <div class="quantity-control">
			
			            <!-- MINUS -->
			
			            <form action="<%= request.getContextPath() %>/cart"
						      method="post">
						
						    <input type="hidden"
						           name="action"
						           value="update">
						
						    <input type="hidden"
						           name="source"
						           value="menu">
						
						    <input type="hidden"
						           name="menuId"
						           value="<%= menu.getMenuId() %>">
						
						    <input type="hidden"
						           name="restaurantId"
						           value="<%= menu.getRestaurantId() %>">
						
						    <input type="hidden"
						           name="quantity"
						           value="<%= quantity - 1 %>">
						
						    <button type="submit" class="quantity-btn">
						        −
						    </button>
						
						</form>
			
			
			            <!-- QUANTITY -->
			
			            <span class="quantity">
			                <%= quantity %>
			            </span>
			
			
			            <!-- PLUS -->
			
			            <form action="<%= request.getContextPath() %>/cart"
						      method="post">
						
						    <input type="hidden"
						           name="action"
						           value="update">
						
						    <input type="hidden"
						           name="source"
						           value="menu">
						
						    <input type="hidden"
						           name="menuId"
						           value="<%= menu.getMenuId() %>">
						
						    <input type="hidden"
						           name="restaurantId"
						           value="<%= menu.getRestaurantId() %>">
						
						    <input type="hidden"
						           name="quantity"
						           value="<%= quantity + 1 %>">
						
						    <button type="submit" class="quantity-btn">
						        +
						    </button>
						
						</form>
			
			        </div>
			
			    <% } %>
			
			<% } else { %>
			
			    <button
			        class="add-cart"
			        type="button"
			        disabled>
			        Currently Unavailable
			    </button>
			
			<% } %>


                </div>

            </div>


            <%

                    }

                } else {

            %>


            <!-- =========================
                 EMPTY STATE
            ========================== -->

            <div class="empty-message">

                <h2>No Menu Items Available</h2>

                <p>
                    This restaurant currently has no menu items available.
                </p>

            </div>


            <%

                }

            %>

        </div>

    </main>


</body>

</html>