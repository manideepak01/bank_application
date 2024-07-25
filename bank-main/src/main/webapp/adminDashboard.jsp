<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.15/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <div class="max-w-3xl mx-auto py-8">
        <h1 class="text-3xl font-bold text-center mb-8">Admin Dashboard</h1>
        <div class="bg-white shadow-lg rounded-lg p-8">
            <c:if test="${empty sessionScope.admin}">
                <p class="text-lg text-center text-red-600">You are not logged in as an admin. Please <a href="adminLogin.jsp" class="underline">login</a> first.</p>
            </c:if>
            <c:if test="${not empty sessionScope.admin}">
                <ul class="space-y-4">
                    <li>
                        <a href="registerCustomer.jsp" class="block bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-lg text-center">Register a Customer</a>
                    </li>
                    <li>
                        <a href="customerDetails.jsp" class="block bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-lg text-center">View and Edit Customer Details</a>
                    </li>
                    <li>
                        <a href="closeCustomer.jsp" class="block bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-lg text-center">Close Customer Account</a>
                    </li>
                  
                    <li>
                        <a href="reopenAccount.jsp" class="block bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-lg text-center">Reopen Customer Account</a>
                    </li>
                    <li>
                        <a href="AdminLogoutServlet" class="block bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded-lg text-center">Logout</a>
                    </li>
                </ul>
            </c:if>
        </div>
    </div>
</body>
</html>
 