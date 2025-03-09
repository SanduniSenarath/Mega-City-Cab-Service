<%-- 
    Document   : index
    Created on : 9 Mar 2025, 12:23:36
    Author     : Sanduni
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Fetch user role and username from session
    String userRole = (String) session.getAttribute("userRole");
    String username = (String) session.getAttribute("username");
    if (userRole == null) {
        userRole = "guest"; 
    }
     if (username != null && username.equals("admin")) {
        response.sendRedirect("admin_home.jsp");
        return; // Stop further execution
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cab Booking System</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <!-- Header with Role-Based Customization -->
    <header>
        <nav>
            <ul>
                <li><a href="index.jsp" class="logo">Cab Booking</a></li>
                
                <% if (userRole.equals("admin")) { %>
                <li><a href="admin_home.jsp" class="logo">Cab Booking</a></li>
                <li><a href="admin_home.jsp">Home</a></li>
                <li><a href="vehicle-registration.jsp">Vehicle Registration</a></li>
                <li><a href="driver_registration.jsp">Driver Registration</a></li>
                <li><a href="view_bookings.jsp">All Bookings</a></li>
                <li><a href="view_customers.jsp">All Customers</a></li>
                <li><a href="logout.jsp">Logout</a></li>
                <% } else if (userRole.equals("driver")) { %>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="driver_dashboard.jsp">Driver Dashboard</a></li>
                    <li><a href="view_bookings.jsp">View Bookings</a></li>
                <% } else if (userRole.equals("customer")) { %>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="AddBookings.jsp">Book a Cab</a></li>
                    <li><a href="my_bookings.jsp">My Bookings</a></li>
                <% } else { %>
                    <li><a href="login.jsp">Login</a></li>
                    <li><a href="CustomerRegistrationJSP.jsp">Register</a></li>
                <% } %>
                <li><a href="help.jsp">Help</a></li>
                <% if (!userRole.equals("guest")) { %>
                    <li><a href="logout.jsp">Logout</a></li>
                <% } %>
            </ul>
        </nav>
    </header>

    <!-- Main Content -->
    <main>
        <!-- Introduction Section -->
        <section class="intro-section">
            <h1>Welcome to the Cab Booking System</h1>
            <p>Book your ride with ease and convenience. Whether you're commuting to work, heading to the airport, or exploring the city, we've got you covered.</p>
            <% if (userRole.equals("guest")) { %>
                <a href="login.jsp" class="cta-button">Login to Book Now</a>
            <% } else { %>
                <a href="AddBookings.jsp" class="cta-button">Book Now</a>
            <% } %>
        </section>

        <!-- Features Section -->
        <section class="features-section">
            <h2>Why Choose Us?</h2>
            <div class="features-container">
                <div class="feature">
                    <h3>Fast & Reliable</h3>
                    <p>Get a cab in minutes with our fast and reliable service.</p>
                </div>
                <div class="feature">
                    <h3>Affordable Prices</h3>
                    <p>Enjoy competitive pricing with no hidden charges.</p>
                </div>
                <div class="feature">
                    <h3>24/7 Support</h3>
                    <p>We're here for you round the clock. Contact us anytime!</p>
                </div>
            </div>
        </section>
    </main>

    <!-- Footer -->
    <footer>
        <p>&copy; 2023 Cab Booking System. All rights reserved.</p>
        <ul>
            <li><a href="privacy_policy.jsp">Privacy Policy</a></li>
            <li><a href="terms_of_service.jsp">Terms of Service</a></li>
            <li><a href="contact_us.jsp">Contact Us</a></li>
        </ul>
    </footer>
</body>
</html>