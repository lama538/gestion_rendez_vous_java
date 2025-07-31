package com.lama.gestion_rendez_vous.servlet;

import com.lama.gestion_rendez_vous.Models.User;
import com.lama.gestion_rendez_vous.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/users/list")
public class UserListServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<User> users = userDAO.findAll();
        req.setAttribute("users", users);
        req.getRequestDispatcher("/WEB-INF/users/list.jsp").forward(req, resp);
    }
}
