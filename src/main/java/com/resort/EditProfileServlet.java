package com.resort;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.RequestDispatcher;

//@WebServlet("/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the current session to get staff information
        HttpSession session = request.getSession();
        Integer staffId = (Integer) session.getAttribute("staffId");
        
        if (staffId == null) {
            response.sendRedirect("AdminProfile.jsp?error=notLoggedIn");
            return;
        }

        // Get the field to update and the new value
        String field = request.getParameter("field");
        String newValue = request.getParameter("newValue");

        if (newValue == null || newValue.trim().isEmpty()) {
            response.sendRedirect("EditProfile.jsp?error=emptyField&field=" + field);
            return;
        }

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection con = AzureConnection.getConnection()) {
                String query = "";
                switch (field) {
                    case "staffName":
                        query = "UPDATE STAFF SET STAFFNAME = ? WHERE STAFFID = ?";
                        break;
                    case "staffEmail":
                        query = "UPDATE STAFF SET STAFFEMAIL = ? WHERE STAFFID = ?";
                        break;
                    case "staffPhoneNo":
                        query = "UPDATE STAFF SET STAFFPHONENO = ? WHERE STAFFID = ?";
                        break;
                    default:
                        response.sendRedirect("EditProfile.jsp?error=invalidField");
                        return;
                }

                // Prepare the statement and execute the update
                try (PreparedStatement ps = con.prepareStatement(query)) {
                    ps.setString(1, newValue);
                    ps.setInt(2, staffId);
                    int rowsUpdated = ps.executeUpdate();

                    if (rowsUpdated > 0) {
                        // Update the session attribute with the new value
                        session.setAttribute(field, newValue);

                        // Redirect to the profile page with a success message
                        response.sendRedirect("AdminProfile.jsp?update=success");
                    } else {
                        response.sendRedirect("EditProfile.jsp?error=updateFailed&field=" + field);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("EditProfile.jsp?error=exception");
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("EditProfile.jsp?error=exception");
                return;
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("EditProfile.jsp?error=driverNotFound&field=" + field);
            return;
        }

        // Forward the request to AdminProfile.jsp
        RequestDispatcher req = request.getRequestDispatcher("AdminProfile.jsp");
        req.forward(request, response);
    }
}
