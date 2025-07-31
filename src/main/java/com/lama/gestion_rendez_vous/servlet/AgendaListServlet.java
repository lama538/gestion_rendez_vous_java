package com.lama.gestion_rendez_vous.servlet;

import com.lama.gestion_rendez_vous.Models.Agenda;
import com.lama.gestion_rendez_vous.Models.User;
import com.lama.gestion_rendez_vous.dao.AgendaDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;

@WebServlet("/agenda/list")
public class AgendaListServlet extends HttpServlet {

    private AgendaDAO agendaDAO = new AgendaDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            HttpSession session = req.getSession(false);
            if (session == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            User currentUser = (User) session.getAttribute("user");
            if (currentUser == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            List<Agenda> agendas;

            if ("admin".equalsIgnoreCase(currentUser.getRole())) {

                agendas = agendaDAO.findAll();
            } else if ("medecin".equalsIgnoreCase(currentUser.getRole())) {

                agendas = agendaDAO.findByMedecin(currentUser.getId());
            } else {

                agendas = java.util.Collections.emptyList();
            }

            req.setAttribute("agendas", agendas);



            req.getRequestDispatcher("/WEB-INF/agenda/list.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("agendas", java.util.Collections.emptyList());
            req.setAttribute("errorMessage", "Erreur lors du chargement des agendas : " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/agenda/list.jsp").forward(req, resp);
        }
    }


}