<%-- 
    Document   : AddBookings
    Created on : 8 Mar 2025, 22:32:09
    Author     : Sanduni
--%>

<%@ page import="java.util.UUID" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Bookings</title>
        <link rel="stylesheet" href="styles.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f9;
                color: #333;
                align-items: center;
                height: 100vh;
            }

            .container {
                width: 60%;
                max-width: 1200px;
                margin: 20px;
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                margin-left: 320px;
            }

            h1 {
                text-align: center;
                font-size: 2rem;
                color: #2c3e50;
            }

            .form-section {
                margin-bottom: 30px;
            }

            h2 {
                font-size: 1.5rem;
                margin-bottom: 10px;
            }

            form input {
                width: 100%;
                padding: 10px;
                margin: 5px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            form input[readonly] {
                background-color: #e9ecef;
                cursor: not-allowed;
            }

            form button {
                width: 100%;
                padding: 10px;
                background-color: #2ecc71;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 1rem;
            }

            form button:hover {
                background-color: #27ae60;
            }
        </style>
        <script>
            document.addEventListener('DOMContentLoaded', function () {

                let pricePerKm = 0;

                fetch('http://localhost:8080/Mega_City_Cab_Service/api/prices/1')
                        .then(response => response.json())
                        .then(data => {
                            pricePerKm = data.price; // Assign the fetched price
                        })
                        .catch(error => console.error('Error fetching price:', error));
                // Generate a random book number
                const bookNumber = Math.floor(Math.random() * 1000000); // Adjust range as needed
                document.getElementById('bookNumber').value = bookNumber;

                // Get empSchNo from the URL
                const urlParams = new URLSearchParams(window.location.search);
                const empSchNo = urlParams.get('empSchNo');
                if (empSchNo) {
                    document.getElementById('empSchNo').value = empSchNo;
                }

                document.getElementById('distance').addEventListener('input', function () {
                    const distance = parseFloat(this.value);
                    if (!isNaN(distance) && pricePerKm > 0) {
                        document.getElementById('amount').value = (distance * pricePerKm).toFixed(2);
                    } else {
                        document.getElementById('amount').value = '';
                    }
                });
                // Disable past dates and times
                const dateInput = document.getElementById('date');
                const timeInput = document.getElementById('time');

                const now = new Date();
                const currentDate = now.toISOString().split('T')[0]; // Get current date in YYYY-MM-DD format
                const currentTime = now.toTimeString().split(' ')[0].substring(0, 5); // Get current time in HH:MM format

                // Set min date to today
                dateInput.setAttribute('min', currentDate);

                // Set min time to current time if today's date is selected
                dateInput.addEventListener('change', function () {
                    if (this.value === currentDate) {
                        timeInput.setAttribute('min', currentTime);
                    } else {
                        timeInput.removeAttribute('min'); // Allow any time for future dates
                    }


                });



                document.getElementById('bookingForm').addEventListener('submit', function (e) {
                    e.preventDefault();

                    const booking = {
                        bookNumber: document.getElementById('bookNumber').value,
                        startLocation: document.getElementById('startLocation').value,
                        endLocation: document.getElementById('endLocation').value,
                        distance: parseFloat(document.getElementById('distance').value),
                        amount: parseFloat(document.getElementById('amount').value),
                        empSchNo: document.getElementById('empSchNo').value,
                        username: document.getElementById('username').value,
                        date: document.getElementById('date').value,
                        time: document.getElementById('time').value
                    };

                    if (Object.values(booking).some(value => !value)) {
                        alert("Please fill in all fields.");
                        return;
                    }

                    // Use the provided endpoint to add the booking
                    fetch('http://localhost:8080/Mega_City_Cab_Service/api/schedules/add', {
                        method: 'POST',
                        headers: {'Content-Type': 'application/json'},
                        body: JSON.stringify(booking),
                    })
                            .then(response => response.json())
                            .then(data => {
                                alert(data.message);
                                if (data.success) {
                                    // Clear the form after successful submission
                                    document.getElementById('bookingForm').reset();
                                }
                            })
                            .catch(error => alert('Error adding booking: ' + error));
                });
            });
        </script>
    </head>
    <body>
     
        <div class="container">
            <h1>Add Bookings</h1>
            <section class="form-section">

                <h2>Add Booking</h2>
                <form id="bookingForm">
                    <!-- Book Number (Auto-generated and read-only) -->
                    <input type="text" id="bookNumber" name="bookNumber" placeholder="Book Number" readonly>

                    <!-- Start Location -->
                    <input type="text" id="startLocation" name="startLocation" placeholder="Start Location" required>

                    <!-- End Location -->
                    <input type="text" id="endLocation" name="endLocation" placeholder="End Location" required>

                    <!-- Distance -->
                    <input type="number" id="distance" name="distance" placeholder="Distance" required>

                    <!-- Amount -->
                    <input type="number" id="amount" name="amount" placeholder="Amount" readonly>

                    <!-- Employee Schedule Number (Read-only, taken from URL) -->
                    <input type="text" id="empSchNo" name="empSchNo" placeholder="Employee Schedule Number" readonly>

                    <!-- Username (Read-only, taken from session) -->
                    <input type="text" id="username" name="username" placeholder="Username" value="<%= session.getAttribute("username")%>" readonly>

                    <!-- Date -->
                    <input type="date" id="date" name="date" required>

                    <!-- Time -->
                    <input type="time" id="time" name="time" required>

                    <!-- Submit Button -->
                    <button type="submit">Add Booking</button>
                </form>
            </section>
        </div>

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