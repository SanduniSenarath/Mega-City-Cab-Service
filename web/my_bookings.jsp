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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 90%;
            margin: 20px auto;
            padding: 20px;
            background: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
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
        button {
            padding: 8px 15px;
            border: none;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
        }
        button.delete {
            background-color: #dc3545;
        }
        button:hover {
            opacity: 0.9;
        }
        .actions {
            display: flex;
            gap: 10px;
        }
        .export-buttons {
            margin-bottom: 20px;
        }
        .search-container {
            margin-bottom: 20px;
        }
        #searchInput {
            width: 30%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
        footer {
            text-align: center;
            padding: 20px;
            color: white;
            margin-top: 40px;
        }
         #billPopup {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: white;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        border-radius: 8px;
        z-index: 1000;
        width: 300px;
        text-align: center;
    }
    .receipt-container button {
        margin: 10px;
        padding: 8px 15px;
        border: none;
        background-color: #007bff;
        color: white;
        cursor: pointer;
        border-radius: 5px;
    }
    .receipt-container button:hover {
        opacity: 0.9;
    }
     .dropdown {
                position: relative;
                display: inline-block;
            }
            .dropdown-content {
                display: none;
                position: absolute;
                right: 0;
                background-color: #fff;
                min-width: 150px;
                box-shadow: 0px 4px 8px rgba(0,0,0,0.2);
                z-index: 10;
            }
            .dropdown:hover .dropdown-content {
                display: block;
            }
            .dropdown-content a {
                color: black;
                padding: 8px 12px;
                text-decoration: none;
                display: block;
            }
            .dropdown-content a:hover {
                background-color: #f1f1f1;
            }
    </style>
</head>
<body>
    <!-- Header Section -->
    <header>
            <nav>
                <ul>
                     <li><a href="index.jsp" class="logo">Cab Booking</a></li>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="frame.jsp">Book a Cab</a></li>
                    <li><a href="my_bookings.jsp">My Bookings</a></li>
       
                    <li><a href="help.jsp">Help</a></li>
                    <!-- User Profile Section -->
                    <li class="user-info dropdown">
                        <i class="fas fa-user-circle"></i>
                        <div class="dropdown-content">
                            <span><%= session.getAttribute("username")%></span>
                            <a href="edit_profile.jsp"><i class="fas fa-user-edit"></i> Edit Profile</a>
                            <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
                        </div>
                    </li>
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
                        out.println("<tr><td colspan='10'>No bookings found</td></tr>");
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
                            java.time.LocalDate currentDate = java.time.LocalDate.now();

                            if (schedule.getString("date").compareTo(currentDate.toString()) > 0) {
                                out.println("<form action='bookingUpdate.jsp' method='POST'>");
                                out.println("<input type='hidden' name='_method' value='PUT' />");
                                out.println("<input type='hidden' name='id' value='" + schedule.getInt("id") + "' />");
                                out.println("<button type='submit'>Update</button>");
                                out.println("<button class='delete' type='button' onclick='deleteSchedule(" + schedule.getInt("id") + ")'>Cancel</button>");
                                out.println("</form>");
                            }
                            out.println("</td>");

                            // Add bill download button
                            out.println("<td>");
                            out.println("<button onclick='showBillPopup(" + (i + 1) + ")'>Bill</button>");
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
    <footer style=" position: fixed; width: 100%">
            <p>&copy; 2023 Cab Booking System. All rights reserved.</p>
            <ul>
                <li><strong>Phone:</strong> 0332246638</li>
                <li><strong>Address:</strong> Maradana, Colombo 10</li>
                <li><strong>Email:</strong> no.reply.megacity.cabservice@gmail.com</li>
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
function showBillPopup(rowIndex) {
    console.log("showBillPopup triggered with rowIndex:", rowIndex);

    const table = document.getElementById("scheduleTable");
    if (!table) {
        console.error("Table with ID 'scheduleTable' not found!");
        return;
    }

    const rows = table.getElementsByTagName("tr");
    console.log("Total rows:", rows.length);

    if (rowIndex < 1 || rowIndex >= rows.length) {
        console.error("Invalid row index:", rowIndex);
        return;
    }

    const row = rows[rowIndex];
    const cells = row.getElementsByTagName("td");

    if (cells.length === 0) {
        console.error("No table cells found in row:", row);
        return;
    }

    console.log("Row content:", row.innerHTML);

    const extractedData = {
        scheduleId: cells[0]?.textContent.trim() || "N/A",
        bookNumber: cells[1]?.textContent.trim() || "N/A",
        startLocation: cells[2]?.textContent.trim() || "N/A",
        endLocation: cells[3]?.textContent.trim() || "N/A",
        distance: cells[4]?.textContent.trim() || "N/A",
        amount: cells[5]?.textContent.trim() || "N/A",
        date: cells[6]?.textContent.trim() || "N/A",
        time: cells[7]?.textContent.trim() || "N/A",
    };

    console.log("Extracted Data:", extractedData);

    let existingPopup = document.getElementById("billPopup");
    if (existingPopup) {
        existingPopup.remove();
    }

    const popup = document.createElement("div");
    popup.id = "billPopup";
    popup.style = `
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        padding: 20px;
        background: #fff;
        border: 3px solid #003092;
        box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.3);
        z-index: 1000;
        width: 380px;
        text-align: center;
        font-family: Arial, sans-serif;
        border-radius: 10px;
    `;

    console.log("Generating Bill Content...");

    popup.innerHTML = `
        <div style="background: #00879E; color: white; padding: 12px; border-radius: 10px 10px 0 0;">
            <h2 style="margin: 0; font-size: 20px;">Mega City Cab Service</h2>
            <p style="margin: 5px 0; font-size: 12px;">Fast, Safe, and Reliable</p>
        </div>

        <table style="width: 100%; margin-top: 15px; font-size: 14px; text-align: left; padding: 10px;">
            <tr><td style="color: #003092; font-weight: bold;">Schedule ID:</td><td id="popup-scheduleId"></td></tr>
            <tr><td style="color: #003092; font-weight: bold;">Book Number:</td><td id="popup-bookNumber"></td></tr>
            <tr><td style="color: #003092; font-weight: bold;">Start Location:</td><td id="popup-startLocation"></td></tr>
            <tr><td style="color: #003092; font-weight: bold;">End Location:</td><td id="popup-endLocation"></td></tr>
            <tr><td style="color: #003092; font-weight: bold;">Distance:</td><td id="popup-distance"></td></tr>
            <tr><td style="color: #003092; font-weight: bold;">Date:</td><td id="popup-date"></td></tr>
            <tr><td style="color: #003092; font-weight: bold;">Time:</td><td id="popup-time"></td></tr>
        </table>

        <div style="background: #FFAB5B; color: black; font-weight: bold; padding: 10px; margin-top: 15px; border-radius: 5px;">
            <h3 style="margin: 5px 0; font-size: 18px;">Total: LKR <span id="popup-amount"></span></h3>
        </div>

        <button onclick="closePopup()" style="display:block; margin: 15px auto; padding: 10px 15px; background:#690B22; color:black; font-weight:bold; border:none; font-size: 14px; border-radius: 5px; cursor: pointer;">Close</button>
    `;

    document.body.appendChild(popup);

    document.getElementById("popup-scheduleId").innerText = extractedData.scheduleId;
    document.getElementById("popup-bookNumber").innerText = extractedData.bookNumber;
    document.getElementById("popup-startLocation").innerText = extractedData.startLocation;
    document.getElementById("popup-endLocation").innerText = extractedData.endLocation;
    document.getElementById("popup-distance").innerText = extractedData.distance + " km";
    document.getElementById("popup-amount").innerText = extractedData.amount;
    document.getElementById("popup-date").innerText = extractedData.date;
    document.getElementById("popup-time").innerText = extractedData.time;

    console.log("Popup added to DOM:", document.getElementById("billPopup"));
}

// Function to Close Popup
function closePopup() {
    let popup = document.getElementById("billPopup");
    if (popup) {
        popup.remove();
        console.log("Popup closed.");
    }
}






// 📌 Function to Download Bill as PDF
function downloadBillPDF(scheduleId, bookNumber, startLocation, endLocation, distance, amount, date, time) {
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();

    doc.setFontSize(18);
    doc.text("Mega City Cab Service", 10, 20);

    doc.setFontSize(12);
    doc.text(`Schedule ID: ${scheduleId}`, 10, 40);
    doc.text(`Book Number: ${bookNumber}`, 10, 50);
    doc.text(`Start Location: ${startLocation}`, 10, 60);
    doc.text(`End Location: ${endLocation}`, 10, 70);
    doc.text(`Distance: ${distance} km`, 10, 80);
    doc.text(`Amount: ₹${amount}`, 10, 90);
    doc.text(`Date: ${date}`, 10, 100);
    doc.text(`Time: ${time}`, 10, 110);

    doc.save(`Bill_${bookNumber}.pdf`);
}





        // 📌 Function to Download Excel
        function downloadExcel() {
            let table = document.querySelector("#scheduleTable");
            let wb = XLSX.utils.book_new();
            let ws = XLSX.utils.table_to_sheet(table);
            
            XLSX.utils.book_append_sheet(wb, ws, "Schedules");
            XLSX.writeFile(wb, "Schedule_List.xlsx");
        }

       
      
        
        function deleteSchedule(id) {
    if (confirm("Are you sure you want to cancel this schedule?")) {
        fetch("http://localhost:8080/Mega_City_Cab_Service/api/schedules/delete/" + id, {
            method: "DELETE"
        })
        .then(response => {
            if (response.ok) {
                // If the response is plain text, use .text()
                return response.text().then(message => {
                    alert(message); // Show the success message
                    location.reload(); // Reload the page to reflect the changes
                });
            } else {
                // Handle non-OK responses (e.g., 404, 500)
                return response.text().then(errorMessage => {
                    throw new Error(errorMessage);
                });
            }
        })
        .catch(error => {
            alert("An error occurred: " + error.message);
        });
    }
}

    </script>
</body>
</html>