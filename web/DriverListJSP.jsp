<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL, org.json.JSONArray, org.json.JSONObject" %>
<!DOCTYPE html>
<html>
<head> 
    <meta charset="UTF-8">
    <title>Driver List</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
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
            padding: 5px 10px;
            border: none;
            background-color: #28a745;
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
    </style>
</head>
<body>
    <h2>Driver List</h2>
    <table>
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
                // Fetch data from the backend API
                URL url = new URL("http://localhost:8080/Mega_City_Cab_Service/api/drivers/getAll");
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                conn.setRequestProperty("Accept", "application/json");

                if (conn.getResponseCode() != 200) {
                    out.println("Failed to fetch data: HTTP error code " + conn.getResponseCode());
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
                out.println("Error: " + e.getMessage());
            }
        %>
    </table>
</body>
</html>
