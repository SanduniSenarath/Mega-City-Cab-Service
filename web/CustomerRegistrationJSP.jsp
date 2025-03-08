<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Registration</title>
    <link rel="stylesheet" href="CSS/styles.css">
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
    <h1>Register a New Customer</h1>

    <div id="message" class="message"></div>

    <form id="customerForm" class="form">
        <h2>Customer Details</h2>
        <div>
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required />
            <small id="usernameError" class="error-message"></small>
        </div>
        <div>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required />
            <small id="passwordError" class="error-message"></small>
        </div>
        <div>
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required />
            <small id="confirmPasswordError" class="error-message"></small>
        </div>
        <div>
            <label for="nic">NIC:</label>
            <input type="text" id="nic" name="nic" required />
            <small id="nicError" class="error-message"></small>
        </div>
        <div>
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required />
            <small id="nameError" class="error-message"></small>
        </div>
        <div>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required />
            <small id="emailError" class="error-message"></small>
        </div>
        <div>
            <label for="phoneno">Phone Number:</label>
            <input type="text" id="phoneno" name="phoneno" required />
            <small id="phonenoError" class="error-message"></small>
        </div>
        <div>
            <label for="addressLine1">Address Line 1:</label>
            <input type="text" id="addressLine1" name="addressLine1" required />
            <small id="addressLine1Error" class="error-message"></small>
        </div>
        <div>
            <label for="addressLine2">Address Line 2:</label>
            <input type="text" id="addressLine2" name="addressLine2" />
        </div>
        <div>
            <label for="addressLine3">Address Line 3:</label>
            <input type="text" id="addressLine3" name="addressLine3" />
        </div>
        
        <div>
            <button type="submit">Register Customer</button>
            <button type="button" id="clearButton">Clear</button>
        </div>
    </form>

    <script>
        function validateEmail(email) {
            const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return regex.test(email);
        }

        function validateNIC(nic) {
            const regex = /^\d{9}[Vv]$/;
            return regex.test(nic);
        }

        function validatePhone(phone) {
            const regex = /^\d{10}$/;
            return regex.test(phone);
        }

        document.getElementById("customerForm").addEventListener("submit", async function(e) {
            e.preventDefault();
            
            const username = document.getElementById("username").value;
            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirmPassword").value;
            const email = document.getElementById("email").value;
            const nic = document.getElementById("nic").value;
            const phoneno = document.getElementById("phoneno").value;

            if (password !== confirmPassword) {
                document.getElementById("confirmPasswordError").textContent = "Passwords do not match.";
                document.getElementById("confirmPasswordError").style.display = "block";
                return;
            }

            const customerData = {
                nic: nic,
                name: document.getElementById("name").value,
                email: email,
                phoneno: phoneno,
                address: [document.getElementById("addressLine1").value,
                          document.getElementById("addressLine2").value,
                          document.getElementById("addressLine3").value].filter(line => line.trim() !== "").join(", ")
            };

            const userData = {
                username: username,
                password: password,
                role: "customer"
            };
            
            try {
                const customerResponse = await fetch("http://localhost:8080/Mega_City_Cab_Service/api/customers/add", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify(customerData)
                });
                
                const userResponse = await fetch("http://localhost:8080/Mega_City_Cab_Service/api/users/add", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify(userData)
                });

                if (customerResponse.ok && userResponse.ok) {
                    document.getElementById("message").textContent = "Registration successful!";
                    document.getElementById("message").className = "message success";
                    setTimeout(() => { document.getElementById("customerForm").reset(); }, 2000);
                } else {
                    document.getElementById("message").textContent = "Registration failed.";
                    document.getElementById("message").className = "message error";
                }
            } catch (error) {
                document.getElementById("message").textContent = "Error connecting to the server.";
                document.getElementById("message").className = "message error";
            }
        });
    </script>
</body>
</html>
