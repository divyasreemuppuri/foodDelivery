<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List, com.tap.model.Restaurant"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Foodwala | Restaurants</title>

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
            background: rgba(255,255,255,0.08);
            top: -120px;
            left: -80px;
        }

        .header::after {
            content: "";
            position: absolute;
            width: 400px;
            height: 400px;
            border-radius: 50%;
            background: rgba(255,255,255,0.06);
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
           RESTAURANT GRID
        ========================= */

        .restaurant-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 28px;
        }


        /* =========================
           RESTAURANT CARD
        ========================= */

        .restaurant-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.08);
            transition:
                transform 0.35s ease,
                box-shadow 0.35s ease;

            animation: cardAppear 0.7s ease forwards;

            opacity: 0;
        }

        .restaurant-card:nth-child(1) {
            animation-delay: 0.1s;
        }

        .restaurant-card:nth-child(2) {
            animation-delay: 0.15s;
        }

        .restaurant-card:nth-child(3) {
            animation-delay: 0.2s;
        }

        .restaurant-card:nth-child(4) {
            animation-delay: 0.25s;
        }

        .restaurant-card:nth-child(5) {
            animation-delay: 0.3s;
        }

        .restaurant-card:nth-child(6) {
            animation-delay: 0.35s;
        }

        .restaurant-card:nth-child(7) {
            animation-delay: 0.4s;
        }

        .restaurant-card:nth-child(8) {
            animation-delay: 0.45s;
        }

        .restaurant-card:nth-child(9) {
            animation-delay: 0.5s;
        }

        .restaurant-card:nth-child(10) {
            animation-delay: 0.55s;
        }

        .restaurant-card:nth-child(11) {
            animation-delay: 0.6s;
        }

        .restaurant-card:nth-child(12) {
            animation-delay: 0.65s;
        }

        .restaurant-card:nth-child(13) {
            animation-delay: 0.7s;
        }

        .restaurant-card:nth-child(14) {
            animation-delay: 0.75s;
        }

        .restaurant-card:nth-child(15) {
            animation-delay: 0.8s;
        }

        .restaurant-card:nth-child(16) {
            animation-delay: 0.85s;
        }

        .restaurant-card:nth-child(17) {
            animation-delay: 0.9s;
        }

        .restaurant-card:nth-child(18) {
            animation-delay: 0.95s;
        }

        .restaurant-card:nth-child(19) {
            animation-delay: 1s;
        }

        .restaurant-card:nth-child(20) {
            animation-delay: 1.05s;
        }

        .restaurant-card:nth-child(21) {
            animation-delay: 1.1s;
        }

        .restaurant-card:nth-child(22) {
            animation-delay: 1.15s;
        }

        .restaurant-card:nth-child(23) {
            animation-delay: 1.2s;
        }

        .restaurant-card:nth-child(24) {
            animation-delay: 1.25s;
        }

        .restaurant-card:nth-child(25) {
            animation-delay: 1.3s;
        }

        .restaurant-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 45px rgba(15, 23, 42, 0.15);
        }


        /* =========================
           IMAGE
        ========================= */

        .image-container {
            height: 220px;
            overflow: hidden;
            position: relative;
        }

        .restaurant-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .restaurant-card:hover .restaurant-image {
            transform: scale(1.08);
        }

        .image-container::after {
            content: "";
            position: absolute;
            inset: 0;
            background: linear-gradient(
                to top,
                rgba(0,0,0,0.35),
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

        .restaurant-name {
            font-size: 22px;
            font-weight: 700;
            color: #111827;
            margin-bottom: 8px;
        }

        .cuisine {
            color: #64748b;
            font-size: 14px;
            margin-bottom: 18px;
        }


        /* =========================
           RESTAURANT INFO
        ========================= */

        .restaurant-info {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 16px;
            gap: 10px;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 14px;
            color: #475569;
        }

        .rating {
            background: #16a34a;
            color: white;
            padding: 6px 9px;
            border-radius: 7px;
            font-weight: 700;
        }

        .delivery {
            background: #fff7ed;
            color: #ea580c;
            padding: 6px 9px;
            border-radius: 7px;
            font-weight: 600;
        }


        /* =========================
           ADDRESS
        ========================= */

        .address {
            color: #64748b;
            font-size: 13px;
            line-height: 1.5;
            padding-top: 14px;
            border-top: 1px solid #e5e7eb;
        }


        /* =========================
           VIEW MENU BUTTON
        ========================= */

        .view-menu {
            display: block;
            text-align: center;
            text-decoration: none;
            margin-top: 18px;
            padding: 12px 18px;
            border-radius: 10px;

            background: linear-gradient(
                135deg,
                #ff6b35,
                #ff3d00
            );

            color: white;
            font-weight: 600;

            transition:
                transform 0.25s ease,
                box-shadow 0.25s ease;
        }

        .view-menu:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 61, 0, 0.3);
        }


        /* =========================
           EMPTY STATE
        ========================= */

        .empty-message {
            background: white;
            padding: 60px 30px;
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.08);
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
                transform: translateY(35px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }

        }

        @keyframes headerFade {

            from {
                opacity: 0;
                transform: translateY(-20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }

        }


        /* =========================
           TABLET
        ========================= */

        @media (max-width: 1000px) {

            .restaurant-grid {
                grid-template-columns: repeat(2, 1fr);
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
                padding: 45px 20px 65px;
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

            .restaurant-grid {
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

            <h1>Discover Restaurants</h1>

            <p>
                Explore delicious food from the best restaurants around you
            </p>

        </div>

    </header>


    <!-- =========================
         MAIN CONTENT
    ========================== -->

    <main class="container">

        <div class="restaurant-grid">

            <%

                List<Restaurant> restaurants =
                    (List<Restaurant>) request.getAttribute("restaurant");

                if (restaurants != null && !restaurants.isEmpty()) {

                    for (Restaurant restaurant : restaurants) {

            %>


            <!-- =========================
                 RESTAURANT CARD
            ========================== -->

            <div class="restaurant-card">


                <!-- Restaurant Image -->

                <div class="image-container">

                    <img
                        class="restaurant-image"
                        src="<%= request.getContextPath() + restaurant.getImagePath() %>"
                        alt="<%= restaurant.getName() %>"
                    >

                </div>


                <!-- Restaurant Details -->

                <div class="card-content">


                    <h2 class="restaurant-name">
                        <%= restaurant.getName() %>
                    </h2>


                    <p class="cuisine">
                        <%= restaurant.getCuisineType() %>
                    </p>


                    <div class="restaurant-info">


                        <span class="info-item">

                            <span class="rating">
                                ★ <%= restaurant.getRating() %>
                            </span>

                        </span>


                        <span class="info-item">

                            <span class="delivery">
                                ⏱ <%= restaurant.getDeliveryTime() %> mins
                            </span>

                        </span>


                    </div>


                    <p class="address">
                        📍 <%= restaurant.getAddress() %>
                    </p>


                    <a href="<%= request.getContextPath() %>/menu?restaurantId=<%= restaurant.getRestaurantId() %>" class="view-menu">
                        View Menu
                    </a>


                </div>

            </div>


            <%

                    }

                } else {

            %>


            <!-- Empty State -->

            <div class="empty-message">

                <h2>No Restaurants Available</h2>

                <p>
                    We couldn't find any restaurants at the moment.
                </p>

            </div>


            <%

                }

            %>

        </div>

    </main>


</body>

</html>