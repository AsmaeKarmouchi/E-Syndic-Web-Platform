package com.syndic.mail;

import javax.mail.MessagingException;
import java.io.IOException;
import java.util.List;

public class NotificationService {

    public void sendEmailToUsers(List<String> emails, String subject, String message,String logoPath) {
        Mail mail = new Mail();
        mail.setupServerProperties();

        try {
            for (String email : emails) {
                mail.draftEmail(email, subject, message,logoPath);
                mail.sendEmail();
            }
        } catch (MessagingException e) {
            e.printStackTrace(); // Gérer l'exception de manière appropriée
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
