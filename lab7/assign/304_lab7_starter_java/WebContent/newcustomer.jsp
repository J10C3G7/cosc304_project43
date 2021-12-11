<%@ page import="java.util.Locale" %>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html style="background-color:#9eb4ff">
<head>
	<title>Nostalgic Gaming - Login Screen</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="col-md-12" align="center">
	<%@ include file="header.jsp" %>
	<div class = "row" style="background-color:#9eb4ff">

<h2>Create a New Account</h2>

<!-- <%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
%> -->

<br>
<form name="MyForm" method=post action="newcustomer.jsp">
<table style="display:inline">
<tr>
    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">First Name:</font></div></td>
    <td><input type="text" name="inputFirstName" size="50" maxlength="40"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Last Name:</font></div></td>
	<td><input type="text" name="inputLastName" size="50" maxlength="40"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></div></td>
	<td><input type="text" name="inputEmail" size="50" maxlength="50"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Phone Number:</font></div></td>
	<td><input type="text" name="inputPhonenum" size="50" maxlength="20"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Address:</font></div></td>
	<td><input type="text" name="inputAddress" size="50" maxlength="50"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">City:</font></div></td>
	<td><input type="text" name="inputCity" size="50" maxlength="40"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">State:</font></div></td>
	<td><input type="text" name="inputState" size="50" maxlength="20"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Postal Code:</font></div></td>
	<td><input type="text" name="inputPostalCode" size="50" maxlength="20"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Country:</font></div></td>
	<td><input type="text" name="inputCountry" size="50" maxlength="40"></td>
</tr>
<tr><td height="30"></td></tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
	<td><input type="text" name="inputUsername"  size="50" maxlength=20></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
	<td><input type="password" name="inputPassword" size="50" maxlength="30"></td>
</tr>
<tr><td height="30"></td></tr>
<tr>
    <td colspan="2"><div><input class="submit" type="submit" name="Submit2" value="Create Account"></div></td>
</tr>
<tr><td height="30"></td></tr>
</table>
<br/>
</form>

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
    String newUsername = request.getParameter("inputUsername");
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
        Boolean booleanUsername = (newUsername != null) && (!newUsername.equals(""));
        Boolean booleanPassword = (newPassword != null) && (!newPassword.equals(""));
        
        if (!(booleanFirstName && booleanLastName && booleanEmail && booleanPhonenum && booleanAddress && booleanCity && booleanState && booleanPostalCode && booleanCountry && booleanUsername && booleanPassword)) {
            out.println("<p>All fields are required.</p>");
        } else {
            String sql_validateNewUserId = "SELECT userid FROM customer WHERE userid = ?";
            PreparedStatement pstmt1 = con.prepareStatement(sql_validateNewUserId);
            pstmt1.setString(1, newUsername);
            ResultSet rst = pstmt1.executeQuery();
            if(rst.next()) {
                out.println("<p>An account already exists with this username.  Please log in.</p>");
            } else {
                String sql_insertCustomer = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password, admin) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'false')";
                PreparedStatement pstmt2 = con.prepareStatement(sql_insertCustomer);
                pstmt2.setString(1, newFirstName);
                pstmt2.setString(2, newLastName);
                pstmt2.setString(3, newEmail);
                pstmt2.setString(4, newPhonenum);
                pstmt2.setString(5, newAddress);
                pstmt2.setString(6, newCity);
                pstmt2.setString(7, newState);
                pstmt2.setString(8, newPostalCode);
                pstmt2.setString(9, newCountry);
                pstmt2.setString(10, newUsername);
                pstmt2.setString(11, newPassword);
                pstmt2.execute();
                
                out.println("<h3>Success! Please proceed to <a href=login.jsp><u>login</u></a></h3>");
            }
        }
		
	} catch (SQLException ex) {
		out.println(ex); 
	}
%>

<h3><a style="color:#333333" href="index.jsp">Back to Main Page</a></h3>
</div>
</body>
</html>

