package com.lama.gestion_rendez_vous.servlet;

import com.lama.gestion_rendez_vous.Models.User;
import com.lama.gestion_rendez_vous.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = userDAO.findByUsername(username);

        if (user != null && BCrypt.checkpw(password, user.getPassword())) {

            HttpSession session = req.getSession();
            session.setAttribute("user", user);


            req.getRequestDispatcher("/dashboard.jsp").forward(req, resp);
        } else {

            req.setAttribute("error", "Nom d'utilisateur ou mot de passe incorrect");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}
