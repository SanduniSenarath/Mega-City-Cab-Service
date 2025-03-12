<%-- 
    Document   : help
    Created on : 12 Mar 2025, 22:52:10
    Author     : Sanduni
--%>

<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Help & Support</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            padding: 20px;
            background: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .faq {
            margin-bottom: 20px;
        }
        .faq h2 {
            background: #007bff;
            color: white;
            padding: 12px;
            margin: 0;
            cursor: pointer;
            border-radius: 5px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .faq h2 i {
            transition: transform 0.3s ease;
        }
        .faq-content {
            display: none;
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background: #f9f9f9;
            margin-top: 5px;
        }
        .contact-section {
            text-align: center;
            margin-top: 40px;
            padding: 20px;
            background: #007bff;
            color: white;
            border-radius: 8px;
        }
        .contact-section a {
            color: #fff;
            text-decoration: underline;
        }
    </style>

    <script>
        function toggleFAQ(id) {
            let content = document.getElementById(id);
            let icon = document.querySelector("#" + id + "Toggle i");

            if (content.style.display === "block") {
                content.style.display = "none";
                icon.style.transform = "rotate(0deg)";
            } else {
                content.style.display = "block";
                icon.style.transform = "rotate(180deg)";
            }
        }
    </script>
</head>
<body>

    <div class="container">
        <h1>Help & Support</h1>

        <div class="faq">
            <h2 id="faq1Toggle" onclick="toggleFAQ('faq1')">
                How to search for a customer? <i class="fas fa-chevron-down"></i>
            </h2>
            <div class="faq-content" id="faq1">
                To search for a customer, use the search bar at the top of the customer list page. Enter a username, and the list will update dynamically.
            </div>
        </div>

        <div class="faq">
            <h2 id="faq2Toggle" onclick="toggleFAQ('faq2')">
                How to remove a customer? <i class="fas fa-chevron-down"></i>
            </h2>
            <div class="faq-content" id="faq2">
                Click the "Remove" button next to a customer. A confirmation prompt will appear. Click "OK" to proceed.
            </div>
        </div>

        <div class="faq">
            <h2 id="faq3Toggle" onclick="toggleFAQ('faq3')">
                I forgot my password. What should I do? <i class="fas fa-chevron-down"></i>
            </h2>
            <div class="faq-content" id="faq3">
                Please contact support or click on "Forgot Password" at the login page to reset your password.
            </div>
        </div>

        <div class="faq">
            <h2 id="faq4Toggle" onclick="toggleFAQ('faq4')">
                How can I contact support? <i class="fas fa-chevron-down"></i>
            </h2>
            <div class="faq-content" id="faq4">
                You can reach out to us via email at <b>support@megacitycab.com</b> or call our helpline at <b>+123 456 7890</b>.
            </div>
        </div>

        <div class="contact-section">
            <h2>Need More Help?</h2>
            <p>Contact our support team at <a href="mailto:support@megacitycab.com">support@megacitycab.com</a> or call +123 456 7890.</p>
        </div>
    </div>

</body>
</html>
