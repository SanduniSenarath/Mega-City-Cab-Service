<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL, org.json.JSONArray, org.json.JSONObject" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Schedule Data</title>
        <style>

            body {
                font-family: 'Arial', sans-serif;
                background-color: #f4f4f9;
                margin: 0;
                padding: 0;
            }

            .container {
                width: 90%;
                max-width: 1200px;
                margin: 20px auto;
                padding: 20px;
                background: #fff;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
            }

            h1 {
                color: #333;
                text-align: center;
                margin-bottom: 20px;
                font-size: 2.5rem;
                font-weight: bold;
            }


            .filter-section {
                display: flex;
                justify-content: center;
                gap: 10px;
                margin-bottom: 20px;
            }

            #filterDate {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
                width: 200px;
            }

            button {
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            button#applyFilter {
                background-color: #007bff;
                color: white;
            }

            button#applyFilter:hover {
                background-color: #0056b3;
            }

            button#clearFilter {
                background-color: #6c757d;
                color: white;
            }

            button#clearFilter:hover {
                background-color: #5a6268;
            }

            button#downloadPdf {
                background-color: #28a745;
                color: white;
            }

            button#downloadPdf:hover {
                background-color: #218838;
            }

            /* Table Styles */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: left;
            }

            th {
                background-color: #007bff;
                color: white;
                font-weight: bold;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            /* Total Amount Row */
            tfoot td {
                font-weight: bold;
                background-color: #e9ecef;
            }

            tfoot td#totalAmount {
                color: #007bff;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .filter-section {
                    flex-direction: column;
                    align-items: center;
                }

                #filterDate {
                    width: 100%;
                    margin-bottom: 10px;
                }

                button {
                    width: 100%;
                    margin-bottom: 10px;
                }
            }
        </style>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.25/jspdf.plugin.autotable.min.js"></script>
        <script>
            // Initialize jsPDF
            window.jsPDF = window.jspdf.jsPDF;

            function filterByDate() {
                const filterDate = document.getElementById("filterDate").value;
                if (!filterDate) {
                    alert("Please select a date.");
                    return;
                }

                // Make an AJAX request to fetch filtered data
                $.ajax({
                    url: "http://localhost:8080/Mega_City_Cab_Service/api/schedules/getAll",
                    method: "GET",
                    dataType: "json",
                    success: function (data) {
                        console.log("Data fetched:", data); // Debugging
                        let filteredData = data.filter(schedule => schedule.date === filterDate);
                        console.log("Filtered data:", filteredData); // Debugging
                        renderTable(filteredData);
                    },
                    error: function (xhr, status, error) {
                        console.error("Error fetching data:", error);
                        alert("Failed to fetch data. Please try again.");
                    }
                });
            }

            function clearFilter() {
                // Clear the date input
                document.getElementById("filterDate").value = "";

                // Fetch all data again
                fetchAllData();
            }

            function fetchAllData() {
                // Make an AJAX request to fetch all data
                $.ajax({
                    url: "http://localhost:8080/Mega_City_Cab_Service/api/schedules/getAll",
                    method: "GET",
                    dataType: "json",
                    success: function (data) {
                        console.log("All data fetched:", data); // Debugging
                        renderTable(data);
                    },
                    error: function (xhr, status, error) {
                        console.error("Error fetching data:", error);
                        alert("Failed to fetch data. Please try again.");
                    }
                });
            }

            function renderTable(data) {
                console.log("Data to render:", data); // Debugging
                const tbody = document.querySelector("#scheduleTable tbody");
                console.log("Table body element:", tbody); // Debugging
                tbody.innerHTML = ""; // Clear existing rows

                let totalAmount = 0;

                data.forEach(schedule => {
                    console.log("Processing schedule:", schedule); // Debugging
                    totalAmount += schedule.amount;

                    // Create a new row
                    const row = document.createElement("tr");

                    // Create and append table cells
                    const createCell = (value) => {
                        const cell = document.createElement("td");
                        cell.textContent = value;
                        return cell;
                    };

                    row.appendChild(createCell(schedule.id));
                    row.appendChild(createCell(schedule.bookNumber));
                    row.appendChild(createCell(schedule.date));
                    row.appendChild(createCell(schedule.time));
                    row.appendChild(createCell(schedule.startLocation));
                    row.appendChild(createCell(schedule.endLocation));
                    row.appendChild(createCell(schedule.distance));
                    row.appendChild(createCell(schedule.amount));
                    row.appendChild(createCell(schedule.empSchNo));
                    row.appendChild(createCell(schedule.username));

                    // Append the row to the table body
                    tbody.appendChild(row);
                });

                // Update total amount
                console.log("Total Amount:", totalAmount); // Debugging
                document.getElementById("totalAmount").innerText = totalAmount.toFixed(2);
            }

            function downloadPdf() {
                const doc = new jsPDF();

                // Add title
                doc.setFontSize(18);
                doc.text("Schedule Data", 10, 10);

                // Extract table data
                const table = document.getElementById("scheduleTable");
                const headers = [];
                const rows = [];

                // Extract headers
                table.querySelectorAll("th").forEach(th => {
                    headers.push(th.textContent);
                });

                // Extract rows
                table.querySelectorAll("tbody tr").forEach(tr => {
                    const row = [];
                    tr.querySelectorAll("td").forEach(td => {
                        row.push(td.textContent);
                    });
                    rows.push(row);
                });

                // Add table to PDF
                doc.autoTable({
                    head: [headers],
                    body: rows,
                    startY: 20, // Start below the title
                });

                // Save the PDF
                doc.save("schedule_data.pdf");
            }
        </script>
    </head>
    <body>
        <div class="container">
            <h1>Schedule Data</h1>

            <!-- Filter Section -->
            <div class="filter-section">
                <input type="date" id="filterDate" name="filterDate">
                <button id="applyFilter" onclick="filterByDate()">Apply Filter</button>
                <button id="clearFilter" onclick="clearFilter()">Clear Filter</button>
                <button id="downloadPdf" onclick="downloadPdf()">Download PDF</button>
            </div>

            <!-- Table -->
            <table id="scheduleTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Book Number</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Start Location</th>
                        <th>End Location</th>
                        <th>Distance</th>
                        <th>Amount</th>
                        <th>Employee Schedule No</th>
                        <th>Username</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Data will be populated here dynamically -->
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="7"><strong>Total Amount</strong></td>
                        <td><strong id="totalAmount">0.00</strong></td>
                        <td colspan="2"></td>
                    </tr>
                </tfoot>
            </table>
        </div>

        <script>
            // Load all data initially
            $(document).ready(function () {
                fetchAllData();
            });
        </script>
    </body>
</html>