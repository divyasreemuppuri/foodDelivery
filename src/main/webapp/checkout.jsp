<%@ page import="com.tap.model.User" %>
<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>
<%@ page import="java.util.Map" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Checkout - Foodwala</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            color: #333;
        }

        .checkout-container {
            width: 90%;
            max-width: 1100px;
            margin: 40px auto;
        }

        .checkout-title {
            text-align: center;
            margin-bottom: 30px;
        }

        .checkout-title h1 {
            font-size: 32px;
            color: #222;
        }

        .checkout-title p {
            color: #777;
            margin-top: 8px;
        }

        .checkout-content {
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 25px;
        }

        .checkout-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            margin-bottom: 20px;
        }

        .checkout-card h2 {
            font-size: 20px;
            margin-bottom: 20px;
            color: #222;
        }

        .user-details {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .detail-row {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .detail-row label {
            font-size: 14px;
            font-weight: 600;
            color: #555;
        }

        .detail-row input,
        .detail-row textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
        }

        .detail-row textarea {
            resize: none;
            height: 90px;
        }

        .detail-row input:focus,
        .detail-row textarea:focus {
            border-color: #ff6b35;
        }

        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }

        .cart-item:last-child {
            border-bottom: none;
        }

        .item-info {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .item-name {
            font-size: 16px;
            font-weight: 600;
        }

        .item-price {
            font-size: 14px;
            color: #777;
        }

        .item-quantity {
            font-size: 14px;
            color: #555;
        }

        .item-total {
            font-weight: 600;
            color: #222;
        }

        .payment-options {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .payment-option {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 14px;
            cursor: pointer;
        }

        .payment-option:hover {
            border-color: #ff6b35;
        }

        .payment-option label {
            cursor: pointer;
            font-size: 15px;
            font-weight: 500;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            font-size: 15px;
        }

        .summary-row.total {
            border-top: 1px solid #ddd;
            padding-top: 18px;
            margin-top: 15px;
            font-size: 20px;
            font-weight: 700;
        }

        .place-order-btn {
            width: 100%;
            border: none;
            padding: 15px;
            margin-top: 20px;
            border-radius: 10px;
            background: linear-gradient(
                135deg,
                #ff6b35,
                #ff3d00
            );
            color: white;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.3s;
        }

        .place-order-btn:hover {
            transform: translateY(-2px);
            box-shadow:
                0 8px 20px rgba(255, 61, 0, 0.25);
        }

        .empty-message {
            text-align: center;
            padding: 50px;
        }

        @media (max-width: 800px) {

            .checkout-content {
                grid-template-columns: 1fr;
            }

            .checkout-container {
                width: 94%;
            }
        }

    </style>

</head>

<body>

<%@ include file="components/navbar.jsp" %>

<%
    User user = (User) session.getAttribute("user");
    Cart cart = (Cart) session.getAttribute("cart");
%>

<div class="checkout-container">

    <div class="checkout-title">

        <h1>Checkout</h1>

        <p>Review your order and complete your purchase</p>

    </div>

    <%
        if (cart == null || cart.getItems().isEmpty()) {
    %>

        <div class="checkout-card empty-message">

            <h2>Your cart is empty</h2>

            <p>
                Add some delicious items before proceeding to checkout.
            </p>

        </div>

    <%
        } else {
    %>

    <div class="checkout-content">

        <!-- LEFT SIDE -->

        <div>

            <!-- DELIVERY DETAILS -->

            <div class="checkout-card">

                <h2>Delivery Details</h2>

                <div class="user-details">

                    <div class="detail-row">

                        <label>Username</label>

                        <input type="text"
                               value="<%= user.getUsername() %>"
                               readonly>

                    </div>

                    <div class="detail-row">

                        <label>Email</label>

                        <input type="email"
                               value="<%= user.getEmail() %>"
                               readonly>

                    </div>

                    <div class="detail-row">

                        <label>Phone</label>

                        <input type="text"
                               value="<%= user.getPhone() %>"
                               readonly>

                    </div>

                    <div class="detail-row">

                        <label>Delivery Address</label>

                        <textarea name="address"
                                  form="orderForm"
                                  required><%= user.getAddress() %></textarea>

                    </div>

                </div>

            </div>


            <!-- ORDER ITEMS -->

            <div class="checkout-card">

                <h2>Order Items</h2>

                <%
                    for (Map.Entry<Integer, CartItem> entry
                            : cart.getItems().entrySet()) {

                        CartItem cartItem = entry.getValue();
                %>

                    <div class="cart-item">

                        <div class="item-info">

                            <div class="item-name">
                                <%= cartItem.getMenu().getItemName() %>
                            </div>

                            <div class="item-price">

                                &#8377;<%= cartItem.getMenu().getPrice() %>

                            </div>

                            <div class="item-quantity">

                                Quantity:
                                <%= cartItem.getQuantity() %>

                            </div>

                        </div>

                        <div class="item-total">

                            &#8377;<%= cartItem.getTotalPrice() %>

                        </div>

                    </div>

                <%
                    }
                %>

            </div>


            <!-- PAYMENT MODE -->

            <div class="checkout-card">

                <h2>Payment Mode</h2>

                <div class="payment-options">

                    <div class="payment-option">

                        <input type="radio"
                               id="cod"
                               name="paymentMode"
                               value="Cash on Delivery"
                               form="orderForm"
                               required>

                        <label for="cod">
                            Cash on Delivery
                        </label>

                    </div>

                    <div class="payment-option">

                        <input type="radio"
                               id="upi"
                               name="paymentMode"
                               value="UPI"
                               form="orderForm">

                        <label for="upi">
                            UPI
                        </label>

                    </div>

                    <div class="payment-option">

                        <input type="radio"
                               id="card"
                               name="paymentMode"
                               value="Card"
                               form="orderForm">

                        <label for="card">
                            Card
                        </label>

                    </div>

                </div>

            </div>

        </div>


        <!-- RIGHT SIDE -->

        <div>

            <div class="checkout-card">

                <h2>Order Summary</h2>

                <div class="summary-row">

                    <span>Items</span>

                    <span>
                        <%= cart.getItems().size() %>
                    </span>

                </div>

                <div class="summary-row total">

                    <span>Total</span>

                    <span>
                        &#8377;<%= cart.getTotalAmount() %>
                    </span>

                </div>

                <form id="orderForm"
                      action="<%= request.getContextPath() %>/checkout"
                      method="post">

                    <button type="submit"
                            class="place-order-btn">

                        Place Order

                    </button>

                </form>

            </div>

        </div>

    </div>

    <%
        }
    %>

</div>

</body>

</html>