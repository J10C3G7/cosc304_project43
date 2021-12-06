<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>Administrator Page</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="col-md-12" align="center">
    <%@ include file="header.jsp" %>
    <div style="margin:0 auto;text-align:center;display:inline">
        <h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

        <h2 align="center"><a href="placeshipment.jsp">Place Shipment</a></h2>

        <h2 align="center"><a href="listcustomers.jsp">List All Customers</a></h2>

        <h2 align="center"><a href="editproduct.jsp">Edit Product List</a></h2>

        <h2 align="center"><a href="addproduct.jsp">Add to Product List</a></h2>

        <h2 align="center"><a href="listinventory.jsp">List Inventory</a></h2>

        <h2 align="center"><a href="editinventory.jsp">Edit Inventory</a></h2>
<%

// TODO: Write SQL query that prints out total order amount by day
String sql = "";

%>

</div>
</body>
</html>

