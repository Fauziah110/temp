package com.resort;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DeleteAccount")
public class DeleteAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer staffId = (Integer) session.getAttribute("staffId");

        if (staffId == null) {
            response.sendRedirect("index.jsp?error=notLoggedIn");
            return;
        }

        System.out.println("Attempting to delete account for staffId: " + staffId); // Debugging

        try (Connection con = AzureConnection.getConnection()) {
            if (con == null) {
                throw new Exception("Database connection failed. Connection is null.");
            }

            // Use a transaction to ensure deletion completes
            con.setAutoCommit(false);

            try {
                String sql = "DELETE FROM STAFF WHERE STAFFID = ?";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setInt(1, staffId);
                    int rowsDeleted = ps.executeUpdate();
                    System.out.println("Rows Deleted: " + rowsDeleted); // Debugging

                    if (rowsDeleted > 0) {
                        // Commit the transaction
                        con.commit();
                        // Invalidate session and redirect to confirmation page
                        session.invalidate();
                        response.sendRedirect("AccountDeleted.jsp");
                    } else {
                        con.rollback(); // Rollback if no rows are deleted
                        response.sendRedirect("AdminProfile.jsp?error=deleteFailed");
                    }
                }
            } catch (SQLException e) {
                con.rollback(); // Rollback on failure
                throw e; // Re-throw the exception to the catch block below
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("AdminProfile.jsp?error=driverNotFound");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminProfile.jsp?error=exception");
        }
    }
}
