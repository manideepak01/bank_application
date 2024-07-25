package com.bank;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/ReopenAccountServlet")
public class ReopenAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String accountno = request.getParameter("accountno");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_system", "root", "12345678");

            PreparedStatement checkPst = conn.prepareStatement("SELECT active FROM customer WHERE accountno = ?");
            checkPst.setString(1, accountno);
            ResultSet rs = checkPst.executeQuery();

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html><head><title>Reopen Account</title></head><body>");

            if (rs.next()) {
                boolean isActive = rs.getBoolean("active");
                if (isActive) {
                    out.println("<p>Account is already active.</p>");
                } else {
                    PreparedStatement pst = conn.prepareStatement("UPDATE customer SET active = 1 WHERE accountno = ?");
                    pst.setString(1, accountno);
                    int rowCount = pst.executeUpdate();

                    if (rowCount > 0) {
                        out.println("<p>Account reopened successfully.</p>");
                    } else {
                        out.println("<p>Failed to reopen account. Please try again.</p>");
                    }
                }
            } else {
                out.println("<p>Account not found.</p>");
            }

            out.println("</body></html>");

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
