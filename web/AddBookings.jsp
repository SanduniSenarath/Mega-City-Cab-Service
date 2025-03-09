<%-- 
    Document   : AddBookings
    Created on : 8 Mar 2025, 22:32:09
    Author     : Sanduni
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Schedule Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            width: 80%;
            max-width: 1200px;
            margin: 20px;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            font-size: 2rem;
            color: #2c3e50;
        }

        .form-section, .schedule-list {
            margin-bottom: 30px;
        }

        h2 {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        form input {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        form button {
            width: 100%;
            padding: 10px;
            background-color: #2ecc71;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1rem;
        }

        form button:hover {
            background-color: #27ae60;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        table th {
            background-color: #3498db;
            color: white;
        }

        table td button {
            padding: 5px 10px;
            background-color: #f39c12;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        table td button:hover {
            background-color: #e67e22;
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            fetchSchedules();

            document.getElementById('scheduleForm').addEventListener('submit', function (e) {
                e.preventDefault();

                const schedule = {
                    bookNumber: document.getElementById('bookNumber').value,
                    startLocation: document.getElementById('startLocation').value,
                    endLocation: document.getElementById('endLocation').value,
                    distance: parseFloat(document.getElementById('distance').value),
                    amount: parseFloat(document.getElementById('amount').value),
                    empSchNo: document.getElementById('empSchNo').value,
                    username: document.getElementById('username').value,
                    date: document.getElementById('date').value,
                    time: document.getElementById('time').value
                };

                if (Object.values(schedule).some(value => !value)) {
                    alert("Please fill in all fields.");
                    return;
                }

                fetch('http://localhost:8080/Mega_City_Cab_Service/api/schedules/add', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(schedule),
                })
                .then(response => response.json())
                .then(data => {
                    alert(data.message);
                    if (data.success) fetchSchedules();
                })
                .catch(error => alert('Error adding schedule: ' + error));
            });
        });

        function fetchSchedules() {
            fetch('http://localhost:8080/Mega_City_Cab_Service/api/schedules/getAll')
                .then(response => response.json())
                .then(schedules => {
                    const tableBody = document.querySelector('#scheduleTable tbody');
                    tableBody.innerHTML = '';
                    schedules.forEach(schedule => {
                        const row = document.createElement('tr');
                        row.innerHTML = `
                            <td>${schedule.bookNumber}</td>
                            <td>${schedule.startLocation}</td>
                            <td>${schedule.endLocation}</td>
                            <td>${schedule.distance}</td>
                            <td>${schedule.amount}</td>
                            <td>${schedule.empSchNo}</td>
                            <td>${schedule.username}</td>
                            <td>${schedule.date}</td>
                            <td>${schedule.time}</td>
                            <td>
                                <button onclick="updateSchedule(${schedule.id})">Update</button>
                                <button onclick="deleteSchedule(${schedule.id})">Delete</button>
                            </td>
                        `;
                        tableBody.appendChild(row);
                    });
                })
                .catch(error => alert('Error fetching schedules.'));
        }

        function deleteSchedule(id) {
            fetch(`http://localhost:8080/Mega_City_Cab_Service/api/schedules/delete/${id}`, {
                method: 'DELETE'
            })
            .then(response => response.json())
            .then(data => {
                alert(data.message);
                if (data.success) fetchSchedules();
            })
            .catch(error => alert('Error deleting schedule: ' + error));
        }

        function updateSchedule(id) {
            alert(`Update functionality for schedule ID ${id}`);
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Schedule Management</h1>
        <section class="form-section">
            <h2>Add Schedule</h2>
            <form id="scheduleForm">
                <input type="text" id="bookNumber" placeholder="Book Number" required>
                <input type="text" id="startLocation" placeholder="Start Location" required>
                <input type="text" id="endLocation" placeholder="End Location" required>
                <input type="number" id="distance" placeholder="Distance" required>
                <input type="number" id="amount" placeholder="Amount" required>
                <input type="text" id="empSchNo" placeholder="Employee Schedule Number" required>
                <input type="text" id="username" placeholder="Username" required>
                <input type="date" id="date" required>
                <input type="time" id="time" required>
                <button type="submit">Add Schedule</button>
            </form>
        </section>
        <section class="schedule-list">
            <h2>All Schedules</h2>
            <table id="scheduleTable">
                <thead>
                    <tr>
                        <th>Book Number</th>
                        <th>Start Location</th>
                        <th>End Location</th>
                        <th>Distance</th>
                        <th>Amount</th>
                        <th>Employee Schedule Number</th>
                        <th>Username</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </section>
    </div>
</body>
</html>
