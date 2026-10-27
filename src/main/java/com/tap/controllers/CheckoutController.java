package com.tap.controllers;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Map;

import com.tap.DAOImpl.OrderDAOImpl;
import com.tap.DAOImpl.OrderItemDAOImpl;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        User user = null;

        if (session != null) {
            user = (User) session.getAttribute("user");
        }

        if (user != null) {

            resp.sendRedirect(
                req.getContextPath() + "/checkout.jsp"
            );

        } else {

            resp.sendRedirect(
                req.getContextPath() + "/login.jsp"
            );
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null) {

            resp.sendRedirect(
                req.getContextPath() + "/login.jsp"
            );

            return;
        }


        // Get logged-in user

        User user = (User) session.getAttribute("user");

        if (user == null) {

            resp.sendRedirect(
                req.getContextPath() + "/login.jsp"
            );

            return;
        }


        // Get cart

        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null || cart.getItems().isEmpty()) {

            resp.sendRedirect(
                req.getContextPath() + "/cart"
            );

            return;
        }


        // Get payment mode

        String paymentMode = req.getParameter("paymentMode");


        // Create Order object

        Order order = new Order();
        System.out.println("Logged-in User ID: " + user.getUserId());
        order.setUserId(user.getUserId());

        order.setRestaurantId(cart.getRestaurantId());

        order.setOrderDate(
            new Timestamp(System.currentTimeMillis())
        );

        order.setTotalAmount(
            cart.getTotalAmount()
        );

        order.setStatus("Placed");

        order.setPaymentMode(paymentMode);


        // Save Order

        OrderDAOImpl orderDAO = new OrderDAOImpl();

        int orderId = orderDAO.addOrder(order);
        

        // Check whether order was created successfully

        if (orderId == 0) {

            resp.sendRedirect(
                req.getContextPath()
                + "/checkout.jsp?message=Unable to place order"
            );

            return;
        }

        order.setOrderId(orderId);
        // Create OrderItems

        OrderItemDAOImpl orderItemDAO = new OrderItemDAOImpl();


        for (Map.Entry<Integer, CartItem> entry
                : cart.getItems().entrySet()) {

            CartItem cartItem = entry.getValue();


            OrderItem orderItem = new OrderItem();

            orderItem.setOrderId(orderId);

            orderItem.setMenuId(
                cartItem.getMenu().getMenuId()
            );

            orderItem.setTotalAmount(
                cartItem.getTotalPrice()
            );


            orderItemDAO.addOrderItem(orderItem);
        }

        session.removeAttribute("cart");
        session.setAttribute("lastOrder", order);
        // For now, just redirect to checkout page

        resp.sendRedirect(
            req.getContextPath()
            + "/order-confirmation.jsp"
        );
    }
}