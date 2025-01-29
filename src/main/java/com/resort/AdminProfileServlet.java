// AdminProfileServlet.java
package com.resort;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AdminProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String staffName = (String) session.getAttribute("staffName");

        if (staffName == null) {
            response.sendRedirect("index.jsp?error=notLoggedIn");
            return;
        }

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection con = AzureConnection.getConnection();
            String query = "SELECT STAFFNAME, STAFFEMAIL, STAFFPHONENO FROM STAFF WHERE STAFFNAME = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, staffName); 

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Set request attributes (not session attributes)
                request.setAttribute("staffName", rs.getString("STAFFNAME")); 
                request.setAttribute("staffEmail", rs.getString("STAFFEMAIL"));
                request.setAttribute("staffPhoneNo", rs.getString("STAFFPHONENO"));

                request.getRequestDispatcher("AdminProfile.jsp").forward(request, response);
            } else {
                response.sendRedirect("index.jsp?error=userNotFound"); 
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace(); // Or use a logger
            response.sendRedirect("index.jsp?error=exception"); 
        }
    }
}