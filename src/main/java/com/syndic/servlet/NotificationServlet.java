package com.syndic.servlet;

import com.syndic.connection.Syndic_con;
import com.syndic.dao.MemberProfileDAO;
import com.syndic.dao.MemberProfileDAOImpl;
import com.syndic.mail.NotificationService;
import com.syndic.beans.Member;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class NotificationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("sendNotification.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        NotificationService notificationService = new NotificationService();

        // Récupérer les e-mails des membres depuis la base de données
        List<String> emails = new ArrayList<>();
        Connection connection = null;
        try {
            connection = Syndic_con.getConnection();
            MemberProfileDAO memberDAO = new MemberProfileDAOImpl(connection);
            List<Member> listMembers = memberDAO.getMember();
            for (Member member : listMembers) {
                String email = member.getMail();
                if (email != null && !email.isEmpty()) {
                    emails.add(email);
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // Gérer l'exception de manière appropriée

        }

        // Ajoutez l'e-mail de test directement
        emails.add("kendimohammedamine@gmail.com");
        System.out.println(emails);

        // Envoyer des e-mails à tous les utilisateurs
        //notificationService.sendEmailToUsers(emails, subject, message);

        response.getWriter().write("Notifications envoyées avec succès");
    }
}
