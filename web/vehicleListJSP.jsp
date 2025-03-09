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
    <link rel="stylesheet" href="styles.css">
    <!-- Library for PDF -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.24/jspdf.plugin.autotable.min.js"></script>
    <style>
        /* Search Container */
        .search-container {
            margin: 20px 0;
        }

        .search-container input {
            width: 50%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        /* Action Buttons */
        .action-buttons {
            margin: 20px 0;
        }

        .action-buttons button {
            padding: 10px 20px;
            font-size: 16px;
            margin-right: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .action-buttons button:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
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

    <h2>Vehicle List</h2>

    <!-- Action Buttons -->
     <div class="action-buttons">
        <button onclick="downloadPDF()" style="background-color: #007bff; color: white; padding: 10px 20px; font-size: 16px; border: none; border-radius: 4px; cursor: pointer;">
            Download PDF
        </button>
    </div>

    <!-- Search Bar -->
    <div class="search-container">
        <input type="text" id="searchInput" placeholder="Search by Vehicle Number, Type, or Owner..." onkeyup="searchTable()">
    </div>

    <!-- Message Display -->
    <div id="message" class="message"></div>

    <!-- Vehicle Table -->
    <table id="vehicleTable">
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
        // Search Functionality
        function searchTable() {
            const input = document.getElementById("searchInput").value.toLowerCase();
            const rows = document.querySelectorAll("#vehicleTable tr");

            rows.forEach((row, index) => {
                if (index === 0) return; // Skip the header row
                const cells = row.querySelectorAll("td");
                let match = false;
                cells.forEach(cell => {
                    if (cell.textContent.toLowerCase().includes(input)) {
                        match = true;
                    }
                });
                row.style.display = match ? "" : "none";
            });
        }

        // Download as PDF
        function downloadPDF() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();

            // Get the table element
            const table = document.getElementById("vehicleTable");

            // Use autoTable plugin to generate PDF
            doc.autoTable({
                html: table,
                theme: 'grid', // Optional: Add a theme
                headStyles: { fillColor: [41, 128, 185], textColor: 255 }, // Optional: Style the header
                bodyStyles: { textColor: [0, 0, 0] }, // Optional: Style the body
            });

            // Save the PDF
            doc.save("vehicle-list.pdf");
        }

        // Delete Vehicle
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

        // Update Vehicle
        function updateVehicle(vehicleId) {
            window.location.href = "vehicle-update.jsp?id=" + vehicleId;
        }
    </script>

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