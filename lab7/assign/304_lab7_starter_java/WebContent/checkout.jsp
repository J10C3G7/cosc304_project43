<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="auth.jsp"%>

<% 
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
String userName = (String) session.getAttribute("authenticatedUser");

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
    String sql_selectCustomer = "SELECT customerId FROM customer WHERE userID = ?";
    PreparedStatement pstmt = con.prepareStatement(sql_selectCustomer);
    pstmt.setString(1, userName);
    ResultSet rst = pstmt.executeQuery();
    rst.next();
    int custId = rst.getInt(1);
    response.sendRedirect("order.jsp?customerId=" + custId);
}    catch (SQLException ex) {
    out.println(ex); 
}
%>

