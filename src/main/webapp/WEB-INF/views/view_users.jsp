<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Users</title>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Reset and Base Styling */
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            background: linear-gradient(135deg, #e0f7fa, #b2ebf2);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 30px;
            overflow-x: hidden;
        }

        /* Header Styling */
        h2 {
            font-size: 28px;
            font-weight: 700;
            color: #0277bd;
            text-align: center;
            margin-bottom: 30px;
            position: relative;
            animation: slideInDown 0.8s ease-out;
        }

        h2::after {
            content: '';
            width: 60px;
            height: 3px;
            background: #0277bd;
            display: block;
            margin: 10px auto;
            border-radius: 2px;
        }

        /* Container Styling */
        .container {
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* Table Container */
        .table-container {
            max-width: 1200px; /* Match the wider table width from wholesaler.jsp */
            width: 100%;
            overflow-x: auto; /* Allow horizontal scrolling on smaller screens */
        }

        /* Search Bar Styling */
        .search-bar {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 25px;
        }

        .search-bar input[type="text"] {
            width: 50%;
            padding: 10px;
            border: 1px solid #b3e5fc;
            border-radius: 8px;
            font-size: 15px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .search-bar input[type="text"]:focus {
            border-color: #0277bd;
            box-shadow: 0 0 8px rgba(2, 119, 189, 0.3);
            outline: none;
        }

        .search-bar button {
            padding: 10px 20px;
            font-size: 15px;
            font-weight: 500;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            transition: transform 0.3s, box-shadow 0.3s;
            background-color: #0288d1;
            color: white;
        }

        .search-bar button:hover {
            background-color: #01579b;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(1, 87, 155, 0.4);
        }

        /* Table Styling */
        table {
            width: 100%;
            border-collapse: collapse;
            background: #ffffff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            animation: fadeInUp 1s ease-in-out;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #e0f7fa;
        }

        th {
            background-color: #0277bd;
            color: white;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background-color: #f5fafa;
        }

        tr:hover {
            background-color: #e0f7fa;
            transition: background-color 0.3s;
        }

        /* Action Button Styling */
        .action-button {
            background-color: #dc3545;
            color: white;
            padding: 6px 12px;
            font-size: 15px;
            font-weight: 500;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .action-button:hover {
            background-color: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(200, 35, 51, 0.4);
        }

        /* Message Styling */
        .message {
            color: #28a745;
            margin-bottom: 20px;
            font-weight: 500;
            text-align: center;
            background-color: #e7f3e7;
            padding: 10px;
            border-radius: 8px;
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

        .pill, .syringe {
            position: absolute;
            opacity: 0.1;
            animation: float 10s infinite ease-in-out;
        }

        .pill {
            width: 20px;
            height: 10px;
            background-color: #0288d1;
            border-radius: 10px;
            top: 15%;
            left: 20%;
        }

        .syringe {
            width: 25px;
            height: 5px;
            background: linear-gradient(90deg, #0288d1, transparent);
            border-radius: 5px;
            top: 70%;
            left: 75%;
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

            h2 {
                font-size: 24px;
            }

            th, td {
                font-size: 14px;
                padding: 10px;
            }

            .table-container {
                max-width: 100%;
                overflow-x: auto;
            }

            .search-bar {
                flex-direction: column;
                gap: 10px;
            }

            .search-bar input[type="text"] {
                width: 100%;
            }

            .action-button {
                font-size: 14px;
                padding: 8px 15px;
            }
        }
    </style>
</head>
<body>
    <!-- Background Animation -->
    <div class="background-animation">
        <span class="pill"></span>
        <span class="syringe"></span>
    </div>

    <!-- View Users -->
    <h2><i class="fas fa-users me-2"></i> View Users</h2>
    <div class="container">
        <!-- Message -->
        <c:if test="${not empty message}">
            <div class="message">${message}</div>
        </c:if>

        <!-- Search Bar -->
        <div class="search-bar">
            <form action="/viewUsers" method="get">
                <input type="text" name="username" placeholder="Search by Username" />
                <button type="submit"><i class="fas fa-search me-2"></i>Search</button>
                <button type="button" onclick="window.location.href='/viewUsers'"><i class="fas fa-list me-2"></i>Show All</button>
            </form>
        </div>

        <!-- Table Section -->
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Sno</th>
                        <th>Username</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}" varStatus="loop">
                        <tr>
                            <td>${loop.count}</td>
                            <td>${user.username}</td>
                            <td>
                                <form action="/deleteUser" method="post" style="display:inline;" onsubmit="return confirmDelete();">
                                    <input type="hidden" name="id" value="${user.id}" />
                                    <button type="submit" class="action-button">
                                        <i class="fas fa-trash-alt me-1"></i> Delete
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- JavaScript Logic -->
    <script>
        // Confirm deletion
        function confirmDelete() {
            return confirm('Are you sure you want to delete this user?');
        }
    </script>
</body>
</html>