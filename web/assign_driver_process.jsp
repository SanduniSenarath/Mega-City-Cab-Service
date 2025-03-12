<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL, org.json.JSONArray, org.json.JSONObject" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Assign Driver to Vehicle</title>
        <link rel="stylesheet" href="styles.css">
        <link rel="stylesheet" href="CSS/asign.css">
    </head>
    <body>

        <header>
            <nav>
                <ul>
                    <li><a href="admin_home.jsp" class="logo">Cab Booking</a></li>
                    <li><a href="admin_home.jsp">Home</a></li>
                    <li><a href="vehicle-list.jsp">Vehicle List</a></li>
                    <li><a href="driver_registration.jsp">Driver Registration</a></li>
                </ul>
            </nav>
        </header>

        <h2>Assign Driver to Vehicle</h2>

        <%
            String vehicleId = request.getParameter("vehicleId");
            JSONObject vehicle = null;

            if (vehicleId != null && !vehicleId.isEmpty()) {
                try {
                    URL url = new URL("http://localhost:8080/Mega_City_Cab_Service/api/vehicles/" + vehicleId);
                    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                    conn.setRequestMethod("GET");
                    conn.setRequestProperty("Accept", "application/json");

                    if (conn.getResponseCode() == 200) {
                        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                        String output, jsonResponse = "";
                        while ((output = br.readLine()) != null) {
                            jsonResponse += output;
                        }
                        conn.disconnect();
                        vehicle = new JSONObject(jsonResponse);
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Error fetching vehicle details.</p>");
                }
            }
        %>

        <div class="container">
            <div class="info-box">
                <h3>Vehicle Information</h3>
                <% if (vehicle != null) { %>
                <p><strong>Vehicle Number:</strong> <span id="vehicleNumber"><%= vehicle.getString("vehicleNumber") %></span></p>
                <p><strong>Brand:</strong> <%= vehicle.getString("brandName") %></p>
                <p><strong>Type:</strong> <%= vehicle.getString("type") %></p>
                <p><strong>Fuel Type:</strong> <%= vehicle.getString("fuelType") %></p>
                <p><strong>Available Seats:</strong> <%= vehicle.getInt("availableSeats") %></p>
                <p><strong>Owner:</strong> <%= vehicle.getString("owner") %></p>
                <% } else { %>
                <p style="color:red;">No vehicle selected or vehicle not found.</p>
                <% } %>
            </div>

            <div class="info-box">
                <h3>Driver Details</h3>
                <form action="assign_driver_submit.jsp" method="post">
                    <input type="hidden" name="vehicleId" id="vehicleId" value="<%= vehicleId %>">

                    <label for="driver">Select Driver:</label>
                    <select name="driverId" id="driver" onchange="fetchDriverDetails(this)">
                        <option value="">Select a Driver</option>
                        <% 
                        try {
                            URL url = new URL("http://localhost:8080/Mega_City_Cab_Service/api/drivers/available");
                            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                            conn.setRequestMethod("GET");
                            conn.setRequestProperty("Accept", "application/json");

                            if (conn.getResponseCode() == 200) {
                                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                                String output, jsonResponse = "";
                                while ((output = br.readLine()) != null) {
                                    jsonResponse += output;
                                }
                                conn.disconnect();

                                JSONArray drivers = new JSONArray(jsonResponse);
                                for (int i = 0; i < drivers.length(); i++) {
                                    JSONObject driver = drivers.getJSONObject(i);
                                    out.println("<option value='" + driver.getInt("id") + "' data-driver='" + driver.toString() + "'>" 
                                                + driver.getString("name") + "</option>");
                                }
                            }
                        } catch (Exception e) {
                            out.println("<option value=''>Error fetching drivers</option>");
                        }
                        %>
                    </select>

                    <div id="driverDetails" style="display:none;text-align: left;">
                        <p><strong>Name:</strong> <span id="driverName"></span></p>
                        <p><strong>Username:</strong> <span id="driverUsername"></span></p>
                        <p><strong>Email:</strong> <span id="driverEmail"></span></p>
                        <p><strong>NIC:</strong> <span id="driverNIC"></span></p>
                        <p><strong>Phone No:</strong> <span id="driverPhoneNo"></span></p>
                        <p><strong>Gender:</strong> <span id="driverGender"></span></p>
                        <p><strong>Address:</strong> <span id="driverAddress"></span></p>
                    </div>
                </form>
            </div>
        </div>

        <div class="container">
            <div class="info-box" styles="text-align: left;">
                <h3>Assign Vehicle to Driver</h3>
                <form id="assignForm" method="post" onsubmit="return assignDriverVehicle(event)">
                    <input type="hidden" id="empSchNo" name="empSchNo">
                    <p><strong>Employee Schedule No:</strong> <span id="displayEmpSchNo"></span></p>
                    <p><strong>Vehicle Number:</strong> <span id="displayVehicleNo"></span></p>
                    <p><strong>Driver Username:</strong> <span id="displayDriverUsername"></span></p>
                    <button type="submit">Assign</button>
                </form>
            </div>
        </div>

        <footer>
            <p>&copy; 2025 Cab Booking System. All rights reserved.</p>
        </footer>

        <script>
            function generateRandomEmpSchNo() {
                return Math.floor(1000 + Math.random() * 9000);
            }

            function updateAssignBox() {
                document.getElementById('empSchNo').value = generateRandomEmpSchNo();
                document.getElementById('displayEmpSchNo').innerText = document.getElementById('empSchNo').value;
                document.getElementById('displayVehicleNo').innerText = document.getElementById("vehicleNumber").innerText;
                //            document.getElementById('displayDriverUsername').innerText = document.querySelector("#driver option:checked").text;
                let selectedDriver = document.querySelector("#driver option:checked");
                let driverData = selectedDriver.getAttribute('data-driver');

                if (driverData) {
                    let driver = JSON.parse(driverData);
                    document.getElementById('displayDriverUsername').innerText = driver.username; // Use username instead of name
                }
            }

            document.getElementById("driver").addEventListener("change", updateAssignBox);

            function assignDriverVehicle(event) {
                event.preventDefault();

                const empSchNo = document.getElementById('empSchNo').value;
                const vehicleNo = document.getElementById('displayVehicleNo').innerText;
                const driverUsername = document.getElementById('displayDriverUsername').innerText;

                if (!vehicleNo || !driverUsername) {
                    alert("Please select a vehicle and a driver first.");
                    return;
                }

                fetch("http://localhost:8080/Mega_City_Cab_Service/api/drivervehicle/add", {
                    method: "POST",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify({empSchNo, vehicleNo, driverUsername, isavailable: "true"})
                })
                        .then(response => response.text())
                        .then(data => {
                            console.log("Server Response:", data);
                            alert("Assignment Successful!");
                            resetForm();
                        })
                        .catch(error => console.error("Error:", error));
                resetForm();
            }

            function fetchDriverDetails(selectElement) {
                let selectedOption = selectElement.options[selectElement.selectedIndex];
                let driverData = selectedOption.getAttribute('data-driver');

                if (driverData) {
                    let driver = JSON.parse(driverData);
                    document.getElementById('driverName').innerText = driver.name || "N/A";
                    document.getElementById('driverUsername').innerText = driver.username || "N/A";
                    document.getElementById('driverEmail').innerText = driver.email || "N/A";
                    document.getElementById('driverNIC').innerText = driver.nic || "N/A";
                    document.getElementById('driverPhoneNo').innerText = driver.phoneNo || "N/A";
                    document.getElementById('driverGender').innerText = driver.gender || "N/A";

                    // Construct the full address
                    let address = `${driver.addressNo || ""}, ${driver.addressLine1 || ""}, ${driver.addressLine2 || ""}`;
                                document.getElementById('driverAddress').innerText = driver.addressLine2 || "N/A";

                                document.getElementById('driverDetails').style.display = 'block';
                            } else {
                                document.getElementById('driverDetails').style.display = 'none';
                            }
                        }

                        function resetForm() {
                            document.getElementById("assignForm").reset(); // Reset form fields
                            document.getElementById("driverDetails").style.display = "none"; // Hide driver details
                            document.getElementById("displayEmpSchNo").innerText = "";
                            document.getElementById("displayVehicleNo").innerText = "";
                            document.getElementById("displayDriverUsername").innerText = "";
                            document.getElementById("driver").selectedIndex = 0; // Reset driver dropdown
                        }
        </script>

    </body>
</html>