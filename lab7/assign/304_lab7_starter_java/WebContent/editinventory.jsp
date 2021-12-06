<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="authadmin.jsp"%>

<html>
<head>
	<title>The Nostalgic Gamer</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>


<body>
<%@ include file="header.jsp" %>
<div style="margin:0 auto;text-align:center;display:inline">

	<h1>Add Inventory, All Fields Must Be Filled:</h1>
    <br>
    <form method="get" action="editinventory.jsp">
        <table style="display:inline">
            <tbody>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Product Id:</font></div></td>
            <td><input type="text" name="productId" size="6" maxlength="6"></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Warehouse Id:</font></div></td>
            <td><input type="text" name="warehouseId" size="3" maxlength="3"></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Quantity:</font></div></td>
            <td><input type="text" name="quantity" size="10" maxlength="10"></td>
        </tr>
        <tr>
            <td></td><td align="center"><input type="submit" value="Submit"><input type="reset" value="Reset"></td>
        </tr>
        </tbody>
        </table>

        </form>
    </br>

    <%
    String prodId = request.getParameter("productId");
    String wareId = request.getParameter("warehouseId");
    String quantity = request.getParameter("quantity");
    String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
    String uid = "SA";
    String pw = "YourStrong@Passw0rd";

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
        Boolean bool_prodId = prodId != null && !prodId.equals("");
        Boolean bool_wareId = wareId != null && !wareId.equals("");
        Boolean bool_quantity = quantity != null && !quantity.equals("");

        String sql_in = "INSERT INTO productinventory (productId, warehouseId, quantity, price) VALUES (?, ?, ?, ?)";
        String sql_up = "UPDATE productinventory SET quantity = "+quantity+", price = ? WHERE productId = "+prodId+" AND warehouseId = "+wareId;
        PreparedStatement pstmt=null;
        ResultSet rst = null;
        if(bool_prodId){
            if(bool_wareId){
                if(bool_quantity){
                    String sql_prod = "SELECT productId FROM product WHERE productId = " + prodId;
                    pstmt = con.prepareStatement(sql_prod);
                    rst = pstmt.executeQuery();

                    if(rst.next()  == true){
                        sql_prod = "SELECT warehouseId FROM warehouse WHERE warehouseId = " + wareId;
                        pstmt = con.prepareStatement(sql_prod);
                        rst = pstmt.executeQuery();

                        if(rst.next() == true){
                            sql_prod = "SELECT productId FROM productinventory WHERE productId = " + prodId + " AND warehouseId= " + wareId;
                            pstmt = con.prepareStatement(sql_prod);
                            rst = pstmt.executeQuery();
                    
                            if(rst.next() == false){
                                sql_prod = "SELECT productPrice FROM product WHERE productId = " + prodId;
                                pstmt = con.prepareStatement(sql_prod);
                                rst = pstmt.executeQuery();
                                rst.next();
                                String val1 = ""+prodId;
                                String val2 = "" + wareId;
                                String val3 = "" + quantity;
                                String val4 = "" + rst.getDouble(1);
                                //out.println("<h2>"+val+"</h2>");

                                pstmt = con.prepareStatement(sql_in);
                                pstmt.setString(1, val1);
                                pstmt.setString(2, val2);
                                pstmt.setString(3, val3);
                                pstmt.setString(4, val4);
                                pstmt.executeUpdate();
                                out.println("<h2>Inventory Change Has Been Made</h2>");
                            }else{
                                sql_prod = "SELECT productPrice FROM product WHERE productId = " + prodId;
                                pstmt = con.prepareStatement(sql_prod);
                                rst = pstmt.executeQuery();
                                rst.next();
                                String val1 = ""+ rst.getDouble(1);
                                //out.println("<h2>Product Has Been Added</h2>");
                                pstmt = con.prepareStatement(sql_up);
                                pstmt.setString(1, val1);
                                pstmt.executeUpdate();
                                out.println("<h2>Inventory Change Has Been Made</h2>");
                            }
                        }else{
                            out.println("<h2>Invalid Warehouse Id</h2>");
                        }
                    }else{
                        out.println("<h2>Invalid Product Id</h2>");
                    }
                    	
                }else{
                    out.println("<h2>Enter Product Id, Warehouse Id, Quantity</h2>");
                }
                
            }else{
                out.println("<h2>Enter Product Id, Warehouse Id, Quantity</h2>");
            }
            
        }else{
            out.println("<h2>Enter Product Id, Warehouse Id, Quantity</h2>");
        }
    }
    catch (SQLException ex) {
        out.println(ex); 
    }
    %>
</div>
</body>
</html>