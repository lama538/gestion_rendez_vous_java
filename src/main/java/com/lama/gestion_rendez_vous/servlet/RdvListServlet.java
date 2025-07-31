package com.lama.gestion_rendez_vous.servlet;

import com.lama.gestion_rendez_vous.Models.Rdv;
import com.lama.gestion_rendez_vous.Models.Patient;
import com.lama.gestion_rendez_vous.Models.User;
import com.lama.gestion_rendez_vous.dao.RdvDAO;
import com.lama.gestion_rendez_vous.dao.PatientDAO;
import com.lama.gestion_rendez_vous.dao.UserDAO;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/rdvs/list")
public class RdvListServlet extends HttpServlet {

    private final RdvDAO rdvDAO = new RdvDAO();
    private final PatientDAO patientDAO = new PatientDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        List<Rdv> rdvs = rdvDAO.findAll();
        List<Patient> patients = patientDAO.findAll();
        List<User> medecins = userDAO.findAllMedecins();

        req.setAttribute("rdvs", rdvs);
        req.setAttribute("patients", patients);
        req.setAttribute("medecins", medecins);

        req.getRequestDispatcher("/WEB-INF/rdvs/list.jsp").forward(req, resp);
    }
}
