package com.syndic.servlet;

import com.syndic.beans.*;
import com.syndic.connection.Syndic_con;
import com.syndic.dao.*;
import com.syndic.mail.NotificationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;


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

                    Syndic syndic = (Syndic) session.getAttribute("syndic");
                    syndicId = syndic.getId();
                    newIncident = new Incident(incidentType, incidentDescription, incidentStatus, syndicId );


                    IncidentDAO incidentDAO = new IncidentDAOImpl(connection);
                    incidentDAO.addIncident(newIncident);
                    // Définir un attribut de session pour le message
                    session.setAttribute("successMessage", "L'incident a été ajouté avec succès !");


                    List<Incident> list_Incidents = new ArrayList<>();
                    incidentDAO = new IncidentDAOImpl(connection);
                    list_Incidents = incidentDAO.getIncidentBySyndicId(syndicId);
                    session.setAttribute("list_Incidents", list_Incidents);




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

                    String subject = "Incident Notification";

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
                            + "<p>We would like to inform you of an incident. Below are the details:</p>"
                            + "</div>"
                            + "<h2>Incident Details</h2>"
                            + "<p><span class='label'>Type:</span> " + incidentType + "</p>"
                            + "<p><span class='label'>Description:</span> " + incidentDescription + "</p>"
                            + "<p><span class='label'>Status:</span> " + incidentStatus + "</p>"
                            + "<p>We appreciate your attention to this matter and will keep you updated on any developments.</p>"
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
