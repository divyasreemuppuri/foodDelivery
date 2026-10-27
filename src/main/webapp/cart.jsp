<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.Map" %>
<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>
<%@ page import="com.tap.model.Menu" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Foodwala | Cart</title>
	 <style>

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

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 50px auto;
        }

        .cart-header {
            margin-bottom: 30px;
        }

        .cart-header h1 {
            font-size: 36px;
            margin-bottom: 8px;
        }

        .cart-header p {
            color: #64748b;
        }

        .cart-card {
            background: white;
            border-radius: 20px;
            padding: 25px;

            box-shadow:
                0 10px 30px rgba(15, 23, 42, 0.08);
        }

        .cart-item {
            display: flex;
            align-items: center;
            gap: 20px;

            padding: 20px 0;

            border-bottom: 1px solid #e5e7eb;
        }

        .cart-item:last-child {
            border-bottom: none;
        }

        .item-image {
            width: 100px;
            height: 80px;

            object-fit: cover;

            border-radius: 12px;
        }

        .item-details {
            flex: 1;
        }

        .item-details h2 {
            font-size: 18px;
            margin-bottom: 7px;
        }

        .item-price {
            color: #ff4d1f;
            font-weight: 700;
        }

        .quantity {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .quantity span {
            font-weight: 700;
            min-width: 25px;
            text-align: center;
        }

        .quantity form {
            display: inline;
        }

        .quantity button {
            width: 32px;
            height: 32px;

            border: none;
            border-radius: 8px;

            background: #fff1eb;
            color: #ff4d1f;

            font-size: 18px;
            font-weight: 700;

            cursor: pointer;
        }

        .quantity button:hover {
            background: #ff6b35;
            color: white;
        }

        .item-total {
            width: 110px;

            text-align: right;

            font-weight: 800;
            font-size: 17px;
        }

        .remove-btn {
            border: none;
            background: #fee2e2;
            color: #dc2626;

            padding: 8px 12px;

            border-radius: 8px;

            cursor: pointer;
            font-weight: 600;
        }

        .remove-btn:hover {
            background: #dc2626;
            color: white;
        }

        .cart-summary {
            margin-top: 30px;
            padding-top: 25px;

            border-top: 2px solid #e5e7eb;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .total-label {
            font-size: 20px;
            font-weight: 700;
        }

        .total-amount {
            font-size: 28px;
            font-weight: 800;
            color: #ff4d1f;
        }

        .empty-cart {
            text-align: center;
            padding: 70px 20px;
        }

        .empty-cart h2 {
            margin-bottom: 10px;
        }

        .empty-cart p {
            color: #64748b;
            margin-bottom: 25px;
        }

        .browse-btn {
            display: inline-block;

            padding: 12px 22px;

            text-decoration: none;

            color: white;

            border-radius: 10px;

            background: linear-gradient(
                135deg,
                #ff6b35,
                #ff3d00
            );
        }
        .cart-actions {
		    display: flex;
		    justify-content: flex-end;
		    margin-bottom: 20px;
		}
		
		.clear-cart-btn {
		    border: none;
		    background: #fee2e2;
		    color: #dc2626;
		    padding: 10px 16px;
		    border-radius: 8px;
		    cursor: pointer;
		    font-weight: 600;
		    transition: 0.3s;
		}
		
		.clear-cart-btn:hover {
		    background: #dc2626;
		    color: white;
		}
		
		.checkout-btn {
		    border: none;
		
		    padding: 13px 22px;
		
		    border-radius: 10px;
		
		    background: linear-gradient(
		        135deg,
		        #ff6b35,
		        #ff3d00
		    );
		
		    color: white;
		
		    font-size: 15px;
		
		    font-weight: 700;
		
		    cursor: pointer;
		
		    transition: 0.3s;
		}
		
		.checkout-btn:hover {
		    transform: translateY(-2px);
		
		    box-shadow:
		        0 8px 20px rgba(255, 61, 0, 0.25);
		}
        @media (max-width: 700px) {

            .cart-item {
                flex-wrap: wrap;
            }

            .item-details {
                min-width: calc(100% - 120px);
            }

            .item-total {
                width: auto;
                margin-left: auto;
            }

            .cart-summary {
                align-items: flex-end;
                gap: 15px;
            }

        }

    </style>

</head>
<body>
	<%@ include file="components/navbar.jsp" %>

    <main class="container">

        <div class="cart-header">

            <h1>Your Cart</h1>

            <p>Review your selected items</p>

        </div>

        <%
            Cart cart = (Cart) session.getAttribute("cart");
        %>

        <div class="cart-card">

        <%
            if (cart == null || cart.getItems().isEmpty()) {
        %>

            <div class="empty-cart">

                <h2>Your cart is empty</h2>

                <p>
                    Add some delicious food from a restaurant.
                </p>

                <a
                    href="<%= request.getContextPath() %>/restaurant"
                    class="browse-btn"
                >
                    Browse Restaurants
                </a>

            </div>

        <%
            } else {
        %>
			<div class="cart-actions">

			    <form action="<%= request.getContextPath() %>/cart"
			          method="post">
			
			        <input type="hidden"
			               name="action"
			               value="clear">
			
			        <button type="submit"
			                class="clear-cart-btn">
			
			            Clear Cart
			
			        </button>
			
			    </form>
			
			</div>
            <%
                for (Map.Entry<Integer, CartItem> entry
                        : cart.getItems().entrySet()) {

                    CartItem cartItem = entry.getValue();

                    Menu menu = cartItem.getMenu();
            %>

                <div class="cart-item">

                    <img
                        class="item-image"
                        src="<%= request.getContextPath()
                                + menu.getImagePath() %>"
                        alt="<%= menu.getItemName() %>"
                    >

                    <div class="item-details">

                        <h2>
                            <%= menu.getItemName() %>
                        </h2>

                        <div class="item-price">
                            ₹<%= menu.getPrice() %>
                        </div>

                    </div>

                    <!-- Quantity -->
                    <div class="quantity">

                        <form action="<%= request.getContextPath() %>/cart"
					      method="post">
					
					    <input type="hidden"
					           name="action"
					           value="update">
					
					    <input type="hidden"
					           name="source"
					           value="cart">
					
					    <input type="hidden"
					           name="menuId"
					           value="<%= cartItem.getMenu().getMenuId() %>">
					
					    <input type="hidden"
					           name="quantity"
					           value="<%= cartItem.getQuantity() - 1 %>">
					
					    <button type="submit" class="quantity-btn">
					        −
					    </button>
					
					</form>

                        <span>
                            <%= cartItem.getQuantity() %>
                        </span>
						<form action="<%= request.getContextPath() %>/cart"
						      method="post">
						
						    <input type="hidden"
						           name="action"
						           value="update">
						
						    <input type="hidden"
						           name="source"
						           value="cart">
						
						    <input type="hidden"
						           name="menuId"
						           value="<%= cartItem.getMenu().getMenuId() %>">
						
						    <input type="hidden"
						           name="quantity"
						           value="<%= cartItem.getQuantity() + 1 %>">
						
						    <button type="submit" class="quantity-btn">
						        +
						    </button>
						
						</form>
                    </div>

                    <div class="item-total">

                        ₹<%= cartItem.getTotalPrice() %>

                    </div>

                    <!-- Remove -->
                    <form
                        action="<%= request.getContextPath() %>/cart"
                        method="post"
                    >

                        <input
                            type="hidden"
                            name="action"
                            value="remove"
                        >

                        <input
                            type="hidden"
                            name="menuId"
                            value="<%= menu.getMenuId() %>"
                        >

                        <button
                            type="submit"
                            class="remove-btn"
                        >
                            Remove
                        </button>

                    </form>

                </div>

            <%
                }
            %>

            <div class="cart-summary">

			    <div>
			        <span class="total-label">
			            Total Amount
			        </span>
			
			        <div class="total-amount">
			            ₹<%= cart.getTotalAmount() %>
			        </div>
			    </div>
			
			    <form action="<%= request.getContextPath() %>/checkout"
			          method="get">
			
			        <button type="submit" class="checkout-btn">
			            Proceed to Checkout
			        </button>
			
			    </form>
			
			</div>

        <%
            }
        %>

        </div>

    </main>
</body>
</html>


