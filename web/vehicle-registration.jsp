<%-- 
    Document   : vehicle-registration.jsp
    Created on : 15 Feb 2025, 14:20:48
    Author     : Sanduni
--%>
<%@ page import="java.sql.*" %>
   <%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Vehicle Registration</title>
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
        
        <!-- Main Content -->
        <main>
            <h1>Register a New Vehicle</h1>
            <div id="message" class="message"></div>

            <form id="vehicleForm" class="form">
                <table class="form-table">
                    <tr>
                        <td><label for="vehicleNumber">Vehicle Number:</label></td>
                        <td><input type="text" id="vehicleNumber" name="vehicleNumber" required />
                            <small id="vehicleNumberError" class="error-message"></small></td>
                    </tr>
                    <tr>
                        <td><label for="availableSeats">Available Seats:</label></td>
                        <td><input type="number" id="availableSeats" name="availableSeats" required />
                            <small id="availableSeatsError" class="error-message"></small></td>
                    </tr>
                    <tr>
                        <td><label for="type">Vehicle Type:</label></td>
                        <td>
                            <select id="type" name="type" required>
                                <option value="Car">Car</option>
                                <option value="Van">Van</option>
                            </select>
                            <small id="typeError" class="error-message"></small>
                        </td>
                    </tr>
                    <tr>
                        <td><label for="owner">Owner:</label></td>
                        <td><input type="text" id="owner" name="owner" required />
                            <small id="ownerError" class="error-message"></small></td>
                    </tr>
                    <tr>
                        <td><label for="colour">Colour:</label></td>
                        <td><input type="text" id="colour" name="colour" required />
                            <small id="colourError" class="error-message"></small></td>
                    </tr>
                    <tr>
                        <td><label for="fuelType">Fuel Type:</label></td>
                        <td>
                            <select id="fuelType" name="fuelType" required>
                                <option value="Petrol">Petrol</option>
                                <option value="Diesel">Diesel</option>
                                <option value="Electric">Electric</option>
                            </select>
                            <small id="fuelTypeError" class="error-message"></small>
                        </td>
                    </tr>
                    <tr>
                        <td><label for="chassisNumber">Chassis Number:</label></td>
                        <td><input type="text" id="chassisNumber" name="chassisNumber" required />
                            <small id="chassisNumberError" class="error-message"></small></td>
                    </tr>
                    <tr>
                        <td><label for="brandName">Brand Name:</label></td>
                        <td><input type="text" id="brandName" name="brandName" required />
                            <small id="brandNameError" class="error-message"></small></td>
                    </tr>
                </table>

                <div class="form-buttons">
                    <button type="submit" class="btn-submit">Register Vehicle</button>
                    <button type="button" id="clearButton" class="btn-clear">Clear</button>
                </div>
            </form>
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

        <script>
            document.getElementById("vehicleForm").addEventListener("submit", function (event) {
                event.preventDefault();

                const vehicleData = {
                    vehicleNumber: document.getElementById("vehicleNumber").value,
                    availableSeats: document.getElementById("availableSeats").value,
                    type: document.getElementById("type").value,
                    owner: document.getElementById("owner").value,
                    colour: document.getElementById("colour").value,
                    fuelType: document.getElementById("fuelType").value,
                    chassisNumber: document.getElementById("chassisNumber").value,
                    brandName: document.getElementById("brandName").value
                };

                fetch('http://localhost:8080/Mega_City_Cab_Service/api/vehicles/add', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(vehicleData)
                })
                        .then(response => response.json())
                        .then(data => {
                            const messageDiv = document.getElementById("message");
                            if (data.success) {
                                messageDiv.innerHTML = data.message;
                                messageDiv.className = "message success";
                                messageDiv.style.display = 'block';

                                // Clear all fields after success
                                document.getElementById("vehicleForm").reset();

                            } else {
                                messageDiv.innerHTML = data.message;
                                messageDiv.className = "message error";
                                messageDiv.style.display = 'block';
                            }

                            // Hide message after 5 seconds
                            setTimeout(() => {
                                messageDiv.style.display = 'none';
                            }, 5000);
                        })
                        .catch(error => {
                            const messageDiv = document.getElementById("message");
                            messageDiv.innerHTML = "An error occurred: " + error.message;
                            messageDiv.className = "message error";
                            messageDiv.style.display = 'block';

                            // Hide message after 5 seconds
                            setTimeout(() => {
                                messageDiv.style.display = 'none';
                            }, 5000);
                        });
            });

            // Clear form fields
            document.getElementById("clearButton").addEventListener("click", function () {
                document.getElementById("vehicleForm").reset();
            });
        </script>
    </body>
</html>
