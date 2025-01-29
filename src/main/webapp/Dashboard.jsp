<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MD Resort</title>
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

.content {
	padding: 20px;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-wrap: wrap;
	gap: 20px;
}

.content h2 {
	color: black;
	font-size: 28px;
	text-align: center;
	width: 100%;
}

.content .image-section {
	flex: 1;
	max-width: 400px;
}

.content .image-section img {
	max-width: 100%;
	height: auto;
	border-radius: 10px;
}

.content .text-section {
	flex: 1;
	max-width: 700px;
	padding: 10px; /* Add padding for better spacing */
}

.content .text-section p {
	font-size: 16px;
	line-height: 1.5;
	text-align: justify; /* Align text on both sides */
}

footer {
	color: white;
	padding: 20px 0;
	text-align: center;
}

footer .social-icons img {
	width: 40px; /* Set a fixed width */
	height: 40px; /* Set a fixed height */
	margin: 0 10px; /* Add spacing between icons */
	object-fit: contain;
	/* Ensure the image scales properly without distortion */
}

footer .middle-section {
	background-color: #e6e6e1;
	padding: 20px 0;
	color: #5f7268;
}

footer .middle-section a {
	color: #5f7268;
	text-decoration: none;
	margin: 0 10px;
	font-size: 14px;
}

footer .middle-section a:hover {
	text-decoration: underline;
}

footer .middle-section .social-icons {
	margin-top: 20px;
}

.welcome-section {
	text-align: center;
	padding: 50px 20px;
}

.welcome-section h2 {
	font-size: 32px;
	color: black;
}

.welcome-section p {
	font-size: 18px;
	color: black;
	max-width: 800px;
	margin: 20px auto;
	line-height: 1.6;
}

.features {
	display: flex;
	justify-content: center;
	flex-wrap: wrap;
	gap: 30px;
	padding: 20px;
}

.feature {
	background-color: white;
	border-radius: 10px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	padding: 20px;
	max-width: 300px;
	text-align: center;
}

.feature img {
	width: 100px;
	margin-bottom: 15px;
}

.feature h3 {
	font-size: 20px;
	color: black;
	margin-bottom: 10px;
}

.feature p {
	font-size: 16px;
	color: black;
}
</style>
</head>
<body>
	<!-- Top header -->


	<!-- Navigation bar -->
	<nav>
		<a href="Dashboard.jsp" class="logo-link"> <img
			src="Images/MDResort.PNG" alt="Resort Logo" class="logo-image">
			<span class="logo-text">MD Resort Pantai Siring Melaka</span>
			<div class="spacer"></div> <!-- Spacer to center the navigation links -->
			<ul>
				<li><a href="Booking.jsp">Booking</a></li>
				<li><a href="Room.jsp">Room</a></li>
				<li><a href="Service.jsp">Service</a></li>
				<li><a href="Profile.jsp">Profile</a></li>
			</ul>
	</nav>

	<!-- content -->
<body>

	<!-- Main Dashboard Content -->
	<div class="main-content">
		<div class="stats">
			<div class="stat-card">
				<h3>New Bookings</h3>
				<p>5</p>
			</div>
			<div class="stat-card">
				<h3>Total Bookings</h3>
				<p>250</p>
			</div>
			<div class="stat-card">
				<h3>Check-In</h3>
				<p>54</p>
			</div>
			<div class="stat-card">
				<h3>Check-Out</h3>
				<p>50</p>
			</div>
		</div>

		<div class="calendar-container">
			<div class="stats-and-schedule">
				<div class="calendar-content">
					<h3>Recent Booking Schedule</h3>
					<div class="controls">
						<label for="month">Month:</label> <select id="month"
							onchange="generateCalendar()">
							<option value="0">January</option>
							<option value="1">February</option>
							<option value="2">March</option>
							<option value="3">April</option>
							<option value="4">May</option>
							<option value="5">June</option>
							<option value="6">July</option>
							<option value="7">August</option>
							<option value="8">September</option>
							<option value="9">October</option>
							<option value="10">November</option>
							<option value="11">December</option>
						</select> <label for="year">Year:</label> <input type="number" id="year"
							value="2025" onchange="generateCalendar()">
					</div>
					<div class="calendar" id="calendar"></div>
				</div>
				<div class="chart-container">
					<h3>Reservation Stats</h3>
					<canvas id="reservationChart"></canvas>
				</div>
			</div>
		</div>
</body>
</html>
