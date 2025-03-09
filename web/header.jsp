<%-- 
    Document   : header
    Created on : 9 Mar 2025, 13:41:27
    Author     : Sanduni
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Fetch user role and username from session
    String userRole = (String) session.getAttribute("userRole");
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Header</title>
    <link rel="stylesheet" href="CSS/styles.css">
</head>
<body>
    <!-- Header -->
    <header>
        <nav>
            <ul>
                <li><a href="admin_home.jsp" class="logo">Cab Booking</a></li>
                <li><a href="admin_home.jsp">Home</a></li>
                <% if ("admin".equals(userRole)) { %>
                    <li><a href="vehicle-registration.jsp">Vehicle Registration</a></li>
                    <li><a href="driver_registration.jsp">Driver Registration</a></li>
                    <li><a href="view_bookings.jsp">All Bookings</a></li>
                    <li><a href="view_customers.jsp">All Customers</a></li>
                <% } %>
                <li><a href="logout.jsp">Logout</a></li>
            </ul>
        </nav>
    </header>

    <!-- Current Date and Time -->
    <div class="current-date-time">
        <p id="date-time"></p>
    </div>

    <!-- JavaScript to Display Current Date and Time -->
    <script>
        function updateDateTime() {
            const now = new Date();
            const dateTimeString = now.toLocaleString(); // Format: "3/9/2025, 1:23:45 PM"
            document.getElementById("date-time").textContent = "Current Date and Time: " + dateTimeString;
        }

        // Update the date and time every second
        setInterval(updateDateTime, 1000);

        // Initialize the date and time immediately
        updateDateTime();
    </script>
</body>
</html>