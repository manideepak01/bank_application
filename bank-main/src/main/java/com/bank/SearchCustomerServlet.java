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

@WebServlet("/SearchCustomerServlet")
public class SearchCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountno = request.getParameter("accountno");

        // Check if account number is provided
        if (accountno == null || accountno.isEmpty()) {
            request.setAttribute("message", "Please enter an account number.");
            request.getRequestDispatcher("/customerDetails.jsp").forward(request, response);
            return;
        }

        // Fetch customer details from the database based on account number
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_system", "root", "12345678");

            // Prepare SQL statement
            pst = conn.prepareStatement("SELECT accountno, firstname, lastname, email, phoneno, address, dob, accounttype, idproof FROM customer WHERE accountno = ?");
            pst.setString(1, accountno);

            // Execute query
            rs = pst.executeQuery();

            // Check if customer details found
            if (rs.next()) {
                // Set customer details as request attributes
                request.setAttribute("accountno", rs.getString("accountno"));
                request.setAttribute("firstname", rs.getString("firstname"));
                request.setAttribute("lastname", rs.getString("lastname"));
                request.setAttribute("email", rs.getString("email"));
                request.setAttribute("phoneno", rs.getString("phoneno"));
                request.setAttribute("address", rs.getString("address"));
                request.setAttribute("dob", rs.getString("dob"));
                request.setAttribute("accounttype", rs.getString("accounttype"));
                request.setAttribute("idproof", rs.getString("idproof"));
            } else {
                // No customer found with provided account number
                request.setAttribute("message", "Customer not found for account number: " + accountno);
            }
        } catch (ClassNotFoundException | SQLException e) {
            // Handle database errors
            e.printStackTrace();
            request.setAttribute("message", "Error fetching customer details.");
        } finally {
            // Close database resources
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Forward request to view_customer.jsp to display results
        request.getRequestDispatcher("/customerDetails.jsp").forward(request, response);
    }
}
