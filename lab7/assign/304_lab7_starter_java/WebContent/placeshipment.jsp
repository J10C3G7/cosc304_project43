<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<%@ include file="authadmin.jsp"%>


<html style="background-color:#9eb4ff">
<head>
	<title>Nostalgic Gaming - Place Shipment</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<div class = "row" style="background-color:#9eb4ff">
	<body class="col-md-12" align="center">
<%@ include file="header.jsp" %>
<h2>Place Shipment by Entering the Order Id:</h2>

<form method="get" action="ship.jsp">
<input type="text" name="orderId" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset">
</form>
<h4>
    <a style="color:#333333" href="admin.jsp">Back to Admin Portal</a>
</h4>
</body>
</div>
</html>