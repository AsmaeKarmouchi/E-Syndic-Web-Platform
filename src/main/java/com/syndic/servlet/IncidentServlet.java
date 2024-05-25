package com.syndic.servlet;

import com.syndic.beans.Incident;
import com.syndic.beans.Meeting;
import com.syndic.beans.Syndic;
import com.syndic.beans.User;
import com.syndic.connection.Syndic_con;
import com.syndic.dao.IncidentDAO;
import com.syndic.dao.IncidentDAOImpl;
import com.syndic.dao.MeetingDAO;
import com.syndic.dao.MeetingDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Calendar;


public class IncidentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public IncidentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("incident.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

            if (action != null && action.equals("addIncident")) {
                // Récupération des paramètres de la requête
                String incidentType = request.getParameter("incident_type");
                String incidentDescription = request.getParameter("incident_description");
                String incidentStatus = request.getParameter("incident_status");

                try {

                    Connection connection = Syndic_con.getConnection();

                    HttpSession session = request.getSession();

                    int syndicId;
                    Incident newIncident = null;
                    User user = (User) session.getAttribute("user");
                    int userId = user.getAdmin();
                    if (userId == 2) {

                        Syndic syndic = (Syndic) session.getAttribute("syndic");
                        syndicId = syndic.getId();
                        newIncident = new Incident(incidentType, incidentDescription, incidentStatus, syndicId );

                    } else {

                    }

                    IncidentDAO incidentDAO = new IncidentDAOImpl(connection);
                    incidentDAO.addIncident(newIncident);
                    // Définir un attribut de session pour le message
                    session.setAttribute("successMessage", "L'incident a été ajouté avec succès !");
                    // Rediriger vers la même page
                    response.sendRedirect(request.getRequestURI());


                } catch (SQLException e) {
                    throw new RuntimeException(e);

                }

        } else if (action != null && action.equals("editIncident")) {

            // Récupérer les paramètres de modification de la conclusion
            int incidentId = Integer.parseInt(request.getParameter("incidentId"));
            String newStatus = request.getParameter("newStatus");
            try {
                Connection connection = Syndic_con.getConnection();
                IncidentDAO incidentDAO = new IncidentDAOImpl(connection);

                // Appeler la méthode pour mettre à jour la conclusion
                Calendar calendar = Calendar.getInstance();
                incidentDAO.updateIncident(incidentId, newStatus, (Date) calendar.getTime());

                HttpSession session = request.getSession();
                session.setAttribute("successMessage", "La conclusion de la réunion a été modifiée avec succès !");
                // Rediriger vers la même page
                response.sendRedirect(request.getRequestURI());

            } catch (SQLException e) {
                throw new ServletException("Erreur lors de la modification de la conclusion de la réunion", e);
            }

        }
    }

}
