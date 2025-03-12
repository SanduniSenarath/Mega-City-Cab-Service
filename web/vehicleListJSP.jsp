<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL, org.json.JSONArray, org.json.JSONObject" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Vehicle List</title>
        <!--<link rel="stylesheet" href="CSS/listStyle.css">-->
        <link rel="stylesheet" href="styles.css">
        <!-- Library for PDF -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.24/jspdf.plugin.autotable.min.js"></script>
        <style>
            /* Center Table */
            .container {
                display: flex;
                flex-direction: column;
                align-items: center;
                text-align: center;
            }

            /* Search & Filter */
            .controls {
                margin: 20px 0;
                display: flex;
                gap: 10px;
                justify-content: center;
                align-items: center;
            }

            .controls input, .controls select {
                padding: 10px;
                font-size: 16px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            /* Table Styling */
            table {
                width: 90%;
                border-collapse: collapse;
                margin: 20px auto; /* Centers the table */
                background-color: white;
            }


            th, td {
                padding: 12px;
                border: 1px solid #ddd;
                text-align: center;
            }

            th {
                background-color: #17A2B8;
                color: white;
            }

            tr:nth-child(even) {
                background-color: #FFEDFA;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            /* Buttons */
            .btn {
                padding: 10px 15px;
                font-size: 14px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: 0.3s;
            }

            .btn-download {
                background-color: #0D4715;
                color: white;
            }

            .btn-download:hover {
                background-color: #218838;
            }

            .btn-update {
                background-color: #ffc107;
                color: black;
            }

            .btn-update:hover {
                background-color: #e0a800;
            }

            .btn-delete {
                background-color: #dc3545;
                color: white;
            }

            .btn-delete:hover {
                background-color: #c82333;
            }

            .btn-assign {
                background-color: #17a2b8;
                color: white;
            }

            .btn-assign:hover {
                background-color: #138496;
            }
            /* Button Styling */
            .update-btn {
                background-color: #FFA000; /* Orange */
                color: white;
                border: none;
                padding: 8px 12px;
                border-radius: 4px;
                cursor: pointer;
                font-size: 14px;
            }

            .update-btn:hover {
                background-color: #FF8F00; /* Darker Orange */
            }

            .delete-btn {
                background-color: #E63946; /* Red */
                color: white;
                border: none;
                padding: 8px 12px;
                border-radius: 4px;
                cursor: pointer;
                font-size: 14px;
            }

            .delete-btn:hover {
                background-color: #D62839; /* Darker Red */
            }

            .delete-btn:disabled {
                background-color: #AAA; /* Gray */
                cursor: not-allowed;
            }

            .assign-btn {
                background-color: #17A2B8; /* Teal */
                color: white;
                border: none;
                padding: 8px 12px;
                border-radius: 4px;
                cursor: pointer;
                font-size: 14px;
            }

            .assign-btn:hover {
                background-color: #138496; /* Darker Teal */
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
        <div class="controls">
            <h2>Vehicle List</h2>
        </div>

        <div class="controls">
            <!-- Action Buttons -->
            <div class="btn-download">
                <button onclick="downloadPDF()" style="background-color: #0D4715; color: white; padding: 10px 20px; font-size: 16px; border: none; border-radius: 4px; cursor: pointer;">
                    Download PDF
                </button>
            </div>
        </div>

        <!-- Search Bar -->
        <div class="controls">

            <input type="text" id="searchInput" placeholder="Search by Vehicle Number, Type, or Owner..." onkeyup="searchTable()">
            <select id="filterAvailability" onchange="filterTable()">
                <option value="">Show All</option>
                <option value="Yes">Available</option>
                <option value="No">Not Available</option>
            </select>
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
                                out.println("<button class='assign-btn' onclick='assignDriver(" + vehicle.getInt("id") + ")'>Assign</button>");
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
                document.querySelectorAll("#vehicleTable tr").forEach((row, index) => {
                    if (index === 0)
                        return;
                    row.style.display = row.innerText.toLowerCase().includes(input) ? "" : "none";
                });
            }

            function filterTable() {
                const filter = document.getElementById("filterAvailability").value;
                document.querySelectorAll("#vehicleTable tr").forEach((row, index) => {
                    if (index === 0)
                        return;
                    row.style.display = filter === "" || row.cells[9].innerText === filter ? "" : "none";
                });
            }

            // Download as PDF
            function downloadPDF() {
                const {jsPDF} = window.jspdf;
                const doc = new jsPDF();

                // Get the table element
                const table = document.getElementById("vehicleTable");

                // Use autoTable plugin to generate PDF
                doc.autoTable({
                    html: table,
                    theme: 'grid', // Optional: Add a theme
                    headStyles: {fillColor: [41, 128, 185], textColor: 255}, // Optional: Style the header
                    bodyStyles: {textColor: [0, 0, 0]}, // Optional: Style the body
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
            function assignDriver(vehicleId) {
                window.location.href = "assign_driver_process.jsp?vehicleId=" + vehicleId;
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