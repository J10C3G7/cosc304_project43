<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<html>
<head>
	<title>The Nostalgic Gamer</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>


<body class="col-md-12" align="center">
<%@ include file="header.jsp" %>
<div style="margin:0 auto;text-align:center;display:inline">

	<h1>Browse Products By Category and Search by Product Name:</h1>


    <form method="get" action="deleteproduct.jsp">
    <input type="text" name="productId" size="50">
    <input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
    </form>

    <%
    String pname = request.getParameter("productId");
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
        Boolean bool_pname = pname != null && !pname.equals("");
        String sql = "DELETE FROM product WHERE productId = " + pname;
        PreparedStatement pstmt=null;
        if(!bool_pname){
            out.println("<h2>Please Enter product Id</h2>");
        }
        else{
            pstmt = con.prepareStatement(sql);
            pstmt.executeUpdate();
            out.println("<h2>Product Has Been Removed.</h2>");
        }	
    }
    catch (SQLException ex) {
        out.println(ex); 
    }
    %>
</div>
</body>
</html>