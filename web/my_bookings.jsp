<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL, org.json.JSONArray, org.json.JSONObject" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Schedule List</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
       
       
        .container {
            width: 90%;
            margin: auto;
            padding-top: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        button {
            padding: 7px 12px;
            border: none;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            border-radius: 5px;
        }
        button.delete {
            background-color: #dc3545;
        }
        button:hover {
            opacity: 0.8;
        }
        .actions {
            display: flex;
            gap: 10px;
        }
        .export-buttons {
            margin-bottom: 10px;
        }
        .search-container {
            margin-bottom: 10px;
        }
        #searchInput {
            width: 30%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <!-- Header Section -->
    <header>
        <nav>
            <ul>
                <li><a href="index.jsp" class="logo">Cab Booking</a></li>
                
                <% 
                    String userRole = (String) session.getAttribute("userRole"); 
                    if ("admin".equals(userRole)) { 
                %>
                    <li><a href="admin_home.jsp">Home</a></li>
                    <li><a href="DriverListJSP.jsp">View Driver List</a></li>
                    <li><a href="vehicle-registration.jsp">Vehicle Registration</a></li>
                    <li><a href="driver_vehicle_registration.jsp">Driver Vehicle Registration</a></li>
                    <li><a href="driver_registration.jsp">Driver Registration</a></li>
                    <li><a href="vehicleListJSP.jsp">Vehicle List</a></li>
                    <li><a href="CustomerRegistrationJSP.jsp">Customer Registration</a></li>
                    <li><a href="AddBookings.jsp">Add Bookings</a></li>
                <% 
                    } else if ("driver".equals(userRole)) { 
                %>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="driver_dashboard.jsp">Driver Dashboard</a></li>
                    <li><a href="view_bookings.jsp">View Bookings</a></li>
                <% 
                    } else if ("customer".equals(userRole)) { 
                %>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="AddBookings.jsp">Book a Cab</a></li>
                    <li><a href="my_bookings.jsp">My Bookings</a></li>
                <% 
                    } else { 
                %>
                    <li><a href="login.jsp">Login</a></li>
                    <li><a href="CustomerRegistrationJSP.jsp">Register</a></li>
                <% 
                    } 
                %>
                <li><a href="help.jsp">Help</a></li>
                <% if (!"guest".equals(userRole)) { %>
                    <li><a href="logout.jsp">Logout</a></li>
                <% } %>
            </ul>
        </nav>
    </header>

    <!-- Main Content Section -->
    <div class="container">
        <h2>Schedule List for User: <%= session.getAttribute("username") %></h2>

        <!-- Search Box -->
        <div class="search-container">
            <input type="text" id="searchInput" onkeyup="filterTable()" placeholder="Search for schedules...">
        </div>

        <!-- Export Buttons -->
        <div class="export-buttons">
            <button onclick="downloadPDF()">Download PDF</button>
            <button onclick="downloadExcel()">Download Excel</button>
        </div>

        <!-- Schedule Table -->
        <table id="scheduleTable">
            <tr>
                <th>ID</th>
                <th>Book Number</th>
                <th>Start Location</th>
                <th>End Location</th>
                <th>Distance</th>
                <th>Amount</th>
                <th>Date</th>
                <th>Time</th>
                <th>Actions</th>
                <th>Bill</th>
            </tr>
            <%
                try {
                    // Fetch the username from session
                    String username = (String) session.getAttribute("username");

                    // Fetch data from backend API using the username
                    URL url = new URL("http://localhost:8080/Mega_City_Cab_Service/api/schedules/username/" + username);
                    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                    conn.setRequestMethod("GET");
                    conn.setRequestProperty("Accept", "application/json");

                    if (conn.getResponseCode() != 200) {
                        out.println("<tr><td colspan='10'>No any bookings found</td></tr>");
                    } else {
                        BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
                        String output, jsonResponse = "";
                        while ((output = br.readLine()) != null) {
                            jsonResponse += output;
                        }
                        conn.disconnect();

                        JSONArray schedules = new JSONArray(jsonResponse);
                        for (int i = 0; i < schedules.length(); i++) {
                            JSONObject schedule = schedules.getJSONObject(i);
                            out.println("<tr>");
                            out.println("<td>" + schedule.getInt("id") + "</td>");
                            out.println("<td>" + schedule.getString("bookNumber") + "</td>");
                            out.println("<td>" + schedule.getString("startLocation") + "</td>");
                            out.println("<td>" + schedule.getString("endLocation") + "</td>");
                            out.println("<td>" + schedule.getDouble("distance") + "</td>");
                            out.println("<td>" + schedule.getDouble("amount") + "</td>");
                            out.println("<td>" + schedule.getString("date") + "</td>");
                            out.println("<td>" + schedule.getString("time") + "</td>");
                            out.println("<td class='actions'>");

                            // Check if the schedule date is upcoming
                            String currentDate = "2025-03-09"; // Replace with dynamic current date
                            if (schedule.getString("date").compareTo(currentDate) > 0) {
                                out.println("<form action='updateSchedule.jsp' method='GET'>");
                                out.println("<input type='hidden' name='id' value='" + schedule.getInt("id") + "' />");
                                out.println("<button type='submit'>Update</button>");
                                out.println("</form>");
                            }

                            out.println("</td>");

                            // Add bill download option
                            out.println("<td>");
                            out.println("<a href='downloadBill.jsp?id=" + schedule.getInt("id") + "' target='_blank'>Download Bill</a>");
                            out.println("</td>");
                            out.println("</tr>");
                        }
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='10'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </table>
    </div>

    <!-- Footer Section -->
    <footer>
        <p>&copy; 2023 Cab Booking System. All rights reserved.</p>
        <ul>
            <li><a href="privacy_policy.jsp">Privacy Policy</a></li>
            <li><a href="terms_of_service.jsp">Terms of Service</a></li>
            <li><a href="contact_us.jsp">Contact Us</a></li>
        </ul>
    </footer>

    <script>
        // 📌 Function to Search & Filter Table
        function filterTable() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let table = document.getElementById("scheduleTable");
            let rows = table.getElementsByTagName("tr");

            for (let i = 1; i < rows.length; i++) { // Skip the header row
                let cells = rows[i].getElementsByTagName("td");
                let found = false;
                
                for (let j = 0; j < cells.length - 2; j++) { // Exclude Actions and Bill columns
                    if (cells[j].innerText.toLowerCase().includes(input)) {
                        found = true;
                        break;
                    }
                }

                rows[i].style.display = found ? "" : "none";
            }
        }

        // 📌 Function to Download PDF
        function downloadPDF() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();
            
            doc.text("Schedule List", 10, 10);
            doc.autoTable({ html: "#scheduleTable" });

            doc.save("Schedule_List.pdf");
        }

        // 📌 Function to Download Excel
        function downloadExcel() {
            let table = document.querySelector("#scheduleTable");
            let wb = XLSX.utils.book_new();
            let ws = XLSX.utils.table_to_sheet(table);
            
            XLSX.utils.book_append_sheet(wb, ws, "Schedules");
            XLSX.writeFile(wb, "Schedule_List.xlsx");
        }
    </script>
</body>
</html>
