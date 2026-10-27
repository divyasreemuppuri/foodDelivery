
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

@WebServlet("/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        // Validate input
        if (email == null || email.trim().isEmpty()
                || password == null || password.isEmpty()) {

            resp.sendRedirect(
                req.getContextPath()
                + "/login.jsp?message=Email and password are required"
            );
            return;
        }

        // Fetch user from database
        UserDAOImpl userDAO = new UserDAOImpl();
        User user = userDAO.getUserByEmail(email);

        // Verify password using BCrypt
        boolean passwordMatches = false;

        if (user != null && user.getPassword() != null) {
            try {
                passwordMatches = BCrypt.checkpw(
                    password,
                    user.getPassword()
                );
            } catch (IllegalArgumentException e) {
                passwordMatches = false;
            }
        }

        if (user != null && passwordMatches) {

            // Create session after successful login
            HttpSession session = req.getSession();
            session.setAttribute("user", user);

            // Preserve checkout redirect logic
            String redirectAfterLogin =
                    (String) session.getAttribute("redirectAfterLogin");

            if ("checkout".equals(redirectAfterLogin)) {

                session.removeAttribute("redirectAfterLogin");

                resp.sendRedirect(
                    req.getContextPath() + "/checkout"
                );

            } else {

                resp.sendRedirect(
                    req.getContextPath() + "/restaurant"
                );
            }

        } else {

            resp.sendRedirect(
                req.getContextPath()
                + "/login.jsp?message=Invalid email or password"
            );
        }
    }
}
