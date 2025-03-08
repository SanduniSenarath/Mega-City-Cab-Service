/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Sanduni
 * no.reply.megacity.cabservice@gmail.com
 */


public class SendEmail {

    public static void sendEmail(String toEmail, String driverName) {
        final String fromEmail = "no.reply.megacity.cabservice@gmail.com"; // Your email
        final String password = "pbkm acgl qsji xteq";  // Use an App Password if using Gmail
        
        // SMTP server configuration
        Properties props = new Properties();
props.put("mail.smtp.host", "smtp.gmail.com");
props.put("mail.smtp.port", "465"); // For SSL
props.put("mail.smtp.auth", "true");
props.put("mail.smtp.ssl.enable", "true");
props.put("mail.smtp.ssl.trust", "smtp.gmail.com"); // Trust the certificate

 // Trust the certificate

        // Authenticate and send email
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Welcome to Mega City Cab Service!");
            message.setText("Dear " + driverName + ",\n\n"
                    + "Welcome to Mega City Cab Service! Your registration was successful.\n"
                    + "You can now log in using your username and password.\n\n"
                    + "Best regards,\nMega City Cab Service Team");

            Transport.send(message);
            System.out.println("Email sent successfully to " + toEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}

