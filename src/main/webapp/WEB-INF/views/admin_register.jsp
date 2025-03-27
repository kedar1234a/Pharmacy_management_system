<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Registration</title>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Font Awesome for Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
/* Your existing CSS remains unchanged */
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
	-
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

/* Form Container */
.form-container {
	max-width: 800px;
	width: 100%;
}

/* Form Styling */
form {
	background: #ffffff;
	padding: 25px;
	border-radius: 15px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
	margin-bottom: 40px;
	animation: fadeInUp 1s ease-in-out;
	width: 100%;
}

.form-row {
	display: flex;
	justify-content: space-between;
	gap: 20px;
	margin-bottom: 15px;
}

.form-group {
	flex: 1;
	min-width: 0;
}

label {
	font-weight: 600;
	color: #0288d1;
	margin-bottom: 5px;
	display: block;
}

input[type="text"], input[type="password"], input[type="number"] {
	width: 100%;
	padding: 10px;
	margin-bottom: 15px;
	border: 1px solid #b3e5fc;
	border-radius: 8px;
	font-size: 15px;
	transition: border-color 0.3s, box-shadow 0.3s;
}

input[type="text"]:focus, input[type="password"]:focus, input[type="number"]:focus
	{
	border-color: #0277bd;
	box-shadow: 0 0 8px rgba(2, 119, 189, 0.3);
	outline: none;
}

/* Button Styling */
.button-group {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 15px;
}

.btn-register, .btn-clear {
	padding: 10px 20px;
	font-size: 15px;
	font-weight: 500;
	border-radius: 8px;
	border: none;
	cursor: pointer;
	transition: transform 0.3s, box-shadow 0.3s;
}

.btn-register {
	background-color: #0288d1;
	color: white;
}

.btn-register:hover {
	background-color: #01579b;
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(1, 87, 155, 0.4);
}

.btn-clear {
	background-color: #6c757d;
	color: white;
}

.btn-clear:hover {
	background-color: #5a6268;
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(108, 117, 125, 0.4);
}

/* Table Container */
.table-container {
	max-width: 800px;
	width: 100%;
	overflow-x: auto;
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

/* Message and Error Styling */
.message {
	color: #28a745;
	margin-bottom: 20px;
	font-weight: 500;
	text-align: center;
	background-color: #e7f3e7;
	padding: 10px;
	border-radius: 8px;
}

.error {
	color: #dc3545;
	margin-bottom: 20px;
	font-weight: 500;
	text-align: center;
	background-color: #f8e1e1;
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
@
keyframes fadeInUp { 0% {
	opacity: 0;
	transform: translateY(20px);
}

100
%
{
opacity
:
1;
transform
:
translateY(
0
);
}
}
@
keyframes slideInDown { 0% {
	opacity: 0;
	transform: translateY(-20px);
}

100
%
{
opacity
:
1;
transform
:
translateY(
0
);
}
}
@
keyframes float { 0% {
	transform: translateY(0);
}

50
%
{
transform
:
translateY(
-40px
);
}
100
%
{
transform
:
translateY(
0
);
}
}

/* Responsive Adjustments */
@media ( max-width : 768px) {
	body {
		padding: 15px;
	}
	h2 {
		font-size: 24px;
	}
	form {
		padding: 15px;
	}
	.form-row {
		flex-direction: column;
		gap: 10px;
	}
	.form-group {
		margin-bottom: 10px;
	}
	.btn-register, .btn-clear {
		font-size: 14px;
		padding: 8px 15px;
	}
	th, td {
		font-size: 14px;
		padding: 10px;
	}
	.table-container {
		max-width: 100%;
		overflow-x: auto;
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
		<span class="pill"></span> <span class="syringe"></span>
	</div>

	<!-- Admin Registration Form and Table -->
	<h2>
		<i class="fas fa-user-plus me-2"></i> Admin Registration
	</h2>
	<div class="container">
		<div class="form-container">
			<form:form action="/adminRegister" method="post"
				modelAttribute="admin" id="adminRegisterForm">
				<form:hidden path="id" />
				<c:if test="${not empty message}">
					<div class="message">${message}</div>
				</c:if>
				<c:if test="${not empty error}">
					<div class="error">${error}</div>
				</c:if>
				<div class="form-row">
					<div class="form-group">
						<label for="username">Username:</label>
						<form:input path="username" id="username" required="true"
							placeholder="Enter username" />
					</div>
					<div class="form-group">
						<label for="password">Password:</label>
						<form:input type="password" path="password" id="password"
							required="true" placeholder="Enter password" />
					</div>
				</div>
				<div class="button-group">
					<button type="submit" class="btn-register">
						<i class="fas fa-save me-2"></i>Register
					</button>
					<button type="button" class="btn-clear" onclick="clearForm();">
						<i class="fas fa-eraser me-2"></i>Clear
					</button>
				</div>
			</form:form>
		</div>

		<!-- Table Section: List of Registered Admins -->
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
					<c:choose>
						<c:when test="${empty admins}">
							<tr>
								<td colspan="3" style="text-align: center;">No admins
									found.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="admin" items="${admins}" varStatus="loop">
								<tr>
									<td>${loop.count}</td>
									<td>${admin.username}</td>
									<td>
										<form action="/deleteAdmin" method="post"
											style="display: inline;" onsubmit="return confirmDelete();">
											<input type="hidden" name="id" value="${admin.id}" />
											<button type="submit" class="action-button">
												<i class="fas fa-trash-alt me-1"></i> Delete
											</button>
										</form>
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>

	<!-- JavaScript Logic -->
	<script>
		// Clear the form
		function clearForm() {
			document.getElementById('adminRegisterForm').reset();
		}

		// Form validation (client-side)
		document.getElementById('adminRegisterForm').addEventListener('submit',
				function(event) {
					let username = document.getElementById('username').value;
					let password = document.getElementById('password').value;

					if (username.trim().length < 3) {
						alert('Username must be at least 3 characters long.');
						event.preventDefault();
					}

					if (password.trim().length < 6) {
						alert('Password must be at least 6 characters long.');
						event.preventDefault();
					}
				});

		// Confirm deletion
		function confirmDelete() {
			return confirm('Are you sure you want to delete this admin?');
		}
	</script>
</body>
</html>