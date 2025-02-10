<%-- 
    Document   : bookListJSP
    Created on : 9 Feb 2025, 16:26:13
    Author     : Sanduni
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL, org.json.JSONArray, org.json.JSONObject" %>
<!DOCTYPE html>
<html>
<head> 
    <meta charset="UTF-8">
    <title>Book List</title>
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
    </style>
</head>
<body>
    <h2>Book List</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Author</th>
            <th>Available</th>
        </tr>
        <%
            try {
                URL url = new URL("http://localhost:8080/Mega_City_Cab_Service/api/books/getAllBooks");
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

                    JSONArray books = new JSONArray(jsonResponse);
                    for (int i = 0; i < books.length(); i++) {
                        JSONObject book = books.getJSONObject(i);
                        out.println("<tr>");
                        out.println("<td>" + book.getInt("id") + "</td>");
                        out.println("<td>" + book.getString("title") + "</td>");
                        out.println("<td>" + book.getString("author") + "</td>");
                        out.println("<td>" + (book.getBoolean("available") ? "Yes" : "No") + "</td>");
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
