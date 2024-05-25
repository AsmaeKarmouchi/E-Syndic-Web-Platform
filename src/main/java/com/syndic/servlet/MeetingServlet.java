package com.syndic.servlet;

import com.syndic.beans.Meeting;
import com.syndic.beans.Member;
import com.syndic.beans.Syndic;
import com.syndic.beans.User;
import com.syndic.connection.Syndic_con;
import com.syndic.dao.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Time;


public class MeetingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public MeetingServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("meeting.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

            if (action != null && action.equals("addMeeting")) {
                // Récupération des paramètres de la requête
                Date meetingDate = Date.valueOf(request.getParameter("meeting_date"));
                String meetingTime = request.getParameter("meeting_time");
                String meetingTopic = request.getParameter("meeting_topic");
                String meetingLocation = request.getParameter("meeting_location");
                String meetingType = request.getParameter("meeting_type");
                String meetingResidence = request.getParameter("meeting_residence");
                String meetingConclusion = request.getParameter("meeting_conclusion");

                try {

                    Connection connection = Syndic_con.getConnection();

                    HttpSession session = request.getSession();
                    Syndic syndic = (Syndic) session.getAttribute("syndic");

                    int syndicId = syndic.getId();

                    Meeting newMeeting = new Meeting(meetingDate, meetingTime, meetingTopic, meetingLocation, meetingType, meetingResidence, meetingConclusion, syndicId);

                    MeetingDAO meetingDAO = new MeetingDAOImpl(connection);
                    meetingDAO.addMeeting(newMeeting);
                    // Définir un attribut de session pour le message
                    session.setAttribute("successMessage", "Le Meet a été ajouté avec succès !");
                    // Rediriger vers la même page
                    response.sendRedirect(request.getRequestURI());


                } catch (SQLException e) {
                    throw new RuntimeException(e);

                }

        } else if (action != null && action.equals("editConclusion")) {

            // Récupérer les paramètres de modification de la conclusion
            int meetingId = Integer.parseInt(request.getParameter("meetingId"));
            String newConclusion = request.getParameter("newConclusion");
            try {
                Connection connection = Syndic_con.getConnection();
                MeetingDAO meetingDAO = new MeetingDAOImpl(connection);

                // Appeler la méthode pour mettre à jour la conclusion
                meetingDAO.updateMeetingConclusion(meetingId, newConclusion);

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
