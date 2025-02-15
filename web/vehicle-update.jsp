<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.net.*, org.json.JSONObject"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Vehicle</title>
    <link rel="stylesheet" href="CSS/updateStyle.css">
</head>
<body>

    <h2>Update Vehicle</h2>

    <div id="message" class="message"></div>

    <%
        String vehicleId = request.getParameter("id");
        JSONObject vehicle = null;

        if (vehicleId != null && !vehicleId.isEmpty()) {
            try {
                URL url = new URL("http://localhost:8080/Mega_City_Cab_Service/api/vehicles/" + vehicleId);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                conn.setRequestProperty("Accept", "application/json");

                if (conn.getResponseCode() == 200) {
                    BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
                    StringBuilder jsonResponse = new StringBuilder();
                    String output;

                    while ((output = br.readLine()) != null) {
                        jsonResponse.append(output);
                    }

                    vehicle = new JSONObject(jsonResponse.toString());
                }
                conn.disconnect();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    %>
    
    <%
    // Log the full JSON response for debugging
    System.out.println("API Response: " + vehicle.toString());
%>

    <% if (vehicle != null) { %>
    <form id="updateVehicleForm">
        <input type="hidden" id="vehicleId" name="vehicleId" value="<%= vehicleId %>" />

        <div>
            <label for="vehicleNumber">Vehicle Number:</label>
            <input type="text" id="vehicleNumber" name="vehicleNumber" value="<%= vehicle.getString("vehicleNumber") %>"  />
        </div>

        <div>
            <label for="availableSeats">Available Seats:</label>
            <input type="number" id="availableSeats" name="availableSeats" value="<%= vehicle.getInt("availableSeats") %>" required />
        </div>

        <div>
            <label for="type">Vehicle Type:</label>
            <select id="type" name="type" required>
                <option value="Car" <%= "Car".equals(vehicle.getString("type")) ? "selected" : "" %>>Car</option>
                <option value="Truck" <%= "Truck".equals(vehicle.getString("type")) ? "selected" : "" %>>Truck</option>
                <option value="Bus" <%= "Bus".equals(vehicle.getString("type")) ? "selected" : "" %>>Bus</option>
                <option value="Bike" <%= "Bike".equals(vehicle.getString("type")) ? "selected" : "" %>>Bike</option>
            </select>
        </div>

        <div>
            <label for="owner">Owner:</label>
            <input type="text" id="owner" name="owner" value="<%= vehicle.getString("owner") %>" required />
        </div>

        <div>
            <label for="colour">Colour:</label>
            <input type="text" id="colour" name="colour" value="<%= vehicle.getString("colour") %>" required />
        </div>

        <div>
            <label for="fuelType">Fuel Type:</label>
            <select id="fuelType" name="fuelType" required>
                <option value="Petrol" <%= "Petrol".equals(vehicle.getString("fuelType")) ? "selected" : "" %>>Petrol</option>
                <option value="Diesel" <%= "Diesel".equals(vehicle.getString("fuelType")) ? "selected" : "" %>>Diesel</option>
                <option value="Electric" <%= "Electric".equals(vehicle.getString("fuelType")) ? "selected" : "" %>>Electric</option>
            </select>
        </div>

        <div>
            <label for="chassisNumber">Chassis Number:</label>
            <input type="text" id="chassisNumber" name="chassisNumber" value="<%= vehicle.getString("chassisNumber") %>" required />
        </div>

        <div>
            <label for="brandName">Brand Name:</label>
            <input type="text" id="brandName" name="brandName" value="<%= vehicle.getString("brandName") %>" required />
        </div>

        <div>
            <button type="submit">Update Vehicle</button>
        </div>
    </form>

    <% } else { %>
        <p>Vehicle not found.</p>
    <% } %>

    <script>
        document.getElementById("updateVehicleForm").addEventListener("submit", function(event) {
            event.preventDefault();

            const vehicleData = {
                id: document.getElementById("vehicleId").value,
                vehicleNumber: document.getElementById("vehicleNumber").value,
                availableSeats: document.getElementById("availableSeats").value,
                type: document.getElementById("type").value,
                owner: document.getElementById("owner").value,
                colour: document.getElementById("colour").value,
                fuelType: document.getElementById("fuelType").value,
                chassisNumber: document.getElementById("chassisNumber").value,
                brandName: document.getElementById("brandName").value
            };

            // Check if all required fields are filled
            for (let key in vehicleData) {
                if (!vehicleData[key]) {
                    alert(key + " is required!");
                    return;
                }
            }

            fetch('http://localhost:8080/Mega_City_Cab_Service/api/vehicles/update/' + vehicleData.id, {
                  method: 'PUT',
                  headers: {
                      'Content-Type': 'application/json'
                  },
                  body: JSON.stringify(vehicleData)
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok ' + response.statusText);
                }
                return response.json();
            })
            .then(data => {
                const messageDiv = document.getElementById("message");
                if (data.success) {
                    messageDiv.innerHTML = data.message;
                    messageDiv.classList.add("success", "show");
                } else {
                    messageDiv.innerHTML = data.message;
                    messageDiv.classList.add("error", "show");
                }

                setTimeout(() => {
                    messageDiv.classList.remove("show");
                }, 5000);
            })
            .catch(error => {
                const messageDiv = document.getElementById("message");
                messageDiv.innerHTML = "An error occurred: " + error.message;
                messageDiv.classList.add("error", "show");

                setTimeout(() => {
                    messageDiv.classList.remove("show");
                }, 5000);
            });
        });
    </script>

</body>
</html>
