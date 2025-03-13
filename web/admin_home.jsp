<%-- 
    Document   : admin_home
    Created on : 9 Mar 2025, 12:43:01
    Author     : Sanduni
--%>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - Cab Booking System</title>
        <link rel="stylesheet" href="styles.css">
        <style>
            /* General Styles */
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                color: #333;
                margin: 0;
                padding: 0;
             
                flex-direction: column;
                align-items: center;
            }

            /* Main Section */
            main {
                width: 90%;
                max-width: 1200px;
                text-align: center;
                margin-top: 50px;
                   margin-left: 130px;
            }

            /* Welcome Section */
            .welcome-section {
                background: rgb(22, 50, 91);
                background: linear-gradient(135deg, rgba(22, 50, 91, 1) 0%, rgba(34, 123, 148, 1) 100%);
                color: white;
                padding: 40px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                
            }

            .welcome-section h1 {
                font-size: 2.5rem;
                margin-bottom: 20px;
            }

            .welcome-section p {
                font-size: 1.2rem;
                margin-bottom: 20px;
            }

            .current-date-time {
                font-size: 1rem;
                margin-top: 10px;
            }

            /* Admin Features Section */
            .admin-features-section {
                margin-top: 50px;
            }

            .admin-features-section h2 {
                font-size: 2rem;
                margin-bottom: 30px;
                color: #343a40;
            }

            .admin-features-container {
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
                gap: 20px;
            }

            .admin-feature {
                flex: 1;
                min-width: 280px;
                max-width: 350px;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            .admin-feature h3 {
                font-size: 1.5rem;
                margin-bottom: 15px;
                color: #007bff;
            }

            .admin-feature p {
                font-size: 1rem;
                color: #6c757d;
                margin-bottom: 20px;
            }

            .admin-button {
                display: inline-block;
                padding: 10px 20px;
                font-size: 1rem;
                color: white;
                background-color: #16325B;
                border-radius: 5px;
                text-decoration: none;
                transition: 0.3s;
                margin: 5px;
            }

            .admin-button:hover {
                background-color: #227B94;
            }

          

            /* Responsive Design */
            @media (max-width: 768px) {
                .admin-features-container {
                    flex-direction: column;
                    align-items: center;
                }

                .welcome-section h1 {
                    font-size: 2rem;
                }

                .welcome-section p {
                    font-size: 1rem;
                }
            }
        </style>
    </head>
    <body>
        

        <!-- Main Content -->
        <main>
            <!-- Welcome Section -->
            <section class="welcome-section">
                <h1>Welcome, <%= username %>!</h1>
                <p>Manage your cab booking system efficiently and effectively.</p>
                <div class="current-date-time">
                    <p id="date-time"></p>
                </div>
            </section>

            <!-- Admin Features Section -->
            <section class="admin-features-section">
                <h2>Admin Dashboard</h2>
                <div class="admin-features-container">
                    <!-- Vehicle Management -->
                    <div class="admin-feature">
                        <h3>Vehicle Management</h3>
                        <p>Register and manage vehicles in the system.</p>
                        <a href="vehicle-registration.jsp" class="admin-button">Add Vehicle</a>
                        <a href="vehicleListJSP.jsp" class="admin-button">View Vehicles</a>
                    </div>

                    <!-- Driver Management -->
                    <div class="admin-feature">
                        <h3>Driver Management</h3>
                        <p>Register and manage drivers in the system.</p>
                        <a href="driver_registration.jsp" class="admin-button">Add Driver</a>
                        <a href="DriverListJSP.jsp" class="admin-button">View Drivers</a>
                    </div>

                    <!-- Booking Management -->
                    <div class="admin-feature">
                        <h3>Booking Management</h3>
                        <p>View and manage all bookings.</p>
                        <a href="bookingList.jsp" class="admin-button">View Bookings</a>
                    </div>

                    <!-- Customer Management -->
                    <div class="admin-feature">
                        <h3>Customer Management</h3>
                        <p>View and manage customer details.</p>
                        <a href="CustomerList.jsp" class="admin-button">View Customers</a>
                    </div>
                    
                    <div class="admin-feature">
                        <h3>Vehicle Driver Management</h3>
                        <p>View and manage customer details.</p>
                        <a href="vehicleDriverList.jsp" class="admin-button">View Assign Drivers</a>
                    </div>
                </div>
            </section>
        </main>

        <!-- Footer -->
        <footer>
            <p>&copy; 2023 Cab Booking System. All rights reserved.</p>
            <ul>
                <li><strong>Phone:</strong> 0332246638</li>
                <li><strong>Address:</strong> Maradana, Colombo 10</li>
                <li><strong>Email:</strong> no.reply.megacity.cabservice@gmail.com</li>
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