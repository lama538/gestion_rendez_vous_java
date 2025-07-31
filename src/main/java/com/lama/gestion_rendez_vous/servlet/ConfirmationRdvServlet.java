package com.lama.gestion_rendez_vous.servlet;

import com.lama.gestion_rendez_vous.Models.Rdv;
import com.lama.gestion_rendez_vous.dao.RdvDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/confirm-rdv")
public class ConfirmationRdvServlet extends HttpServlet {

    private RdvDAO rendezVousDAO = new RdvDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");

        if (code != null) {
            try {
                Rdv rdv = rendezVousDAO.findByConfirmationCode(code);
                rendezVousDAO.confirmerRendezVous(rdv);
                response.getWriter().println("Votre rendez-vous a bien été confirmé !");
            } catch (Exception e) {
                response.getWriter().println("Code de confirmation invalide.");
            }
        } else {
            response.getWriter().println("Paramètre manquant !");
        }
    }
}