<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.Locale" %>
<%@ include file="logoutadmin.jsp"%>

<html>
<head>
<title>The Nostalgic Gamer - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="col-md-12" align="center">
	<%@ include file="header.jsp" %>
<div style="margin:0 auto;text-align:center;display:inline">

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");
Locale.setDefault(new Locale("en","CA"));
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
String link;

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
    String sql = "SELECT productName, productImageURL, productId, productPrice, productImage, productDesc FROM product WHERE productId = "+productId;
    
    PreparedStatement pstmt= con.prepareStatement(sql);
    ResultSet rst = pstmt.executeQuery();
    rst.next();
    out.println("<h2>"+rst.getString(1)+"</h2>");
    out.println("<table class=\"table\" align=\"center\" style=\"display:inline\"><tbody>");
    // TODO: If there is a productImageURL, display using IMG tag
    if(rst.getString(2)!=null)
        out.print("<tr><td><img src=\""+rst.getString(2)+"\"></td></tr>");
    // TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
    if(rst.getBytes(5) != null){
        link = "displayImage.jsp?id="+rst.getInt(3);
        out.println("<tr><td><img src=\""+link+"\"></td></tr>");
    }
    out.println("<tr><th>Id:</th><td>"+rst.getInt(3)+"</td></tr><tr><th>Price:</th><td>"+currFormat.format(rst.getDouble(4))+"</td></tr><tr><th>Description:</th><td>"+rst.getString(6)+"</td></tr><tr><th>Inventory:</th>");
    
    out.println("<td colspan=5><table class=\"table table-hover\" border=\"1\"><tbody><tr><th>Warehouse Id</th><th>Quantity</th></tr>");
    sql = "SELECT warehouseid, quantity FROM productinventory WHERE productId = "+productId;
    pstmt = con.prepareStatement(sql);
    ResultSet rst_2 = pstmt.executeQuery();
    while(rst_2.next())
        out.println("<tr><td>"+rst_2.getInt(1)+"</td>"+"<td>"+rst_2.getInt(2)+"</td></tr>");
    out.println("</tbody></table></td></tr>");
    out.println("</tbody></table>");
    // TODO: Add links to Add to Cart and Continue Shopping
    link = "addcart.jsp?id="+rst.getInt(3)+"&name="+rst.getString(1)+"&price="+rst.getDouble(4);
    out.println("<h4><a href=\""+link+"\">Add to Cart</a></h4>");
}catch (SQLException ex) {
    out.println(ex); 
}
%>

<h4>
    <a href="listprod.jsp">Continue Shopping</a>
</h4>
<%
    out.println("<h4><a href=\"addreview.jsp?id="+productId+"\">Add a Review</a></h4>");
try ( Connection con = DriverManager.getConnection(url, uid, pw);
      Statement stmt = con.createStatement();) {
    String sql = "SELECT C.customerId, firstName, lastName, reviewRating, reviewComment FROM review R JOIN customer C ON R.customerId = C.customerId WHERE productId = "+productId;
    PreparedStatement pstmt= con.prepareStatement(sql);
    ResultSet rst = pstmt.executeQuery();
    out.println("<table class=\"table\" align=\"center\" style=\"display:inline\"><tbody><tr><th>Cust ID</th><th>Customer Name</th><th>Review Rating</th><th>Review</th></tr>");
    while(rst.next()){
        out.println("<tr><td>"+rst.getInt(1)+"</td>"+
        "<td>"+rst.getString(2)+" "+rst.getString(3)+"</td><td>"+rst.getInt(4)+"</td><td>"+rst.getString(5)+"</td>");
    }
    out.println("</tbody></table>");
}catch (SQLException ex) {
    out.println(ex); 
}
%>


</div>
</body>
</html>

