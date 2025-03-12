<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Fetch user role and username from session
    String userRole = (String) session.getAttribute("userRole");
    String username = (String) session.getAttribute("username");
    if (userRole == null) {
        userRole = "guest";
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Customer Registration</title>
        <link rel="stylesheet" href="styles.css">
        <link rel="stylesheet" href="CSS/customer-registration.css">
        <style>
            .message {
                width: 100%;
                text-align: center;
                font-size: 18px;
                margin-bottom: 20px;
                padding: 10px;
                display: none;
            }
            .message.success {
                background-color: #4CAF50;
                color: white;
            }
            .message.error {
                background-color: #f44336;
                color: white;
            }
            .form-table td {
                padding: 10px;
            }
            .form-buttons {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <header>
            <nav>
                <ul>
                    <li><a href="index.jsp" class="logo">Cab Booking</a></li>

                    <% if (userRole.equals("admin")) { %>
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
                        <% }%>
                </ul>
            </nav>
        </header>

        <!-- Main Content -->
        <main>
            <h1>Register a New Customer</h1>
            <div id="message" class="message"></div>

            <form id="customerForm" class="form">
                <table class="form-table">


                    <!-- Contact Details and Address Box -->
                    <tr>
                        <td colspan="2"><h2>Contact Details</h2></td>
                    </tr>
                    <tr>
                        <td><label for="name">Name:</label></td>
                        <td><input type="text" id="name" name="name" required />
                            <small id="nameError" class="error-message"></small></td>
                    </tr>
                    <tr>
                        <td><label for="nic">NIC:</label></td>
                        <td><input type="text" id="nic" name="nic" required />
                            <small id="nicError" class="error-message"></small></td>
                    </tr>

                    <tr>
                        <td><label for="email">Email:</label></td>
                        <td><input type="email" id="email" name="email" required />
                            <small id="emailError" class="error-message"></small></td>
                    </tr>
                    <tr>
                        <td><label for="phoneno">Phone Number:</label></td>
                        <td><input type="text" id="phoneno" name="phoneno" required />
                            <small id="phonenoError" class="error-message"></small></td>
                    </tr>
                    <tr>
                        <td><label for="addressLine1">Address Line 1:</label></td>
                        <td><input type="text" id="addressLine1" name="addressLine1" required />
                            <small id="addressLine1Error" class="error-message"></small></td>
                    </tr>
                    <tr>
                        <td><label for="addressLine2">Address Line 2:</label></td>
                        <td><input type="text" id="addressLine2" name="addressLine2" /></td>
                    </tr>
                    <tr>
                        <td><label for="addressLine3">Address Line 3:</label></td>
                        <td><input type="text" id="addressLine3" name="addressLine3" /></td>
                    </tr>

                    <!-- User Credentials Box -->
                    <tr>
                        <td colspan="2"><h2>Customer Details</h2></td>
                    </tr>
                    <tr>
                        <td><label for="username">Username:</label></td>
                        <td><input type="text" id="username" name="username" required />
                            <small id="usernameError" class="error-message"></small></td>
                    </tr>
                    <tr>
                        <td><label for="password">Password:</label></td>
                        <td><input type="password" id="password" name="password" required />
                            <small id="passwordError" class="error-message"></small></td>
                    </tr>
                    <tr>
                        <td><label for="confirmPassword">Confirm Password:</label></td>
                        <td><input type="password" id="confirmPassword" name="confirmPassword" required />
                            <small id="confirmPasswordError" class="error-message"></small></td>
                    </tr>
                </table>

                <div class="form-buttons">
                    <button type="submit" class="btn-submit">Register Customer</button>
                    <button type="button" id="clearButton" class="btn-clear">Clear</button>
                </div>
            </form>
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

        <script>
            // Form Validation Logic
            function validateEmail(email) {
                const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return regex.test(email);
            }

            function validateNIC(nic) {
                const regex = /^\d{9}[Vv]$|^\d{12}$/;
                return regex.test(nic);
            }

            function validatePhone(phone) {
                const regex = /^\d{10}$/;
                return regex.test(phone);
            }

            function validatePassword(password) {
                // Password must be at least 8 characters long, include letters and symbols
                const regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/;
                return regex.test(password);
            }

            document.getElementById("customerForm").addEventListener("submit", async function (e) {
                e.preventDefault();
                let formIsValid = true;
                const messageDiv = document.getElementById("message");

                // Clear previous error messages
                messageDiv.style.display = 'none';

                // Get values from form fields
                const username = document.getElementById("username").value;
                const password = document.getElementById("password").value;
                const confirmPassword = document.getElementById("confirmPassword").value;
                const email = document.getElementById("email").value;
                const nic = document.getElementById("nic").value;
                const phoneno = document.getElementById("phoneno").value;

                // Validate Fields
                if (password !== confirmPassword) {
                    document.getElementById("confirmPasswordError").textContent = "Passwords do not match.";
                    document.getElementById("confirmPasswordError").style.display = "block";
                    formIsValid = false;
                } else if (!validatePassword(password)) {
                    document.getElementById("passwordError").textContent = "Password must be at least 8 characters long and include at least one letter, one number, and one symbol.";
                    document.getElementById("passwordError").style.display = "block";
                    formIsValid = false;
                } else {
                    document.getElementById("confirmPasswordError").style.display = "none";
                    document.getElementById("passwordError").style.display = "none";
                }

                if (!validateEmail(email)) {
                    document.getElementById("emailError").textContent = "Invalid email format.";
                    document.getElementById("emailError").style.display = "block";
                    formIsValid = false;
                } else {
                    document.getElementById("emailError").style.display = "none";
                }

                if (!validateNIC(nic)) {
                    document.getElementById("nicError").textContent = "Invalid NIC format.";
                    document.getElementById("nicError").style.display = "block";
                    formIsValid = false;
                } else {
                    document.getElementById("nicError").style.display = "none";
                }

                if (!validatePhone(phoneno)) {
                    document.getElementById("phonenoError").textContent = "Phone number must be 10 digits.";
                    document.getElementById("phonenoError").style.display = "block";
                    formIsValid = false;
                } else {
                    document.getElementById("phonenoError").style.display = "none";
                }

                if (formIsValid) {
                    // Proceed with form submission if validation is successful
                    const customerData = {
                        nic: nic,
                        username: username,
                        name: document.getElementById("name").value,
                        email: email,
                        phoneno: phoneno,
                        address: [document.getElementById("addressLine1").value,
                            document.getElementById("addressLine2").value,
                            document.getElementById("addressLine3").value].filter(line => line.trim() !== "").join(", ")
                    };

                    const userData = {
                        username: username,
                        password: password,
                        role: "customer"
                    };

                    try {
                        const customerResponse = await fetch("http://localhost:8080/Mega_City_Cab_Service/api/customers/add", {
                            method: "POST",
                            headers: {"Content-Type": "application/json"},
                            body: JSON.stringify(customerData)
                        });

                        const userResponse = await fetch("http://localhost:8080/Mega_City_Cab_Service/api/users/add", {
                            method: "POST",
                            headers: {"Content-Type": "application/json"},
                            body: JSON.stringify(userData)
                        });

                        if (customerResponse.ok && userResponse.ok) {
                            messageDiv.textContent = "Registration successful!";
                            messageDiv.className = "message success";
                            messageDiv.style.display = 'block';
                            setTimeout(() => {
                                document.getElementById("customerForm").reset();
                                messageDiv.style.display = 'none';
                            }, 2000);
                        } else {
                            messageDiv.textContent = "Registration failed.";
                            messageDiv.className = "message error";
                            messageDiv.style.display = 'block';
                        }
                    } catch (error) {
                        messageDiv.textContent = "Error connecting to the server.";
                        messageDiv.className = "message error";
                        messageDiv.style.display = 'block';
                    }
                }
            });
        </script>
    </body>
</html>
