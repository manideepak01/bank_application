package com.bank;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditCustomerServlet")
public class EditCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountno = request.getParameter("accountno");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String email = request.getParameter("email");
        String phoneno = request.getParameter("phoneno");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob");
        String accounttype = request.getParameter("accounttype");
        String idproof = request.getParameter("idproof");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_system", "root", "12345678");

            PreparedStatement pst = conn.prepareStatement("UPDATE customer SET firstname = ?, lastname = ?, email = ?, phoneno = ?, address = ?, dob = ?, accounttype = ?, idproof = ? WHERE accountno = ?");
            pst.setString(1, firstname);
            pst.setString(2, lastname);
            pst.setString(3, email);
            pst.setString(4, phoneno);
            pst.setString(5, address);
            pst.setString(6, dob);
            pst.setString(7, accounttype);
            pst.setString(8, idproof);
            pst.setString(9, accountno);

            int rowsUpdated = pst.executeUpdate();
            if (rowsUpdated > 0) {
                request.setAttribute("successMessage", "Customer details updated successfully.");
            } else {
                request.setAttribute("errorMessage", "Failed to update customer details.");
            }

            pst.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while updating customer details.");
        }

        // Forward back to customerDetails.jsp with appropriate message
        request.getRequestDispatcher("/customerDetails.jsp").forward(request, response);
    }
}
