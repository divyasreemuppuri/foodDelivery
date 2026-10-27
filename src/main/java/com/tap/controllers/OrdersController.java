
package com.tap.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tap.DAOImpl.MenuDAOImpl;
import com.tap.DAOImpl.OrderDAOImpl;
import com.tap.DAOImpl.OrderItemDAOImpl;
import com.tap.DAOImpl.RestaurantDAOImpl;
import com.tap.model.Menu;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.model.Restaurant;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/orders")
public class OrdersController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDAOImpl orderDAO;
    private OrderItemDAOImpl orderItemDAO;
    private RestaurantDAOImpl restaurantDAO;
    private MenuDAOImpl menuDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
        orderItemDAO = new OrderItemDAOImpl();
        restaurantDAO = new RestaurantDAOImpl();
        menuDAO = new MenuDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        User user = null;

        if (session != null) {
            user = (User) session.getAttribute("user");
        }

        if (user == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        // Fetch only the logged-in user's orders
        List<Order> orders =
            orderDAO.getOrdersByUser(user.getUserId());

        // Store restaurant details by restaurant ID
        Map<Integer, Restaurant> restaurants = new HashMap<>();

        // Store order items by order ID
        Map<Integer, List<OrderItem>> orderItems = new HashMap<>();

        // Store menu details by menu ID
        Map<Integer, Menu> menuItems = new HashMap<>();

        for (Order order : orders) {

            int restaurantId = order.getRestaurantId();

            if (!restaurants.containsKey(restaurantId)) {
                Restaurant restaurant =
                    restaurantDAO.getRestaurant(restaurantId);

                if (restaurant != null) {
                    restaurants.put(restaurantId, restaurant);
                }
            }

            List<OrderItem> items =
                orderItemDAO.getOrderItemsByOrder(order.getOrderId());

            if (items == null) {
                items = new ArrayList<>();
            }

            orderItems.put(order.getOrderId(), items);

            for (OrderItem item : items) {

                int menuId = item.getMenuId();

                if (!menuItems.containsKey(menuId)) {
                    Menu menu = menuDAO.getMenu(menuId);

                    if (menu != null) {
                        menuItems.put(menuId, menu);
                    }
                }
            }
        }

        request.setAttribute("orders", orders);
        request.setAttribute("restaurants", restaurants);
        request.setAttribute("orderItems", orderItems);
        request.setAttribute("menuItems", menuItems);

        request.getRequestDispatcher("/orders.jsp")
               .forward(request, response);
    }
}
