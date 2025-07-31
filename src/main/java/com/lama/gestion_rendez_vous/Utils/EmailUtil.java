package com.lama.gestion_rendez_vous.Utils;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtil {

    public static void sendConfirmationEmail(String toEmail, String patientName, String dateHeure, String confirmationLink) {
        String fromEmail = "falllama660@gmail.com";
        String password = "svqq rudc nphk nacc";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(fromEmail, password);
                    }
                });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail)
            );
            message.setSubject("Confirmation de votre rendez-vous");

            String content = "Bonjour " + patientName + ",\n\n"
                    + "Votre rendez-vous est prévu pour le **" + dateHeure + "**.\n"
                    + "Merci de confirmer votre présence en cliquant sur ce lien :\n"
                    + confirmationLink + "\n\n"
                    + "Cordialement,\nCabinet Médical,\nMediDental";

            message.setText(content);

            Transport.send(message);
            System.out.println("Email envoyé à " + toEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
