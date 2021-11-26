<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Locale" %>
<%@ include file="jdbc.jsp" %>

<html>
	<head>
		<title>The Nostalgic Gamer - Shipment Processing</title>
	</head>
	<body>
			
	<%@ include file="header.jsp" %>

	<%
		// TODO: Get order id
		String orderId = request.getParameter("orderId");

		Locale.setDefault(new Locale("en","CA"));
		String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
		String uid = "SA";
		String pw = "YourStrong@Passw0rd";
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		
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
			// TODO: Check if valid order id
			String sql_validateOrder = "SELECT orderId FROM ordersummary WHERE orderId = ?";
			PreparedStatement pstmt_validateOrder = con.prepareStatement(sql_validateOrder);
			pstmt_validateOrder.setInt(1, Integer.parseInt(orderId));
			ResultSet rst_validateOrder = pstmt_validateOrder.executeQuery();

			if(rst_validateOrder.next() == false) {
				out.println("OrderId is invalid. No such order exists.");

			} else {
				// String orderId = rst_validateOrder.getString("orderId");
				

				// TODO: Start a transaction (turn-off auto-commit)
				try {
					con.setAutoCommit(false);
				} catch (SQLException e) {
					out.println("Error disabling auto-commit");
				}
				

				// TODO: Retrieve all items in order with given id
				String sql_selectProducts = "SELECT P.productId, P.quantity, I.quantity AS prevInv, I.quantity - P.quantity AS newInv FROM orderproduct P, productinventory I WHERE P.productId = I.productId AND warehouseId = ? AND orderId = ?";

				PreparedStatement pstmt_selectProducts = con.prepareStatement(sql_selectProducts);
				pstmt_selectProducts.setInt(1, 1);  // warehouseId
				pstmt_selectProducts.setInt(2, Integer.parseInt(orderId));
				ResultSet rst_selectProducts = pstmt_selectProducts.executeQuery();
				

				// TODO: Create a new shipment record.
				String sql_createShip = "DECLARE @shipmentId int; INSERT INTO shipment (shipmentDate, shipmentDesc, warehouseId) VALUES (?, ?, ?)";

				PreparedStatement pstmt_createShip = con.prepareStatement(sql_createShip);
				pstmt_createShip.setTimestamp(1, new java.sql.Timestamp((new Date()).getTime()));
				pstmt_createShip.setString(2, "N/A");
				pstmt_createShip.setInt(3, 1);

				pstmt_createShip.executeUpdate();


				// TODO: For each item verify sufficient quantity available in warehouse 1.
				// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
				String sql_updateInventory = "UPDATE productinventory SET quantity = quantity - ? WHERE productId = ? AND warehouseId = ?";
				PreparedStatement pstmt_updateInventory = con.prepareStatement(sql_updateInventory);

				boolean allSufficientInventory = true;
				int insufficientProductId = 0;
				while (rst_selectProducts.next()) {  // for each product in order...
					if(rst_selectProducts.getInt("newInv") >= 0) {  // if there is sufficient inventory
						// then update inventory for that product
						pstmt_updateInventory.setInt(1, rst_selectProducts.getInt("quantity"));
						pstmt_updateInventory.setInt(2, rst_selectProducts.getInt("productId"));
						pstmt_updateInventory.setInt(3, 1);  // warehouseId
						pstmt_updateInventory.executeUpdate();

						out.println("<h2>Ordered Product: " + rst_selectProducts.getInt("productId") + "\tQty: " + rst_selectProducts.getInt("quantity") + 
								"\tPrevious inventory: " + rst_selectProducts.getInt("prevInv") + "\tNew inventory: " + rst_selectProducts.getInt("newInv") + "</h2>");
					
					} else {  // if there is insufficient inventory
						allSufficientInventory = false;
						insufficientProductId = rst_selectProducts.getInt("productId");
						break;
					}
				}
				if(allSufficientInventory) {
					out.println("<h1>Shipment successfully processed.</h1>");
					con.commit();

				} else {
					out.println("<h1>Shipment not done.  Insufficient inventory for product id: " + insufficientProductId + "</h1>");
					con.rollback();
				}


				// TODO: Auto-commit should be turned back on
				con.setAutoCommit(true);

			}
		} catch (SQLException ex) {
			out.println(ex); 
		}
	%>                       				

	<h2><a href="shop.html">Back to Main Page</a></h2>
	</body>
</html>
