<!DOCTYPE html>
<html>
<head>
    <title>The Nostalgic Gamer CheckOut Line</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="header.jsp" %>
<h1>Enter your customer id to complete the transaction:</h1>

<form method="get" action="order.jsp">
<input type="text" name="customerId" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset">
</form>

</body>
</html>

