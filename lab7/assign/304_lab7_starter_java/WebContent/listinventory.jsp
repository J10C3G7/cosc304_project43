<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<%@ include file="authadmin.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<title>The Nostalgic Gamer Order List</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="col-md-12" align="center">
	<%@ include file="header.jsp" %>
<div style="margin:0 auto;text-align:center;display:inline">
<h1>Order List</h1>

<%
Locale.setDefault(new Locale("en","CA"));
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
//Note: Forces loading of SQL Server driver
try{	
	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e){
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection
try ( Connection con = DriverManager.getConnection(url, uid, pw);
      Statement stmt = con.createStatement();) {

	// Write query to retrieve all order summary records
	// For each order in the ResultSet
	ResultSet rst = stmt.executeQuery("SELECT productId, productName, productPrice FROM product");
	
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	PreparedStatement pstmt = null; 
	ResultSet rst_2 = null;
	
	String sql = "SELECT warehouseId, quantity, price FROM productinventory WHERE productId = ?";
	
	// Print out the order summary information	
	out.println("<font face=\"Century Gothic\" size=\"2\"><table class=\"table table-hover\" border=\"1\" style=\"display:inline\"><tbody><tr><th>Product ID</th><th>Product Name</th><th>Price</th></tr>");
	while (rst.next()){
		out.println("<tr><td>"+rst.getInt(1)+"</td><td>"+rst.getString(2)+"</td><td>"+currFormat.format(rst.getDouble(3))+"</td></tr>");
		out.println("<tr align=right><td colspan=5><table class=\"table table-hover\" border=\"1\"><tbody><tr><th>Warehouse Id</th><th>Quantity</th><th>Price</th></tr>");
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, rst.getInt(1));
		rst_2 = pstmt.executeQuery();
		while(rst_2.next())
			out.println("<tr><td>"+rst_2.getInt(1)+"</td>"+"<td>"+rst_2.getInt(2)+"</td>"+"<td>"+currFormat.format(rst_2.getDouble(3))+"</td></tr>");
		out.println("</tbody></table></td></tr>");
	}
	out.println("</tbody></table></font></tr>");
}
catch (SQLException ex) {
 	out.println(ex); 
}
// Close connection
%>
</div>
</body>
</html>

