<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Profile</title>
   
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
    <!-- Success Message after Profile Update -->
    <%
        if ("success".equals(request.getParameter("update"))) {
    %>
        <div class="success-message">
            <p>Your profile was successfully updated!</p>
        </div>
    <%
        }
    %>

    <!-- Error Handling for Empty Field or Update Failure -->
    <%
        String error = request.getParameter("error");
        if (error != null) {
    %>
        <div class="error-message">
            <p style="color: red;">
                <%
                    if ("emptyField".equals(error)) {
                %>
                    Please fill in the field.
                <%
                    } else if ("updateFailed".equals(error)) {
                %>
                    Failed to update profile. Please try again.
                <%
                    } else if ("exception".equals(error)) {
                %>
                    An error occurred while updating your profile.
                <%
                    } else {
                %>
                    Unknown error occurred.
                <%
                    }
                %>
            </p>
        </div>
    <%
        }
    %>

    <!-- Profile Header -->
    <section class="profile-header">
        <img src="Profile.png" alt="MD Resort Logo" style=" width: 45px; height: auto;">
        <h2>@<%= (request.getAttribute("staffName") != null) ? request.getAttribute("staffName") : "N/A" %></h2>
        <p><%= (request.getAttribute("staffEmail") != null) ? request.getAttribute("staffEmail") : "N/A" %></p>
    </section>

    <!-- User Profile Section -->
    <section class="card">
        <h3>Admin Profile</h3>
        <div class="info">
            <span>Username:</span>
            <span>
                <%= (request.getAttribute("staffName") != null) ? request.getAttribute("staffName") : "N/A" %>
                <a href="EditProfile.jsp?field=staffName">Edit</a>
            </span>
        </div>
        <div class="info">
            <span>Email Address:</span>
            <span>
                <%= (request.getAttribute("staffEmail") != null) ? request.getAttribute("staffEmail") : "N/A" %>
                <a href="EditProfile.jsp?field=staffEmail">Edit</a>
            </span>
        </div>
        <div class="info">
            <span>Phone Number:</span>
            <span>
                <%= (request.getAttribute("staffPhoneNo") != null) ? request.getAttribute("staffPhoneNo") : "N/A" %>
                <a href="EditProfile.jsp?field=staffPhoneNo">Edit</a>
            </span>
        </div>
    </section>

    <!-- Security Section -->
    <section class="card">
        <h3>Security</h3>
        <div class="info">
            <span>Password:</span>
            <span>**** <a href="ChangePassword.jsp">Change Password</a></span>
        </div>
        <div class="info">
            <span>Delete Account:</span>
            <a href="DeleteAccount.jsp" style="color: red;">Delete Account</a>
        </div>
    </section>

    <!-- Logout Button -->
    <form action="AdminProfile.jsp?logout=true" method="post">
        <button type="submit" class="btn-logout">LOG OUT</button>
    </form>

    <%
        // Invalidate session if logout parameter is present
        String logout = request.getParameter("logout");
        if ("true".equals(logout)) {
            session.invalidate(); // Invalidate the session
            response.sendRedirect("index.jsp"); // Redirect to Admin Register page
        }
    %>
<style>

/* General Styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

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

/* Profile Section */
.profile-header {
    text-align: center;
    margin: 2em 0;
}

.profile-header img {
    width: 100px;
    height: 100px;
    border-radius: 50%;
}

.profile-header h2 {
    margin: 0.5em 0;
    color: #333;
}

.profile-header p {
    color: #666;
}

/* User Profile & Security Sections */
.card {
    background: #fff;
    border-radius: 5px;
    padding: 1.5em;
    margin: 2em auto;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    max-width: 800px;
}

.card h3 {
    margin-bottom: 1em;
    color: #333;
    border-bottom: 1px solid #ccc;
    padding-bottom: 0.5em;
}

.card .info {
    display: flex;
    justify-content: space-between;
    margin-bottom: 1em;
    align-items: center;
}

.card .info span {
    font-weight: bold;
    color: #333;
}

.card .info a {
    color: blue;
    text-decoration: none;
    font-size: 0.9em;
}

.card .info a:hover {
    text-decoration: underline;
}

/* Logout Button */
.btn-logout {
    display: block;
    margin: 0 auto;
    padding: 0.8em 2em;
    background: red;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 1em;
    cursor: pointer;
}

.btn-logout:hover {
    background: darkred;
}

.success-message {
    background-color: #d4edda;
    color: #155724;
    padding: 10px;
    border-radius: 5px;
    margin-top: 10px;
}

.error-message {
    background-color: #f8d7da;
    color: #721c24;
    padding: 10px;
    border-radius: 5px;
    margin-top: 10px;
}
</style>

</body>
</html>
