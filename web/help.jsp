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
            /* General Styles */
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f4f4f9;
                margin: 0;
                padding: 0;
                line-height: 1.6;
            }

            .container {
                width: 90%;
                max-width: 1200px;
                margin: 20px auto;
                padding: 20px;
                background: #fff;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
            }

            h1 {
                text-align: center;
                color: #16325B;
                margin-bottom: 30px;
                font-size: 2.5rem;
            }

            h2 {
                color: #227B94;
                margin-top: 40px;
                font-size: 2rem;
                border-bottom: 2px solid #227B94;
                padding-bottom: 10px;
            }

            h3 {
                color: #16325B;
                font-size: 1.5rem;
                margin-bottom: 15px;
            }

            /* FAQ Section */
            .faq {
                margin-bottom: 20px;
            }

            .faq h3 {
                background: #16325B;
                color: white;
                padding: 15px;
                margin: 0;
                cursor: pointer;
                border-radius: 5px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                transition: background 0.3s ease;
            }

            .faq h3:hover {
                background: #227B94;
            }

            .faq h3 i {
                transition: transform 0.3s ease;
            }

            .faq-content {
                display: none;
                padding: 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
                background: #f9f9f9;
                margin-top: 5px;
                font-size: 1rem;
                color: #555;
            }

            /* Features Section */
            .features-section {
                margin-top: 40px;
            }

            .features-section ul {
                list-style-type: none;
                padding: 0;
            }

            .features-section ul li {
                background: #f9f9f9;
                margin: 10px 0;
                padding: 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 1rem;
                color: #555;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .features-section ul li:hover {
                transform: translateY(-5px);
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            /* Contact Section */
            .contact-section {
                text-align: center;
                margin-top: 40px;
                padding: 30px;
                background: #16325B;
                color: white;
                border-radius: 10px;
            }

            .contact-section h2 {
                color: white;
                border-bottom: none;
                margin-bottom: 20px;
            }

            .contact-section a {
                color: #FF9D23;
                text-decoration: none;
                font-weight: bold;
            }

            .contact-section a:hover {
                text-decoration: underline;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                h1 {
                    font-size: 2rem;
                }

                h2 {
                    font-size: 1.75rem;
                }

                h3 {
                    font-size: 1.25rem;
                }

                .container {
                    width: 95%;
                    padding: 15px;
                }
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

            <!-- FAQ Section -->
            <h2>Frequently Asked Questions</h2>
            <div class="faq">
                <h3 id="faq1Toggle" onclick="toggleFAQ('faq1')">
                    How do I search for a customer? <i class="fas fa-chevron-down"></i>
                </h3>
                <div class="faq-content" id="faq1">
                    To search for a customer, go to the <b>Customer Management</b> section in the admin dashboard. Use the search bar at the top of the page to enter the customer's name, email, or phone number. The list will update dynamically to show matching results.
                </div>
            </div>

            <div class="faq">
                <h3 id="faq2Toggle" onclick="toggleFAQ('faq2')">
                    How do I remove a customer? <i class="fas fa-chevron-down"></i>
                </h3>
                <div class="faq-content" id="faq2">
                    To remove a customer, navigate to the <b>Customer Management</b> section. Click the <b>"Remove"</b> button next to the customer you want to delete. A confirmation prompt will appear. Click <b>"OK"</b> to proceed with the removal.
                </div>
            </div>

            <div class="faq">
                <h3 id="faq3Toggle" onclick="toggleFAQ('faq3')">
                    What should I do if I forget my password? <i class="fas fa-chevron-down"></i>
                </h3>
                <div class="faq-content" id="faq3">
                    If you forget your password, click on the <b>"Forgot Password"</b> link on the login page. Enter your registered email address, and you will receive a password reset link. Alternatively, contact our support team for assistance.
                </div>
            </div>

            <div class="faq">
                <h3 id="faq4Toggle" onclick="toggleFAQ('faq4')">
                    How can I contact support? <i class="fas fa-chevron-down"></i>
                </h3>
                <div class="faq-content" id="faq4">
                    You can contact our support team via email at <b>support@megacitycab.com</b> or call our helpline at <b>+123 456 7890</b>. Our team is available 24/7 to assist you with any issues or queries.
                </div>
            </div>

            <!-- Features Section -->
            <div class="features-section">
                <h2>Key Features of Our Cab Booking System</h2>
                <ul>
                    <li><b>Easy Booking:</b> Book a cab in just a few clicks with our user-friendly interface.</li>
                    <li><b>Real-Time Tracking:</b> Track your ride in real-time using GPS technology.</li>
                    <li><b>Multiple Payment Options:</b> Pay via credit card, debit card, or digital wallets for a seamless experience.</li>
                    <li><b>Admin Dashboard:</b> Manage vehicles, drivers, bookings, and customers efficiently with the admin dashboard.</li>
                    <li><b>24/7 Support:</b> Get assistance anytime with our round-the-clock customer support.</li>
                    <li><b>Driver Management:</b> Add, update, or remove drivers easily through the admin panel.</li>
                    <li><b>Customer Management:</b> View and manage customer details, including booking history and preferences.</li>
                    <li><b>Affordable Pricing:</b> Enjoy competitive pricing with no hidden charges.</li>
                </ul>
            </div>

            <!-- Contact Section -->
            <div class="contact-section">
                <h2>Need More Help?</h2>
                <p>Contact our support team at <a href="mailto:support@megacitycab.com">support@megacitycab.com</a> or call <b>+123 456 7890</b>.</p>
            </div>
        </div>
        
         <footer>
            <p>&copy; 2023 Cab Booking System. All rights reserved.</p>
            <ul>
                <li><strong>Phone:</strong> 0332246638</li>
                <li><strong>Address:</strong> Maradana, Colombo 10</li>
                <li><strong>Email:</strong> no.reply.megacity.cabservice@gmail.com</li>
            </ul>

        </footer>

    </body>
</html>