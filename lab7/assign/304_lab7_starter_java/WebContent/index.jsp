<!DOCTYPE html>
<html>
<head>
        <title>The Nostalgic Gamer Main Page</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%@ include file="header.jsp" %>

<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="placeshipment.jsp">Place Shipment</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>

<h2 align="center"><a href="loaddata.jsp">Load Data</a></h2>

	
<% 
// TODO: Display user name that is logged in (or nothing if not logged in)
if(session.getAttribute("authenticatedUser") != null) {
        String userName = ((String) session.getAttribute("authenticatedUser"));
        out.println("<h3 align=\"center\">Current User: " + userName + "</h3>");
}
%>
</body>
</head>


