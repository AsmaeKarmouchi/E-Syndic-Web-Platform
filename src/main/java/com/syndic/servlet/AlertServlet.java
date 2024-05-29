package com.syndic.servlet;

import com.syndic.beans.Syndic;
import com.syndic.connection.Syndic_con;
import com.syndic.mail.NotificationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AlertServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AlertServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("membersbySyndic.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = Syndic_con.getConnection();
        HttpSession session = request.getSession();
        Syndic syndic = (Syndic) session.getAttribute("syndic");

        // Récupérer les informations du membre depuis la requête
        String memberId = request.getParameter("memberId");
        String memberFirstName = request.getParameter("memberFirstName");
        String memberLastName = request.getParameter("memberLastName");
        String memberMail = request.getParameter("membermail");



        NotificationService notificationService = new NotificationService();

        // Liste des e-mails à notifier
        List<String> emails = new ArrayList<>();
        emails.add(memberMail);
        emails.add("kendimohammedamine@gmail.com");
        emails.add("karmouchiasmae@gmail.com");
        System.out.println(emails);

        // Sujet de l'email
        String subject = "Reminder to Pay";

        // Contenu de l'email avec les informations du membre
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
                + "<p>Dear " + memberFirstName + " " + memberLastName + ",</p>"
                + "<p>We are reminding you to pay your dues.</p>"
                + "</div>"
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
        notificationService.sendEmailToUsers(emails, subject, message, logoPath);

        response.getWriter().write("Notifications envoyées avec succès");

        // Définir un attribut de session pour le message
        session.setAttribute("successMessage", "Le membre a été notifié avec succès !");
        // Rediriger vers la même page
        response.sendRedirect(request.getRequestURI());

    }
}
