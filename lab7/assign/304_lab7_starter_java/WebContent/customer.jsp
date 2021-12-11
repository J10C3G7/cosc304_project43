<%@ page import="java.util.Locale" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp"%>

<!DOCTYPE html>
<html style="background-color:#9eb4ff">
<head>
	<title>Nostalgic Gaming - Customer Page</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="col-md-12" align="center">
	<%@ include file="header.jsp" %>
	<div class = "row" style="background-color:#9eb4ff">

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
		String sql_selectCustomer = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, admin FROM customer WHERE userID = ?";
		PreparedStatement pstmt = con.prepareStatement(sql_selectCustomer);
		pstmt.setString(1, userName);
    	ResultSet rst = pstmt.executeQuery();
		

		if(rst.next() == false){
			out.println("<h3>Error: Invalid Username</h3>");
		} else {
			out.println("<table style=\"display:inline\"><tbody><font face=\"Century Gothic\" size=\"2\">"+
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
				"<tr><th>Admin</th><td>"+rst.getString("admin")+"</td></tr>"+
				"</font></tbody></table>");
			
			String editLink = "editcustomer.jsp";
			out.println("<h3><a style=\"color:#333333\" href=\""+editLink+"\">Edit Account Information</a></h3>");

			String link = "listcustomerorder.jsp?id="+rst.getInt(1);
			out.println("<h3><a style=\"color:#333333\" href=\""+link+"\">List My Orders</a></h3>");
		}
		

	} catch (SQLException ex) {
		out.println(ex); 
	}
%>

<h3><a style="color:#333333" href="index.jsp">Back to Main Page</a></h3>
</div>
</body>
</html>

