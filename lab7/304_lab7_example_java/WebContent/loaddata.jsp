<%@ page import="java.sql.*" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="java.io.File" %>
<%@ page import="javax.servlet.jsp.*" %>

<html>
<head>
<title>Sample Data Loader</title>
</head>
<body>
<%!
void loadData(String fileName, Connection con, JspWriter out) throws Exception
{    
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
            // out.print(command+"<br>");        // Uncomment if want to see commands executed
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
    }
    catch (Exception e)
    {
        out.print(e);
    }  
}
%>
<h3>Loading data into Microsoft SQL Server</h3>
<%
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=workson;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

out.print("<h3>Connecting to database.</h3>");
try (Connection con = DriverManager.getConnection(url, uid, pw);  )
{
    out.print("<h4>Loading workson database.</h4>");
    loadData("/usr/local/tomcat/webapps/sample/data/workson.sql", con, out);
    loadData("/usr/local/tomcat/webapps/sample/data/provstates.sql", con, out);
    out.print("<h3>Successful data load.</h3>");
}
catch (Exception e)
{
    out.print(e);
}  
%>

<h3>Loading data into MySQL</h3>
<%
url = "jdbc:mysql://cosc304_mysql/workson";
uid = "test";
pw = "test";

out.print("<h3>Connecting to database.</h3>");
try (Connection con = DriverManager.getConnection(url, uid, pw);  )
{
    out.print("<h4>Loading workson database.</h4>");
    loadData("/usr/local/tomcat/webapps/sample/data/workson_mysql.sql", con, out);
    loadData("/usr/local/tomcat/webapps/sample/data/provstates.sql", con, out);
    out.print("<h3>Successful data load.</h3>");
}
catch (Exception e)
{
    out.print(e);
}  
%>
</body>
</html> 
