
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.tap.model.Order" %>
<%@ page import="com.tap.model.OrderItem" %>
<%@ page import="com.tap.model.Restaurant" %>
<%@ page import="com.tap.model.Menu" %>
<%@ page import="com.tap.model.User" %>

<%
    User ordersPageUser = (User) session.getAttribute("user");

    if (ordersPageUser == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Order> orders =
        (List<Order>) request.getAttribute("orders");

    Map<Integer, Restaurant> restaurants =
        (Map<Integer, Restaurant>) request.getAttribute("restaurants");

    Map<Integer, List<OrderItem>> orderItems =
        (Map<Integer, List<OrderItem>>) request.getAttribute("orderItems");

    Map<Integer, Menu> menuItems =
        (Map<Integer, Menu>) request.getAttribute("menuItems");

    SimpleDateFormat dateFormat =
        new SimpleDateFormat("dd MMM yyyy, hh:mm a");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>My Orders | Foodwala</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background: #fff8f5;
            color: #1e293b;
            min-height: 100vh;
        }

        .page-container {
            width: 90%;
            max-width: 1100px;
            margin: 40px auto;
        }

        .page-header {
            margin-bottom: 30px;
        }

        .page-header h1 {
            font-size: 32px;
            margin-bottom: 10px;
        }

        .page-header p {
            color: #64748b;
            line-height: 1.6;
        }

        .orders-list {
            display: grid;
            gap: 25px;
        }

        .order-card {
            background: #fff;
            border: 1px solid #f1e5df;
            border-radius: 16px;
            padding: 25px;
            box-shadow: 0 6px 22px rgba(30, 41, 59, 0.06);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-wrap: wrap;
            gap: 15px;
            padding-bottom: 20px;
            border-bottom: 1px solid #f1e5df;
        }

        .order-number {
            font-size: 21px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .order-date {
            color: #64748b;
            font-size: 14px;
            line-height: 1.7;
        }

        .restaurant-name {
            font-size: 19px;
            font-weight: 700;
            margin-top: 12px;
            color: #f04b20;
        }

        .status {
            display: inline-block;
            padding: 9px 14px;
            border-radius: 20px;
            background: #f1f5f9;
            color: #334155;
            font-size: 13px;
            font-weight: 700;
            text-transform: capitalize;
        }

        .section-title {
            font-size: 17px;
            margin: 22px 0 15px;
        }

        .item-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 15px;
            padding: 14px 0;
            border-bottom: 1px solid #f1e5df;
        }

        .item-info {
            flex: 1;
            min-width: 0;
        }

        .item-name {
            font-size: 15px;
            font-weight: 700;
            margin-bottom: 6px;
            overflow-wrap: anywhere;
        }

        .item-id {
            color: #64748b;
            font-size: 12px;
        }

        .item-price {
            font-size: 15px;
            font-weight: 700;
            white-space: nowrap;
        }

        .no-items {
            padding: 15px 0;
            color: #64748b;
            font-size: 14px;
        }

        .order-summary {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
            padding-top: 20px;
        }

        .payment-info {
            color: #64748b;
            font-size: 14px;
            line-height: 1.8;
        }

        .payment-info strong {
            color: #1e293b;
        }

        .total-box {
            text-align: right;
        }

        .total-label {
            font-size: 13px;
            color: #64748b;
            margin-bottom: 6px;
        }

        .total-amount {
            color: #f04b20;
            font-size: 25px;
            font-weight: 800;
        }

        .empty-state {
            background: #fff;
            text-align: center;
            padding: 55px 20px;
            border-radius: 16px;
            border: 1px solid #f1e5df;
        }

        .empty-icon {
            font-size: 48px;
            margin-bottom: 18px;
        }

        .empty-state h2 {
            margin-bottom: 10px;
        }

        .empty-state p {
            color: #64748b;
            margin-bottom: 24px;
            line-height: 1.6;
        }

        .browse-button {
            display: inline-block;
            text-decoration: none;
            padding: 12px 20px;
            border-radius: 10px;
            color: #fff;
            font-weight: 700;
            background: linear-gradient(135deg, #ff6b35, #ff3d00);
        }

        .browse-button:hover {
            opacity: 0.9;
        }

        @media (max-width: 650px) {
            .page-container {
                width: 92%;
                margin: 25px auto;
            }

            .page-header h1 {
                font-size: 27px;
            }

            .order-card {
                padding: 18px;
            }

            .total-amount {
                font-size: 22px;
            }
        }
		.item-row {
		    display: flex;
		    align-items: center;
		    gap: 16px;
		    padding: 16px 0;
		    border-bottom: 1px solid #f1e5df;
		}
		
		.item-image {
		    width: 90px;
		    height: 90px;
		    flex-shrink: 0;
		    object-fit: cover;
		    border-radius: 12px;
		    background: #fff1e9;
		    border: 1px solid #f1e5df;
		}
		
		.item-info {
		    flex: 1;
		    min-width: 0;
		}
		
		.item-name {
		    font-size: 16px;
		    font-weight: 700;
		    margin-bottom: 8px;
		}
		
		.item-id {
		    color: #64748b;
		    font-size: 12px;
		}
		
		.item-price {
		    font-size: 16px;
		    font-weight: 700;
		    color: #f04b20;
		    white-space: nowrap;
		}
		
		@media (max-width: 480px) {
		    .item-image {
		        width: 70px;
		        height: 70px;
		    }
		
		    .item-row {
		        gap: 10px;
		    }
		
		    .item-name {
		        font-size: 14px;
		    }
		}

    </style>
</head>

<body>

    <%@ include file="/components/navbar.jsp" %>

    <main class="page-container">

        <header class="page-header">
            <h1>My Orders</h1>
            <p>
                Hi, <%= ordersPageUser.getUsername() %>!
                View your orders and the items you purchased.
            </p>
        </header>

        <% if (orders == null || orders.isEmpty()) { %>

            <section class="empty-state">
                <div class="empty-icon">&#127860;</div>
                <h2>No orders yet</h2>

                <p>
                    You haven't placed any orders yet.
                    Explore restaurants and order your favourite food!
                </p>

                <a class="browse-button"
                   href="<%= request.getContextPath() %>/restaurant">
                    Explore Restaurants
                </a>
            </section>

        <% } else { %>

            <section class="orders-list">

                <% for (Order order : orders) {

                    Restaurant restaurant = restaurants == null
                        ? null
                        : restaurants.get(order.getRestaurantId());

                    List<OrderItem> items = orderItems == null
                        ? null
                        : orderItems.get(order.getOrderId());
                %>

                    <article class="order-card">

                        <div class="order-header">

                            <div>
                                <div class="order-number">
                                    Order <!--  #<%= order.getOrderId() %>-->
                                </div>

                                <div class="order-date">
                                    <% if (order.getOrderDate() != null) { %>
                                        Placed on:
                                        <%= dateFormat.format(
                                            order.getOrderDate()) %>
                                    <% } else { %>
                                        Order date unavailable
                                    <% } %>
                                </div>

                                <div class="restaurant-name">
                                    &#127860;
                                    <%= restaurant != null
                                        ? restaurant.getName()
                                        : "Restaurant unavailable" %>
                                </div>
                            </div>

                            <span class="status">
                                <%= order.getStatus() == null
                                    ? "Unknown"
                                    : order.getStatus() %>
                            </span>

                        </div>

                        <h3 class="section-title">Items ordered</h3>

                        <% if (items == null || items.isEmpty()) { %>

                            <p class="no-items">
                                No item details are available for this order.
                            </p>

                        <% } else { %>

                            <% for (OrderItem item : items) {

                                Menu menu = menuItems == null
                                    ? null
                                    : menuItems.get(item.getMenuId());
                            %>

								                               
								<div class="item-row">
								
								    <% if (menu != null
								            && menu.getImagePath() != null
								            && !menu.getImagePath().trim().isEmpty()) { %>
								
								        <img
								            class="item-image"
								            src="<%= request.getContextPath() %>/<%= menu.getImagePath().replace("\\", "/").replaceFirst("^/+", "") %>"
								            alt="<%= menu.getItemName() %>"
								            onerror="this.onerror=null; this.src='<%= request.getContextPath() %>/images/menu/default-food.jpg';"
								        >
								
								    <% } else { %>
								
								        <img
								            class="item-image"
								            src="<%= request.getContextPath() %>/images/menu/default-food.jpg"
								            alt="Food image unavailable"
								        >
								
								    <% } %>
								
								    <div class="item-info">
								        <div class="item-name">
								            <%= menu != null
								                ? menu.getItemName()
								                : "Menu item #" + item.getMenuId() %>
								        </div>
								
								        <div class="item-id">
								            Item ID: <%= item.getMenuId() %>
								        </div>
								    </div>
								
								    <div class="item-price">
								        &#8377;<%= String.format("%.2f", item.getTotalAmount()) %>
								    </div>
								
								</div>


                            <% } %>

                        <% } %>

                        <div class="order-summary">

                            <div class="payment-info">
                                <div>
                                    Payment mode:
                                    <strong>
                                        <%= order.getPaymentMode() == null
                                            ? "Not specified"
                                            : order.getPaymentMode() %>
                                    </strong>
                                </div>

                               <!-- 
                             <div>
                                    Order ID:
                                    <strong>#<%= order.getOrderId() %></strong>
                                </div> --> 
                            </div>  

                            <div class="total-box">
                                <div class="total-label">Order total</div>

                                <div class="total-amount">
                                    &#8377;<%= String.format("%.2f",
                                        order.getTotalAmount()) %>
                                </div>
                            </div>

                        </div>

                    </article>

                <% } %>

            </section>

        <% } %>

    </main>

</body>
</html>
