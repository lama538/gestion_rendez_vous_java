package com.lama.gestion_rendez_vous.servlet;

import com.lama.gestion_rendez_vous.Models.User;
import com.lama.gestion_rendez_vous.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/users/create")
public class UserCreateServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/WEB-INF/users/create.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role"); // admin, secretaire, medecin

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setRole(role);

        userDAO.save(user);

        resp.sendRedirect(req.getContextPath() + "/users/list");
    }
}
