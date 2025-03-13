<%-- 
    Document   : index
    Created on : 9 Mar 2025, 12:23:36
    Author     : Sanduni
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cab Booking System</title>
        <link rel="stylesheet" href="styles.css">
        <style>
            /* General Styles */
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                color: #333;
                margin: 0;
                padding: 0;
                /*display: flex;*/
                flex-direction: column;
                align-items: center;
            }

            /* Main Section */
            main {
                width: 90%;
                max-width: 1200px;
                text-align: center;
                margin-top: 50px;
                margin-left: 150px;
            }

            /* Introduction Section */
            .intro-section {
                 background: rgb(22, 50, 91);
                background: linear-gradient(135deg, rgba(22, 50, 91, 1) 0%, rgba(34, 123, 148, 1) 100%);
                color: white;
                padding: 40px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);

            }

            .intro-section h1 {
                font-size: 2.5rem;
                margin-bottom: 20px;
            }

            .intro-section p {
                font-size: 1.2rem;
                margin-bottom: 20px;
            }

            .cta-button {
                display: inline-block;
                padding: 12px 25px;
                font-size: 1.2rem;
                color: white;
                background-color: #FF9D23;
                border-radius: 5px;
                text-decoration: none;
                transition: 0.3s;
            }

            .cta-button:hover {
                background-color: #FFCF50;
            }

            /* Features Section */
            .features-section {
                margin-top: 50px;
            }

            .features-section h2 {
                font-size: 2rem;
                margin-bottom: 30px;
                color: #343a40;
            }

            .features-container {
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
                gap: 20px;
            }

            .feature {
                flex: 1;
                min-width: 280px;
                max-width: 350px;
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            .feature h3 {
                font-size: 1.5rem;
                margin-bottom: 15px;
                color: #007bff;
            }

            .feature p {
                font-size: 1rem;
                color: #6c757d;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .features-container {
                    flex-direction: column;
                    align-items: center;
                }

                .intro-section h1 {
                    font-size: 2rem;
                }

                .intro-section p {
                    font-size: 1rem;
                }
            }
        </style>
    </head>
    <body>
        <!-- Header with Role-Based Customization -->


        <!-- Main Content -->
        <main>
            <!-- Introduction Section -->
            <section class="intro-section">
                <h1>Welcome to the Cab Booking System</h1>
                <p>Book your ride with ease and convenience. Whether you're commuting to work, heading to the airport, or exploring the city, we've got you covered.</p>
                <% if (userRole.equals("guest")) { %>
                <a href="login.jsp" class="cta-button">Login to Book Now</a>
                <% } else { %>
                <a href="frame.jsp" class="cta-button">Book Now</a>
                <% }%>
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
                <li><strong>Phone:</strong> 0332246638</li>
                <li><strong>Address:</strong> Maradana, Colombo 10</li>
                <li><strong>Email:</strong> no.reply.megacity.cabservice@gmail.com</li>
            </ul>

        </footer>
    </body>
</html>