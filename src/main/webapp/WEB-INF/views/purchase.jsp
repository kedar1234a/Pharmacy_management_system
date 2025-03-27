<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Purchase Medicine</title>
    <!-- Bootstrap 5 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Body Styling */
        body {
            background: linear-gradient(135deg, #e8f5e9, #c8e6c9);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            overflow-x: hidden;
        }

        /* Container Styling */
        .container-fluid {
            padding: 0 30px;
            margin-top: 40px;
        }

        /* Header Styling */
        h2.text-center {
            font-size: 28px;
            font-weight: 700;
            color: #2e7d32;
            margin-bottom: 30px;
            position: relative;
            animation: slideInDown 0.8s ease-out;
        }

        h2.text-center::after {
            content: '';
            width: 60px;
            height: 3px;
            background: #2e7d32;
            display: block;
            margin: 10px auto;
            border-radius: 2px;
        }

        /* Card Styling */
        .card {
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            background: #ffffff;
            padding: 30px;
            animation: fadeInUp 1s ease-in-out;
            position: relative;
            overflow: hidden;
        }

        /* Form Input Styling */
        .mb-3 label {
            font-weight: 600;
            color: #388e3c;
            margin-bottom: 5px;
            display: block;
        }

        .form-control {
            border-radius: 8px;
            border: 1px solid #c8e6c9;
            padding: 10px;
            font-size: 15px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .form-control:focus {
            border-color: #2e7d32;
            box-shadow: 0 0 8px rgba(46, 125, 50, 0.3);
            outline: none;
        }

        /* Input Animation */
        .mb-3 {
            animation: slideInLeft 0.5s ease-out;
            animation-fill-mode: backwards;
        }

        /* Staggered Animation for Inputs */
        .mb-3:nth-child(1) { animation-delay: 0.1s; }
        .mb-3:nth-child(2) { animation-delay: 0.2s; }
        .mb-3:nth-child(3) { animation-delay: 0.3s; }
        .mb-3:nth-child(4) { animation-delay: 0.4s; }
        .mb-3:nth-child(5) { animation-delay: 0.5s; }
        .mb-3:nth-child(6) { animation-delay: 0.6s; }
        .mb-3:nth-child(7) { animation-delay: 0.7s; }
        .mb-3:nth-child(8) { animation-delay: 0.8s; }
        .mb-3:nth-child(9) { animation-delay: 0.9s; }

        /* Button Styling */
        .btn {
            padding: 12px 20px;
            font-size: 16px;
            font-weight: 500;
            border-radius: 8px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .btn-success {
            background-color: #2e7d32;
            border-color: #2e7d32;
        }

        .btn-success:hover {
            background-color: #1b5e20;
            border-color: #1b5e20;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(46, 125, 50, 0.4);
        }

        .btn-secondary {
            background-color: #757575;
            border-color: #757575;
        }

        .btn-secondary:hover {
            background-color: #616161;
            border-color: #616161;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(97, 97, 97, 0.4);
        }

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

        .pill, .syringe {
            position: absolute;
            opacity: 0.1;
            animation: float 10s infinite ease-in-out;
        }

        .pill {
            width: 20px;
            height: 10px;
            background-color: #2e7d32;
            border-radius: 10px;
            top: 15%;
            left: 10%;
        }

        .syringe {
            width: 25px;
            height: 5px;
            background: linear-gradient(90deg, #2e7d32, transparent);
            border-radius: 5px;
            top: 70%;
            left: 85%;
        }

        /* Animations */
        @keyframes fadeInUp {
            0% { opacity: 0; transform: translateY(30px); }
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
            .container-fluid {
                padding: 0 15px;
            }
            .card {
                padding: 20px;
            }
            h2.text-center {
                font-size: 24px;
            }
            .btn {
                font-size: 14px;
                padding: 10px 15px;
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid mt-5">
        <!-- Background Animation -->
        <div class="background-animation">
            <span class="pill"></span>
            <span class="syringe"></span>
        </div>

        <!-- Header -->
        <h2 class="text-center">
            <i class="fas fa-shopping-basket me-2"></i> Add New Purchase
        </h2>

        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card p-4">
                    <form action="savePurchase" method="post">
                        <!-- Hidden field for ID (only included when updating) -->
                        <c:if test="${not empty purchase}">
                            <input type="hidden" name="id" value="${purchase.id}">
                        </c:if>

                        <div class="mb-3">
                            <label>Medicine Name:</label>
                            <input type="text" name="medicineName" class="form-control" required value="${purchase.medicineName}">
                        </div>

                        <div class="mb-3">
                            <label>Purchase Date:</label>
                            <input type="date" name="purchaseDate" class="form-control" required value="${purchase.purchaseDate}">
                        </div>

                        <div class="mb-3">
                            <label>Quantity:</label>
                            <input type="number" name="quantity" class="form-control" required value="${purchase.quantity}">
                        </div>

                        <div class="mb-3">
                            <label>Price:</label>
                            <input type="number" step="0.01" name="price" class="form-control" required value="${purchase.price}">
                        </div>

                        <div class="mb-3">
                            <label>Invoice:</label>
                            <input type="text" name="invoice" class="form-control" required value="${purchase.invoice}">
                        </div>

                        <div class="mb-3">
                            <label>Manufacture Date:</label>
                            <input type="date" name="manufactureDate" class="form-control" required value="${purchase.manufactureDate}">
                        </div>

                        <div class="mb-3">
                            <label>Expiry Date:</label>
                            <input type="date" name="expiryDate" class="form-control" required value="${purchase.expiryDate}">
                        </div>

                        <div class="mb-3">
                            <label>Batch No:</label>
                            <input type="text" name="batchNo" class="form-control" required value="${purchase.batchNo}">
                        </div>

                        <div class="mb-3">
                            <label>Wholesaler Name:</label>
                            <input type="text" name="wholesalerName" class="form-control" required value="${purchase.wholesalerName}">
                        </div>

                        <div class="text-center">
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-save me-2"></i>
                                <c:choose>
                                    <c:when test="${not empty purchase}">Update</c:when>
                                    <c:otherwise>Save</c:otherwise>
                                </c:choose>
                            </button>
                            <a href="stock" class="btn btn-secondary">
                                <i class="fas fa-times me-2"></i> Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS (Optional for interactivity) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>