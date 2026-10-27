
package com.tap.controllers;

import java.io.IOException;

import com.tap.DAOImpl.UserDAOImpl;
import com.tap.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAOImpl userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAOImpl();
    }

    // Display the user's profile
    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");

        // Fetch the latest details from the database
        User user = userDAO.getUser(sessionUser.getUserId());

        if (user == null) {
            session.invalidate();
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // Keep the session's user information up to date
        session.setAttribute("user", user);

        req.setAttribute("profileUser", user);

        req.getRequestDispatcher("/profile.jsp").forward(req, resp);
    }

    // Save profile changes
    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");

        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");

        // Basic input validation
        if (username == null || username.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || phone == null || phone.trim().isEmpty()
                || address == null || address.trim().isEmpty()) {

            resp.sendRedirect(
                req.getContextPath() + "/profile?error=Please fill in all fields"
            );
            return;
        }

        username = username.trim();
        email = email.trim();
        phone = phone.trim();
        address = address.trim();

        User updatedUser = new User();
        updatedUser.setUserId(sessionUser.getUserId());
        updatedUser.setUsername(username);
        updatedUser.setEmail(email);
        updatedUser.setPhone(phone);
        updatedUser.setAddress(address);

        userDAO.updateProfile(updatedUser);

        // Reload the saved details from the database
        User savedUser = userDAO.getUser(sessionUser.getUserId());

        if (savedUser == null) {
            resp.sendRedirect(
                req.getContextPath() + "/profile?error=Unable to load profile"
            );
            return;
        }

        session.setAttribute("user", savedUser);

        resp.sendRedirect(
            req.getContextPath() + "/profile?success=Profile updated successfully"
        );
    }
}
