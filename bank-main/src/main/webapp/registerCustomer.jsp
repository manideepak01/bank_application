<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Customer</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.15/dist/tailwind.min.css" rel="stylesheet">
    <script>
        function validateForm() {
            let phone = document.getElementById("phoneno").value;
            let balance = parseFloat(document.getElementById("balance").value);
            let phonePattern = /^[0-9]{10}$/;

            if (!phonePattern.test(phone)) {
                alert("Phone number must be 10 digits.");
                return false;
            }

            if (balance < 1000) {
                alert("Initial balance must be at least 1000.");
                return false;
            }

            return true;
        }
    </script>
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">
    <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-lg">
        <c:choose>
            <c:when test="${not empty sessionScope.admin}">
                <h1 class="text-3xl font-bold mb-6 text-center">Register New Customer</h1>
                <form action="RegisterCustomerServlet" method="post" class="space-y-4" onsubmit="return validateForm()">
                    <div>
                        <label for="firstname" class="block text-gray-700">First Name:</label>
                        <input type="text" id="firstname" name="firstname" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500">
                    </div>
                    <div>
                        <label for="lastname" class="block text-gray-700">Last Name:</label>
                        <input type="text" id="lastname" name="lastname" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500">
                    </div>
                    <div>
                        <label for="email" class="block text-gray-700">Email:</label>
                        <input type="email" id="email" name="email" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500">
                    </div>
                    <div>
                        <label for="phoneno" class="block text-gray-700">Phone Number:</label>
                        <input type="text" id="phoneno" name="phoneno" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500">
                    </div>
                    <div>
                        <label for="address" class="block text-gray-700">Address:</label>
                        <input type="text" id="address" name="address" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500">
                    </div>
                    <div>
                        <label for="dob" class="block text-gray-700">Date of Birth:</label>
                        <input type="date" id="dob" name="dob" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500">
                    </div>
                    <div>
                        <label for="accounttype" class="block text-gray-700">Account Type:</label>
                        <select id="accounttype" name="accounttype" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500">
                            <option value="Saving">Saving</option>
                            <option value="Current">Current</option>
                        </select>
                    </div>
                    <div>
                        <label for="balance" class="block text-gray-700">Initial Balance:</label>
                        <input type="number" step="0.01" id="balance" name="balance" min="1000" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500">
                    </div>
                    <div>
                        <label for="idproof" class="block text-gray-700">ID Proof:</label>
                        <input type="text" id="idproof" name="idproof" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500">
                    </div>
                    <div class="flex justify-center">
                        <input type="submit" value="Register Customer" class="bg-green-500 hover:bg-green-600 text-white py-2 px-4 rounded-lg cursor-pointer">
                    </div>
                </form>
            </c:when>
            <c:otherwise>
                <p class="text-center text-red-500">You are not logged in as an admin. Please <a href="adminLogin.jsp" class="underline text-blue-500">login</a> first.</p>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
