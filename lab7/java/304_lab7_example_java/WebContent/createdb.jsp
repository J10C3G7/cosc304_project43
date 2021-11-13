<%@ page import="java.sql.*" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="java.io.File" %>
<%@ page import="javax.servlet.jsp.*" %>

<html>
<head>
<title>Creates SQL Server Database</title>
</head>
<body>

<h3>Creating Microsoft SQL Server Database</h3>
<%
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

out.print("<h3>Connecting to database.</h3>");
try (Connection con = DriverManager.getConnection(url, uid, pw);  )
{    
    Statement stmt = con.createStatement();
    stmt.execute("CREATE DATABASE workson");
    out.print("<h3>Successful database creation.</h3>");
}
catch (Exception e)
{
    out.print(e);    
}  
%>

</body>
</html> 
