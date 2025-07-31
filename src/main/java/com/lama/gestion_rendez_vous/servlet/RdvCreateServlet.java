package com.lama.gestion_rendez_vous.servlet;

import com.lama.gestion_rendez_vous.Models.Rdv;
import com.lama.gestion_rendez_vous.Models.Patient;
import com.lama.gestion_rendez_vous.Models.User;
import com.lama.gestion_rendez_vous.Utils.EmailUtil;
import com.lama.gestion_rendez_vous.dao.RdvDAO;
import com.lama.gestion_rendez_vous.dao.PatientDAO;
import com.lama.gestion_rendez_vous.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

@WebServlet("/rdvs/create")
public class RdvCreateServlet extends HttpServlet {

    private RdvDAO rdvDAO = new RdvDAO();
    private PatientDAO patientDAO = new PatientDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<User> medecins = userDAO.findAllMedecins();
        List<Patient> patients = patientDAO.findAll();

        req.setAttribute("medecins", medecins);
        req.setAttribute("patients", patients);

        req.getRequestDispatcher("/WEB-INF/rdvs/create.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            String patientIdStr = req.getParameter("patientId");
            String medecinIdStr = req.getParameter("medecinId");
            String dateRdvStr = req.getParameter("dateRdv");
            String heureRdvStr = req.getParameter("heureRdv");
            String statut = req.getParameter("statut");

            if (patientIdStr == null || medecinIdStr == null || dateRdvStr == null ||
                    heureRdvStr == null || statut == null ||
                    patientIdStr.isEmpty() || medecinIdStr.isEmpty() ||
                    dateRdvStr.isEmpty() || heureRdvStr.isEmpty() || statut.isEmpty()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Tous les champs sont requis.");
                return;
            }

            int patientId = Integer.parseInt(patientIdStr);
            int medecinId = Integer.parseInt(medecinIdStr);

            LocalDate date = LocalDate.parse(dateRdvStr);
            LocalTime time = LocalTime.parse(heureRdvStr);
            LocalDateTime dateTime = LocalDateTime.of(date, time);

            Rdv rdv = new Rdv();
            rdv.setPatientId(patientId);
            rdv.setMedecinId(medecinId);
            rdv.setDateRdv(Timestamp.valueOf(dateTime));
            rdv.setStatut(statut);


            String confirmationCode = UUID.randomUUID().toString();
            rdv.setConfirmationCode(confirmationCode);
            rdv.setConfirmed(false);


            rdvDAO.save(rdv);


            Patient patient = patientDAO.findById(patientId);
            if (patient != null && patient.getEmail() != null) {
                String email = patient.getEmail();
                String nom = patient.getNom(); // ou getPrenom()
                String dateHeure = dateRdvStr + " à " + heureRdvStr;


                String confirmationLink = req.getRequestURL().toString()
                        .replace(req.getServletPath(), "") + "/confirm-rdv?code=" + confirmationCode;

                EmailUtil.sendConfirmationEmail(email, nom, date + " à " + heureRdvStr, confirmationLink);

            }

            resp.sendRedirect(req.getContextPath() + "/rdvs/list");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Identifiants numériques invalides.");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Paramètres invalides.");
        }
    }
}
