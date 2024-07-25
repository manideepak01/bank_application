package com.bank;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterCustomerServlet")
public class RegisterCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String email = request.getParameter("email");
        String phoneno = request.getParameter("phoneno");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob");
        String accounttype = request.getParameter("accounttype");
        String idproof = request.getParameter("idproof");
        String balanceStr = request.getParameter("balance");
        double balance = Double.parseDouble(balanceStr);

        // Validate minimum balance
        if (balance < 1000) {
            response.sendRedirect("errorPage.jsp?message=Minimum balance is 1000");
            return;
        }

        // Generate unique account number
        String accountno = generateAccountNumber();

        // Generate temporary password
        String tempPassword = generateTempPassword();

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank_system", "root", "12345678");

            PreparedStatement pst = conn.prepareStatement("INSERT INTO customer (accountno, firstname, lastname, email, phoneno, address, dob, accounttype, balance, idproof, password, temp_colum) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            pst.setString(1, accountno);
            pst.setString(2, firstname);
            pst.setString(3, lastname);
            pst.setString(4, email);
            pst.setString(5, phoneno);
            pst.setString(6, address);
            pst.setString(7, dob);
            pst.setString(8, accounttype);
            pst.setDouble(9, balance);
            pst.setString(10, idproof);
            pst.setString(11, tempPassword);
            pst.setInt(12, 1); // Set temp_colum to 1
            int rowCount = pst.executeUpdate();

            out.println("<html>");
            out.println("<head>");
            out.println("<title>Customer Registration</title>");
            out.println("<style>");
            out.println("body { font-family: Arial, sans-serif; background-color: #f4f4f9; padding: 20px; }");
            out.println(".container { max-width: 600px; margin: 50px auto; padding: 20px; background: #fff; border-radius: 10px; box-shadow: 0 0 20px rgba(0, 0, 0, 0.1); }");
            out.println(".success { color: #4CAF50; font-size: 18px; }");
            out.println(".fail { color: #F44336; font-size: 18px; }");
            out.println(".details { margin-top: 20px; }");
            out.println("h2 { color: #333; }");
            out.println("p { margin: 5px 0; }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            out.println("<div class='container'>");

            if (rowCount > 0) {
                out.println("<h2 class='success'>Customer registered successfully.</h2>");
                out.println("<div class='details'>");
                out.println("<p><strong>Account Number:</strong> " + accountno + "</p>");
                out.println("<p><strong>Temporary Password:</strong> " + tempPassword + "</p>");
                out.println("</div>");
            } else {
                out.println("<h2 class='fail'>Failed to register customer.</h2>");
            }

            out.println("</div>");
            out.println("</body>");
            out.println("</html>");

            pst.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<html><body><h2 class='fail'>An error occurred while registering the customer.</h2></body></html>");
        }
    }

    private String generateAccountNumber() {
        Random rand = new Random();
        int num = 1000000 + rand.nextInt(9000000);
        return String.valueOf(num);
    }

    private String generateTempPassword() {
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder(10);
        for (int i = 0; i < 10; i++) {
            int randomIndex = random.nextInt(CHARACTERS.length());
            sb.append(CHARACTERS.charAt(randomIndex));
        }
        return sb.toString();
    }
}
