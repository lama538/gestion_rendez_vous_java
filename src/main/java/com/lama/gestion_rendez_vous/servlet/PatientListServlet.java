package com.lama.gestion_rendez_vous.servlet;

import com.lama.gestion_rendez_vous.Models.Patient;
import com.lama.gestion_rendez_vous.dao.PatientDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/patients/list")
public class PatientListServlet extends HttpServlet {

    private PatientDAO patientDAO = new PatientDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Patient> patients = patientDAO.findAll();
        req.setAttribute("patients", patients);
        req.getRequestDispatcher("/WEB-INF/patients/list.jsp").forward(req, resp);
    }
}
