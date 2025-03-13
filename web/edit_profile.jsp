<%-- 
    Document   : edit_profile
    Created on : 12 Mar 2025, 18:01:42
    Author     : Sanduni
--%>

<%@ page import="java.io.*, java.net.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="org.json.JSONObject" %>
<%@ include file="header.jsp" %>

<%
    if (userRole == null || username == null) {
        response.sendRedirect("login.jsp"); // Redirect to login if not authenticated
        return;
    }

    // Fetch customer details by username
    String apiUrl = "http://localhost:8080/Mega_City_Cab_Service/api/customers/username/" + username;
    URL url = new URL(apiUrl);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("GET");
    conn.setRequestProperty("Accept", "application/json");

    BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
    String output, jsonResponse = "";
    while ((output = br.readLine()) != null) {
        jsonResponse += output;
    }
    conn.disconnect();

    JSONObject customer = new JSONObject(jsonResponse);
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Update Customer Details</title>
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
                padding: 50px;
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
                padding: 15px;
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
    </head>
    <body>
        <h1>Update Your Details</h1>
        <div class="container">
            
            <form id="updateForm">
                <label>Name:</label>
                <input type="text" id="name" value="<%= customer.getString("name")%>" required>

                <label>NIC:</label>
                <input type="text" id="nic" value="<%= customer.getString("nic")%>" required>

                <label>Email:</label>
                <input type="email" id="email" value="<%= customer.getString("email")%>" required>

                <label>Address:</label>
                <input type="text" id="address" value="<%= customer.getString("address")%>" required>

                <label>Phone Number:</label>
                <input type="text" id="phoneno" value="<%= customer.getString("phoneno")%>" required>

                <button type="button" onclick="updateCustomer()">Update</button>
            </form>
        </div>

        <script>
            function updateCustomer() {
                const username = "<%= username%>"; // Fetching from session
                const apiUrl = "http://localhost:8080/Mega_City_Cab_Service/api/customers/update/username/" + username;

                const customerData = {
                    name: document.getElementById("name").value,
                    nic: document.getElementById("nic").value,
                    email: document.getElementById("email").value,
                    address: document.getElementById("address").value,
                    phoneno: document.getElementById("phoneno").value
                };

                fetch(apiUrl, {
                    method: "PUT",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify(customerData)
                })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                alert("Customer updated successfully!");
                            } else {
                                alert("Update failed: " + data.message);
                            }
                        })
                        .catch(error => console.error("Error:", error));
            }
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
