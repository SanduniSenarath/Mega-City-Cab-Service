<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL, org.json.JSONArray, org.json.JSONObject" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle List</title>
    <link rel="stylesheet" href="CSS/listStyle.css">
</head>
<body>

    <h2>Vehicle List</h2>
    
    <div id="message" class="message"></div>

    <table>
        <tr>
            <th>ID</th>
            <th>Vehicle Number</th>
            <th>Available Seats</th>
            <th>Type</th>
            <th>Owner</th>
            <th>Colour</th>
            <th>Fuel Type</th>
            <th>Chassis Number</th>
            <th>Brand Name</th>
            <th>Available</th>
            <th>Actions</th>
        </tr>
        <%
            try {
                URL url = new URL("http://localhost:8080/Mega_City_Cab_Service/api/vehicles/getAll");
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                conn.setRequestProperty("Accept", "application/json");

                if (conn.getResponseCode() != 200) {
                    out.println("<tr><td colspan='11'>Failed to fetch data: HTTP error code " + conn.getResponseCode() + "</td></tr>");
                } else {
                    BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
                    String output, jsonResponse = "";
                    while ((output = br.readLine()) != null) {
                        jsonResponse += output;
                    }
                    conn.disconnect();

                    JSONArray vehicles = new JSONArray(jsonResponse);
                    for (int i = 0; i < vehicles.length(); i++) {
                        JSONObject vehicle = vehicles.getJSONObject(i);
                        out.println("<tr>");
                        out.println("<td>" + vehicle.getInt("id") + "</td>");
                        out.println("<td>" + vehicle.getString("vehicleNumber") + "</td>");
                        out.println("<td>" + vehicle.getInt("availableSeats") + "</td>");
                        out.println("<td>" + vehicle.getString("type") + "</td>");
                        out.println("<td>" + vehicle.getString("owner") + "</td>");
                        out.println("<td>" + vehicle.getString("colour") + "</td>");
                        out.println("<td>" + vehicle.getString("fuelType") + "</td>");
                        out.println("<td>" + vehicle.getString("chassisNumber") + "</td>");
                        out.println("<td>" + vehicle.getString("brandName") + "</td>");
                        out.println("<td>" + (vehicle.getBoolean("available") ? "Yes" : "No") + "</td>");
                        out.println("<td>");
                        out.println("<button class='update-btn' onclick='updateVehicle(" + vehicle.getInt("id") + ")'>Update</button>");
                        out.println("<button class='delete-btn' " + (vehicle.getBoolean("available") ? "" : "disabled") + 
            " onclick='deleteVehicle(" + vehicle.getInt("id") + ")'>Delete</button>");
out.println("</td>");
                        out.println("</tr>");
                    }
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='11'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>

    <script>
        function deleteVehicle(vehicleId) {
            if (confirm("Are you sure you want to delete this vehicle?")) {
                fetch("http://localhost:8080/Mega_City_Cab_Service/api/vehicles/delete/" + vehicleId, {
                    method: "DELETE"
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert("Vehicle deleted successfully.");
                        location.reload();
                    } else {
                        alert("Error: " + data.message);
                    }
                })
                .catch(error => {
                    alert("An error occurred: " + error.message);
                });
            }
        }

        function updateVehicle(vehicleId) {
            window.location.href = "vehicle-update.jsp?id=" + vehicleId;
        }
    </script>

</body>
</html>
