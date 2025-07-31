package com.lama.gestion_rendez_vous.servlet;

import com.lama.gestion_rendez_vous.Models.Agenda;
import com.lama.gestion_rendez_vous.Models.User;
import com.lama.gestion_rendez_vous.dao.AgendaDAO;
import com.lama.gestion_rendez_vous.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Time;
import java.util.List;

@WebServlet("/agenda/create")
public class AgendaCreateServlet extends HttpServlet {

    private AgendaDAO agendaDAO = new AgendaDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            UserDAO userDAO = new UserDAO();
            List<User> medecins = userDAO.findAllMedecins();
            req.setAttribute("medecins", medecins);
        } catch (Exception e) {
            e.printStackTrace();
        }
        req.getRequestDispatcher("/WEB-INF/agenda/create.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String medecinUsername = req.getParameter("medecinUsername");
            String jourSemaine = req.getParameter("jourSemaine");
            String heureDebutRaw = req.getParameter("heureDebut");
            String heureFinRaw = req.getParameter("heureFin");

            if (medecinUsername == null || medecinUsername.isEmpty()
                    || jourSemaine == null || jourSemaine.isEmpty()
                    || heureDebutRaw == null || heureDebutRaw.isEmpty()
                    || heureFinRaw == null || heureFinRaw.isEmpty()) {
                resp.sendError(400, "Tous les paramètres sont obligatoires");
                return;
            }

            UserDAO userDAO = new UserDAO();
            User medecin = userDAO.findByUsername(medecinUsername);

            if (medecin == null) {
                resp.sendError(400, "Médecin introuvable");
                return;
            }


            Time heureDebut = Time.valueOf(heureDebutRaw + ":00");
            Time heureFin = Time.valueOf(heureFinRaw + ":00");

            Agenda agenda = new Agenda();
            agenda.setMedecin(medecin);
            agenda.setJourSemaine(jourSemaine);
            agenda.setHeureDebut(heureDebut);
            agenda.setHeureFin(heureFin);

            agendaDAO.save(agenda);

            resp.sendRedirect(req.getContextPath() + "/agenda/list");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(400, "Paramètres invalides");
        }
    }

}
