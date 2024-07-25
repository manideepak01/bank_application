<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.15/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .container {
            max-width: 800px;
            margin: auto;
            padding: 20px;
        }
        .card {
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .actions {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .actions a, .actions button {
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            text-align: center;
            transition: background-color 0.3s;
            cursor: pointer;
        }
        .actions a:hover, .actions button:hover {
            background-color: #4a90e2;
            color: white;
        }
        .logout-btn {
            background-color: #ff4d4d;
            color: white;
        }
        .logout-btn:hover {
            background-color: #e63434;
        }
        .info-list {
            margin-top: 20px;
            padding: 10px;
            background-color: #f5f5f5;
            border-radius: 8px;
        }
        .info-list p {
            margin: 10px 0;
            line-height: 1.6;
        }
        .balance {
            font-size: 1.2rem;
            font-weight: bold;
            color: #2b6cb0; /* Adjusted to a shade of blue */
        }
    </style>
</head>
<body class="bg-gray-100">
    <div class="container">
        <c:choose>
            <c:when test="${not empty sessionScope.customer}">
                <div class="card">
                    <h1 class="text-3xl font-bold mb-4">Customer Dashboard</h1>
                    <%-- Retrieve account details from session --%>
                    <%
                        String accountno = (String) session.getAttribute("customer");
                        Connection conn = null;
                        PreparedStatement pst = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_system", "root", "12345678");

                            pst = conn.prepareStatement("SELECT * FROM customer WHERE accountno = ?");
                            pst.setString(1, accountno);
                            rs = pst.executeQuery();

                            if (rs.next()) {
                    %>
                                <div class="info-list">
                                    <p><strong>Account Number:</strong> <%= rs.getString("accountno") %></p>
                                    <p><strong>Name:</strong> <%= rs.getString("firstname") %> <%= rs.getString("lastname") %></p>
                                    <p><strong>Email:</strong> <%= rs.getString("email") %></p>
                                    <p><strong>Phone Number:</strong> <%= rs.getString("phoneno") %></p>
                                    <p><strong>Address:</strong> <%= rs.getString("address") %></p>
                                    <p><strong>Date of Birth:</strong> <%= rs.getString("dob") %></p>
                                    <p><strong>Account Type:</strong> <%= rs.getString("accounttype") %></p>
                                    <p><strong>ID Proof:</strong> <%= rs.getString("idproof") %></p>
                                    <p><strong>Balance:</strong> <span class="balance"><%= rs.getDouble("balance") %></span></p>
                                </div>
                    <%        
                            } else {
                    %>
                                <p>Customer not found.</p>
                    <%
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
                </div>
                <div class="actions">
                    <a href='deposit.jsp?accountno=<%= accountno %>' class="bg-blue-500 hover:bg-blue-600 text-white rounded-lg">Deposit</a>
                    <a href='withdraw.jsp?accountno=<%= accountno %>' class="bg-green-500 hover:bg-green-600 text-white rounded-lg">Withdraw</a>
                    <a href='TransactionsServlet?accountno=<%= accountno %>' class="bg-yellow-500 hover:bg-yellow-600 text-white rounded-lg">View Transactions</a>
                    <form action="CloseAccountServlet" method="post" onsubmit="return confirm('Are you sure you want to close your account?');">
                        <input type="hidden" name="accountno" value="<%= accountno %>">
                        <button type="submit" class="bg-red-500 hover:bg-red-600 text-white rounded-lg logout-btn">Close Account</button>
                    </form>
                    <form action="CustomerLogoutServlet">
                        <button type="submit" class="bg-gray-500 hover:bg-gray-600 text-white rounded-lg">Logout</button>
                    </form>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card">
                    <p class="text-lg text-center">You are not logged in. Please <a href="customerLogin.jsp" class="underline">login</a> first.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
