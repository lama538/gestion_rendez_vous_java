package com.lama.gestion_rendez_vous.servlet.medecins;

import com.google.gson.Gson;

import com.lama.gestion_rendez_vous.Models.Agenda;
import com.lama.gestion_rendez_vous.Models.Rdv;
import com.lama.gestion_rendez_vous.Services.CreneauService;
import com.lama.gestion_rendez_vous.Utils.AgendaUtils;
import com.lama.gestion_rendez_vous.dao.RdvDAO;
import com.lama.gestion_rendez_vous.dao.AgendaDAO;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/medecins/disponibilites")
public class DisponibilitesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int medecinId = Integer.parseInt(request.getParameter("medecinId"));
            String dateStr = request.getParameter("date");

            List<String> creneauxDisponibles;

            AgendaDAO agendaDAO = new AgendaDAO();

            if (dateStr != null && !dateStr.isEmpty()) {
                LocalDate date = LocalDate.parse(dateStr);

                String jourSemaine = date.getDayOfWeek().toString();
                jourSemaine = jourSemaine.substring(0, 1).toUpperCase() + jourSemaine.substring(1).toLowerCase();

                Agenda agenda = agendaDAO.findByMedecinAndJour(medecinId, jourSemaine);

                if (agenda == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Agenda non trouvé pour ce médecin à cette date");
                    return;
                }

                RdvDAO rdvDao = new RdvDAO();
                List<Rdv> rdvsPris = rdvDao.getRdvsByMedecinAndDate(medecinId, date);

                creneauxDisponibles = AgendaUtils.getCreneauxDisponibles(agenda, rdvsPris, date);

            } else {

                List<Agenda> agendas = agendaDAO.findByMedecin(medecinId);

                creneauxDisponibles = new ArrayList<>();
                CreneauService creneauService = new CreneauService();

                for (Agenda agenda : agendas) {
                    creneauxDisponibles.addAll(creneauService.generateCreneauxDisponibles(agenda));
                }


                creneauxDisponibles = creneauxDisponibles.stream().distinct().sorted().toList();
            }

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            new Gson().toJson(creneauxDisponibles, response.getWriter());

        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Paramètres invalides ou erreur serveur");
            e.printStackTrace();
        }
    }
}
