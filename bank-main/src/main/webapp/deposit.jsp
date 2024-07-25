<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
    <c:when test="${not empty sessionScope.customer}">
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Deposit Money</title>
            <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.15/dist/tailwind.min.css" rel="stylesheet">
        </head>
        <body class="bg-gray-100 flex items-center justify-center h-screen">
            <div class="bg-white p-8 rounded-lg shadow-lg">
                <h1 class="text-3xl font-bold mb-4 text-center">Deposit Money</h1>
                <form action="DepositServlet" method="post" class="space-y-4">
                    <input type="hidden" name="accountno" value="${param.accountno}">
                    <div class="flex flex-col items-center">
                        <label for="amount" class="mb-2">Amount to Deposit:</label>
                        <input type="number" id="amount" name="amount" step="0.01" required class="py-2 px-4 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500">
                    </div>
                    <div class="flex justify-center">
                        <input type="submit" value="Deposit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-lg cursor-pointer">
                    </div>
                </form>
            </div>
        </body>
        </html>
    </c:when>
    <c:otherwise>
        <jsp:forward page="customerLogin.jsp"/>
    </c:otherwise>
</c:choose>
