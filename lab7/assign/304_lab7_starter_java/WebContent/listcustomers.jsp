<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="authadmin.jsp"%>

<html>
<head>
	<title>The Nostalgic Gamer- Customer List</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="col-md-12" align="center">
    <%@ include file="header.jsp" %>
    <div style="margin:0 auto;text-align:center;display:inline">
    	<h1>Search by Customer ID:</h1>

	<form method="get" action="listcustomers.jsp">
	<input type="text" name="customerId" size="50">
	<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
	</form>

    <% // Get product name to search for
String pname = request.getParameter("customerId");
String temp1;
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
	String sql = "SELECT * FROM customer";
	String link = null;
	String link2 = null;
	Boolean boolean_custId = pname != null && !pname.equals("");
	PreparedStatement pstmt=null;
	ResultSet rst = null;
	
	if(!boolean_custId){
			out.println("<h2>All Products</h2>");
			out.println("<font face=\"Century Gothic\" size=\"2\"><table class=\"table table-hover\" border=\"1\" style=\"display:inline\"><tr>"+
                "<th>Customer ID</th><th>Customer Name</th><th>email</th><th>Phone Number</th><th>Address</th>"+
                "<th>City</th><th>State</th><th>Postal Code</th><th>Country</th><th>User ID</th><th>Password</th></tr>");
			pstmt = con.prepareStatement(sql);
			rst = pstmt.executeQuery();
			while (rst.next()){
				out.println("<tr><td>"+rst.getInt(1)+"</td><td>"+rst.getString(2)+" "+rst.getString(3)+"</a></td>"+
                    "<td>"+rst.getString(4)+"</td><td>"+rst.getString(5)+"</td><td>"+rst.getString(6)+"</td>"+
                    "<td>"+rst.getString(7)+"</td><td>"+rst.getString(8)+"</td><td>"+rst.getString(9)+"</td>"+
                    "<td>"+rst.getString(10)+"</td><td>"+rst.getString(11)+"</td><td>"+rst.getString(12)+"</td></tr>");
			}
			out.println("</table></font>");
	}
	else{
        out.println("<font face=\"Century Gothic\" size=\"2\"><table class=\"table table-hover\" border=\"1\" style=\"display:inline\"><tr>"+
            "<th>Customer ID</th><th>Customer Name</th><th>email</th><th>Phone Number</th><th>Address</th>"+
            "<th>City</th><th>State</th><th>Postal Code</th><th>Country</th><th>User ID</th><th>Password</th></tr>");
			temp1 = "%"+pname+"%";
			sql += " WHERE customerId LIKE ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, temp1);
			rst = pstmt.executeQuery();
			while (rst.next()){
                out.println("<tr><td>"+rst.getInt(1)+"</td><td>"+rst.getString(2)+" "+rst.getString(3)+"</td>"+
                    "<td>"+rst.getString(4)+"</td><td>"+rst.getString(5)+"</td><td>"+rst.getString(6)+"</td>"+
                    "<td>"+rst.getString(7)+"</td><td>"+rst.getString(8)+"</td><td>"+rst.getString(9)+"</td>"+
                    "<td>"+rst.getString(10)+"</td><td>"+rst.getString(11)+"</td><td>"+rst.getString(12)+"</td></tr>");
			}
			out.println("</table></font>");
	}	
}
catch (SQLException ex) {
 	out.println(ex); 
}
%>
    </div>
</body>
</html>