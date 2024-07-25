<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reopen Customer Account</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.15/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 h-screen flex items-center justify-center">
    <div class="max-w-md mx-auto bg-white p-8 shadow-lg rounded-lg">
        <c:if test="${empty sessionScope.admin}">
            <p class="text-center text-red-500 mb-4">You are not logged in as an admin. Please <a href="adminLogin.jsp" class="underline text-blue-500">login</a> first.</p>
        </c:if>
        <c:if test="${not empty sessionScope.admin}">
            <h1 class="text-3xl font-bold mb-4 text-center">Reopen Customer Account</h1>
            <form action="ReopenAccountServlet" method="post" class="space-y-4">
                <div class="flex items-center">
                    <label for="accountno" class="mr-2">Account Number:</label>
                    <input type="text" id="accountno" name="accountno" required class="px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500">
                </div>
                <div class="flex justify-center">
                    <input type="submit" value="Reopen Account" class="bg-green-500 hover:bg-green-600 text-white py-2 px-4 rounded-lg cursor-pointer">
                </div>
            </form>
        </c:if>
    </div>
</body>
</html>
