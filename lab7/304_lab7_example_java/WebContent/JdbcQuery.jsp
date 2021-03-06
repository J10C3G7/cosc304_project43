<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Query Results Using JSP</title>
</head>

<body>

<h3>Example MySQL JDBC Query on Workson Database</h3>

<% 
String url = "jdbc:mysql://cosc304_mysql/workson";
String uid = "test";
String pw = "test";

try 
{	// Load driver class
	Class.forName("com.mysql.jdbc.Driver");
}
catch (java.lang.ClassNotFoundException e) {
	System.err.println("ClassNotFoundException: " +e);	
}

try ( Connection con = DriverManager.getConnection(url, uid, pw);
      Statement stmt = con.createStatement();) 
{		
	ResultSet rst = stmt.executeQuery("SELECT ename,salary FROM emp");		
	out.println("<table><tr><th>Name</th><th>Salary</th></tr>");
	while (rst.next())
	{	out.println("<tr><td>"+rst.getString(1)+"</td>"+"<td>"+rst.getDouble(2)+"</td></tr>");
	}
	out.println("</table>");
}
catch (SQLException ex) 
{ 	out.println(ex); 
}

%>
</body>
</html>
