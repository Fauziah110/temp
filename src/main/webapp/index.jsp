<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="form-container">
        <form action="AdminLoginServlet" method="POST">
        	 <h2>Admin Sign In</h2>
            <input type="text" name="staffName" placeholder="Enter Username" required />
            <input type="password" name="staffPassword" placeholder="Enter Password" required />
            <button type="submit">Sign In</button>
            <p>Don't have an account? <a href="AdminRegister.jsp">Sign Up</a></p>
            
            <!-- Display error messages -->
            <div class="error-message">
                <p style="color: red;">
                    <%
                        String error = request.getParameter("error");
                        if (error != null) {
                            switch (error) {
                                case "invalid":
                                    out.println("Invalid username or password.");
                                    break;
                                case "emptyfields":
                                    out.println("Please fill in both fields.");
                                    break;
                                case "exception":
                                    out.println("An error occurred. Please try again.");
                                    break;
                                default:
                                    out.println("Unexpected error.");
                                    break;
                            }
                        }
                    %>
                </p>
            </div>
        </form>
    </div>
</body>
</html>