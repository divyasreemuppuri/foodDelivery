 
<%@ page import="com.tap.model.Order" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>

<%
    Order order = (Order) session.getAttribute("lastOrder");

    if (order == null) {
        response.sendRedirect(request.getContextPath() + "/restaurant");
        return;
    }

    SimpleDateFormat dateFormat =
        new SimpleDateFormat("dd MMM yyyy, hh:mm a", Locale.ENGLISH);

    String formattedDate = order.getOrderDate() == null
        ? "Not available"
        : dateFormat.format(order.getOrderDate());

    String formattedAmount = String.format(
        Locale.US, "%.2f", order.getTotalAmount()
    );
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Order Confirmed - Foodwala</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f5f6f8;
            color: #252525;
        }

        .confirmation-container {
            width: 90%;
            max-width: 850px;
            margin: 45px auto;
        }

        .confirmation-card {
            background: #fff;
            padding: 45px 40px;
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.07);
        }

        .success-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 22px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background: #e8f8ee;
            color: #22a447;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 43px;
            font-weight: bold;
        }

        .confirmation-card h1 {
            font-size: 30px;
            color: #222;
            margin-bottom: 12px;
        }

        .subtitle {
            color: #777;
            font-size: 17px;
            line-height: 1.6;
            margin-bottom: 34px;
        }

        .order-details {
            text-align: left;
            border-top: 1px solid #eee;
            border-bottom: 1px solid #eee;
            padding: 20px 0;
            margin-bottom: 28px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            padding: 13px 0;
            font-size: 16px;
        }

        .detail-label {
            color: #777;
        }

        .detail-value {
            color: #222;
            font-weight: 600;
            text-align: right;
            overflow-wrap: anywhere;
        }

        .amount {
            color: #ff5722;
            font-size: 20px;
        }

        .status {
            color: #209b4b;
            background: #e8f8ee;
            padding: 7px 13px;
            border-radius: 20px;
            font-size: 14px;
        }

        .success-note {
            color: #777;
            font-size: 14px;
            line-height: 1.7;
            margin-bottom: 25px;
        }

        .continue-btn {
            display: inline-block;
            text-decoration: none;
            padding: 14px 27px;
            border-radius: 10px;
            background: linear-gradient(135deg, #ff6b35, #ff3d00);
            color: #fff;
            font-size: 15px;
            font-weight: 700;
            transition: 0.3s;
        }

        .continue-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 61, 0, 0.25);
        }

        @media (max-width: 600px) {
            .confirmation-container {
                width: 94%;
                margin: 25px auto;
            }

            .confirmation-card {
                padding: 32px 20px;
            }

            .confirmation-card h1 {
                font-size: 25px;
            }

            .subtitle {
                font-size: 15px;
            }

            .detail-row {
                font-size: 14px;
                gap: 12px;
            }
        }
    </style>
</head>

<body>

    <%@ include file="components/navbar.jsp" %>

    <main class="confirmation-container">

        <section class="confirmation-card">

            <div class="success-icon">&#10003;</div>

            <h1>Order Placed Successfully!</h1>

            <p class="subtitle">
                Thank you for ordering from Foodwala.
                Your order has been placed successfully.
            </p>

            <div class="order-details">

                <div class="detail-row">
                    <span class="detail-label">Order ID</span>
                    <span class="detail-value">
                        #<%= order.getOrderId() %>
                    </span>
                </div>

                <div class="detail-row">
                    <span class="detail-label">Order Date</span>
                    <span class="detail-value">
                        <%= formattedDate %>
                    </span>
                </div>

                <div class="detail-row">
                    <span class="detail-label">Total Amount</span>
                    <span class="detail-value amount">
                        INR <%= formattedAmount %>
                    </span>
                </div>

                <div class="detail-row">
                    <span class="detail-label">Payment Mode</span>
                    <span class="detail-value">
                        <%= order.getPaymentMode() == null
                            ? "Not specified"
                            : order.getPaymentMode() %>
                    </span>
                </div>

                <div class="detail-row">
                    <span class="detail-label">Status</span>
                    <span class="detail-value status">
                        <%= order.getStatus() == null
                            ? "Unknown"
                            : order.getStatus() %>
                    </span>
                </div>

            </div>

            <p class="success-note">
                Your order details have been recorded.
                Thank you for choosing Foodwala!
            </p>

            <a href="<%= request.getContextPath() %>/restaurant"
               class="continue-btn">
                Continue Shopping
            </a>

        </section>

    </main>

</body>
</html>
