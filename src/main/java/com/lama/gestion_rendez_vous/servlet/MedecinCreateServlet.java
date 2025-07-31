package com.lama.gestion_rendez_vous.servlet;

import com.lama.gestion_rendez_vous.Models.Medecin;
import com.lama.gestion_rendez_vous.dao.MedecinDAO;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/medecins/create")
public class MedecinCreateServlet extends HttpServlet {
    private EntityManagerFactory emf;

    @Override
    public void init() {
        emf = Persistence.createEntityManagerFactory("cabinetPU");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();
        MedecinDAO medecinDAO = new MedecinDAO(em);

        String nom = req.getParameter("nom");
        String specialite = req.getParameter("specialite");
        String email = req.getParameter("email");
        String telephone = req.getParameter("telephone");

        Medecin medecin = new Medecin(nom, specialite, email, telephone);
        medecinDAO.ajouterMedecin(medecin);

        em.close();
        resp.sendRedirect(req.getContextPath() + "/medecins/list");

    }

    @Override
    public void destroy() {
        emf.close();
    }
}
