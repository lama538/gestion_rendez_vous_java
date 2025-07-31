package com.lama.gestion_rendez_vous.servlet;

import com.lama.gestion_rendez_vous.Models.Agenda;
import com.lama.gestion_rendez_vous.dao.AgendaDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/agenda/list")
public class AgendaListServlet extends HttpServlet {

    private AgendaDAO agendaDAO = new AgendaDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Agenda> agendas = agendaDAO.findAll();
        req.setAttribute("agendas", agendas);
        req.getRequestDispatcher("/WEB-INF/agenda/list.jsp").forward(req, resp);
    }
}
