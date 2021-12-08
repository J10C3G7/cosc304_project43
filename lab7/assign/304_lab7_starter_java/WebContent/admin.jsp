<%@ include file="jdbc.jsp" %>
<%@ include file="authadmin.jsp"%>
<!DOCTYPE html>
<html style="background-color:#9eb4ff">
<head>
    <title>Nostalgic Gaming - Administrator Page</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="col-md-12" align="center">
    <%@ include file="header.jsp" %>
    <div class = "row" style="background-color:#9eb4ff">
        <h2 align="center"><a style="color:#333333" href="listorder.jsp">List All Orders</a></h2>

        <h2 align="center"><a style="color:#333333" href="placeshipment.jsp">Place Shipment</a></h2>

        <h2 align="center"><a style="color:#333333" href="listcustomers.jsp">List All Customers</a></h2>

        <h2 align="center"><a style="color:#333333" href="editproduct.jsp">Edit Product List</a></h2>

        <h2 align="center"><a style="color:#333333" href="addproduct.jsp">Add to Product List</a></h2>

        <h2 align="center"><a style="color:#333333" href="listinventory.jsp">List Inventory</a></h2>

        <h2 align="center"><a style="color:#333333" href="editinventory.jsp">Edit Inventory</a></h2>

        <h2 align="center"><a style="color:#333333" href="loaddata.jsp">Load/Restore Database</a></h2>
<%

// TODO: Writ SQL query that prints out total order amount by day
String sql = "";

%>

</div>
</body>
</html>

