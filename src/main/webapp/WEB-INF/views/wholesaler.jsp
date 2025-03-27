<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wholesaler Manager</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #e0eafc, #cfdef3);
            margin: 0;
            padding: 30px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .header {
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            color: white;
            text-align: center;
            padding: 15px;
            width: 100%;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            animation: fadeIn 1s ease-in-out;
        }

        .header h1 {
            font-size: 2rem;
            margin: 0;
        }

        .container {
            display: flex;
            flex-direction: column; /* Stack form and table vertically */
            align-items: center;
            gap: 30px;
            width: 100%;
            max-width: 800px; /* Reduced max-width for better readability */
        }

        .form-container, .table-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            width: 100%; /* Full width within the container */
        }

        .form-container {
            animation: slideInLeft 0.8s ease-out;
        }

        .table-container {
            animation: slideInRight 0.8s ease-out;
        }

        .form-container:hover, .table-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
        }

        .form-container h3 {
            color: #2a5298;
            margin-bottom: 25px;
            font-size: 1.5rem;
            text-align: center;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #333;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-group input:focus, .form-group select:focus {
            border-color: #2a5298;
            box-shadow: 0 0 8px rgba(42, 82, 152, 0.2);
            outline: none;
        }

        .button-group {
            display: flex;
            justify-content: space-between;
            gap: 15px;
        }

        .button-group input[type="submit"], .button-group input[type="button"] {
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 500;
            transition: background-color 0.3s ease, transform 0.2s ease;
            width: 32%;
        }

        .button-group input[type="submit"]:hover, .button-group input[type="button"]:hover {
            transform: scale(1.05);
        }

        .button-group input[value="Add"] {
            background-color: #28a745;
            color: white;
        }

        .button-group input[value="Add"]:hover {
            background-color: #218838;
        }

        .button-group input[value="Save"] {
            background-color: #007bff;
            color: white;
        }

        .button-group input[value="Save"]:hover {
            background-color: #0056b3;
        }

        .button-group input[value="Clear"] {
            background-color: #6c757d;
            color: white;
        }

        .button-group input[value="Clear"]:hover {
            background-color: #5a6268;
        }

        .message {
            color: #28a745;
            margin-bottom: 20px;
            font-weight: 500;
            text-align: center;
        }

        .error {
            color: #dc3545;
            margin-bottom: 20px;
            font-weight: 500;
            text-align: center;
        }

        .search-bar {
            display: flex;
            justify-content: space-between;
            gap: 15px;
            margin-bottom: 25px;
        }

        .search-bar input[type="text"] {
            width: 70%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .search-bar input[type="text"]:focus {
            border-color: #2a5298;
            box-shadow: 0 0 8px rgba(42, 82, 152, 0.2);
            outline: none;
        }

        .search-bar input[type="submit"] {
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            background-color: #2a5298;
            color: white;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .search-bar input[type="submit"]:hover {
            background-color: #1e3c72;
            transform: scale(1.05);
        }

        .table-container table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .table-container th, .table-container td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
            font-size: 0.9rem;
        }

        .table-container th {
            background: linear-gradient(90deg, #2a5298, #1e3c72);
            color: white;
            position: sticky;
            top: 0;
            z-index: 1;
        }

        .table-container tbody tr {
            transition: background-color 0.3s ease;
        }

        .table-container tbody tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        .table-container tbody tr:hover {
            background-color: #e9ecef;
            cursor: pointer;
        }

        .table-container tbody tr.selected {
            background-color: #d1e7ff;
        }

        .action-buttons form {
            display: inline;
        }

        .action-buttons input[type="submit"] {
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: background-color 0.3s ease, transform 0.2s ease;
            margin-right: 8px;
        }

        .action-buttons input[value="Update"] {
            background-color: #007bff;
            color: white;
        }

        .action-buttons input[value="Update"]:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }

        .action-buttons input[value="Delete"] {
            background-color: #dc3545;
            color: white;
        }

        .action-buttons input[value="Delete"]:hover {
            background-color: #c82333;
            transform: scale(1.05);
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideInLeft {
            from { transform: translateY(-50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        @keyframes slideInRight {
            from { transform: translateY(50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                gap: 20px;
            }

            .form-container, .table-container {
                width: 100%;
                max-width: 100%;
            }

            .search-bar input[type="text"] {
                width: 60%;
            }

            .button-group input[type="submit"], .button-group input[type="button"] {
                width: 48%;
                margin-bottom: 10px;
            }

            .button-group {
                flex-wrap: wrap;
            }

            .action-buttons input[type="submit"] {
                padding: 6px 12px;
                font-size: 0.85rem;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Wholesaler Manager</h1>
    </div>
    <div class="container">
        <!-- Form Section -->
        <div class="form-container">
            <h3>Enter Details</h3>
            <c:if test="${not empty message}">
                <div class="message">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>

            <form:form action="/wholesaler" method="post" modelAttribute="wholesaler" id="wholesalerForm">
                <form:hidden path="id" />
                <div class="form-group">
                    <label for="wholesalerName">Wholesaler Name:</label>
                    <form:input path="wholesalerName" id="wholesalerName" required="true" placeholder="Enter name" />
                </div>
                <div class="form-group">
                    <label for="wholesalerContact">Wholesaler Contact:</label>
                    <form:input path="wholesalerContact" id="wholesalerContact" required="true" placeholder="Enter contact number" />
                </div>
                <div class="form-group">
                    <label for="address">Address:</label>
                    <form:input path="address" id="address" required="true" placeholder="Enter address" />
                </div>
                <div class="form-group">
                    <label for="dealsWith">Deals with:</label>
                    <form:input path="dealsWith" id="dealsWith" placeholder="Enter deals" />
                </div>
                <div class="form-group">
                    <label for="idType">ID Type:</label>
                    <form:input path="idType" id="idType" placeholder="Enter ID type" />
                </div>
                <div class="form-group">
                    <label for="idProof">ID Proof:</label>
                    <form:select path="idProof" id="idProof">
                        <form:option value="Driving License">Driving License</form:option>
                        <form:option value="Passport">Passport</form:option>
                        <form:option value="Aadhar Card">Aadhar Card</form:option>
                        <form:option value="Voter ID">Voter ID</form:option>
                    </form:select>
                </div>
                <div class="button-group">
                    <input type="submit" name="action" value="Add">
                    <input type="submit" name="action" value="Save">
                    <input type="button" value="Clear" onclick="clearForm();">
                </div>
            </form:form>
        </div>

        <!-- Table Section -->
        <div class="table-container">
            <div class="search-bar">
                <form:form action="/wholesaler" method="post" modelAttribute="wholesaler">
                    <form:input path="wholesalerName" placeholder="Search by Wholesaler Name" />
                    <input type="submit" name="action" value="Search">
                </form:form>
                <form action="/wholesaler" method="post">
                    <input type="submit" name="action" value="Show All">
                </form>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>Sno</th>
                        <th>Wholesaler Name</th>
                        <th>Wholesaler Contact</th>
                        <th>Address</th>
                        <th>Deals in</th>
                        <th>ID Type</th>
                        <th>ID Proof</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="wholesaler" items="${wholesalers}" varStatus="loop">
                        <tr data-id="${wholesaler.id}">
                            <td>${loop.count}</td>
                            <td>${wholesaler.wholesalerName}</td>
                            <td>${wholesaler.wholesalerContact}</td>
                            <td>${wholesaler.address}</td>
                            <td>${wholesaler.dealsWith}</td>
                            <td>${wholesaler.idType}</td>
                            <td>${wholesaler.idProof}</td>
                            <td class="action-buttons">
                                <form action="/wholesaler/edit" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="${wholesaler.id}" />
                                    <input type="submit" value="Update" onclick="highlightRow(${wholesaler.id});" />
                                </form>
                                <form action="/wholesaler" method="post" style="display:inline;" onsubmit="return confirmDelete();">
                                    <input type="hidden" name="id" value="${wholesaler.id}" />
                                    <input type="hidden" name="action" value="Delete" />
                                    <input type="submit" value="Delete" />
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        // Form validation for contact number
        document.getElementById('wholesalerForm').addEventListener('submit', function(event) {
            let contact = document.getElementById('wholesalerContact').value;
            if (!/^\d{10}$/.test(contact)) {
                alert('Please enter a valid 10-digit contact number.');
                event.preventDefault();
            }
        });

        // Highlight the selected row when editing
        function highlightRow(id) {
            document.querySelectorAll('tbody tr').forEach(row => {
                row.classList.remove('selected');
            });
            document.querySelector(`tr[data-id="${id}"]`).classList.add('selected');
        }

        // Confirm deletion
        function confirmDelete() {
            return confirm('Are you sure you want to delete this wholesaler?');
        }

        // Clear the form and remove row highlighting
        function clearForm() {
            document.getElementById('wholesalerForm').reset();
            document.querySelectorAll('tbody tr').forEach(row => {
                row.classList.remove('selected');
            });
        }

        // Highlight the row if the form is populated with a wholesaler's data
        window.onload = function() {
            const id = document.querySelector('input[name="id"]').value;
            if (id) {
                highlightRow(id);
            }
        };
    </script>
</body>
</html>