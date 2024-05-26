package com.syndic.servlet;

import com.syndic.beans.Meeting;
import com.syndic.beans.Member;
import com.syndic.beans.Syndic;
import com.syndic.beans.User;
import com.syndic.connection.Syndic_con;
import com.syndic.dao.*;
import com.syndic.mail.NotificationService;
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
import java.util.ArrayList;
import java.util.List;


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

                    NotificationService notificationService = new NotificationService();

                    // Récupérer les e-mails des membres depuis la base de données
                    List<String> emails = new ArrayList<>();

                    MemberProfileDAO memberDAO = new MemberProfileDAOImpl(connection);
                    List<Member> listMembers = memberDAO.getMemberbySid(syndicId);
                    for (Member member : listMembers) {
                        String email = member.getMail();
                        if (email != null && !email.isEmpty()) {
                            emails.add(email);
                        }
                    }

                    // Ajoutez l'e-mail de test directement
                    emails.add("kendimohammedamine@gmail.com");
                    emails.add("karmouchiasmae@gmail.com");
                    System.out.println(emails);

                    String subject = " Mail to participate to New Meeting  ";

                    String message = "<html>"
                            + "<head>"
                            + "<style>"
                            + "body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: #f4f4f4; }"
                            + ".container { background-color: #ffffff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); max-width: 600px; margin: auto; }"
                            + ".header { text-align: center; margin-bottom: 20px; }"
                            + ".header img { width: 100px; margin-bottom: 10px; }"
                            + ".header h1 { font-size: 24px; color: #333333; margin: 0; }"
                            + "h2 { color: #333333; border-bottom: 2px solid #eeeeee; padding-bottom: 10px; }"
                            + "p { line-height: 1.6; color: #555555; }"
                            + ".label { font-weight: bold; color: #333333; }"
                            + ".intro { margin-bottom: 20px; }"
                            + ".footer { margin-top: 20px; font-size: 12px; text-align: center; color: #999999; }"
                            + "</style>"
                            + "</head>"
                            + "<body>"
                            + "<div class='container'>"
                            + "<div class='header'>"
                            + "<img src='cid:logo' alt='Logo'>"
                            + "<h1>Ensias_Syndic</h1>"
                            + "</div>"
                            + "<div class='intro'>"
                            + "<p>Dear Member,</p>"
                            + "<p>We are pleased to invite you to an upcoming meeting. Below are the details of the meeting:</p>"
                            + "</div>"
                            + "<h2>Meeting Details</h2>"
                            + "<p><span class='label'>Date:</span> " + meetingDate + "</p>"
                            + "<p><span class='label'>Time:</span> " + meetingTime + "</p>"
                            + "<p><span class='label'>Topic:</span> " + meetingTopic + "</p>"
                            + "<p><span class='label'>Location:</span> " + meetingLocation + "</p>"
                            + "<p><span class='label'>Type:</span> " + meetingType + "</p>"
                            + "<p><span class='label'>Residence:</span> " + meetingResidence + "</p>"
                            + "<p><span class='label'>Conclusion:</span> " + meetingConclusion + "</p>"
                            + "<p>We look forward to your participation.</p>"
                            + "<p>Best regards,</p>"
                            + "<p>The Syndic Team</p>"
                            + "<div class='footer'>"
                            + "<p>&copy; 2024 Ensias_Syndic. All rights reserved.</p>"
                            + "</div>"
                            + "</div>"
                            + "</body>"
                            + "</html>";

                    // Get the absolute path of the logo
                    String logoPath = getServletContext().getRealPath("/image/logo2.png");



                    // Envoyer des e-mails à tous les utilisateurs
                    notificationService.sendEmailToUsers(emails, subject, message,logoPath);

                    response.getWriter().write("Notifications envoyées avec succès");
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
