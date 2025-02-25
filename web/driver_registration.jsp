<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Registration</title>
    <link rel="stylesheet" href="CSS/styles.css">
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
            <small id="driverNameError" class="error-message"></small>
        </div>
        <div>
            <label for="phoneNo">Phone Number:</label>
            <input type="text" id="phoneNo" name="phoneNo" required />
            <small id="phoneNoError" class="error-message"></small>
        </div>
        <div>
            <label for="addressNo">Address No:</label>
            <input type="text" id="addressNo" name="addressNo" required />
            <small id="addressNoError" class="error-message"></small>
        </div>
        <div>
            <label for="addressLine1">Address Line 1:</label>
            <input type="text" id="addressLine1" name="addressLine1" required />
            <small id="addressLine1Error" class="error-message"></small>
        </div>
        <div>
            <label for="addressLine2">Address Line 2:</label>
            <input type="text" id="addressLine2" name="addressLine2" required />
            <small id="addressLine2Error" class="error-message"></small>
        </div>
        <div>
            <label for="gender">Gender:</label>
            <select id="gender" name="gender" required>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
            </select>
        </div>

        <div>
            <button type="submit">Register Driver</button>
            <button type="button" id="clearButton">Clear</button>
        </div>
    </form>

    <script>
        document.getElementById("driverForm").addEventListener("submit", async function(e) {
            e.preventDefault();
            
            const driverData = {
                nic: document.getElementById("nic").value,
                name: document.getElementById("driverName").value,
                phoneNo: document.getElementById("phoneNo").value,
                addressNo: document.getElementById("addressNo").value,
                addressLine1: document.getElementById("addressLine1").value,
                addressLine2: document.getElementById("addressLine2").value,
                gender: document.getElementById("gender").value
            };
            
            try {
                const response = await fetch("http://localhost:8080/Mega_City_Cab_Service/api/drivers/add", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify(driverData)
                });

                const result = await response.json();
                document.getElementById("message").textContent = result.message;
                document.getElementById("message").className = response.ok ? "message success show" : "message error show";
                
                if (response.ok) {
                    setTimeout(() => {
                        document.getElementById("driverForm").reset();
                    }, 2000);
                }
            } catch (error) {
                document.getElementById("message").textContent = "Error connecting to the server.";
                document.getElementById("message").className = "message error show";
            }
        });
    </script>
</body>
</html>