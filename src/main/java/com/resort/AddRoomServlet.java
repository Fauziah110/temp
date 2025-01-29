package com.resort;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.resort.AzureConnection;

public class AddRoomServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    static Connection con = null;
    static PreparedStatement ps = null;

    public AddRoomServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roomIdStr = request.getParameter("roomId");
        String roomType = request.getParameter("roomType");
        String roomStatus = request.getParameter("roomStatus");
        String roomPriceStr = request.getParameter("roomPrice");
        String staffIdStr = request.getParameter("staffId");

        if (roomIdStr == null || roomType == null || roomStatus == null || roomPriceStr == null || staffIdStr == null ||
            roomIdStr.isEmpty() || roomType.isEmpty() || roomStatus.isEmpty() || roomPriceStr.isEmpty() || staffIdStr.isEmpty()) {
            response.sendRedirect("Room.jsp?error=Missing+required+field");
            return;
        }

        try {
            int roomId = Integer.parseInt(roomIdStr);
            double roomPrice = Double.parseDouble(roomPriceStr);
            int staffId = Integer.parseInt(staffIdStr);

            con = AzureConnection.getConnection();
            if (con != null) {
                System.out.println("Database connection established successfully.");
            } else {
                System.out.println("Failed to establish database connection.");
                response.sendRedirect("Room.jsp?error=Database+connection+failed");
                return;
            }

            String sql = "INSERT INTO room (roomId, roomType, roomStatus, roomPrice, staffId) VALUES (?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setInt(1, roomId);
            ps.setString(2, roomType);
            ps.setString(3, roomStatus);
            ps.setDouble(4, roomPrice);
            ps.setInt(5, staffId);

            int rowsAffected = ps.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);

            // Redirect to Room.jsp with a success message
            response.sendRedirect("Room.jsp?success=Room+added+successfully");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("Room.jsp?error=Invalid+number+format");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("Room.jsp?error=Database+error");
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
