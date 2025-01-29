<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.Statement"%>
<!DOCTYPE html>
<html>
<head>
<title>Service Details</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">

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
	font-weight: bold;
	margin: 40px 40px 10px;
	color: #5f7268;
}

table {
	width: 100%;
	max-width: 90%; /* Set a maximum width */
	border-collapse: collapse;
	margin: 1px 40px 10px;
	/* Add top/bottom margin and auto left/right margin */
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

.action-buttons a {
	margin-right: 5px;
}

.modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
	width: 400px;
	margin: 50px auto;
	background-color: #f3f3f3;
	color: #5f7268;
	border-radius: 10px;
	padding: 20px;
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
}

.modal-content label {
	font-size: 16px;
	font-weight: bold;
	margin-bottom: 5px;
	display: inline-block;
	font-color: #5f7268;
}

.modal-content input, .modal-content select, .modal-content textarea {
	width: 100%;
	padding: 8px 10px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 14px;
	color: #5f7268;
}

.modal-content button {
	width: 100%;
	padding: 10px;
	background-color: #5f7268;
	color: white;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
}

.modal-content button:hover {
	background-color: #4b5c53;
}

.modal-header, .modal-footer {
	border: none;
}

.modal-header h5 {
	color: #5f7268;
}

.close {
	position: absolute;
	top: 20px;
	right: 20px;
	color: #5f7268;
	font-size: 24px;
	font-weight: bold;
	cursor: pointer;
}

.close:hover {
	color: #4b5c53; /* Slightly darker hover color */
}

#addRoomBtn {
	background-color: #5f7268;
	color: white;
	padding: 10px 20px;
	border: none;
	cursor: pointer;
	margin: 40px;
}

#addRoomBtn:hover {
	background-color: #5f7268;
}
</style>
<script>
	function showModal() {
		document.getElementById("addRoomModal").style.display = "block";
	}
	function closeModal() {
		document.getElementById("addRoomModal").style.display = "none";
	}
</script>
</head>
<body>
	<nav>
		<a href="Dashboard.jsp" class="logo-link"> <img
			src="Images/MDResort.PNG" alt="Resort Logo" class="logo-image">
			<span class="logo-text">MD Resort Pantai Siring Melaka</span>
		</a>
		<div class="spacer"></div>
		<ul>
			<li><a href="Booking.jsp">Booking</a></li>
			<li><a href="Room.jsp">Room</a></li>
			<li><a href="Service.jsp">Service</a></li>
			<li><a href="Profile.jsp">Profile</a></li>
		</ul>
	</nav>
	<h1>Service Details</h1>
	<button id="addRoomBtn" onclick="showModal()">+ Add Service</button>

	<table>
		<thead>
			<tr>
				<th>No Service</th>
				<th>Charge</th>
				<th>Date</th>
				<th>Price</th>
				<th>Staff In Charge</th>
				<th>Action</th>
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
				String sql = "SELECT r.roomId, r.roomType, r.roomStatus, r.roomPrice, s.staffName "
				+ "FROM room r JOIN staff s ON r.staffId = s.staffID";
				rs = stmt.executeQuery(sql);
				while (rs.next()) {
			%>
			<tr>
				<td><%=rs.getInt("roomId")%></td>
				<td><%=rs.getString("roomType")%></td>
				<td><%=rs.getString("roomStatus")%></td>
				<td><%=rs.getBigDecimal("roomPrice")%></td>
				<td><%=rs.getString("staffName")%></td>
				<td class="action-buttons"><a href="#"
					class="btn btn-sm btn-warning">Edit</a> <a href="#"
					class="btn btn-sm btn-danger">Delete</a></td>
			</tr>
			<%
			}
			} catch (Exception e) {
			e.printStackTrace();
			} finally {
			if (rs != null)
			rs.close();
			if (stmt != null)
			stmt.close();
			if (conn != null)
			conn.close();
			}
			%>
		</tbody>
	</table>

	<!-- Add Room Modal -->
	<div id="addRoomModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>
			<h2>Add Room</h2>
			<form action="/AddRoomServlet" method="post">
				<label for="roomId">No Room:</label> <input type="text" id="roomId"
					name="roomId" required><br> <br> <label
					for="roomType">Type Room:</label> <select id="roomType"
					name="roomType">
					<option value="Family">Family</option>
					<option value="Cabin">Cabin</option>
					<option value="Wood">Wood</option>
				</select><br> <br> <label for="roomStatus">Room Status:</label> <select
					id="roomStatus" name="roomStatus">
					<option value="Available">Available</option>
					<option value="Occupied">Occupied</option>
					<option value="Reserved">Reserved</option>
					<option value="Under Maintenance">Under Maintenance</option>
					<option value="Out of Service">Out of Service</option>
				</select><br> <br> <label for="roomPrice">Room Price:</label> <input
					type="text" id="roomPrice" name="roomPrice" required><br>
				<br> <label for="staffInCharge">Staff In Charge:</label> <select
					id="staffInCharge" name="staffInCharge">
					<%
					Connection connStaff = null;
					Statement stmtStaff = null;
					ResultSet rsStaff = null;
					try {
						connStaff = DriverManager.getConnection("jdbc:mysql://localhost:3306/mdresort", "root", "");
						stmtStaff = connStaff.createStatement();
						String staffSql = "SELECT staffID, staffName FROM staff";
						rsStaff = stmtStaff.executeQuery(staffSql);
						while (rsStaff.next()) {
					%>
					<option value="<%=rsStaff.getInt("staffID")%>"><%=rsStaff.getString("staffName")%></option>
					<%
					}
					} catch (Exception e) {
					e.printStackTrace();
					} finally {
					if (rsStaff != null)
					rsStaff.close();
					if (stmtStaff != null)
					stmtStaff.close();
					if (connStaff != null)
					connStaff.close();
					}
					%>
				</select><br> <br>
				<button type="submit">Add Room</button>
			</form>


		</div>
	</div>
</body>
</html>
