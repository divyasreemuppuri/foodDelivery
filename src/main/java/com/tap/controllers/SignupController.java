
package com.tap.controllers;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.tap.DAOImpl.UserDAOImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/signup")
public class SignupController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");

        // Validate password
        if (password == null || password.trim().isEmpty()) {
            resp.sendRedirect(
                req.getContextPath()
                + "/signup.jsp?message=Password is required"
            );
            return;
        }

        // Hash the password using BCrypt
        String hashedPassword = BCrypt.hashpw(
            password,
            BCrypt.gensalt(12)
        );

        // Create user
        User user = new User();

        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(hashedPassword);
        user.setPhone(phone);
        user.setAddress(address);
        user.setRole("user");

        // Save user to database
        UserDAOImpl userDAO = new UserDAOImpl();
        userDAO.addUser(user);

        // Preserve your existing automatic-login flow
        HttpSession session = req.getSession();
        session.setAttribute("user", user);

        resp.sendRedirect(
            req.getContextPath() + "/restaurant"
        );
    }
}
