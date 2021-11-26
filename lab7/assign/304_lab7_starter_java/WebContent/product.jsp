<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.Locale" %>

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");
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
    String sql = "SELECT productName, productImageURL, productImage, productId, productPrice FROM product WHERE productId = "+productId;
    String link;
    PreparedStatement pstmt= con.prepareStatement(sql);
    ResultSet rst = pstmt.executeQuery();
    rst.next();
    out.println("<h2>"+rst.getString(1)+"</h2>");
    // TODO: If there is a productImageURL, display using IMG tag
    if(rst.getString(2)!=null)
        out.println("<img src=\""+rst.getString(2)+"\">");
    // TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
    if(rst.getBytes(3) != null){
        link = "displayImage.jsp?id="+rst.getInt(4);
        out.println("<img src=\""+link+"\">");        
    }
    out.println("<table><tbody><tr><th>Id</th><td>"+rst.getInt(4)+"</td></tr><tr><th>Price</th><td>"+currFormat.format(rst.getDouble(5))+"</td></tr></tbody></table>");
    // TODO: Add links to Add to Cart and Continue Shopping
    link = "addcart.jsp?id="+rst.getInt(4)+"&name="+rst.getString(1)+"&price="+rst.getDouble(5);
    out.println("<h3><a href=\""+link+"\">Add to Cart</a></h3>");
}catch (SQLException ex) {
    out.println(ex); 
}
%>

<h3>
    <a href="listprod.jsp">Continue Shopping</a>
</h3>
</body>
</html>

