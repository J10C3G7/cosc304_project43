<%@ page import="java.util.Locale" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp"%>

<!DOCTYPE html>
<html style="background-color:#9eb4ff">
<head>
	<title>Nostalgic Gaming - Edit Customer Page</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="col-md-12" align="center">
	<%@ include file="header.jsp" %>
	<div class = "row" style="background-color:#9eb4ff">

<h2>Edit User Information:</h2>
<br>
<form method="get" action="editcustomer.jsp">
    <table style="display:inline"><tbody><font face="Century Gothic" size="2">
        <tr><th>First Name</th><td><input type="text" name="inputFirstName" size="50" maxlength="40"></td></tr>
        <tr><th>Last Name</th><td><input type="text" name="inputLastName" size="50" maxlength="40"></td></tr>
        <tr><th>Email</th><td><input type="text" name="inputEmail" size="50" maxlength="50"></td></tr>
        <tr><th>Phone</th><td><input type="text" name="inputPhonenum" size="50" maxlength="20"></td></tr>
        <tr><th>Address</th><td><input type="text" name="inputAddress" size="50" maxlength="50"></td></tr>
        <tr><th>City</th><td><input type="text" name="inputCity" size="50" maxlength="40"></td></tr>
        <tr><th>State</th><td><input type="text" name="inputState" size="50" maxlength="20"></td></tr>
        <tr><th>Postal Code</th><td><input type="text" name="inputPostalCode" size="50" maxlength="20"></td></tr>
        <tr><th>Country</th><td><input type="text" name="inputCountry" size="50" maxlength="40"></td></tr>
        <tr><td height="30"></td></tr>
        <% String userName = (String) session.getAttribute("authenticatedUser"); %>
        <tr><th>User Id</th><td><div align="left"><% out.println(userName); %></div></td></tr>
        <tr><th>Password</th><td><input type="password" name="inputPassword" size="50" maxlength="30"></td></tr>
        <tr><td height="30"></td></tr>
        <tr><td align="center" colspan="2"><input type="submit" value="Submit"><input type="reset" value="Reset"></td></tr>
    </font></tbody></table>
    </form>
</br>

<%
    String newFirstName = request.getParameter("inputFirstName");
    String newLastName = request.getParameter("inputLastName");
    String newEmail = request.getParameter("inputEmail");
    String newPhonenum = request.getParameter("inputPhonenum");
    String newAddress = request.getParameter("inputAddress");
    String newCity = request.getParameter("inputCity");
    String newState = request.getParameter("inputState");
    String newPostalCode = request.getParameter("inputPostalCode");
    String newCountry = request.getParameter("inputCountry");
    String newPassword = request.getParameter("inputPassword");
    Locale.setDefault(new Locale("en","CA"));

    String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
    String uid = "SA";
    String pw = "YourStrong@Passw0rd";

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
        Boolean booleanFirstName = (newFirstName != null) && (!newFirstName.equals(""));
        Boolean booleanLastName = (newLastName != null) && (!newLastName.equals(""));
        Boolean booleanEmail = (newEmail != null) && (!newEmail.equals(""));
        Boolean booleanPhonenum = (newPhonenum != null) && (!newPhonenum.equals(""));
        Boolean booleanAddress = (newAddress != null) && (!newAddress.equals(""));
        Boolean booleanCity = (newCity != null) && (!newCity.equals(""));
        Boolean booleanState = (newState != null) && (!newState.equals(""));
        Boolean booleanPostalCode = (newPostalCode != null) && (!newPostalCode.equals(""));
        Boolean booleanCountry = (newCountry != null) && (!newCountry.equals(""));
        Boolean booleanPassword = (newPassword != null) && (!newPassword.equals(""));

        String sql_selectCustomer = "SELECT customerId FROM customer WHERE userID = ?";
		PreparedStatement pstmt1 = con.prepareStatement(sql_selectCustomer);
		pstmt1.setString(1, userName);
    	ResultSet rst = pstmt1.executeQuery();
        rst.next();
        int customerId = rst.getInt("customerId");
        /* String prevFirstName = rst.getString("firstName");
        String prevLastName = rst.getString("lastName");
        String prevEmail = rst.getString("email");
        String prevPhonenum = rst.getString("phonenum");
        String prevAddress = rst.getString("address");
        String prevCity = rst.getString("city");
        String prevState = rst.getString("state");
        String prevPostalCode = rst.getString("postalCode");
        String prevCountry = rst.getString("country");
        String prevPassword = rst.getString("password");
		String admin = rst.getString("admin"); */

        ArrayList<String> listChanges = new ArrayList<String>();
        if (booleanFirstName) listChanges.add("firstName = '"+newFirstName+"'");
        if (booleanLastName) listChanges.add("lastName = '"+newLastName+"'");
        if (booleanEmail) listChanges.add("email = '"+newEmail+"'");
        if (booleanPhonenum) listChanges.add("phonenum = '"+newPhonenum+"'");
        if (booleanAddress) listChanges.add("address = '"+newAddress+"'");
        if (booleanCity) listChanges.add("city = '"+newCity+"'");
        if (booleanState) listChanges.add("state = '"+newState+"'");
        if (booleanPostalCode) listChanges.add("postalCode = '"+newPostalCode+"'");
        if (booleanCountry) listChanges.add("country = '"+newCountry+"'");
        if (booleanPassword) listChanges.add("password = '"+newPassword+"'");
        String listString = String.join(", ", listChanges);

        try {
            String SQL_updateCustomer = "UPDATE customer SET "+listString+" WHERE customerId = ?";
            //out.println("<p>"+SQL_updateCustomer+"</p>");
            PreparedStatement pstmt2 = con.prepareStatement(SQL_updateCustomer);
            pstmt2.setInt(1, customerId);
            pstmt2.execute();
            out.println("<h2>Changes Have Been Saved</h2>");

        } catch (SQLException e) {
            if (request.getParameter("inputFirstName") != null) {
                out.println(e);
                out.println("<h3>Save Unsuccessful, Please Try Again</h3>");
            }
        }

	} catch (SQLException ex) {
        out.println("second catch:");
		out.println(ex); 
	}
%>

<h3><a style="color:#333333" href="index.jsp">Back to Main Page</a></h3>
</div>
</body>
</html>

