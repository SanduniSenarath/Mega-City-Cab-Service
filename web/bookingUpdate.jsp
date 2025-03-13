
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL, org.json.JSONObject" %>
<%@ page import="java.io.OutputStreamWriter" %>
   <%@ include file="header.jsp" %>
<%
   
    // Handle form submission
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String id = request.getParameter("id");
        String bookNumber = request.getParameter("bookNumber");
        String startLocation = request.getParameter("startLocation");
        String endLocation = request.getParameter("endLocation");
        String distance = request.getParameter("distance");
        String amount = request.getParameter("amount");
        String empSchNo = request.getParameter("empSchNo");
        String date = request.getParameter("date");
        String time = request.getParameter("time");

        try {
            // Prepare the JSON payload
            JSONObject updatedSchedule = new JSONObject();
            updatedSchedule.put("bookNumber", bookNumber);
            updatedSchedule.put("startLocation", startLocation);
            updatedSchedule.put("endLocation", endLocation);
            updatedSchedule.put("distance", Double.parseDouble(distance));
            updatedSchedule.put("amount", Double.parseDouble(amount));
            updatedSchedule.put("empSchNo", empSchNo);
            updatedSchedule.put("username", username);
            updatedSchedule.put("date", date);
            updatedSchedule.put("time", time);

            // Send the PUT request to the backend API
            URL url = new URL("http://localhost:8080/Mega_City_Cab_Service/api/schedules/update/" + id);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("PUT");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream());
            writer.write(updatedSchedule.toString());
            writer.flush();
            writer.close();

            // Check the response code
            int responseCode = conn.getResponseCode();
            if (responseCode == 200) {
                out.println("<script>alert('Schedule updated successfully!');</script>");
            } else {
                out.println("<script>alert('Failed to update. Error code: " + responseCode + "');</script>");
            }
        } catch (Exception e) {
//            out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Update Schedule</title>
        <link rel="stylesheet" href="styles.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f9;
                color: #333;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .container {
                width: 60%;
                max-width: 1200px;
                margin: 20px;
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                margin-left: 320px;
            }

            h1 {
                text-align: center;
                font-size: 2rem;
                color: #2c3e50;
            }

            form input {
                width: 100%;
                padding: 10px;
                margin: 5px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            form input[readonly] {
                background-color: #e9ecef;
                cursor: not-allowed;
            }

            form button {
                width: 100%;
                padding: 10px;
                background-color: #3498db;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 1rem;
            }

            form button:hover {
                background-color: #2980b9;
            }
        </style>
        <link rel="stylesheet" href="styles.css">
    
</head>
<body>
    <div class="container">
        <h1>Update Schedule</h1>
        <form id="updateForm" method="POST">
            <%
                // Fetch the schedule ID from the request parameter
                String id = request.getParameter("id");
                if (id == null || id.isEmpty()) {
                    out.println("<script>alert('Invalid Schedule ID.');</script>");
                } else {
                    try {
                        // Fetch schedule details from the backend API
                        URL url = new URL("http://localhost:8080/Mega_City_Cab_Service/api/schedules/" + id);
                        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                        conn.setRequestMethod("GET");
                        conn.setRequestProperty("Accept", "application/json");

                        if (conn.getResponseCode() != 200) {
                            out.println("<script>alert('Error fetching schedule details.');</script>");
                        } else {
                            BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
                            StringBuilder jsonResponse = new StringBuilder();
                            String output;
                            while ((output = br.readLine()) != null) {
                                jsonResponse.append(output);
                            }
                            conn.disconnect();

                            // Parse the JSON response
                            JSONObject schedule = new JSONObject(jsonResponse.toString());
            %>
            <!-- Hidden field for schedule ID -->
            <input type="hidden" id="id" name="id" value="<%= id%>">

            <!-- Book Number (Read-only) -->
            <input type="text" id="bookNumber" name="bookNumber" placeholder="Book Number" value="<%= schedule.getString("bookNumber")%>" readonly>

            <!-- Start Location -->
            <input type="text" id="startLocation" name="startLocation" placeholder="Start Location" value="<%= schedule.getString("startLocation")%>" required>

            <!-- End Location -->
            <input type="text" id="endLocation" name="endLocation" placeholder="End Location" value="<%= schedule.getString("endLocation")%>" required>

            <!-- Distance -->
            <input type="number" id="distance" name="distance" placeholder="Distance" value="<%= schedule.getDouble("distance")%>" required>

            <!-- Amount -->
            <input type="number" id="amount" name="amount" placeholder="Amount" value="<%= schedule.getDouble("amount")%>" readonly>

            <!-- Employee Schedule Number (Read-only) -->
            <input type="text" id="empSchNo" name="empSchNo" placeholder="Employee Schedule Number" value="<%= schedule.getString("empSchNo")%>" readonly>

            <!-- Username (Read-only) -->
            <input type="text" id="username" name="username" placeholder="Username" value="<%= schedule.getString("username")%>" readonly>

            <!-- Date -->
            <input type="date" id="date" name="date" value="<%= schedule.getString("date")%>" required>

            <!-- Time -->
            <input type="time" id="time" name="time" value="<%= schedule.getString("time")%>" required>

            <!-- Submit Button -->
            <button type="submit">Update Schedule</button>
            <%
                        }
                    } catch (Exception e) {
                        out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
                    }
                }
            %>
        </form>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            let pricePerKm = 0;

            // Fetch price per km from the API
            fetch('http://localhost:8080/Mega_City_Cab_Service/api/prices/1')
                    .then(response => response.json())
                    .then(data => {
                        if (data && data.price) {
                            pricePerKm = parseFloat(data.price); // Store the fetched price
                        } else {
                            console.error('Invalid response for price');
                        }
                    })
                    .catch(error => console.error('Error fetching price:', error));



            // Calculate the amount based on distance
            document.getElementById('distance').addEventListener('input', function () {
                const distance = parseFloat(this.value);
                if (!isNaN(distance) && pricePerKm > 0) {
                    document.getElementById('amount').value = (distance * pricePerKm).toFixed(2);
                } else {
                    document.getElementById('amount').value = '';
                }
            });

            // Disable past dates and times
            const dateInput = document.getElementById('date');
            const timeInput = document.getElementById('time');

            const now = new Date();
            const currentDate = now.toISOString().split('T')[0]; // Get current date in YYYY-MM-DD format
            const currentTime = now.toTimeString().split(' ')[0].substring(0, 5); // Get current time in HH:MM format

            // Set min date to today
            dateInput.setAttribute('min', currentDate);

            // Update time restrictions based on date selection
            dateInput.addEventListener('change', function () {
                if (this.value === currentDate) {
                    timeInput.setAttribute('min', currentTime);
                } else {
                    timeInput.removeAttribute('min'); // Allow any time for future dates
                }
            });
        });
    </script>


   <footer>
            <p>&copy; 2023 Cab Booking System. All rights reserved.</p>
            <ul>
                <li><strong>Phone:</strong> 0332246638</li>
                <li><strong>Address:</strong> Maradana, Colombo 10</li>
                <li><strong>Email:</strong> no.reply.megacity.cabservice@gmail.com</li>
            </ul>

        </footer>
</body>
</html>