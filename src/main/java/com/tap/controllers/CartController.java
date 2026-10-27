package com.tap.controllers;

import java.io.IOException;

import com.tap.DAOImpl.MenuDAOImpl;
import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        HttpSession session = req.getSession();

        Cart cart = (Cart) session.getAttribute("cart");

        // =========================
        // ADD TO CART
        // =========================

        if ("add".equals(action)) {

            int menuId = Integer.parseInt(
                    req.getParameter("menuId")
            );

            int restaurantId = Integer.parseInt(
                    req.getParameter("restaurantId")
            );

            MenuDAOImpl menuDAO = new MenuDAOImpl();

            Menu menu = menuDAO.getMenu(menuId);

            if (cart == null) {

                cart = new Cart(restaurantId);

                session.setAttribute("cart", cart);
            }

            if (cart.getRestaurantId() != restaurantId) {

                resp.sendRedirect(
                    req.getContextPath()
                    + "/menu?restaurantId="
                    + restaurantId
                    + "&message=You cannot add items from different restaurants to the same cart."
                );

                return;
            }

            CartItem cartItem = new CartItem(menu, 1);

            cart.addItem(cartItem);

            session.setAttribute("cart", cart);

            resp.sendRedirect(
            	    req.getContextPath()
            	    + "/menu?restaurantId="
            	    + restaurantId
            	);

   
            return;
        }

     // =========================
     // UPDATE QUANTITY
     // =========================

     if ("update".equals(action)) {

         int menuId = Integer.parseInt(
                 req.getParameter("menuId")
         );

         int quantity = Integer.parseInt(
                 req.getParameter("quantity")
         );

         String source = req.getParameter("source");

         if (cart != null && cart.getItems().containsKey(menuId)) {

             CartItem cartItem =
                     cart.getItems().get(menuId);

             if (quantity > 0) {

                 cartItem.setQuantity(quantity);

             } else {

                 cart.removeItem(menuId);
             }

             session.setAttribute("cart", cart);
         }

         // =========================
         // REDIRECT BASED ON SOURCE
         // =========================

         if ("menu".equals(source)) {

             int restaurantId = Integer.parseInt(
                     req.getParameter("restaurantId")
             );

             resp.sendRedirect(
                 req.getContextPath()
                 + "/menu?restaurantId="
                 + restaurantId
             );

         } else if ("cart".equals(source)) {

             resp.sendRedirect(
                 req.getContextPath()
                 + "/cart"
             );
         }

         return;
     }

        // =========================
        // REMOVE ITEM
        // =========================

        if ("remove".equals(action)) {

            int menuId = Integer.parseInt(
                    req.getParameter("menuId")
            );

            if (cart != null) {

                cart.removeItem(menuId);

                session.setAttribute("cart", cart);
            }

            resp.sendRedirect(
                req.getContextPath() + "/cart"
            );

            return;
        }
        
        //============================
        // CLEAR ITEMS
        //============================
        
        if ("clear".equals(action)) {

            session.removeAttribute("cart");

            resp.sendRedirect(
                req.getContextPath() + "/cart"
            );

            return;
        
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	req.getRequestDispatcher("cart.jsp").forward(req, resp);
    }
}