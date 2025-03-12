<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL" %>
<%@ page import="org.json.JSONArray, org.json.JSONObject" %>
<%
    // Fetch user role and username from session
    String userRole = (String) session.getAttribute("userRole");
    String username = (String) session.getAttribute("username");
    if (userRole == null) {
        userRole = "guest"; 
    }
%>
<html>
    <head>
        <title>Available Vehicles</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="styles.css">
    <header>
        <nav>
            <ul>
                <li><a href="index.jsp" class="logo">Cab Booking</a></li>

                <% if (userRole.equals("admin")) { %>
                <li><a href="admin_home.jsp" class="logo">Cab Booking</a></li>
                <li><a href="admin_home.jsp">Home</a></li>
                <li><a href="vehicle-registration.jsp">Vehicle Registration</a></li>
                <li><a href="driver_registration.jsp">Driver Registration</a></li>
                <li><a href="view_bookings.jsp">All Bookings</a></li>
                <li><a href="view_customers.jsp">All Customers</a></li>
                <li><a href="logout.jsp">Logout</a></li>
                    <% } else if (userRole.equals("driver")) { %>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="driver_dashboard.jsp">Driver Dashboard</a></li>
                <li><a href="view_bookings.jsp">View Bookings</a></li>
                    <% } else if (userRole.equals("customer")) { %>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="frame.jsp">Book a Cab</a></li>
                <li><a href="my_bookings.jsp">My Bookings</a></li>
                    <% } else { %>
                <li><a href="login.jsp">Login</a></li>
                <li><a href="CustomerRegistrationJSP.jsp">Register</a></li>
                    <% } %>
                <li><a href="help.jsp">Help</a></li>
                    <% if (!userRole.equals("guest")) { %>
                <li><a href="logout.jsp">Logout</a></li>
                    <% } %>
            </ul>
        </nav>
    </header>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            color: #333;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        h2 {
            text-align: center;
            color: #444;
            margin-bottom: 30px;
        }
        .vehicle-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .vehicle-box {
            width: 250px;
            border: 1px solid #ddd;
            padding: 20px;
            text-align: left;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .vehicle-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        .vehicle-box img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 10px;
        }
        .vehicle-box p {
            margin: 10px 0;
            font-size: 14px;
            color: #555;
        }
        .vehicle-box strong {
            color: #333;
        }
        .loading {
            text-align: center;
            font-size: 16px;
            color: #666;
            margin-top: 20px;
        }
        .error-message {
            text-align: center;
            font-size: 16px;
            color: red;
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Available Vehicles</h2>
        <div class="error-message" id="error-message" style="display: none;"></div>
        <div class="vehicle-container" id="vehicle-list">

            <%
                String apiUrl = "http://localhost:8080/Mega_City_Cab_Service/api/drivervehicle/available";
                StringBuilder jsonResponse = new StringBuilder();
                try {
                    URL url = new URL(apiUrl);
                    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                    conn.setRequestMethod("GET");
                    conn.setRequestProperty("Accept", "application/json");

                    if (conn.getResponseCode() != 200) {
                        out.println("<p class='error-message'>Failed to fetch vehicles. Please try again later.</p>");
                    } else {
                        BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
                        String output;
                        while ((output = br.readLine()) != null) {
                            jsonResponse.append(output);
                        }
                        conn.disconnect();

                        JSONArray vehicles = new JSONArray(jsonResponse.toString());

                        if (vehicles.length() == 0) {
                            out.println("<p>No vehicles available at the moment.</p>");
                        } else {
                            for (int i = 0; i < vehicles.length(); i++) {
                                JSONObject vehicle = vehicles.getJSONObject(i);
                                String vehicleNo = vehicle.optString("vehicleNo", "N/A");
                                String empschNo = vehicle.optString("empSchNo", "N/A"); 


                                // Fetch vehicle details based on vehicleNo
                                String detailsApiUrl = "http://localhost:8080/Mega_City_Cab_Service/api/vehicles/number/" + vehicleNo;
                                StringBuilder detailsResponse = new StringBuilder();
                                try {
                                    URL detailsUrl = new URL(detailsApiUrl);
                                    HttpURLConnection detailsConn = (HttpURLConnection) detailsUrl.openConnection();
                                    detailsConn.setRequestMethod("GET");
                                    detailsConn.setRequestProperty("Accept", "application/json");

                                    if (detailsConn.getResponseCode() == 200) {
                                        BufferedReader detailsBr = new BufferedReader(new InputStreamReader((detailsConn.getInputStream())));
                                        String detailsOutput;
                                        while ((detailsOutput = detailsBr.readLine()) != null) {
                                            detailsResponse.append(detailsOutput);
                                        }
                                        detailsBr.close();
                                    }
                                    detailsConn.disconnect();

                                    // Parse vehicle details
                                    JSONObject vehicleDetails = new JSONObject(detailsResponse.toString());
                                    String brand = vehicleDetails.optString("brandName", "Unknown");
                                    String type = vehicleDetails.optString("type", "Unknown");
                                    int availableSeats = vehicleDetails.optInt("availableSeats", 0);
                                    String imageUrl = vehicleDetails.optString("imageUrl", "https://via.placeholder.com/250x150?text=No+Image");

            %>
            <div class="vehicle-box"  onclick="redirectToBooking('<%= empschNo %>')">
                <h3><img src="download (1)_1.png" alt="Car Icon" > Vehicle Details</h3>
                <p><strong>Vehicle No:</strong> <%= vehicleNo %></p>
                <p><strong>Brand:</strong> <%= brand %></p>
                <p><strong>Type:</strong> <%= type %></p>
                <p><strong>Available Seats:</strong> <%= availableSeats %></p>
            </div>
            <%
                                } catch (Exception detailsEx) {
                                    out.println("<p class='error-message'>Error fetching details for Vehicle No: " + vehicleNo + "</p>");
                                }
                            }
                        }
                    }
                } catch (Exception e) {
                    out.println("<p class='error-message'>Error: " + e.getMessage() + "</p>");
                }
            %>



        </div>
    </div>
    <script>
        function redirectToBooking(empschNo) {
            window.location.href = "AddBookings.jsp?empSchNo=" + encodeURIComponent(empschNo);
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
