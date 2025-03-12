<%-- 
    Document   : admin_home
    Created on : 9 Mar 2025, 12:43:01
    Author     : Sanduni
--%>
<%@ page import="java.sql.*" %>
<%
    // Fetch user role and username from session
    String userRole = (String) session.getAttribute("userRole");
    String username = (String) session.getAttribute("username");

    // Redirect to login page if not an admin
    if (!"admin".equals(userRole)) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - Cab Booking System</title>
        <link rel="stylesheet" href="CSS/adminDashboard.css">
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <!-- Header -->
        <header>
            <nav>
                <ul>
                    <li><a href="admin_home.jsp" class="logo">Cab Booking</a></li>
                    <li><a href="admin_home.jsp">Home</a></li>
                    <li><a href="vehicle-registration.jsp">Vehicle Registration</a></li>
                    <li><a href="driver_registration.jsp">Driver Registration</a></li>
                    <li><a href="view_bookings.jsp">All Bookings</a></li>
                    <li><a href="view_customers.jsp">All Customers</a></li>
                    <li><a href="logout.jsp">Logout</a></li>
                </ul>
            </nav>
        </header>

        <!-- Main Content -->
        <main>
            <!-- Current Date and Time -->


            <div class="admin-welcome">

                <h1>Welcome,  <%= username%>!</h1>
                <p>Manage your cab booking system efficiently.</p>
                <div class="current-date-time">
                    <p id="date-time"></p>
                </div>
            </div>

            <!-- Functionality Boxes -->
            <div class="admin-boxes">
                <!-- Vehicle Registration -->
                <div class="admin-box">
                    <h2>Vehicle Registration</h2>
                    <p>Register new vehicles into the system.</p>
                    <a href="vehicle-registration.jsp" class="admin-button">Add new</a>
                    <a href="vehicleListJSP.jsp" class="admin-button">List</a>
                </div>

                <!-- Driver Registration -->
                <div class="admin-box">
                    <h2>Driver Registration</h2>
                    <p>Register new drivers into the system.</p>
                    <a href="driver_registration.jsp" class="admin-button">Register new</a>
                    <a href="DriverListJSP.jsp" class="admin-button">List</a>
                </div>

                <!-- All Bookings -->
                <div class="admin-box">
                    <h2>All Bookings</h2>
                    <p>View and manage all bookings.</p>
                    <a href="bookingList.jsp" class="admin-button">View All Bookings</a>
                </div>

                <!-- All Customer Details -->
                <div class="admin-box">
                    <h2>All Customer Details</h2>
                    <p>View and manage all customer details.</p>
                    <a href="CustomerList.jsp" class="admin-button">View All Customers</a>
                </div>
            </div>
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