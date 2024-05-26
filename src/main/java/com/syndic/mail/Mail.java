package com.syndic.mail;

import javax.mail.*;
import javax.mail.internet.*;
import java.io.IOException;
import java.util.List;
import java.util.Properties;

public class Mail {

    Session newSession = null;
    MimeMessage mimeMessage = null;

    public void setupServerProperties() {
        Properties properties = System.getProperties();
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.debug", "true");
        newSession = Session.getDefaultInstance(properties, null);
    }

    public void sendEmail() throws MessagingException {
        String fromUser = "ensiassyndic@gmail.com"; // Adresse e-mail de l'expéditeur
        String fromUserPassword = "jfpk msou angk hite"; // Mot de passe de l'e-mail de l'expéditeur
        String emailHost = "smtp.gmail.com";

        Transport transport = newSession.getTransport("smtp");
        transport.connect(emailHost, fromUser, fromUserPassword);
        transport.sendMessage(mimeMessage, mimeMessage.getAllRecipients());
        transport.close();
        System.out.println("E-mail envoyé avec succès !!!");
    }

    public MimeMessage draftEmail(String recipient, String subject, String message, String logoPath) throws MessagingException, IOException {
        mimeMessage = new MimeMessage(newSession);
        mimeMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
        mimeMessage.setSubject(subject);

        // Create the HTML part
        MimeBodyPart bodyPart = new MimeBodyPart();
        bodyPart.setContent(message, "text/html");

        // Attach the logo
        MimeBodyPart logoPart = new MimeBodyPart();
        logoPart.attachFile(logoPath);
        logoPart.setContentID("<logo>");
        logoPart.setDisposition(MimeBodyPart.INLINE);

        // Create a multipart to combine the parts
        MimeMultipart multipart = new MimeMultipart();
        multipart.addBodyPart(bodyPart);
        multipart.addBodyPart(logoPart);

        mimeMessage.setContent(multipart);
        return mimeMessage;
    }

}
