package com.bank;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DepositServlet")
public class DepositServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountno = request.getParameter("accountno");
        double amount = Double.parseDouble(request.getParameter("amount"));

        Connection conn = null;
        PreparedStatement depositStmt = null;
        PreparedStatement transactionStmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_system", "root", "12345678");

            // Update balance in the customer table
            depositStmt = conn.prepareStatement("UPDATE customer SET balance = balance + ? WHERE accountno = ?");
            depositStmt.setDouble(1, amount);
            depositStmt.setString(2, accountno);
            int rowCount = depositStmt.executeUpdate();

            if (rowCount > 0) {
                // Record transaction in the transactions table
                transactionStmt = conn.prepareStatement("INSERT INTO transactions (accountno, type, amount) VALUES (?, ?, ?)");
                transactionStmt.setString(1, accountno);
                transactionStmt.setString(2, "Deposit");
                transactionStmt.setDouble(3, amount);
                transactionStmt.executeUpdate();

                // Redirect back to customer dashboard after successful deposit
                response.sendRedirect("customerDashboard.jsp?accountno=" + accountno);
            } else {
                response.getWriter().println("Deposit failed. Please try again.");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (depositStmt != null) depositStmt.close();
                if (transactionStmt != null) transactionStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
