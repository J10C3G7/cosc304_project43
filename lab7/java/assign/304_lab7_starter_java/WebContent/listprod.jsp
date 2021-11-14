<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>

<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
Locale.setDefault(new Locale("en","CA"));
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();

//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

try ( Connection con = DriverManager.getConnection(url, uid, pw);
      Statement stmt = con.createStatement();) {
	String sql = "SELECT * FROM product";
	String link = null;
	Boolean boolean_Name = name != null && !name.equals("");
	PreparedStatement pstmt=null;
	ResultSet rst = null;
	
	if(!boolean_Name){
		out.println("<h2>All Products</h2>");
		out.println("<table><tr><th></th><th>Product Name</th><th>Price</th></tr>");
		pstmt = con.prepareStatement(sql);
		rst = pstmt.executeQuery();
		while (rst.next()){
			link = "addcart.jsp?id="+rst.getInt(1)+"&name="+rst.getString(2)+"&price="+rst.getDouble(3);
			out.println("<tr><td><a href=\""+link+"\">Add to Cart</a></td><td>"+rst.getString(2)+"</td><td>"+currFormat.format(rst.getDouble(3))+"</td></tr>");
		}
		out.println("</table>");
	}
	else{
		out.println("<h2>Products containing '"+name+"'</h2>");
		out.println("<table><tr><th></th><th>Product Name</th><th>Price</th></tr>");
		name = "%"+name+"%";
		sql += " WHERE productName LIKE ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, name);
		rst = pstmt.executeQuery();
		while (rst.next()){
			link = "addcart.jsp?id="+rst.getInt(1)+"&name="+rst.getString(2)+"&price="+rst.getDouble(3);
			out.println("<tr><td><a href=\""+link+"\">Add to Cart</a></td><td>"+rst.getString(2)+"</td><td>"+currFormat.format(rst.getDouble(3))+"</td></tr>");
		}
		out.println("</table>");
	}	
}
catch (SQLException ex) {
 	out.println(ex); 
}
// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection

// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>