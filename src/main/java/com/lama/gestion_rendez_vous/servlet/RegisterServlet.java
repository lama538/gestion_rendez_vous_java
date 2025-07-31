package com.lama.gestion_rendez_vous.servlet;

import com.lama.gestion_rendez_vous.Models.User;
import com.lama.gestion_rendez_vous.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        if (username == null || password == null || role == null ||
                username.isEmpty() || password.isEmpty() || role.isEmpty()) {
            req.setAttribute("error", "Tous les champs sont obligatoires.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }


        User existingUser = userDAO.findByUsername(username);
        if (existingUser != null) {
            req.setAttribute("error", "Ce nom d'utilisateur est déjà pris.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
            return;
        }


        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());


        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(hashedPassword);
        newUser.setRole(role);


        userDAO.save(newUser);

        req.setAttribute("success", "Inscription réussie !");
        req.getRequestDispatcher("register.jsp").forward(req, resp);
    }
}
