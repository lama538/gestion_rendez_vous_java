package com.lama.gestion_rendez_vous.servlet;

import com.lama.gestion_rendez_vous.Models.Patient;
import com.lama.gestion_rendez_vous.dao.PatientDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/patients/create")
public class PatientCreateServlet extends HttpServlet {

    private PatientDAO patientDAO = new PatientDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/WEB-INF/patients/create.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String nom = req.getParameter("nom");
        String prenom = req.getParameter("prenom");
        String dateNaissance = req.getParameter("dateNaissance");
        String telephone = req.getParameter("telephone");
        String email = req.getParameter("email");

        java.sql.Date sqlDate = java.sql.Date.valueOf(dateNaissance);

        Patient patient = new Patient();
        patient.setNom(nom);
        patient.setPrenom(prenom);
        patient.setDateNaissance(sqlDate);
        patient.setTelephone(telephone);
        patient.setEmail(email);

        patientDAO.save(patient);

        resp.sendRedirect(req.getContextPath() + "/patients/list");
    }
}
