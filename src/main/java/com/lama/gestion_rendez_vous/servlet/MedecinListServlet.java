package com.lama.gestion_rendez_vous.servlet;

import com.lama.gestion_rendez_vous.Models.User;
import com.lama.gestion_rendez_vous.dao.UserDAO;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/medecins/list")
public class MedecinListServlet extends HttpServlet {
    private EntityManagerFactory emf;

    @Override
    public void init() {
        emf = Persistence.createEntityManagerFactory("cabinetPU");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();
        UserDAO userDao = new UserDAO();

        List<User> medecins = userDao.findAllMedecins(); // Appelle la bonne méthode
        req.setAttribute("medecins", medecins);

        em.close();

        req.getRequestDispatcher("/WEB-INF/medecins/list.jsp").forward(req, resp);
    }

    @Override
    public void destroy() {
        emf.close();
    }
}
