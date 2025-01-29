package com.resort;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.RequestDispatcher;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/AdminRegisterServlet")
public class AdminRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String staffName = request.getParameter("staffName");
        String staffEmail = request.getParameter("staffEmail");
        String staffPhoneNo = request.getParameter("staffPhoneNo");
        String staffPassword = request.getParameter("staffPassword");

        // Validate inputs
        if (staffName == null || staffEmail == null || staffPhoneNo == null || staffPassword == null ||
            staffName.isEmpty() || staffEmail.isEmpty() || staffPhoneNo.isEmpty() || staffPassword.isEmpty()) {
            response.sendRedirect("AdminRegister.jsp?error=emptyfields");
            return;
        }

        try  {
        	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection con = AzureConnection.getConnection();
            String sql = "INSERT INTO staff (staffName, staffEmail, staffPhoneNo, staffPassword) VALUES (?, ?, ? , ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, staffName);
            ps.setString(2, staffEmail);
            ps.setString(3, staffPhoneNo);
            ps.setString(4, staffPassword);
            ps.executeUpdate();
            con.close();}
        
            catch (Exception e) {
                System.out.println(e);
            }

            RequestDispatcher req = request.getRequestDispatcher("index.jsp");
            req.forward(request, response);
        }
}
