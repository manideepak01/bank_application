package com.bank;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CloseAccountServlet")
public class CloseAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountno = request.getParameter("accountno");

        Connection conn = null;
        PreparedStatement balanceStmt = null;
        PreparedStatement updateStmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_system", "root", "12345678");

            // Check balance before closing account
            balanceStmt = conn.prepareStatement("SELECT balance FROM customer WHERE accountno = ?");
            balanceStmt.setString(1, accountno);
            ResultSet rs = balanceStmt.executeQuery();

            if (rs.next()) {
                double balance = rs.getDouble("balance");
                if (balance > 0) {
                    // Redirect to withdraw.jsp to withdraw remaining balance
                    response.sendRedirect("withdraw.jsp?accountno=" + accountno);
                } else {
                    // Update account status to closed
                    updateStmt = conn.prepareStatement("UPDATE customer SET active = 0 WHERE accountno = ?");
                    updateStmt.setString(1, accountno);
                    int rowCount = updateStmt.executeUpdate();

                    if (rowCount > 0) {
                        response.getWriter().println("Account closed successfully.");

                        // Invalidate session to log out user
                        request.getSession().invalidate();
                        response.sendRedirect("customerLogin.jsp"); // Redirect to login page after logout
                    } else {
                        response.getWriter().println("Failed to close account. Please try again.");
                    }
                }
            } else {
                response.getWriter().println("Account not found.");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (balanceStmt != null) balanceStmt.close();
                if (updateStmt != null) updateStmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
