<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>


<html>
<head>
	<title>The Nostalgic Gamer</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%@ include file="header.jsp" %>
<h1>Browse Products By Category and Search by Product Name:</h1>

<form method="get" action="listprod.jsp">
	<select size="1" name="categoryName">
		<option>All</option>
		<option>Beverages</option>
		<option>Condiments</option>
		<option>Confections</option>
		<option>Dairy Products</option>
		<option>Grains/Cereals</option>
		<option>Meat/Poultry</option>
		<option>Produce</option>
		<option>Seafood</option>       
	</select>
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String pname = request.getParameter("productName");
String cname = request.getParameter("categoryName");
String temp1, temp2;
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
	String sql = "SELECT productId, productName, C.categoryName, productPrice FROM product P JOIN category C ON P.categoryId = C.categoryId";
	String link = null;
	String link2 = null;
	Boolean boolean_Pname = pname != null && !pname.equals("");
	Boolean boolean_Cname = cname != null && !cname.equals("All");
	PreparedStatement pstmt=null;
	ResultSet rst = null;
	
	if(!boolean_Pname){
		if(!boolean_Cname){
			out.println("<h2>All Products</h2>");
			out.println("<font face=\"Century Gothic\" size=\"2\"><table class=\"table\" border=\"1\"><tr><th></th><th>Product Name</th><th>Category</th><th>Price</th></tr>");
			pstmt = con.prepareStatement(sql);
			rst = pstmt.executeQuery();
			while (rst.next()){
				link = "addcart.jsp?id="+rst.getInt(1)+"&name="+rst.getString(2)+"&price="+rst.getDouble(4);
				link2 = "product.jsp?id="+rst.getInt(1);
				out.println("<tr><td><a href=\""+link+"\">Add to Cart</a></td><td><a href=\""+link2+"\">"+rst.getString(2)+"</a></td><td>"+rst.getString(3)+"</td><td>"+currFormat.format(rst.getDouble(4))+"</td></tr>");
		
			}
			out.println("</table></font>");
		}
		else{
			out.println("<h2>Products in category: '"+cname+"'</h2>");
			out.println("<font face=\"Century Gothic\" size=\"2\"><table class=\"table\" border=\"1\"><tr><th></th><th>Product Name</th><th>Category</th><th>Price</th></tr>");
			temp1 = "%"+cname+"%";
			sql += " WHERE categoryName LIKE ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, temp1);
			rst = pstmt.executeQuery();
			while (rst.next()){
				link = "addcart.jsp?id="+rst.getInt(1)+"&name="+rst.getString(2)+"&price="+rst.getDouble(4);
				link2 = "product.jsp?id="+rst.getInt(1);
				out.println("<tr><td><a href=\""+link+"\">Add to Cart</a></td><td><a href=\""+link2+"\">"+rst.getString(2)+"</a></td><td>"+rst.getString(3)+"</td><td>"+currFormat.format(rst.getDouble(4))+"</td></tr>");
			}
			out.println("</table></font>");
		}

	}
	else{
		if(!boolean_Cname){
			out.println("<h2>Products containing '"+pname+"'</h2>");
			out.println("<font face=\"Century Gothic\" size=\"2\"><table class=\"table\" border=\"1\"><tr><th></th><th>Product Name</th><th>Category</th><th>Price</th></tr>");
			temp1 = "%"+pname+"%";
			sql += " WHERE productName LIKE ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, temp1);
			rst = pstmt.executeQuery();
			while (rst.next()){
				link = "addcart.jsp?id="+rst.getInt(1)+"&name="+rst.getString(2)+"&price="+rst.getDouble(4);
				link2 = "product.jsp?id="+rst.getInt(1);
				out.println("<tr><td><a href=\""+link+"\">Add to Cart</a></td><td><a href=\""+link2+"\">"+rst.getString(2)+"</a></td><td>"+rst.getString(3)+"</td><td>"+currFormat.format(rst.getDouble(4))+"</td></tr>");
			}
			out.println("</table></font>");
		}
		else{
			out.println("<h2>Products containing '"+pname+"' in category: '"+cname+"'</h2>");
			out.println("<font face=\"Century Gothic\" size=\"2\"><table class=\"table\" border=\"1\"><tr><th></th><th>Product Name</th><th>Category</th><th>Price</th></tr>");
			temp1 = "%"+pname+"%";
			temp2 = "%"+cname+"%";
			sql += " WHERE productName LIKE ? AND categoryName LIKE ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, temp1);
			pstmt.setString(2, temp2);
			rst = pstmt.executeQuery();
			while (rst.next()){
				link = "addcart.jsp?id="+rst.getInt(1)+"&name="+rst.getString(2)+"&price="+rst.getDouble(4);
				link2 = "product.jsp?id="+rst.getInt(1);
				out.println("<tr><td><a href=\""+link+"\">Add to Cart</a></td><td><a href=\""+link2+"\">"+rst.getString(2)+"</a></td><td>"+rst.getString(3)+"</td><td>"+currFormat.format(rst.getDouble(4))+"</td></tr>");
			}
			out.println("</table></font>");
		}
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