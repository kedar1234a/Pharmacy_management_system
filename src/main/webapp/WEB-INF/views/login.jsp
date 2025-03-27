<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            position: relative;
            overflow: hidden;
        }

        /* Background Animation */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, #1a73e8, #00d4ff, #f0f2f5);
            opacity: 0.1;
            animation: backgroundFlow 15s ease infinite;
            z-index: -1;
        }

        @keyframes backgroundFlow {
            0% {
                background-position: 0% 0%;
            }
            50% {
                background-position: 100% 100%;
            }
            100% {
                background-position: 0% 0%;
            }
        }

        /* Floating particles effect */
        .particles {
            position: absolute;
            width: 100%;
            height: 100%;
            z-index: -1;
        }

        .particle {
            position: absolute;
            background: rgba(26, 115, 232, 0.3);
            border-radius: 50%;
            animation: float 10s infinite ease-in-out;
        }

        .particle:nth-child(1) { width: 20px; height: 20px; left: 10%; top: 20%; animation-duration: 12s; }
        .particle:nth-child(2) { width: 15px; height: 15px; left: 30%; top: 60%; animation-duration: 15s; }
        .particle:nth-child(3) { width: 25px; height: 25px; left: 70%; top: 30%; animation-duration: 13s; }
        .particle:nth-child(4) { width: 10px; height: 10px; left: 50%; top: 80%; animation-duration: 14s; }

        @keyframes float {
            0% { transform: translate(0, 0); opacity: 0.3; }
            50% { transform: translate(30px, -30px); opacity: 0.6; }
            100% { transform: translate(0, 0); opacity: 0.3; }
        }

        .header-container {
            margin-bottom: 20px;
            text-align: center;
        }

        .main-heading {
            font-size: 36px;
            color: #1a73e8;
            text-transform: uppercase;
            letter-spacing: 2px;
            position: relative;
            animation: slideIn 1s ease-out, glow 2s infinite alternate;
            padding: 10px 20px;
            background: linear-gradient(45deg, #1a73e8, #00d4ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        @keyframes slideIn {
            0% { transform: translateY(-100px); opacity: 0; }
            100% { transform: translateY(0); opacity: 1; }
        }

        @keyframes glow {
            0% { text-shadow: 0 0 5px rgba(26, 115, 232, 0.5); }
            100% { text-shadow: 0 0 20px rgba(26, 115, 232, 0.8), 
                          0 0 30px rgba(0, 212, 255, 0.6); }
        }

        h2 {
            color: #1a73e8;
            text-align: center;
            margin-bottom: 20px;
        }

        form {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            position: relative;
            z-index: 1;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #1a73e8;
            box-shadow: 0 0 5px rgba(26, 115, 232, 0.3);
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #1557b0;
        }

        p {
            text-align: center;
            margin-top: 15px;
        }

        p[style="color:red;"] {
            margin-top: 10px;
            font-size: 14px;
        }

        a {
            color: #1a73e8;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="particles">
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
    </div>
    <div class="header-container">
        <h1 class="main-heading">Pharmacy Management System</h1>
    </div>
    <form action="login" method="post">
        <h2>Login</h2>
        <label>Username:</label>
        <input type="text" name="username" required><br>
        
        <label>Password:</label>
        <input type="password" name="password" required><br>
        
        <button type="submit">Login</button>
        <p style="color:red;">${error}</p>
       
    </form>
</body>
</html>