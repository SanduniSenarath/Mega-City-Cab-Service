package util;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * Utility class for sending emails.
 */
public class SendEmail {

    private static final String FROM_EMAIL = "no.reply.megacity.cabservice@gmail.com";
    private static final String PASSWORD = "pbkm acgl qsji xteq";  // Consider using environment variables for security.
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "465";

    /**
     * Sends an email with the specified subject and message.
     *
     * @param toEmail Recipient's email address
     * @param subject Email subject
     * @param messageBody Email message body
     */
    public static void sendEmail(String toEmail, String subject, String messageBody) {
        Properties props = new Properties();
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.ssl.trust", SMTP_HOST);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setText(messageBody);

            Transport.send(message);
            System.out.println("Email sent successfully to " + toEmail);
        } catch (MessagingException e) {
            System.err.println("Failed to send email to " + toEmail + ": " + e.getMessage());
        }
    }

    /**
     * Sends a welcome email to a new driver.
     *
     * @param toEmail Recipient's email
     * @param driverName Driver's name
     */
    public static void sendWelcomeEmail(String toEmail, String driverName) {
        String subject = "Welcome to Mega City Cab Service!";
        String message = "Dear " + driverName + ",\n\n"
                + "Welcome to Mega City Cab Service! Your registration was successful.\n"
                + "You can now log in using your username and password.\n\n"
                + "Best regards,\nMega City Cab Service Team\n"
                + "no.reply.megacity.cabservice@gmail.com\n"
                + "+94 33 2246638";

        sendEmail(toEmail, subject, message);
    }

    /**
     * Sends an assignment email to a driver.
     *
     * @param toEmail Recipient's email
     * @param driverName Driver's name
     * @param vehicleNo Assigned vehicle number
     */
    public static void sendAssignmentEmail(String toEmail, String driverName, String vehicleNo) {
        String subject = "Vehicle Assignment Notification";
        String message = "Dear " + driverName + ",\n\n"
                + "We are pleased to inform you that you have been assigned to drive Vehicle No: **" + vehicleNo + "**.\n"
                + "Please ensure that you follow all safety protocols and company guidelines while on duty.\n\n"
                + "If you have any questions or concerns, feel free to reach out to our support team.\n\n"
                + "Safe driving!\n\n"
                + "Best Regards,\n"
                + "Mega City Cab Service Team\n"
                + "no.reply.megacity.cabservice@gmail.com\n"
                + "+94 33 2246638";

        sendEmail(toEmail, subject, message);
    }

    /**
     * Sends an email informing a driver that their assigned vehicle has been
     * changed.
     *
     * @param toEmail Recipient's email
     * @param driverName Driver's name
     * @param oldVehicleNo Previous vehicle number
     * @param newVehicleNo New vehicle number
     */
    public static void sendVehicleChangeEmail(String toEmail, String driverName, String newVehicleNo) {
        String subject = "Vehicle Assignment Updated";
        String message = "Dear " + driverName + ",\n\n"
                + "We would like to inform you that your assigned vehicle has been **updated**.\n\n"
                + " New Vehicle No: " + newVehicleNo + "\n\n"
                + "Please check the new vehicle before starting your shift.\n"
                + "If you have any concerns, feel free to contact the support team.\n\n"
                + "Safe driving!\n\n"
                + "Best Regards,\n"
                + "Mega City Cab Service Team\n"
                + "no.reply.megacity.cabservice@gmail.com\n"
                + "+94 33 2246638";

        sendEmail(toEmail, subject, message);
    }

    /**
     * Sends a booking confirmation email to a customer with all booking
     * details.
     *
     * @param toEmail Customer's email address
     * @param customerName Customer's name
     * @param bookingDate Date of the booking
     * @param pickupLocation Pickup location
     * @param dropoffLocation Drop-off location
     * @param vehicleType Vehicle type booked
     * @param fare Total fare amount
     * @param bookingId Unique booking ID
     */
    public static void sendBookingConfirmationEmail(String toEmail, String customerName,
            String bookingDate, String pickupLocation, String dropoffLocation,
            double distance, double fare, String bookingId) {

        String subject = "Booking Confirmation - Mega City Cab Service";
        String message = "Dear " + customerName + ",\n\n"
                + "We are pleased to confirm your booking with Mega City Cab Service.\n\n"
                + "Booking Details:\n"
                + "Booking ID: " + bookingId + "\n"
                + "Date: " + bookingDate + "\n"
                + "Pickup Location: " + pickupLocation + "\n"
                + "Drop-off Location: " + dropoffLocation + "\n"
                + "distance : " + distance + " km\n"
                + "Total Fare: LKR " + fare + "\n\n"
                + "Thank you for choosing Mega City Cab Service! We look forward to serving you.\n\n"
                + "Best Regards,\n"
                + "Mega City Cab Service Team**\n"
                + "no.reply.megacity.cabservice@gmail.com\n"
                + "+94 33 2246638";

        sendEmail(toEmail, subject, message);
    }

}
