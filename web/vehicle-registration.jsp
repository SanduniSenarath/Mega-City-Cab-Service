<%-- 
    Document   : vehicle-registration.jsp
    Created on : 15 Feb 2025, 14:20:48
    Author     : Sanduni
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Registration</title>
     <link rel="stylesheet" href="CSS/styles.css">
</head>
<body>
    <h1>Register a New Vehicle</h1>

    <div id="message" class="message"></div>

    <form id="vehicleForm">
        <div>
            <label for="vehicleNumber">Vehicle Number:</label>
            <input type="text" id="vehicleNumber" name="vehicleNumber" required />
        </div>
        <div>
            <label for="availableSeats">Available Seats:</label>
            <input type="number" id="availableSeats" name="availableSeats" required />
        </div>
        <div>
            <label for="type">Vehicle Type:</label>
            <select id="type" name="type" required>
                <option value="Car">Car</option>
                <option value="Truck">Truck</option>
                <option value="Bus">Bus</option>
                <option value="Bike">Bike</option>
            </select>
        </div>
        <div>
            <label for="owner">Owner:</label>
            <input type="text" id="owner" name="owner" required />
        </div>
        <div>
            <label for="colour">Colour:</label>
            <input type="text" id="colour" name="colour" required />
        </div>
        <div>
            <label for="fuelType">Fuel Type:</label>
            <select id="fuelType" name="fuelType" required>
                <option value="Petrol">Petrol</option>
                <option value="Diesel">Diesel</option>
                <option value="Electric">Electric</option>
            </select>
        </div>
        <div>
            <label for="chassisNumber">Chassis Number:</label>
            <input type="text" id="chassisNumber" name="chassisNumber" required />
        </div>
        <div>
            <label for="brandName">Brand Name:</label>
            <input type="text" id="brandName" name="brandName" required />
        </div>

        <div>
            <button type="submit">Register Vehicle</button>
        </div>
    </form>

    <script>
        document.getElementById("vehicleForm").addEventListener("submit", function(event) {
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
            .then(response => response.json()) // Parse the response as JSON
            .then(data => {
                const messageDiv = document.getElementById("message");
                if (data.success) {
                    messageDiv.innerHTML = data.message;
                    messageDiv.classList.add("success", "show");

                    // Clear all fields after success
                    document.getElementById("vehicleForm").reset();

                } else {
                    messageDiv.innerHTML = data.message;
                    messageDiv.classList.add("error", "show");
                }

                // Hide message after 5 seconds
                setTimeout(() => {
                    messageDiv.classList.remove("show");
                }, 5000);
            })
            .catch(error => {
                const messageDiv = document.getElementById("message");
                messageDiv.innerHTML = "An error occurred: " + error.message;
                messageDiv.classList.add("error", "show");

                // Hide message after 5 seconds
                setTimeout(() => {
                    messageDiv.classList.remove("show");
                }, 5000);
            });
        });
    </script>
</body>
</html>
