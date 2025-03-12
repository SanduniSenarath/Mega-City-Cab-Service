<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL, org.json.JSONArray, org.json.JSONObject" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Customer List</title>
        <link rel="stylesheet" type="text/css" href="styles.css">
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
            h1 {
                color: #333;
                text-align: center;
            }
            .search-container {
                text-align: center;
                margin-bottom: 20px;
            }
            #searchInput {
                width: 50%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
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
                background-color: #D84040;
                color: white;
                cursor: pointer;
                border-radius: 5px;
                font-size: 14px;
            }
            button:hover {
                opacity: 0.9;
            }
        </style>
        <script>
            function removeCustomer(id) {
                if (confirm("Are you sure you want to remove this customer?")) {
                    fetch("http://localhost:8080/Mega_City_Cab_Service/api/customers/delete/" + id, {
                        method: "DELETE"
                    })
                            .then(response => response.json())
                            .then(data => {
                                if (data.success) {
                                    alert("Customer removed successfully");
                                    location.reload();
                                } else {
                                    alert("Failed to remove customer");
                                }
                            })
                            .catch(error => console.error("Error:", error));
                }
            }

            function filterCustomers() {
                let input = document.getElementById("searchInput").value.toLowerCase();
                let rows = document.getElementById("customerTable").getElementsByTagName("tr");

                for (let i = 1; i < rows.length; i++) {
                    let usernameCell = rows[i].getElementsByTagName("td")[6]; // Username column
                    if (usernameCell) {
                        let username = usernameCell.textContent.toLowerCase();
                        rows[i].style.display = username.includes(input) ? "" : "none";
                    }
                }
            }
        </script>
    </head>
    <body>
        <div class="container">
            <h1>Customer List</h1>

            <div class="search-container">
                <input type="text" id="searchInput" onkeyup="filterCustomers()" placeholder="Search by username...">
            </div>

            <table id="customerTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone No</th>
                        <th>Address</th>
                        <th>NIC</th>
                        <th>Username</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            URL url = new URL("http://localhost:8080/Mega_City_Cab_Service/api/customers/getAll");
                            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                            conn.setRequestMethod("GET");
                            conn.setRequestProperty("Accept", "application/json");

                            if (conn.getResponseCode() != 200) {
                                throw new RuntimeException("Failed : HTTP error code : " + conn.getResponseCode());
                            }

                            BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
                            StringBuilder sb = new StringBuilder();
                            String output;
                            while ((output = br.readLine()) != null) {
                                sb.append(output);
                            }
                            conn.disconnect();

                            JSONArray customers = new JSONArray(sb.toString());

                            for (int i = 0; i < customers.length(); i++) {
                                JSONObject customer = customers.getJSONObject(i);
                    %>
                    <tr>
                        <td><%= customer.getInt("id")%></td>
                        <td><%= customer.getString("name")%></td>
                        <td><%= customer.getString("email")%></td>
                        <td><%= customer.getString("phoneno")%></td>
                        <td><%= customer.getString("address")%></td>
                        <td><%= customer.getString("nic")%></td>
                        <td><%= customer.getString("username")%></td>
                        <td>
                            <button onclick="removeCustomer(<%= customer.getInt("id")%>)">Remove</button>
                        </td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </tbody>
            </table>
        </div>
    </body>
</html>
