<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.io.PrintWriter, java.net.HttpURLConnection, java.net.URL, org.json.JSONArray, org.json.JSONObject" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver-Vehicle List</title>
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
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
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
        .search-box, .filter-box, .download-btn {
            margin: 10px;
            padding: 8px;
            font-size: 16px;
        }
        .action-btn {
            padding: 6px 12px;
            margin: 5px;
            border: none;
            cursor: pointer;
        }
        .update-btn {
            background-color: #28A745;
            color: white;
        }
        .delete-btn {
            background-color: #DC3545;
            color: white;
        }
    </style>
    <script>
        function searchByEmpSchNo() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let rows = document.querySelectorAll("table tbody tr");

            rows.forEach(row => {
                let empSchNo = row.cells[1].innerText.toLowerCase();
                row.style.display = empSchNo.includes(input) ? "" : "none";
            });
        }

        function filterByAvailability() {
            let filterValue = document.getElementById("availabilityFilter").value;
            let rows = document.querySelectorAll("table tbody tr");

            rows.forEach(row => {
                let available = row.cells[3].innerText;
                row.style.display = (filterValue === "All" || available === filterValue) ? "" : "none";
            });
        }

        function downloadCSV() {
            let csv = "Driver Username,Employee Schedule No,Vehicle No,Available\n";
            let rows = document.querySelectorAll("table tbody tr");

            rows.forEach(row => {
                let cols = row.querySelectorAll("td");
                if (cols.length > 0) {
                    csv += cols[0].innerText + "," + cols[1].innerText + "," + cols[2].innerText + "," + cols[3].innerText + "\n";
                }
            });

            let blob = new Blob([csv], { type: "text/csv" });
            let link = document.createElement("a");
            link.href = URL.createObjectURL(blob);
            link.download = "DriverVehicleList.csv";
            link.click();
        }

        function updateEntry(empSchNo) {
    window.location.href = "updateDriverVehicle.jsp?empSchNo=" + empSchNo;
}


        function deleteEntry(empSchNo) {
        if (confirm("Are you sure you want to delete Employee Schedule No: " + empSchNo + "?")) {
            fetch("http://localhost:8080/Mega_City_Cab_Service/api/drivervehicle/delete/" + empSchNo, {
                method: "DELETE"
            })
            .then(response => {
                if (response.ok) {
                    alert("Record deleted successfully.");
                    location.reload(); // Refresh the page to update the table
                } else {
                    alert("Failed to delete. Please try again.");
                }
            })
            .catch(error => {
                console.error("Error:", error);
                alert("An error occurred while deleting.");
            });
        }
    }
    </script>
</head>
<body>
    <h2 align="center">Driver-Vehicle List</h2>
    
    <div class="container">
        <input type="text" id="searchInput" class="search-box" placeholder="Search by Employee Schedule No" onkeyup="searchByEmpSchNo()">
        <select id="availabilityFilter" class="filter-box" onchange="filterByAvailability()">
            <option value="All">All</option>
            <option value="Yes">Available</option>
            <option value="No">Not Available</option>
        </select>
        <button class="download-btn" onclick="downloadCSV()" style="background-color: #0D4715; color: white; padding: 10px 20px; font-size: 16px; border: none; border-radius: 4px; cursor: pointer;">Download CSV</button>
    </div>

    <table>
        <thead>
            <tr>
                <th>Driver Username</th>
                <th>Employee Schedule No</th>
                <th>Vehicle No</th>
                <th>Available</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    URL url = new URL("http://localhost:8080/Mega_City_Cab_Service/api/drivervehicle/getAll");
                    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                    conn.setRequestMethod("GET");
                    conn.setRequestProperty("Accept", "application/json");

                    if (conn.getResponseCode() != 200) {
                        out.println("<tr><td colspan='5'>Failed to fetch data: HTTP error code " + conn.getResponseCode() + "</td></tr>");
                    } else {
                        BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
                        String output, jsonResponse = "";
                        while ((output = br.readLine()) != null) {
                            jsonResponse += output;
                        }
                        conn.disconnect();

                        JSONArray driverVehicles = new JSONArray(jsonResponse);
                        for (int i = 0; i < driverVehicles.length(); i++) {
                            JSONObject entry = driverVehicles.getJSONObject(i);
                            String driverUsername = entry.getString("driverUsername");
                            int empSchNo = entry.getInt("empSchNo");
                            String vehicleNo = entry.getString("vehicleNo");
                            String available = entry.getBoolean("available") ? "Yes" : "No";

                            out.println("<tr>");
                            out.println("<td>" + driverUsername + "</td>");
                            out.println("<td>" + empSchNo + "</td>");
                            out.println("<td>" + vehicleNo + "</td>");
                            out.println("<td>" + available + "</td>");
                            out.println("<td>");
                            out.println("<button class='action-btn update-btn' onclick='updateEntry(" + empSchNo + ")'>Update</button>");
                            out.println("<button class='action-btn delete-btn' onclick='deleteEntry(" + empSchNo + ")'>Delete</button>");
                            out.println("</td>");
                            out.println("</tr>");
                        }
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </tbody>
    </table>
</body>
</html>
