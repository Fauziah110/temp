<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page
    import="java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.Statement"%>
<!DOCTYPE html>
<html>
<head>
<title>Booking Details</title>
<style>
body {
    margin: 0;
    font-family: Arial, Helvetica, sans-serif;
}

header {
    background-color: #5f7268; /* Dark greenish color */
    color: white;
    padding: 10px;
    text-align: center;
    font-size: 18px;
}

nav {
    display: flex;
    align-items: center;
    padding: 10px 20px;
    background-color: white;
    border-bottom: 1px solid #ddd;
    width: 100%;
}

nav .logo-link {
    display: flex;
    align-items: center;
    text-decoration: none; /* Remove underline */
    color: #5f7268; /* Text color */
}

.logo-image {
    height: 55px; /* Adjust as needed */
    margin-right: 10px; /* Space between logo and text */
}

.logo-text {
    font-size: 16px;
    font-weight: bold;
    margin-right: 200px;
}

nav .spacer {
    flex: 1; /* Creates space between the logo and navigation links */
}

nav ul {
    list-style: none;
    display: flex;
    margin: 0;
    padding: 0;
}

nav ul li {
    margin: 0 50px; /* Spacing between navigation items */
    font-weight: bold;
}

nav ul li a {
    text-decoration: none;
    color: #5f7268;
    font-size: 16px;
}

nav ul li a:hover {
    text-decoration: underline;
}

h1 {
    font-size: 18px; 
    margin: 40px;
    color: #5f7268;
}

table {
    width: 100%;
    max-width: 90%; /* Set a maximum width */
    border-collapse: collapse;
    margin: 40px; /* Add top/bottom margin and auto left/right margin */
}

th, td {
    border: 1px solid #000;
    padding: 10px;
    text-align: center;
    color: #5f7268;
}

th {
    background-color: #5f7268;
    color: white;
}
</style>
</head>
<body>
    <nav>
        <a href="Dashboard.jsp" class="logo-link">
            <img src="Images/MDResort.PNG" alt="Resort Logo" class="logo-image">
            <span class="logo-text">MD Resort Pantai Siring Melaka</span>
        </a>
        <div class="spacer"></div> <!-- Spacer to center the navigation links -->
        <ul>
            <li><a href="Booking.jsp">Booking</a></li>
            <li><a href="Room.jsp">Room</a></li>
            <li><a href="Service.jsp">Service</a></li>
            <li><a href="Profile.jsp">Profile</a></li>
        </ul>
    </nav>
    <h1>Booking Details</h1>
    
    <table>
        <thead>
            <tr>
                <th>No.</th>
                <th>Name Customer</th>
                <th>No Room</th>
                <th>Type Room</th>
                <th>Total Guest</th>
                <th>Price</th>
                <th>Date Check In</th>
                <th>Date Check Out</th>
            </tr>
        </thead>
        <tbody>
            <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mdresort", "root", "");
                stmt = conn.createStatement();
                String sql = "SELECT re.reservationId, c.customerName, r.roomID, r.roomType, " +
                             "(re.totalAdult + re.totalKids) AS totalGuest, " +
                             "p.totalPayment, re.checkinDate, re.checkoutDate " +
                             "FROM reservation re " +
                             "JOIN customer c ON re.customerId = c.customerId " +
                             "JOIN room r ON re.roomId = r.roomId " +
                             "JOIN payment p ON re.reservationId = p.reservationId";
                rs = stmt.executeQuery(sql);
                int count = 1;
                while (rs.next()) {
            %>
            <tr>
                <td><%=count++%></td>
                <td><%=rs.getString("customerName")%></td>
                <td><%=rs.getInt("roomID")%></td>
                <td><%=rs.getString("roomType")%></td>
                <td><%=rs.getInt("totalGuest")%></td>
                <td><%=rs.getBigDecimal("totalPayment")%></td>
                <td><%=rs.getDate("checkinDate")%></td>
                <td><%=rs.getDate("checkoutDate")%></td>
            </tr>
            <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
            %>
        </tbody>
    </table>
</body>
</html>
