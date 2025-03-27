<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
    <!-- Prevent Browser Caching -->
    <meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate, max-age=0">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <!-- Bootstrap 5 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* General Body Styling */
        body {
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Dashboard Container */
        .dashboard-container {
            width: 60%;
            margin: 50px auto;
            padding: 30px;
            border-radius: 15px;
            background: #ffffff;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            animation: fadeIn 1s ease-in-out;
        }

        /* Dashboard Header */
        .dashboard-header {
            text-align: center;
            font-size: 28px;
            font-weight: 700;
            color: #1a73e8;
            margin-bottom: 30px;
            position: relative;
        }

        .dashboard-header::after {
            content: '';
            width: 50px;
            height: 3px;
            background: #1a73e8;
            display: block;
            margin: 10px auto;
            border-radius: 2px;
        }

        /* Button Styling */
        .dashboard-button {
            width: 100%;
            margin: 10px 0;
            padding: 12px;
            font-size: 16px;
            font-weight: 500;
            border-radius: 8px;
            transition: transform 0.3s, box-shadow 0.3s;
            position: relative;
            overflow: hidden;
        }

        .dashboard-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        /* Button Ripple Effect */
        .dashboard-button::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            animation: ripple 1.5s infinite;
            opacity: 0;
        }

        .dashboard-button:hover::before {
            opacity: 1;
        }

        /* Specific Button Colors */
        .btn-primary { background-color: #1a73e8; border-color: #1a73e8; }
        .btn-primary:hover { background-color: #1557b0; border-color: #1557b0; }
        .btn-danger { background-color: #dc3545; border-color: #dc3545; }
        .btn-danger:hover { background-color: #c82333; border-color: #c82333; }

        /* Pharmacy-Themed Background Animation */
        .background-animation {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: -1;
            overflow: hidden;
        }

        .pill, .cross {
            position: absolute;
            opacity: 0.1;
            animation: float 8s infinite ease-in-out;
        }

        .pill {
            width: 20px;
            height: 10px;
            background-color: #1a73e8;
            border-radius: 10px;
            top: 20%;
            left: 15%;
        }

        .cross {
            width: 15px;
            height: 15px;
            background: transparent;
            border: 2px solid #28a745;
            transform: rotate(45deg);
            top: 60%;
            left: 80%;
        }

        /* Animations */
        @keyframes fadeIn {
            0% { opacity: 0; transform: translateY(20px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        @keyframes ripple {
            0% { width: 0; height: 0; opacity: 1; }
            100% { width: 200%; height: 200%; opacity: 0; }
        }

        @keyframes float {
            0% { transform: translateY(0); }
            50% { transform: translateY(-50px); }
            100% { transform: translateY(0); }
        }

        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .dashboard-container {
                width: 90%;
            }
            .dashboard-header {
                font-size: 24px;
            }
            .dashboard-button {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <!-- Dashboard Container -->
    <div class="container dashboard-container">
        <!-- Background Animation -->
        <div class="background-animation">
            <span class="pill"></span>
            <span class="cross"></span>
        </div>

        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <i class="fas fa-user me-2"></i> User Dashboard
        </div>

        <!-- Buttons Layout -->
        <div class="row gy-3">
            <div class="col-md-6 mx-auto"> <!-- Centered column -->
                <a href="/billing/form" class="btn btn-primary dashboard-button">
                    <i class="fas fa-file-invoice-dollar me-2"></i> Billing
                </a>
                <a href="/stock" class="btn btn-primary dashboard-button">
                    <i class="fas fa-warehouse me-2"></i> Stock
                </a>
                <a href="/billing/sale_history" class="btn btn-primary dashboard-button">
                    <i class="fas fa-history me-2"></i> Sale History
                </a>
                <a href="/logout" class="btn btn-danger dashboard-button">
                    <i class="fas fa-sign-out-alt me-2"></i> Logout
                </a>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS (Optional for interactivity) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>