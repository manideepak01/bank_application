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
import javax.servlet.http.HttpSession;

@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountno = request.getParameter("accountno");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_system", "root", "12345678");

            PreparedStatement pst = conn.prepareStatement("SELECT * FROM customer WHERE accountno = ?");
            pst.setString(1, accountno);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                String tempPassword = rs.getString("password");
                int tempColum = rs.getInt("temp_colum");
                int active = rs.getInt("active");

                if (active == 1) {
                    if (tempColum == 1 && tempPassword.equals(password)) {
                        // Redirect to change password page
                        response.sendRedirect("changePassword.jsp?accountno=" + accountno);
                    } else if (tempColum == 0 && tempPassword.equals(password)) {
                        // Create session for customer and redirect to customer dashboard
                        HttpSession session = request.getSession();
                        session.setAttribute("customer", accountno);
                        response.sendRedirect("customerDashboard.jsp");
                    } else {
                        response.getWriter().println("Invalid credentials");
                    }
                } else {
                    response.getWriter().println("Your account is closed. Please contact the bank for assistance.");
                }
            } else {
                response.getWriter().println("Customer not found.");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
