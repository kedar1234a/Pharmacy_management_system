<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Purchase" %>
<%@ page import="com.model.Bill" %>
<!DOCTYPE html>
<html>
<head>
    <title>Billing Page</title>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap 5 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Body Styling */
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

        /* Form Styling */
        form {
            background: #ffffff;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 40px;
            animation: fadeInUp 1s ease-in-out;
        }

        label {
            font-weight: 600;
            color: #0288d1;
            margin-bottom: 5px;
            display: block;
        }

        input[type="text"], input[type="date"], input[type="number"], select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #b3e5fc;
            border-radius: 8px;
            font-size: 15px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        input[type="text"]:focus, input[type="date"]:focus, input[type="number"]:focus, select:focus {
            border-color: #0277bd;
            box-shadow: 0 0 8px rgba(2, 119, 189, 0.3);
            outline: none;
        }

        input[readonly] {
            background-color: #eceff1;
            cursor: not-allowed;
        }

        /* Button Styling */
        button, .action-button {
            padding: 10px 20px;
            font-size: 15px;
            font-weight: 500;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        #saveBill {
            background-color: #0288d1;
            color: white;
        }

        #saveBill:hover {
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

        .action-button {
            background-color: #0288d1;
            color: white;
            margin-right: 5px;
            padding: 6px 12px;
        }

        .action-button:hover {
            background-color: #01579b;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(1, 87, 155, 0.4);
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
            form {
                padding: 15px;
            }
            button, .action-button {
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
        <span class="syringe"></span>
    </div>

    <!-- Billing Form -->
    <h2><i class="fas fa-file-invoice-dollar me-2"></i> Billing</h2>
    <form id="billingForm" class="container">
        <div class="row">
            <div class="col-md-6">
                <label>Patient Name:</label>
                <input type="text" id="patientName" required>
            </div>
            <div class="col-md-6">
                <label>Patient Contact:</label>
                <input type="text" id="patientContact" placeholder="Optional">
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <label>Medicine Name:</label>
                <select id="medicineName" required>
                    <option value="">Select Medicine</option>
                    <% 
                        List<Purchase> medicines = (List<Purchase>) request.getAttribute("medicines");
                        if (medicines != null) {
                            for (Purchase p : medicines) { 
                    %>
                        <option value="<%= p.getMedicineName() %>"><%= p.getMedicineName() %></option>
                    <% 
                            } 
                        }
                    %>
                </select>
            </div>
            <div class="col-md-6">
                <label>Date:</label>
                <input type="date" id="date" required>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <label>Quantity:</label>
                <input type="number" id="quantity" required min="1">
            </div>
            <div class="col-md-4">
                <label>Cost per Unit:</label>
                <input type="text" id="costPerUnit" readonly>
            </div>
            <div class="col-md-4">
                <label>Total Cost:</label>
                <input type="text" id="totalCost" readonly>
            </div>
        </div>
        <div class="text-center mt-3">
            <button type="button" id="saveBill"><i class="fas fa-save me-2"></i> Save Bill</button>
        </div>
    </form>

    <!-- Billing Records -->
    <h2><i class="fas fa-history me-2"></i> Billing Records</h2>
    <table class="container">
        <thead>
            <tr>
                <th>Patient ID</th>
                <th>Patient Name</th>
                <th>Patient Contact</th>
                <th>Medicine Name</th>
                <th>Date</th>
                <th>Quantity</th>
                <th>Total Cost</th>
                <th>Action</th>
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
                <td><%= b.getPatientName() %></td>
                <td><%= b.getPatientContact() %></td>
                <td><%= b.getMedicineName() %></td>
                <td><%= b.getDate() %></td>
                <td><%= b.getQuantity() %></td>
                <td><%= b.getTotalCost() %></td>
                <td>
                    <button class="action-button" onclick="generateBill(<%= b.getId() %>)">
                        <i class="fas fa-file-alt me-1"></i> Generate
                    </button>
                    <button class="action-button" onclick="downloadBill(<%= b.getId() %>)">
                        <i class="fas fa-download me-1"></i> Download
                    </button>
                </td>
            </tr>
            <% 
                    } 
                }
            %>
        </tbody>
    </table>

    <!-- JavaScript Logic -->
    <script>
        $(document).ready(function () {
            // Fetch medicine price when selected
            $("#medicineName").on("change", function () {
                var medicineName = $(this).val();
                if (medicineName) {
                    $.ajax({
                        url: "/billing/getMedicinePrice",
                        type: "GET",
                        data: { medicineName: medicineName },
                        success: function (response) {
                            $("#costPerUnit").val(response);
                        },
                        error: function () {
                            alert("Error fetching price.");
                        }
                    });
                }
            });

            // Calculate total cost after entering quantity
            $("#quantity").on("input", function () {
                var quantity = $(this).val();
                var price = $("#costPerUnit").val();
                if (quantity && price) {
                    var total = quantity * price;
                    $("#totalCost").val(total.toFixed(2));
                }
            });

            // Save Bill to Database
            $("#saveBill").on("click", function () {
                var patientName = $("#patientName").val();
                var patientContact = $("#patientContact").val();
                var medicineName = $("#medicineName").val();
                var date = $("#date").val();
                var quantity = $("#quantity").val();
                var costPerUnit = $("#costPerUnit").val();
                var totalCost = $("#totalCost").val();

                if (patientName && medicineName && quantity > 0) {
                    $.ajax({
                        url: "/billing/save",
                        type: "POST",
                        contentType: "application/json",
                        data: JSON.stringify({
                            patientName: patientName,
                            patientContact: patientContact,
                            medicineName: medicineName,
                            date: date,
                            quantity: quantity,
                            costPerUnit: costPerUnit,
                            totalCost: totalCost
                        }),
                        success: function () {
                            alert("Bill saved successfully.");
                            location.reload();
                        },
                        error: function () {
                            alert("Error saving bill.");
                        }
                    });
                } else {
                    alert("Please fill all fields correctly.");
                }
            });
        });

        function generateBill(billId) {
            $.ajax({
                url: "/billing/generateBill",
                type: "POST",
                data: { billId: billId },
                success: function(response) {
                    alert(response);
                },
                error: function() {
                    alert("Error generating bill.");
                }
            });
        }

        function downloadBill(billId) {
            window.location.href = "/billing/downloadBill?billId=" + billId;
        }
    </script>
</body>
</html>