package com.bank;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/WithdrawServlet")
public class WithdrawServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountno = request.getParameter("accountno");
        double amount = Double.parseDouble(request.getParameter("amount"));

        Connection conn = null;
        PreparedStatement withdrawStmt = null;
        PreparedStatement transactionStmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_system", "root", "12345678");

            // Check if sufficient balance exists
            PreparedStatement checkBalanceStmt = conn.prepareStatement("SELECT balance FROM customer WHERE accountno = ?");
            checkBalanceStmt.setString(1, accountno);
            ResultSet rs = checkBalanceStmt.executeQuery();

            if (rs.next()) {
                double currentBalance = rs.getDouble("balance");
                if (currentBalance >= amount) {
                    // Update balance in the customer table
                    withdrawStmt = conn.prepareStatement("UPDATE customer SET balance = balance - ? WHERE accountno = ?");
                    withdrawStmt.setDouble(1, amount);
                    withdrawStmt.setString(2, accountno);
                    int rowCount = withdrawStmt.executeUpdate();

                    if (rowCount > 0) {
                        // Record transaction in the transactions table
                        transactionStmt = conn.prepareStatement("INSERT INTO transactions (accountno, type, amount) VALUES (?, ?, ?)");
                        transactionStmt.setString(1, accountno);
                        transactionStmt.setString(2, "Withdrawal");
                        transactionStmt.setDouble(3, amount);
                        transactionStmt.executeUpdate();

                        // Redirect back to customer dashboard after successful withdrawal
                        response.sendRedirect("customerDashboard.jsp?accountno=" + accountno);
                    } else {
                        response.getWriter().println("Withdrawal failed. Please try again.");
                    }
                } else {
                    response.getWriter().println("Insufficient balance.");
                }
            } else {
                response.getWriter().println("Account not found.");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (withdrawStmt != null) withdrawStmt.close();
                if (transactionStmt != null) transactionStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
