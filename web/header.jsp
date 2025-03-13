<%-- 
    Document   : header
    Created on : 9 Mar 2025, 13:41:27
    Author     : Sanduni
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Fetch user role and username from session
    String userRole = (String) session.getAttribute("userRole");
    String username = (String) session.getAttribute("username");

    if (userRole == null) {
        userRole = "guest"; // Default role if not logged in
    }

    Boolean isFirstLogin = (Boolean) session.getAttribute("isFirstLogin");

    if ("admin".equals(userRole) && (isFirstLogin == null || isFirstLogin)) {
        session.setAttribute("isFirstLogin", false); // Set flag to false after first redirect
        response.sendRedirect("admin_home.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Header</title>
        <link rel="stylesheet" href="CSS/styles.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            .user-info {
                float: right;
                display: flex;
                align-items: center;
                margin-right: 20px;
            }
            .user-info i {
                font-size: 18px;
                margin-right: 8px;
            }
            .user-info span {
                font-weight: bold;
                margin-right: 15px;
            }
            .dropdown {
                position: relative;
                display: inline-block;
            }
            .dropdown-content {
                display: none;
                position: absolute;
                right: 0;
                background-color: #fff;
                min-width: 150px;
                box-shadow: 0px 4px 8px rgba(0,0,0,0.2);
                z-index: 10;
            }
            .dropdown:hover .dropdown-content {
                display: block;
            }
            .dropdown-content a {
                color: black;
                padding: 8px 12px;
                text-decoration: none;
                display: block;
            }
            .dropdown-content a:hover {
                background-color: #f1f1f1;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <header>
            <nav>
                <ul>

                    <% if (!userRole.equals("admin")) {%>

                    <li><a href="index.jsp" class="logo">Cab Booking</a></li>
                        <% }%>


                    <% if (userRole.equals("admin")) { %>
                    <li><a href="admin_home.jsp" class="logo">Cab Booking</a></li>
                    <li><a href="admin_home.jsp">Home</a></li>
                     <li class="dropdown">
                        <a href="#">Vehicle <i class="fas fa-caret-down"></i></a>
                        <div class="dropdown-content">
                            <a href="vehicle-registration.jsp">Vehicle Registration</a>
                            <a href="vehicleListJSP.jsp">Vehicle List</a>
                        </div>
                    </li>

                    <!-- Driver Dropdown -->
                    <li class="dropdown">
                        <a href="#">Driver <i class="fas fa-caret-down"></i></a>
                        <div class="dropdown-content">
                            <a href="driver_registration.jsp">Driver Registration</a>
                            <a href="DriverListJSP.jsp">Driver List</a>
                        </div>
                    </li>
                    <li><a href="bookingList.jsp">All Bookings</a></li>
                    <li><a href="CustomerList.jsp">All Customers</a></li>
                    <li><a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                        <% } else if (userRole.equals("driver")) { %>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="driver_dashboard.jsp">Driver Dashboard</a></li>
                    <li><a href="view_bookings.jsp">View Bookings</a></li>
                        <% } else if (userRole.equals("customer")) { %>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="frame.jsp">Book a Cab</a></li>
                    <li><a href="my_bookings.jsp">My Bookings</a></li>
                        <% } else { %>
                    <li><a href="login.jsp">Login</a></li>
                    <li><a href="CustomerRegistrationJSP.jsp">Register</a></li>
                        <% } %>

                    <li><a href="help.jsp">Help</a></li>

                    <% if (!userRole.equals("guest") && !userRole.equals("admin")) {%>

                    <!-- User Profile Section -->
                    <li class="user-info dropdown">
                        <i class="fas fa-user-circle"></i>

                        <div class="dropdown-content">
                            <span><%= username%></span>
                            <a href="edit_profile.jsp"><i class="fas fa-user-edit"></i> Edit Profile</a>
                            <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
                        </div>
                    </li>
                    <% }%>
                </ul>
            </nav>
        </header>
    </body>
</html>
