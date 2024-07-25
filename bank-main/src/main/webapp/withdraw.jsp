<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<c:choose>
    <c:when test="${not empty sessionScope.customer}">
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Withdraw Money</title>
            <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.15/dist/tailwind.min.css" rel="stylesheet">
        </head>
        <body class="bg-gray-100 flex items-center justify-center h-screen">
            <div class="bg-white p-8 rounded-lg shadow-lg">
                <h1 class="text-3xl font-bold mb-4 text-center">Withdraw Money</h1>
                
                <%
                    // Fetch balance from database
                    String accountno = request.getParameter("accountno");
                    double balance = 0.0;
                    Connection conn = null;
                    PreparedStatement pst = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_system", "root", "12345678");

                        pst = conn.prepareStatement("SELECT balance FROM customer WHERE accountno = ?");
                        pst.setString(1, accountno);
                        rs = pst.executeQuery();

                        if (rs.next()) {
                            balance = rs.getDouble("balance");
                        } else {
                            out.println("Balance not found for account: " + accountno);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (pst != null) pst.close();
                            if (conn != null) conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                %>

                <div class="mb-4 text-center">
                    <p><strong>Current Balance:</strong> <%= balance %></p>
                </div>
                
                <form action="WithdrawServlet" method="post" class="space-y-4">
                    <input type="hidden" name="accountno" value="<%= accountno %>">
                    <div class="flex flex-col items-center">
                        <label for="amount" class="mb-2">Amount to Withdraw:</label>
                        <input type="number" id="amount" name="amount" step="0.01" required class="py-2 px-4 border border-gray-300 rounded-lg focus:outline-none focus:border-blue-500">
                    </div>
                    <div class="flex justify-center">
                        <input type="submit" value="Withdraw" class="bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded-lg cursor-pointer">
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
