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

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountno = request.getParameter("accountno");
        String newpassword = request.getParameter("newpassword");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_system", "root", "12345678");

            PreparedStatement pst = conn.prepareStatement("UPDATE customer SET password = ?, temp_colum = 0 WHERE accountno = ?");
            pst.setString(1, newpassword);
            pst.setString(2, accountno);
            int rowCount = pst.executeUpdate();

            if (rowCount > 0) {
                response.sendRedirect("customerDashboard.jsp?accountno=" + accountno);
            } else {
                response.getWriter().println("Password change failed");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
