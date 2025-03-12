<%-- 
    Document   : login
    Created on : 9 Mar 2025, 12:30:24
    Author     : Sanduni
--%>

<%@ page import="java.sql.*" %>
<%
    // Handle login form submission
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Database connection and query to validate user
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cabservicedb", "root", "");
            PreparedStatement stmt = conn.prepareStatement("SELECT role FROM userlogin WHERE username = ? AND password = ?");
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");
                session.setAttribute("userRole", role); // Store role in session
                session.setAttribute("username", username); // Store username in session
                response.sendRedirect("index.jsp"); // Redirect to home page
            } else {
                out.println("<script>alert('Invalid username or password');</script>");
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Database error. Please try again later.');</script>");
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - Cab Booking System</title>
        <link rel="stylesheet" href="CSS/stylesLogin.css">
    </head>
    <body>
        <!-- Header -->
        <header>
            <nav>
                <ul>
                    <li><a href="index.jsp" class="logo">Cab Booking</a></li>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="login.jsp">Login</a></li>
                    <li><a href="CustomerRegistrationJSP.jsp">Register</a></li>
                </ul>
            </nav>
        </header>

        <!-- Login Form -->
        <main class="login-container">
            <div class="login-box">
                <h1>Login</h1>
                <form action="login.jsp" method="POST">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    <button type="submit" class="login-button">Login</button>
                </form>
                <p>Don't have an account? <a href="CustomerRegistrationJSP.jsp">Register here</a>.</p>
            </div>
        </main>

        <!-- Footer -->
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