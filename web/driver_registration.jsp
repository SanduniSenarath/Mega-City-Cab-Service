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

    <!-- Driver Registration Form -->
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
        // Real-time validation functions
        document.getElementById("nic").addEventListener("input", function() {
            validateNIC(this.value);
        });
        document.getElementById("driverName").addEventListener("input", function() {
            validateDriverName(this.value);
        });
        document.getElementById("phoneNo").addEventListener("input", function() {
            validatePhoneNumber(this.value);
        });
        document.getElementById("addressNo").addEventListener("input", function() {
            validateAddressNo(this.value);
        });
        document.getElementById("addressLine1").addEventListener("input", function() {
            validateAddressLine1(this.value);
        });
        document.getElementById("addressLine2").addEventListener("input", function() {
            validateAddressLine2(this.value);
        });

        // NIC Validation
        function validateNIC(nic) {
            const nicError = document.getElementById("nicError");
            const nicInput = document.getElementById("nic");
            const regex = /^[0-9]{9}[VvXx]$/;
            if (!regex.test(nic)) {
                nicInput.classList.remove("valid");
                nicInput.classList.add("invalid");
                nicError.textContent = "Invalid NIC format.";
                return false;
            } else {
                nicInput.classList.remove("invalid");
                nicInput.classList.add("valid");
                nicError.textContent = "";
                return true;
            }
        }

        // Driver Name Validation
        function validateDriverName(driverName) {
            const driverNameError = document.getElementById("driverNameError");
            const driverNameInput = document.getElementById("driverName");
            if (driverName.length < 3) {
                driverNameInput.classList.remove("valid");
                driverNameInput.classList.add("invalid");
                driverNameError.textContent = "Name must be at least 3 characters.";
                return false;
            } else {
                driverNameInput.classList.remove("invalid");
                driverNameInput.classList.add("valid");
                driverNameError.textContent = "";
                return true;
            }
        }

        // Phone Number Validation
        function validatePhoneNumber(phoneNo) {
            const phoneNoError = document.getElementById("phoneNoError");
            const phoneNoInput = document.getElementById("phoneNo");
            const regex = /^[0-9]{10}$/;
            if (!regex.test(phoneNo)) {
                phoneNoInput.classList.remove("valid");
                phoneNoInput.classList.add("invalid");
                phoneNoError.textContent = "Phone number must be 10 digits.";
                return false;
            } else {
                phoneNoInput.classList.remove("invalid");
                phoneNoInput.classList.add("valid");
                phoneNoError.textContent = "";
                return true;
            }
        }

        // Address No Validation
        function validateAddressNo(addressNo) {
            const addressNoError = document.getElementById("addressNoError");
            const addressNoInput = document.getElementById("addressNo");
            if (addressNo.trim() === "") {
                addressNoInput.classList.remove("valid");
                addressNoInput.classList.add("invalid");
                addressNoError.textContent = "Address number is required.";
                return false;
            } else {
                addressNoInput.classList.remove("invalid");
                addressNoInput.classList.add("valid");
                addressNoError.textContent = "";
                return true;
            }
        }

        // Address Line 1 Validation
        function validateAddressLine1(addressLine1) {
            const addressLine1Error = document.getElementById("addressLine1Error");
            const addressLine1Input = document.getElementById("addressLine1");
            if (addressLine1.trim() === "") {
                addressLine1Input.classList.remove("valid");
                addressLine1Input.classList.add("invalid");
                addressLine1Error.textContent = "Address Line 1 is required.";
                return false;
            } else {
                addressLine1Input.classList.remove("invalid");
                addressLine1Input.classList.add("valid");
                addressLine1Error.textContent = "";
                return true;
            }
        }

        // Address Line 2 Validation
        function validateAddressLine2(addressLine2) {
            const addressLine2Error = document.getElementById("addressLine2Error");
            const addressLine2Input = document.getElementById("addressLine2");
            if (addressLine2.trim() === "") {
                addressLine2Input.classList.remove("valid");
                addressLine2Input.classList.add("invalid");
                addressLine2Error.textContent = "Address Line 2 is required.";
                return false;
            } else {
                addressLine2Input.classList.remove("invalid");
                addressLine2Input.classList.add("valid");
                addressLine2Error.textContent = "";
                return true;
            }
        }

        // Form submission handler
        document.getElementById("driverForm").addEventListener("submit", function(e) {
            e.preventDefault();
            if (
                validateNIC(document.getElementById("nic").value) &&
                validateDriverName(document.getElementById("driverName").value) &&
                validatePhoneNumber(document.getElementById("phoneNo").value) &&
                validateAddressNo(document.getElementById("addressNo").value) &&
                validateAddressLine1(document.getElementById("addressLine1").value) &&
                validateAddressLine2(document.getElementById("addressLine2").value)
            ) {
                // Display success message
                document.getElementById("message").className = "message success show";
                document.getElementById("message").textContent = "Driver registered successfully!";

                // Clear form fields after 3 seconds
                setTimeout(() => {
                    document.getElementById("driverForm").reset();
                    clearValidationClasses();
                    document.getElementById("message").className = "message"; // Hide the message
                }, 3000); // 3 seconds delay to keep the message visible
            } else {
                document.getElementById("message").className = "message error show";
                document.getElementById("message").textContent = "Please correct the errors in the form.";
            }
        });

        // Clear button functionality
        document.getElementById("clearButton").addEventListener("click", function() {
            document.getElementById("driverForm").reset();
            clearValidationClasses();
            document.getElementById("message").className = "message"; // Hide the message
        });

        // Clear all validation classes
        function clearValidationClasses() {
            const inputs = document.querySelectorAll(".form input, .form select");
            inputs.forEach(input => {
                input.classList.remove("valid", "invalid");
                input.nextElementSibling.textContent = "";
            });
        }
    </script>
</body>
</html>
