<!DOCTYPE html>
<%
    // Fetch user role and username from session
    String userRole = (String) session.getAttribute("userRole");
    String username = (String) session.getAttribute("username");
    if (userRole == null) {
        userRole = "guest";
    }

%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Driver Registration</title>
        <link rel="stylesheet" href="styles.css">
        <link rel="stylesheet" href="CSS/driver.css">
    <header>
        <nav>
            <ul>


                <% if (userRole.equals("admin")) { %>
                <li><a href="admin_home.jsp" class="logo">Cab Booking</a></li>
                <li><a href="admin_home.jsp">Home</a></li>
                <li><a href="vehicle-registration.jsp">Vehicle Registration</a></li>
                <li><a href="driver_registration.jsp">Driver Registration</a></li>
                <li><a href="view_bookings.jsp">All Bookings</a></li>
                <li><a href="view_customers.jsp">All Customers</a></li>

                <% } else if (userRole.equals("driver")) { %>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="driver_dashboard.jsp">Driver Dashboard</a></li>
                <li><a href="view_bookings.jsp">View Bookings</a></li>
                    <% } else if (userRole.equals("customer")) { %>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="AddBookings.jsp">Book a Cab</a></li>
                <li><a href="my_bookings.jsp">My Bookings</a></li>
                    <% } else { %>
                <li><a href="login.jsp">Login</a></li>
                <li><a href="CustomerRegistrationJSP.jsp">Register</a></li>
                    <% } %>
                <li><a href="help.jsp">Help</a></li>
                    <% if (!userRole.equals("guest")) { %>
                <li><a href="logout.jsp">Logout</a></li>
                    <% }%>
            </ul>
        </nav>
    </header>
    <style>
        .error-message {
            color: red;
            font-size: 12px;
            display: none;
        }
        .message {
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            display: none;
        }
        .message.success {
            background-color: #d4edda;
            color: #155724;
            display: block;
        }
        .message.error {
            background-color: #f8d7da;
            color: #721c24;
            display: block;
        }
    </style>
</head>
<body>
    <h1>Register a New Driver</h1>

    <div id="message" class="message"></div>

    <form id="driverForm" class="form">
        <h2>Driver Details</h2>
        <div>
            <label for="nic">NIC:</label>
            <input type="text" id="nic" name="nic" required />
            <small id="nicError" class="error-message"></small>
        </div>
        <div>
            <label for="driverName">Driver Name:</label>
            <input type="text" id="driverName" name="driverName" required />
        </div>
        <div>
            <label for="phoneNo">Phone Number:</label>
            <input type="text" id="phoneNo" name="phoneNo" required />
        </div>
        <div>
            <label for="addressNo">Address No:</label>
            <input type="text" id="addressNo" name="addressNo" required />
        </div>
        <div>
            <label for="addressLine1">Address Line 1:</label>
            <input type="text" id="addressLine1" name="addressLine1" required />
        </div>
        <div>
            <label for="addressLine2">Address Line 2:</label>
            <input type="text" id="addressLine2" name="addressLine2" required />
        </div>
        <div>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required />
        </div>
        <div>
            <label for="gender">Gender:</label>
            <select id="gender" name="gender" required>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
            </select>
        </div>
        <h2>User Credentials</h2>
        <div>
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required />
        </div>
        <div>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required />
        </div>
        <div>
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required />
            <small id="passwordError" class="error-message"></small>
        </div>
        <div>
            <button type="submit">Register Driver</button><br><br>
            <button type="button" id="clearButton">Clear</button>
        </div>
    </form>

    <script>
        document.getElementById("driverForm").addEventListener("submit", async function (e) {
            e.preventDefault();

            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirmPassword").value;

            if (password !== confirmPassword) {
                document.getElementById("passwordError").textContent = "Passwords do not match.";
                document.getElementById("passwordError").style.display = "block";
                return;
            } else {
                document.getElementById("passwordError").style.display = "none";
            }

            const driverData = {
                nic: document.getElementById("nic").value,
                name: document.getElementById("driverName").value,
                phoneNo: document.getElementById("phoneNo").value,
                addressNo: document.getElementById("addressNo").value,
                addressLine1: document.getElementById("addressLine1").value,
                addressLine2: document.getElementById("addressLine2").value,
                gender: document.getElementById("gender").value,
                username: document.getElementById("username").value,
                email: document.getElementById("email").value
            };

            const userData = {
                username: document.getElementById("username").value,
                password: password,
                role: "driver"
            };

            try {
                const driverResponse = await fetch("http://localhost:8080/Mega_City_Cab_Service/api/drivers/add", {
                    method: "POST",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify(driverData)
                });

                if (!driverResponse.ok)
                    throw new Error("Driver registration failed.");

                const userResponse = await fetch("http://localhost:8080/Mega_City_Cab_Service/api/users/add", {
                    method: "POST",
                    headers: {"Content-Type": "application/json"},
                    body: JSON.stringify(userData)
                });

                if (!userResponse.ok)
                    throw new Error("User registration failed.");

                document.getElementById("message").textContent = "Driver and user registered successfully.";
                document.getElementById("message").className = "message success";

                setTimeout(() => {
                    document.getElementById("driverForm").reset();
                    document.getElementById("message").className = "message";
                }, 2000);
            } catch (error) {
                document.getElementById("message").textContent = error.message;
                document.getElementById("message").className = "message error";
            }
        });

        document.getElementById("clearButton").addEventListener("click", function () {
            document.getElementById("driverForm").reset();
            document.getElementById("message").textContent = "";
            document.getElementById("message").className = "message";
        });
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
