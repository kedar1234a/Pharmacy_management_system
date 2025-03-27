<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Bill" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sale History</title>
    <!-- Bootstrap 5 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Body Styling */
        body {
            background: linear-gradient(135deg, #e8eaf6, #c5cae9);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 30px;
            overflow-x: hidden;
        }

        /* Container Styling */
        .container {
            max-width: 1000px;
            background: #ffffff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            margin: 0 auto;
            animation: fadeInUp 1s ease-in-out;
        }

        /* Header Styling */
        h2 {
            font-size: 28px;
            font-weight: 700;
            color: #3f51b5;
            text-align: center;
            margin-bottom: 30px;
            position: relative;
            animation: slideInDown 0.8s ease-out;
        }

        h2::after {
            content: '';
            width: 60px;
            height: 3px;
            background: #3f51b5;
            display: block;
            margin: 10px auto;
            border-radius: 2px;
        }

        /* Search Bar Styling */
        .search-bar {
            max-width: 500px;
            margin: 0 auto 20px;
            display: flex;
            gap: 10px;
            animation: slideInLeft 0.6s ease-out;
        }

        .form-control {
            border-radius: 8px;
            border: 1px solid #c5cae9;
            padding: 10px;
            font-size: 15px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .form-control:focus {
            border-color: #3f51b5;
            box-shadow: 0 0 8px rgba(63, 81, 181, 0.3);
            outline: none;
        }

        .btn-primary {
            background-color: #3f51b5;
            border-color: #3f51b5;
            border-radius: 8px;
            padding: 10px 20px;
            font-size: 15px;
            transition: background-color 0.3s, transform 0.3s;
        }

        .btn-primary:hover {
            background-color: #303f9f;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(48, 63, 159, 0.4);
        }

        /* Table Styling */
        table {
            width: 100%;
            border-collapse: collapse;
            background: #ffffff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #e8eaf6;
        }

        th {
            background-color: #3f51b5;
            color: white;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background-color: #f5f7fa;
        }

        tr:hover {
            background-color: #e8eaf6;
            transition: background-color 0.3s;
        }

        /* Pharmacy-Themed Background Animation */
        .background-animation {
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: -1;
            overflow: hidden;
        }

        .pill, .capsule {
            position: absolute;
            opacity: 0.1;
            animation: float 10s infinite ease-in-out;
        }

        .pill {
            width: 20px;
            height: 10px;
            background-color: #3f51b5;
            border-radius: 10px;
            top: 20%;
            left: 15%;
        }

        .capsule {
            width: 15px;
            height: 25px;
            background: linear-gradient(90deg, #3f51b5, #5c6bc0);
            border-radius: 15px;
            top: 60%;
            left: 80%;
        }

        /* Animations */
        @keyframes fadeInUp {
            0% { opacity: 0; transform: translateY(20px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideInDown {
            0% { opacity: 0; transform: translateY(-20px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideInLeft {
            0% { opacity: 0; transform: translateX(-20px); }
            100% { opacity: 1; transform: translateX(0); }
        }

        @keyframes float {
            0% { transform: translateY(0); }
            50% { transform: translateY(-40px); }
            100% { transform: translateY(0); }
        }

        /* Responsive Adjustments */
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            .container {
                padding: 20px;
            }
            h2 {
                font-size: 24px;
            }
            .search-bar {
                flex-direction: column;
                gap: 5px;
            }
            .btn-primary {
                font-size: 14px;
                padding: 8px 15px;
            }
            th, td {
                font-size: 14px;
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <!-- Background Animation -->
    <div class="background-animation">
        <span class="pill"></span>
        <span class="capsule"></span>
    </div>

    <div class="container">
        <!-- Header -->
        <h2><i class="fas fa-history me-2"></i> Sale History</h2>

        <!-- Search Bar -->
        <div class="search-bar">
            <input type="text" id="searchInput" placeholder="Search by Patient Name..." class="form-control">
            <button onclick="searchPatient()" class="btn btn-primary">
                <i class="fas fa-search me-2"></i> Search
            </button>
        </div>

        <!-- Sale History Table -->
        <table id="saleTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Patient Name</th>
                    <th>Medicine Name</th>
                    <th>Date</th>
                    <th>Quantity</th>
                    <th>Cost Per Unit</th>
                    <th>Total Cost</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Bill> bills = (List<Bill>) request.getAttribute("bills");
                    if (bills != null) {
                        for (Bill b : bills) { 
                %>
                <tr>
                    <td><%= b.getId() %></td>
                    <td class="patient-name"><%= b.getPatientName() %></td>
                    <td><%= b.getMedicineName() %></td>
                    <td><%= b.getDate() %></td>
                    <td><%= b.getQuantity() %></td>
                    <td><%= b.getCostPerUnit() %></td>
                    <td><%= b.getTotalCost() %></td>
                </tr>
                <% 
                        } 
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- JavaScript Logic -->
    <script>
        function searchPatient() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let table = document.getElementById("saleTable");
            let rows = table.getElementsByTagName("tr");

            for (let i = 1; i < rows.length; i++) { // Start from 1 to skip header row
                let patientNameCell = rows[i].getElementsByClassName("patient-name")[0];
                if (patientNameCell) {
                    let patientName = patientNameCell.innerText.toLowerCase();
                    if (patientName.includes(input)) {
                        rows[i].style.display = "";
                    } else {
                        rows[i].style.display = "none";
                    }
                }
            }
        }
    </script>
</body>
</html>