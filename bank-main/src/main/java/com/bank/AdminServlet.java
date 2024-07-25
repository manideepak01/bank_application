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

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_system", "root", "12345678");

            PreparedStatement pst = conn.prepareStatement("SELECT * FROM admin WHERE username = ? AND password = ?");
            pst.setString(1, username);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                // Admin login successful, create a session
                HttpSession session = request.getSession();
                session.setAttribute("admin", username); // Store admin username in session attribute
                response.sendRedirect("adminDashboard.jsp");
            } else {
                PrintWriter out = response.getWriter();
                out.println("Invalid credentials");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
