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

	<h1>Add a Product:</h1>
    <br>
    <form method="get" action="addproduct.jsp">
        <table style="display:inline">
            <tbody>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Product Name:</font></div></td>
            <td><input type="text" name="productName" size="40" maxlength="40"></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Category ID:</font></div></td>
            <td><input type="text" name="categoryId" size="3" maxlength="3"></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Product Price:</font></div></td>
            <td><input type="text" name="productPrice" size="10" maxlength="10"></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Product Image URL:</font></div></td>
            <td><input type="text" name="productImageURL" size="50" maxlength="100"></td>
        </tr>
        <tr>
            <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Product Description:</font></div></td>
            <td><input type="text" name="productDesc" size="50" maxlength="1000"></td>
        </tr>
        <tr>
            <td></td><td align="center"><input type="submit" value="Submit"><input type="reset" value="Reset"></td>
        </tr>
        </tbody>
        </table>

        </form>
    </br>

    <%
    String prodName = request.getParameter("productName");
    String prodPrice = request.getParameter("productPrice");
    String prodImage = request.getParameter("productImageURL");
    String prodDesc = request.getParameter("productDesc");
    String catId = request.getParameter("categoryId");
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
        Boolean bool_prodName = prodName != null && !prodName.equals("");
        Boolean bool_prodPrice = prodPrice != null && !prodPrice.equals("");
        Boolean bool_prodImage = prodImage != null && !prodImage.equals("");
        Boolean bool_prodDesc = prodDesc != null && !prodDesc.equals("");
        Boolean bool_catId = catId != null && !catId.equals("");
        String attr = "INSERT product (productName";
        String sql = " VALUES (";
        PreparedStatement pstmt=null;
        if(bool_prodName){
            if(bool_catId){
                if(bool_prodPrice){
                    if(bool_prodDesc){
                        sql += "'"+prodName+"'";
                        //out.println("<h2>Product Has Been Added</h2>");
                        sql += ", " + catId;
                        attr += ", categoryId";
                        sql += ", " + prodPrice;
                        attr += ", productPrice";
                        sql += ", " + "'" +prodDesc+ "'";
                        attr += ", productDesc";

                        if(bool_prodImage){
                            sql += ", " + "'"+prodImage+"'";
                            attr += ", productImageURL";
                        }
            
            
                        sql += ")";
                        attr += ")";
                        attr += sql;
                        pstmt = con.prepareStatement(attr);
                        //pstmt.setString(1, attr);
                        pstmt.executeUpdate();
                        out.println("<h2>Product Has Been Added</h2>");	
                    }
                    
                }
                
            }
            
        }else{
            out.println("<h2>Enter Product Name, Category ID, Product Price, Product Description, Other Information is optional</h2>");
        }
    }
    catch (SQLException ex) {
        out.println(ex); 
    }
    %>
</div>
</body>
</html>