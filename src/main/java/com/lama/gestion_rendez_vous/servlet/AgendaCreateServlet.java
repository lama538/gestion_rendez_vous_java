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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
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


            LocalDate today = LocalDate.now();
            req.setAttribute("today", today.toString());


            HttpSession session = req.getSession(false);
            if (session != null) {
                User currentUser = (User) session.getAttribute("user");
                req.setAttribute("currentUser", currentUser);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        req.getRequestDispatcher("/WEB-INF/agenda/create.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            HttpSession session = req.getSession(false);
            if (session == null) {
                resp.sendError(403, "Utilisateur non authentifié");
                return;
            }

            User currentUser = (User) session.getAttribute("user");
            if (currentUser == null) {
                resp.sendError(403, "Utilisateur non authentifié");
                return;
            }

            String medecinUsername;

            if ("admin".equalsIgnoreCase(currentUser.getRole())) {
                // Pour l'admin, on prend la valeur du formulaire
                medecinUsername = req.getParameter("medecinUsername");
            } else if ("medecin".equalsIgnoreCase(currentUser.getRole())) {
                // Pour le médecin connecté, on récupère directement son username en session
                medecinUsername = currentUser.getUsername();
            } else {
                resp.sendError(403, "Accès non autorisé");
                return;
            }

            String dateAgendaRaw = req.getParameter("dateAgenda");
            String heureDebutRaw = req.getParameter("heureDebut");
            String heureFinRaw = req.getParameter("heureFin");


            if (medecinUsername == null || medecinUsername.isEmpty()
                    || dateAgendaRaw == null || dateAgendaRaw.isEmpty()
                    || heureDebutRaw == null || heureDebutRaw.isEmpty()
                    || heureFinRaw == null || heureFinRaw.isEmpty()) {
                resp.sendError(400, "Tous les paramètres sont obligatoires");
                return;
            }


            LocalDate dateAgenda;
            try {
                dateAgenda = LocalDate.parse(dateAgendaRaw);
            } catch (DateTimeParseException e) {
                resp.sendError(400, "Format de date invalide");
                return;
            }


            if (dateAgenda.isBefore(LocalDate.now())) {
                resp.sendError(400, "La date ne peut pas être dans le passé");
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


            if (heureFin.before(heureDebut) || heureFin.equals(heureDebut)) {
                resp.sendError(400, "L'heure de fin doit être après l'heure de début");
                return;
            }


            Agenda agenda = new Agenda();
            agenda.setMedecin(medecin);
            agenda.setDateAgenda(dateAgenda);
            agenda.setHeureDebut(heureDebut);
            agenda.setHeureFin(heureFin);

            agendaDAO.save(agenda);

            resp.sendRedirect(req.getContextPath() + "/agenda/list");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500, "Erreur lors de la création de l'agenda");
        }
    }

}