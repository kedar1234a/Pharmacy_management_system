<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
    <title>Stock Management</title>
    <!-- Bootstrap 5 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Body Styling */
        body {
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            overflow-x: hidden;
        }

        /* Container Styling */
        .container {
            margin-top: 40px;
            padding: 20px;
            animation: fadeIn 1s ease-in-out;
        }

        /* Header Styling */
        h2.text-center {
            font-size: 28px;
            font-weight: 700;
            color: #1e88e5;
            margin-bottom: 30px;
            position: relative;
            animation: slideInDown 0.8s ease-out;
        }

        h2.text-center::after {
            content: '';
            width: 60px;
            height: 3px;
            background: #1e88e5;
            display: block;
            margin: 10px auto;
            border-radius: 2px;
        }

        /* Search Bar Styling */
        .input-group {
            max-width: 500px;
            margin: 0 auto 20px;
            animation: slideInLeft 0.6s ease-out;
        }

        .form-control {
            border-radius: 8px 0 0 8px;
            border: 1px solid #bbdefb;
            padding: 10px;
            font-size: 15px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .form-control:focus {
            border-color: #1e88e5;
            box-shadow: 0 0 8px rgba(30, 136, 229, 0.3);
            outline: none;
        }

        .input-group .btn-primary {
            border-radius: 0 8px 8px 0;
            background-color: #1e88e5;
            border-color: #1e88e5;
            transition: background-color 0.3s, transform 0.3s;
        }

        .input-group .btn-primary:hover {
            background-color: #1565c0;
            transform: translateY(-2px);
        }

        /* Table Styling */
        .table {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            background: #ffffff;
            animation: fadeInUp 1s ease-in-out;
        }

        .table-dark {
            background-color: #1e88e5;
            color: #ffffff;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f5f7fa;
        }

        .table tbody tr {
            transition: background-color 0.3s, transform 0.2s;
        }

        .table tbody tr:hover {
            background-color: #e3f2fd;
            transform: scale(1.01);
        }

        /* Low Stock Highlight */
        .low-stock {
            background-color: #ffcccc !important;
            transition: background-color 0.5s;
        }

        /* Action Buttons */
        .btn-sm {
            padding: 6px 12px;
            font-size: 14px;
            border-radius: 6px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .btn-warning {
            background-color: #ffb300;
            border-color: #ffb300;
        }

        .btn-warning:hover {
            background-color: #e0a800;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(224, 168, 0, 0.4);
        }

        .btn-danger {
            background-color: #d32f2f;
            border-color: #d32f2f;
        }

        .btn-danger:hover {
            background-color: #b71c1c;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(183, 28, 28, 0.4);
        }

        /* Add New Stock and Filter Buttons */
        .btn-success, .btn-warning, .btn-secondary {
            padding: 10px 20px;
            font-size: 15px;
            border-radius: 8px;
            margin: 5px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .btn-success {
            background-color: #43a047;
            border-color: #43a047;
        }

        .btn-success:hover {
            background-color: #2e7d32;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(46, 125, 50, 0.4);
        }

        .btn-warning:hover {
            background-color: #e0a800;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(224, 168, 0, 0.4);
        }

        .btn-secondary {
            background-color: #757575;
            border-color: #757575;
        }

        .btn-secondary:hover {
            background-color: #616161;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(97, 97, 97, 0.4);
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
            animation: float 12s infinite ease-in-out;
        }

        .pill {
            width: 20px;
            height: 10px;
            background-color: #1e88e5;
            border-radius: 10px;
            top: 20%;
            left: 15%;
        }

        .capsule {
            width: 15px;
            height: 25px;
            background: linear-gradient(90deg, #43a047, #1e88e5);
            border-radius: 15px;
            top: 60%;
            left: 80%;
        }

        /* Animations */
        @keyframes fadeIn {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }

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
            50% { transform: translateY(-50px); }
            100% { transform: translateY(0); }
        }

        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }
            h2.text-center {
                font-size: 24px;
            }
            .btn-sm {
                font-size: 12px;
                padding: 5px 10px;
            }
            .btn {
                font-size: 14px;
                padding: 8px 15px;
            }
            .table {
                font-size: 14px;
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

    <div class="container mt-4">
        <!-- Header -->
        <h2 class="text-center">
            <i class="fas fa-warehouse me-2"></i> Stock Management
        </h2>

        <!-- Search Bar -->
        <form action="searchStock" method="get" class="mb-3">
            <div class="input-group">
                <input type="text" name="query" class="form-control" placeholder="Search by Medicine Name...">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-search me-2"></i> Search
                </button>
            </div>
        </form>

        <!-- Stock Table -->
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Medicine Name</th>
                    <th>Purchase Date</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Invoice</th>
                    <th>Manufacture Date</th>
                    <th>Expiry Date</th>
                    <th>Batch No</th>
                    <th>Wholesaler</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="purchase" items="${purchases}">
                    <tr>
                        <td>${purchase.id}</td>
                        <td>${purchase.medicineName}</td>
                        <td>${purchase.purchaseDate}</td>
                        <td>${purchase.quantity}</td>
                        <td>${purchase.price}</td>
                        <td>${purchase.invoice}</td>
                        <td>${purchase.manufactureDate}</td>
                        <td>${purchase.expiryDate}</td>
                        <td>${purchase.batchNo}</td>
                        <td>${purchase.wholesalerName}</td>
                        <td>
                            <a href="updateStock?id=${purchase.id}" class="btn btn-warning btn-sm">
                                <i class="fas fa-edit me-1"></i> Update
                            </a>
                            <a href="deleteStock?id=${purchase.id}" class="btn btn-danger btn-sm" 
                               onclick="return confirm('Are you sure you want to delete this stock?');">
                                <i class="fas fa-trash me-1"></i> Delete
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Buttons -->
        <div class="text-center">
            <a href="addStock" class="btn btn-success">
                <i class="fas fa-plus me-2"></i> Add New Stock
            </a>
            <button id="lowStockBtn" class="btn btn-warning">
                <i class="fas fa-exclamation-triangle me-2"></i> Show Low Stock
            </button>
            <button id="showAllBtn" class="btn btn-secondary">
                <i class="fas fa-list me-2"></i> Show All
            </button>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Clean up date format
            let dateCells = document.querySelectorAll("td:nth-child(3), td:nth-child(7), td:nth-child(8)");
            dateCells.forEach(cell => {
                if (cell.innerText.includes("00:00:00")) {
                    cell.innerText = cell.innerText.split(" ")[0];
                }
            });

            // Low stock threshold and highlighting
            let threshold = 10;
            let rows = document.querySelectorAll("tbody tr");

            rows.forEach(row => {
                let quantityCell = row.cells[3];
                let quantity = parseInt(quantityCell.innerText.trim());

                if (quantity < threshold) {
                    row.classList.add("low-stock");
                }
            });

            // Show low stock
            document.getElementById("lowStockBtn").addEventListener("click", function () {
                rows.forEach(row => {
                    let quantityCell = row.cells[3];
                    let quantity = parseInt(quantityCell.innerText.trim());

                    if (quantity >= threshold) {
                        row.style.display = "none";
                    } else {
                        row.style.display = "";
                    }
                });
            });

            // Show all stock
            document.getElementById("showAllBtn").addEventListener("click", function () {
                rows.forEach(row => row.style.display = "");
            });
        });
    </script>
</body>
</html>