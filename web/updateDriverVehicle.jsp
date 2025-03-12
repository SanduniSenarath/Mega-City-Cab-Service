<%-- 
    Document   : updateDriverVehicle
    Created on : 11 Mar 2025, 14:46:11
    Author     : Sanduni
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.io.OutputStreamWriter, java.net.HttpURLConnection, java.net.URL, org.json.JSONObject, org.json.JSONArray" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Driver-Vehicle</title>
    <link rel="stylesheet" href="styles.css">
    <header>
        <nav>
            <ul>
                <li><a href="admin_home.jsp" class="logo">Cab Booking</a></li>
                <li><a href="admin_home.jsp">Home</a></li>
                <li><a href="vehicle-registration.jsp">Vehicle Registration</a></li>
                <li><a href="driver_registration.jsp">Driver Registration</a></li>
                <li><a href="view_bookings.jsp">All Bookings</a></li>
                <li><a href="view_customers.jsp">All Customers</a></li>
                <li><a href="logout.jsp">Logout</a></li>
            </ul>
        </nav>
    </header>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
        }
        .form-container {
            width: 40%;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        input, select, button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
        }
        button {
            background-color: #28A745;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #218838;
        }
    </style>
    <script>
        function fetchDriverVehicleDetails() {
            var empSchNo = '<%= request.getParameter("empSchNo") %>';
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "http://localhost:8080/Mega_City_Cab_Service/api/drivervehicle/" + empSchNo, true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var data = JSON.parse(xhr.responseText);
                    document.getElementsByName("driverUsername")[0].value = data.driverUsername;
                    document.getElementsByName("vehicleNo")[0].value = data.vehicleNo;
                    document.getElementsByName("available")[0].value = data.available ? "Yes" : "No";
                }
            };
            xhr.send();
        }

        function fetchAvailableDrivers() {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "http://localhost:8080/Mega_City_Cab_Service/api/drivers/available", true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var data = JSON.parse(xhr.responseText);
                    var select = document.getElementsByName("driverUsername")[0];
                    select.innerHTML = "";
                    data.forEach(function(driver) {
                        var option = document.createElement("option");
                        option.value = driver.username;
                        option.text = driver.username;
                        select.appendChild(option);
                    });
                }
            };
            xhr.send();
        }

        window.onload = function() {
            fetchDriverVehicleDetails();
            fetchAvailableDrivers();
        };
    </script>
</head>
<body>

<h2>Update Driver-Vehicle Record</h2>

<div class="form-container">
    <form method="post">
        <label>Employee Schedule No:</label>
        <input type="text" name="empSchNo" value="<%= request.getParameter("empSchNo") %>" readonly>

        <label>Driver Username:</label>
        <select name="driverUsername" required></select>

        <label>Vehicle No:</label>
        <input type="text" name="vehicleNo" readonly>

        <label>Availability:</label>
        <select name="available">
            <option value="Yes">Yes</option>
            <option value="No">No</option>
        </select>

        <button type="submit">Update</button>
    </form>
</div>

<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
    String empSchNo = request.getParameter("empSchNo");
    String driverUsername = request.getParameter("driverUsername");
    String vehicleNo = request.getParameter("vehicleNo");
    String available = request.getParameter("available");

    try {
        // Pass empSchNo in the URL
        URL url = new URL("http://localhost:8080/Mega_City_Cab_Service/api/drivervehicle/update/" + empSchNo);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("PUT");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        JSONObject json = new JSONObject();
        json.put("driverUsername", driverUsername);
        json.put("vehicleNo", vehicleNo);
        json.put("available", "Yes".equals(available));

        OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream());
        writer.write(json.toString());
        writer.flush();
        writer.close();

        int responseCode = conn.getResponseCode();
        if (responseCode == 200) {
            out.println("<p style='color:green;'>Record updated successfully!</p>");
        } else {
            out.println("<p style='color:red;'>Failed to update. Error code: " + responseCode + "</p>");
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
}
%>


</body>
</html>