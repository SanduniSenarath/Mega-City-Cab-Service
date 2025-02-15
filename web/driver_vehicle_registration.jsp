<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle and Driver Registration</title>
    <link rel="stylesheet" href="styles.css"> <!-- External CSS file link -->
    <style>
        /* CSS Styling for the form layout */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }

        h1 {
            color: #333;
        }

        .form-container {
            display: flex;
            justify-content: space-between;
            gap: 30px;
            flex-wrap: wrap;
        }

        .form {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 100%;
            flex: 1 1 45%; /* Allow forms to shrink and grow with a base size of 45% */
        }

        form h2 {
            margin-top: 0;
        }

        div {
            margin-bottom: 15px;
        }

        label {
            display: block;
            font-weight: bold;
        }

        input, select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 16px;
            border-radius: 4px;
        }

        button:hover {
            background-color: #45a049;
        }

        .message {
            margin-top: 20px;
            padding: 10px;
            border-radius: 4px;
            color: #fff;
            display: none; /* Hidden by default */
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            width: 80%;
            max-width: 500px;
            z-index: 1000;
        }

        .success {
            background-color: #4CAF50;
        }

        .error {
            background-color: #f44336;
        }

        .show {
            display: block; /* Show the message */
        }
    </style>
</head>
<body>
    <h1>Register a New Vehicle and Driver</h1>

    <div id="message" class="message"></div>

    <!-- Registration Container -->
    <div class="form-container">
        <!-- Vehicle Registration Form -->
        <form id="vehicleForm" class="form">
            <h2>Vehicle Details</h2>
            <div>
                <label for="vehicleNumber">Vehicle Number:</label>
                <input type="text" id="vehicleNumber" name="vehicleNumber" required />
            </div>
            <div>
                <label for="availableSeats">Available Seats:</label>
                <input type="number" id="availableSeats" name="availableSeats" required />
            </div>
            <div>
                <label for="type">Vehicle Type:</label>
                <select id="type" name="type" required>
                    <option value="Car">Car</option>
                    <option value="Truck">Truck</option>
                    <option value="Bus">Bus</option>
                    <option value="Bike">Bike</option>
                </select>
            </div>
            <div>
                <label for="owner">Owner:</label>
                <input type="text" id="owner" name="owner" required />
            </div>
            <div>
                <label for="colour">Colour:</label>
                <input type="text" id="colour" name="colour" required />
            </div>
            <div>
                <label for="fuelType">Fuel Type:</label>
                <select id="fuelType" name="fuelType" required>
                    <option value="Petrol">Petrol</option>
                    <option value="Diesel">Diesel</option>
                    <option value="Electric">Electric</option>
                </select>
            </div>
            <div>
                <label for="chassisNumber">Chassis Number:</label>
                <input type="text" id="chassisNumber" name="chassisNumber" required />
            </div>
            <div>
                <label for="brandName">Brand Name:</label>
                <input type="text" id="brandName" name="brandName" required />
            </div>

            <div>
                <button type="submit">Register Vehicle</button>
            </div>
        </form>

        <!-- Driver Registration Form -->
        <form id="driverForm" class="form">
            <h2>Driver Details</h2>
            <div>
                <label for="nic">NIC:</label>
                <input type="text" id="nic" name="nic" required />
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
                <label for="gender">Gender:</label>
                <select id="gender" name="gender" required>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                </select>
            </div>
            <div>
                <label for="isAvailable">Is Available:</label>
                <select id="isAvailable" name="isAvailable" required>
                    <option value="true">Yes</option>
                    <option value="false">No</option>
                </select>
            </div>

            <div>
                <button type="submit">Register Driver</button>
            </div>
        </form>
    </div>

    <script>
        // Handle form submissions
        document.getElementById("vehicleForm").addEventListener("submit", function (event) {
            event.preventDefault(); // Prevent page refresh on form submission
            const vehicleData = {
                vehicleNumber: document.getElementById("vehicleNumber").value,
                availableSeats: document.getElementById("availableSeats").value,
                type: document.getElementById("type").value,
                owner: document.getElementById("owner").value,
                colour: document.getElementById("colour").value,
                fuelType: document.getElementById("fuelType").value,
                chassisNumber: document.getElementById("chassisNumber").value,
                brandName: document.getElementById("brandName").value
            };

            if (validateForm(vehicleData)) {
                showMessage("Vehicle Registered Successfully!", "success");
            } else {
                showMessage("Please fill out all vehicle details.", "error");
            }
        });

        document.getElementById("driverForm").addEventListener("submit", function (event) {
            event.preventDefault(); // Prevent page refresh on form submission
            const driverData = {
                nic: document.getElementById("nic").value,
                driverName: document.getElementById("driverName").value,
                phoneNo: document.getElementById("phoneNo").value,
                addressNo: document.getElementById("addressNo").value,
                addressLine1: document.getElementById("addressLine1").value,
                addressLine2: document.getElementById("addressLine2").value,
                gender: document.getElementById("gender").value,
                isAvailable: document.getElementById("isAvailable").value
            };

            if (validateForm(driverData)) {
                showMessage("Driver Registered Successfully!", "success");
            } else {
                showMessage("Please fill out all driver details.", "error");
            }
        });

        // Form validation function
        function validateForm(data) {
            for (const key in data) {
                if (data[key] === "") {
                    return false;
                }
            }
            return true;
        }

        // Show message function
        function showMessage(message, type) {
            const messageElement = document.getElementById("message");
            messageElement.textContent = message;
            messageElement.className = "message show " + type;
            setTimeout(function () {
                messageElement.className = "message"; // Hide message after 3 seconds
            }, 3000);
        }
    </script>
</body>
</html>
