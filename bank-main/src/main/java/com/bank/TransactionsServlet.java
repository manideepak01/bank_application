package com.bank;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/TransactionsServlet")
public class TransactionsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customer") == null) {
            response.sendRedirect("customerLogin.jsp");
            return;
        }

        String accountno = (String) session.getAttribute("customer");

        // Retrieve transactions
        List<String> transactions = getTransactions(accountno);

        // Set transactions in request attribute
        request.setAttribute("transactions", transactions);

        // Forward to JSP for rendering
        request.getRequestDispatcher("transactions.jsp").forward(request, response);
    }

    // Helper method to retrieve transactions from the database
    private List<String> getTransactions(String accountno) {
        List<String> transactions = new ArrayList<>();

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_system", "root", "12345678");
            pst = conn.prepareStatement("SELECT * FROM transactions WHERE accountno = ?");
            pst.setString(1, accountno);
            rs = pst.executeQuery();

            while (rs.next()) {
                Timestamp timestamp = rs.getTimestamp("timestamp");
                String type = rs.getString("type");
                double amount = rs.getDouble("amount");

                String transactionInfo = "Timestamp: " + timestamp + ", Type: " + type + ", Amount: " + amount;
                transactions.add(transactionInfo);
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

        return transactions;
    }
}
