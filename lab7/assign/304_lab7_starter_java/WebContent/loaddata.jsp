<%@ page import="java.sql.*" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="java.io.File" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="authadmin.jsp"%>
<!DOCTYPE html>
<html style="background-color:#9eb4ff">
<head>
<title>Nostalgic Gaming - Refreash Database</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="col-md-12" align="center">
<%@ include file="header.jsp" %>
<div class = "row" style="background-color:#9eb4ff">
<%
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

//String url = "jdbc:sqlserver://cosc304.ok.ubc.ca:1433;DatabaseName=db_jguigon;";
//String uid = "jguigon";
//String pw = "52744570";
out.print("<h1>Connecting to database.</h1><br>");

Connection con = DriverManager.getConnection(url, uid, pw);
        
String fileName = "/usr/local/tomcat/webapps/shop/orderdb_sql.ddl";

try
{
    // Create statement
    Statement stmt = con.createStatement();
    
    Scanner scanner = new Scanner(new File(fileName));
    // Read commands separated by ;
    scanner.useDelimiter(";");
    while (scanner.hasNext())
    {
        String command = scanner.next();
        if (command.trim().equals(""))
            continue;
        // out.print(command);        // Uncomment if want to see commands executed
        try
        {
            stmt.execute(command);
        }
        catch (Exception e)
        {	// Keep running on exception.  This is mostly for DROP TABLE if table does not exist.
            out.print(e);
        }
    }	 
    scanner.close();
    
    out.print("<br><br><h1>Database loaded.</h1>");
}
catch (Exception e)
{
    out.print(e);
}  
%>
</div>
</body>
</html> 
