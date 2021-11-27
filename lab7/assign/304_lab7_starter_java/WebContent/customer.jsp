<%@ page import="java.util.Locale" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<title>The Nostalgic Gamer - Customer Page</title>
	<style>
		table, tr, th, td {
		  border: 1px solid black;
		}
	</style>
</head>
<body>

<%@ include file="header.jsp" %>

<% String userName = (String) session.getAttribute("authenticatedUser"); %>

<%
	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";

	//Note: Forces loading of SQL Server driver
	try {	
		// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	} catch (java.lang.ClassNotFoundException e) {
		out.println("ClassNotFoundException: " +e);
	}

	try ( Connection con = DriverManager.getConnection(url, uid, pw);
			Statement stmt = con.createStatement();) 
	{
		out.println("<h2>Customer Profile</h2>");

		// TODO: Print Customer information
		String sql_selectCustomer = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid FROM customer WHERE userID = ?";
		PreparedStatement pstmt = con.prepareStatement(sql_selectCustomer);
		pstmt.setString(1, userName);
    	ResultSet rst = pstmt.executeQuery();
		
		if(rst.next() == false) {
			out.println("<h3>Error: Invalid Username</h3>");
		} else {
			out.print("<table><tbody>"+
				"<tr><th>Id</th><td>"+rst.getInt("customerId")+"</td></tr>"+
				"<tr><th>First Name</th><td>"+rst.getString("firstName")+"</td></tr>"+
				"<tr><th>Last Name</th><td>"+rst.getString("lastName")+"</td></tr>"+
				"<tr><th>Email</th><td>"+rst.getString("email")+"</td></tr>"+
				"<tr><th>Phone</th><td>"+rst.getString("phonenum")+"</td></tr>"+
				"<tr><th>Address</th><td>"+rst.getString("address")+"</td></tr>"+
				"<tr><th>City</th><td>"+rst.getString("city")+"</td></tr>"+
				"<tr><th>State</th><td>"+rst.getString("state")+"</td></tr>"+
				"<tr><th>Postal Code</th><td>"+rst.getString("postalCode")+"</td></tr>"+
				"<tr><th>Country</th><td>"+rst.getString("country")+"</td></tr>"+
				"<tr><th>User id</th><td>"+rst.getString("userid")+"</td></tr>"+
				"</tbody></table>");
		}
		

	} catch (SQLException ex) {
		out.println(ex); 
	}
%>

<h2><a href="index.jsp">Back to Main Page</a></h2>
</body>
</html>

