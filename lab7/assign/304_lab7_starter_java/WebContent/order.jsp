<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Locale" %>
<%@	page import="java.text.SimpleDateFormat" %> 
<%@	page import="java.util.Date" %>
<%@ include file="logoutadmin.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<title>The Nostalgic Gamer Order Processing</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="col-md-12" align="center">
	<%@ include file="header.jsp" %>
<div style="margin:0 auto;text-align:center;display:inline">
<% 
// Get customer id
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
String custId = request.getParameter("customerId");
String custName = null;
Locale.setDefault(new Locale("en","CA"));
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

// Determine if valid customer id was entered
// Determine if there are products in the shopping cart
// If either are not true, display an error message
int authenticatedUser = 0;
String sql = "SELECT * FROM customer";
try(Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();){
	ResultSet rst = stmt.executeQuery(sql);
	while(rst.next()){
		if(custId.equals(""+rst.getInt(1))){
			authenticatedUser = Integer.parseInt(custId);
			custName = rst.getString(2) +" "+ rst.getString(3);
		}
	}
	if(authenticatedUser == 0){
		out.println("<h1>Invalid customer id. Go back to previous page and try again.</h1>");
	}
	else{
		if(productList == null){
			out.println("<h1>Your shopping cart is empty!</h1>");
		}
		else{
			// Save order information to database
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
    		Date date = new Date(); 
			sql = "INSERT INTO ordersummary (customerId, orderDate) VALUES ("+authenticatedUser+", '"+formatter.format(date)+"')";

			// Use retrieval of auto-generated keys.
			stmt.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);			
			ResultSet keys = stmt.getGeneratedKeys();
			keys.next();
			int orderId = keys.getInt(1);
			double totalAmount = 0.0;

			Map.Entry<String, ArrayList<Object>> entry = null;
			ArrayList<Object> product = null;
			String productId = null;
			String price = null;
			double pr = 0.0;
			int qty = 0;
			PreparedStatement pstmt = null;
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			while (iterator.hasNext())
			{ 
				// Here is the code to traverse through a HashMap
				// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price
				entry = iterator.next();
				product = (ArrayList<Object>) entry.getValue();
				productId = (String) product.get(0);
				price = (String) product.get(2);
				pr = Double.parseDouble(price);
				qty = ((Integer)product.get(3)).intValue();

				// Insert each item into OrderProduct table using OrderId from previous INSERT
				sql = "INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, ""+orderId);
				pstmt.setString(2, productId);
				pstmt.setString(3, ""+qty);
				pstmt.setString(4, ""+pr);
				pstmt.executeUpdate();
				
				totalAmount += (pr * qty);
			}

			// Update total amount for order record
			sql = "UPDATE ordersummary SET totalAmount = "+totalAmount;
			stmt.executeUpdate(sql);

			// Print out order summary
			totalAmount = 0.0;
			sql = "SELECT A.productId, productName, quantity, price FROM orderproduct A JOIN product B ON A.productId = B.productId WHERE A.orderId = "+orderId;
			rst = stmt.executeQuery(sql);
			out.println("<table style=\"display:inline\"><tbody><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");
			while(rst.next()){
				out.println("<tr><td>"+rst.getInt(1)+"</td>"+"<td>"+rst.getString(2)+"</td><td align=center>"+rst.getInt(3)+"</td><td align=right>"+currFormat.format(rst.getDouble(4))+"</td><td align=right>"+currFormat.format(rst.getDouble(4)*rst.getInt(3))+"</td></tr>");
				totalAmount += rst.getDouble(4)*rst.getInt(3);
			}
			out.println("<tr><td colspan=4 align=right><b>Order Total</b></td><td align=right>"+currFormat.format(totalAmount)+"</td></tr>");
			out.println("</tbody></table>");
			out.println("<h1>Order completed.  Will be shipped soon...</h1>");
			out.println("<h1>Your order reference number is : "+orderId+"</h1>");
			out.println("<h1>Shipping to customer: "+custId+" Name: "+custName+"</h1>");
			out.println("<h2><a href=\"index.jsp\">Return to shopping</a></h2>");
			// Clear cart if order placed successfully
			session.removeAttribute("productList");
		}
	}
}
catch(IOException e) { out.println(e); }
catch(NumberFormatException f){out.println(f);}

%>

</div>
</body>
</html>

