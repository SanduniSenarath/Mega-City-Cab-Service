<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL, org.json.JSONArray, org.json.JSONObject" %>
<!DOCTYPE html>
<html>
<head> 
    <meta charset="UTF-8">
    <title>Driver List</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    
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
    <div class="container">
        <h2>Driver List</h2>

        <!-- Search Box -->
        <div class="search-container">
            <input type="text" id="searchInput" onkeyup="filterTable()" placeholder="Search for drivers...">
        </div>

        <!-- Export Buttons -->
        <div class="export-buttons">
            <button onclick="downloadPDF()">Download PDF</button>
            <button onclick="downloadExcel()">Download Excel</button>
        </div>

        <!-- Driver Table -->
        <table id="driverTable">
            <tr>
                <th>ID</th>
                <th>NIC</th>
                <th>Driver Name</th>
                <th>Phone No</th>
                <th>Address</th>
                <th>Gender</th>
                <th>Available</th>
                <th>Actions</th>
            </tr>
            <%
                try {
                    // Fetch data from backend API
                    URL url = new URL("http://localhost:8080/Mega_City_Cab_Service/api/drivers/getAll");
                    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                    conn.setRequestMethod("GET");
                    conn.setRequestProperty("Accept", "application/json");

                    if (conn.getResponseCode() != 200) {
                        out.println("<tr><td colspan='8'>Failed to fetch data: HTTP error code " + conn.getResponseCode() + "</td></tr>");
                    } else {
                        BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
                        String output, jsonResponse = "";
                        while ((output = br.readLine()) != null) {
                            jsonResponse += output;
                        }
                        conn.disconnect();

                        JSONArray drivers = new JSONArray(jsonResponse);
                        for (int i = 0; i < drivers.length(); i++) {
                            JSONObject driver = drivers.getJSONObject(i);
                            out.println("<tr>");
                            out.println("<td>" + driver.getInt("id") + "</td>");
                            out.println("<td>" + driver.getString("nic") + "</td>");
                            out.println("<td>" + driver.getString("name") + "</td>");
                            out.println("<td>" + driver.getString("phoneNo") + "</td>");
                            out.println("<td>" + driver.getString("addressNo") + ", " + driver.getString("addressLine1") + ", " + driver.getString("addressLine2") + "</td>");
                            out.println("<td>" + driver.getString("gender") + "</td>");
                            out.println("<td>" + (driver.getBoolean("available") ? "Yes" : "No") + "</td>");
                            out.println("<td class='actions'>");
                            out.println("<form action='editDriver.jsp' method='GET'>");
                            out.println("<input type='hidden' name='id' value='" + driver.getInt("id") + "' />");
                            out.println("<button type='submit'>Edit</button>");
                            out.println("</form>");
                            out.println("<form action='deleteDriver.jsp' method='POST' onsubmit='return confirm(\"Are you sure you want to delete this driver?\");'>");
                            out.println("<input type='hidden' name='id' value='" + driver.getInt("id") + "' />");
                            out.println("<button type='submit' class='delete'>Delete</button>");
                            out.println("</form>");
                            out.println("</td>");
                            out.println("</tr>");
                        }
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </table>
    </div>

    <script>
        // 📌 Function to Search & Filter Table
        function filterTable() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let table = document.getElementById("driverTable");
            let rows = table.getElementsByTagName("tr");

            for (let i = 1; i < rows.length; i++) { // Skip the header row
                let cells = rows[i].getElementsByTagName("td");
                let found = false;
                
                for (let j = 0; j < cells.length - 1; j++) { // Exclude Actions column
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
            
            doc.text("Driver List", 10, 10);
            doc.autoTable({ html: "#driverTable" });

            doc.save("Driver_List.pdf");
        }

        // 📌 Function to Download Excel
        function downloadExcel() {
            let table = document.querySelector("#driverTable");
            let wb = XLSX.utils.book_new();
            let ws = XLSX.utils.table_to_sheet(table);
            
            XLSX.utils.book_append_sheet(wb, ws, "Drivers");
            XLSX.writeFile(wb, "Driver_List.xlsx");
        }
    </script>
</body>
</html>
