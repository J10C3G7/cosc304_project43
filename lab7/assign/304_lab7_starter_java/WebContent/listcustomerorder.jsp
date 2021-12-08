<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>

<!DOCTYPE html>
<html style="background-color:#9eb4ff">
<head>
	<title>Nostalgic Gaming - Order List</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>

<div class = "row" style="background-color:#9eb4ff">
<body class="col-md-12" align="center">
	<%@ include file="header.jsp" %>
	
<h1>Order List</h1>

<%
String custId = request.getParameter("id");
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
	ResultSet rst = stmt.executeQuery("SELECT A.orderId, orderDate, C.customerId, firstName, lastName, totalAmount FROM ordersummary A LEFT Join customer C ON A.customerId = C.customerId WHERE C.customerId = " + custId);
	
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	PreparedStatement pstmt = null; 
	ResultSet rst_2 = null;
	
	String sql = "SELECT * FROM orderproduct WHERE orderproduct.orderId = ?";
	
	// Print out the order summary information	
	out.println("<table class=\"table\" style=\"display:inline\"><font face=\"Century Gothic\" size=\"2\"><tbody><tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
	while (rst.next()){
		out.println("<tr><td>"+rst.getInt(1)+"</td>"+"<td>"+rst.getTimestamp(2)+"</td>"+"<td>"+rst.getInt(3)+"</td>"+"<td>"+rst.getString(4)+" "+rst.getString(5)+"</td>"+"<td>"+currFormat.format(rst.getDouble(6))+"</td></tr>");
		out.println("<tr align=right><td colspan=1></td><td colspan=3><table class=\"table\" border=\"2\" style=\"background-color:#9eb4ff\"><tbody><tr><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, rst.getInt(1));
		rst_2 = pstmt.executeQuery();
		while(rst_2.next()){
			String link = "product.jsp?id="+rst_2.getInt(1);
			out.println("<tr><td><a style=\"color:#333333\" href=\""+link+"\">"+rst_2.getInt(2)+"</a></td>"+"<td>"+rst_2.getInt(3)+"</td>"+"<td>"+currFormat.format(rst_2.getDouble(4))+"</td></tr>");
		}
		out.println("</tbody></table></td><td colspan=1></td></tr>");
	}
	out.println("</tbody></font></table></tr>");
}
catch (SQLException ex) {
 	out.println(ex); 
}
// Close connection
%>

</body>
</div>
</html>

