<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL, org.json.JSONArray, org.json.JSONObject" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assign Driver to Vehicle</title>
    <link rel="stylesheet" href="CSS/listStyle.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <nav>
            <ul>
                <li><a href="admin_home.jsp" class="logo">Cab Booking</a></li>
                <li><a href="admin_home.jsp">Home</a></li>
                <li><a href="vehicle-list.jsp">Vehicle List</a></li>
                <li><a href="driver_registration.jsp">Driver Registration</a></li>
            </ul>
        </nav>
    </header>

    <h2>Assign Driver to Vehicle</h2>

    <%
        // Get vehicleId from URL
        String vehicleId = request.getParameter("vehicleId");
        JSONObject vehicle = null;

        if (vehicleId != null && !vehicleId.isEmpty()) {
            try {
                // API call to get vehicle details
                URL url = new URL("http://localhost:8080/Mega_City_Cab_Service/api/vehicles/" + vehicleId);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                conn.setRequestProperty("Accept", "application/json");

                if (conn.getResponseCode() == 200) {
                    BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                    String output, jsonResponse = "";
                    while ((output = br.readLine()) != null) {
                        jsonResponse += output;
                    }
                    conn.disconnect();
                    vehicle = new JSONObject(jsonResponse);
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error fetching vehicle details.</p>");
            }
        }
    %>

    <!-- Display Selected Vehicle Details -->
    <div class="vehicle-details">
        <% if (vehicle != null) { %>
            <h3>Vehicle Information</h3>
            <p><strong>Vehicle Number:</strong> <%= vehicle.getString("vehicleNumber") %></p>
            <p><strong>Brand:</strong> <%= vehicle.getString("brandName") %></p>
            <p><strong>Type:</strong> <%= vehicle.getString("type") %></p>
            <p><strong>Fuel Type:</strong> <%= vehicle.getString("fuelType") %></p>
            <p><strong>Chassis Number:</strong> <%= vehicle.getString("chassisNumber") %></p>
            <p><strong>Colour:</strong> <%= vehicle.getString("colour") %></p>
            <p><strong>Available Seats:</strong> <%= vehicle.getInt("availableSeats") %></p>
            <p><strong>Owner:</strong> <%= vehicle.getString("owner") %></p>
        <% } else { %>
            <p style="color:red;">No vehicle selected or vehicle not found.</p>
        <% } %>
    </div>

    <h3>Select Driver</h3>
    <form action="assign_driver_submit.jsp" method="post">
        <input type="hidden" name="vehicleId" value="<%= vehicleId %>">

        <label for="driver">Select Driver:</label>
        <select name="driverId" id="driver" onchange="fetchDriverDetails(this.value)">
            <option value="">Select a Driver</option>
            <% 
            try {
                // Fetch available drivers
                URL url = new URL("http://localhost:8080/Mega_City_Cab_Service/api/drivers/available");
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                conn.setRequestProperty("Accept", "application/json");

                if (conn.getResponseCode() == 200) {
                    BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                    String output, jsonResponse = "";
                    while ((output = br.readLine()) != null) {
                        jsonResponse += output;
                    }
                    conn.disconnect();

                    JSONArray drivers = new JSONArray(jsonResponse);
                    for (int i = 0; i < drivers.length(); i++) {
                        JSONObject driver = drivers.getJSONObject(i);
                        out.println("<option value='" + driver.getInt("id") + "' data-name='" + driver.getString("name") +
                                    "' data-phone='" + driver.getString("phoneNo") + "' data-email='" + driver.getString("email") + "'>" 
                                    + driver.getString("name") + "</option>");
                    }
                }
            } catch (Exception e) {
                out.println("<option value=''>Error fetching drivers</option>");
            }
            %>
        </select>

        <!-- Driver details display -->
        <div id="driverDetails" style="display:none; margin-top:10px; border:1px solid #ccc; padding:10px;">
            <p><strong>Name:</strong> <span id="driverName"></span></p>
            <p><strong>Phone:</strong> <span id="driverPhone"></span></p>
            <p><strong>Email:</strong> <span id="driverEmail"></span></p>
        </div>

        <button type="submit">Assign Driver</button>
    </form>

    <footer>
        <p>&copy; 2025 Cab Booking System. All rights reserved.</p>
    </footer>

    <script>
    function fetchDriverDetails(driverId) {
        let driverSelect = document.getElementById('driver');
        let selectedOption = driverSelect.options[driverSelect.selectedIndex];

        if (driverId) {
            document.getElementById('driverName').innerText = selectedOption.getAttribute('data-name');
            document.getElementById('driverPhone').innerText = selectedOption.getAttribute('data-phone');
            document.getElementById('driverEmail').innerText = selectedOption.getAttribute('data-email');
            document.getElementById('driverDetails').style.display = 'block';
        } else {
            document.getElementById('driverDetails').style.display = 'none';
        }
    }
    </script>
</body>
</html>
