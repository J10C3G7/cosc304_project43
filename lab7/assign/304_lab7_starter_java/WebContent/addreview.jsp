<%@	page import="java.text.SimpleDateFormat" %> 
<%@	page import="java.util.Date" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="logoutadmin.jsp"%>
<%@ include file="auth.jsp"%>

<html>
<head>
	<title>The Nostalgic Gamer</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="header.jsp" %>
    <div style="margin:0 auto;text-align:center;display:inline">
<h3>Enter Review:</h3>
<br>
<form method="get" action="addreview.jsp">
    <table style="display:inline">
        <tbody>
            <tr>
                <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Product Id:</font></div></td>
            </tr>
            <tr>
                <td><input type="text" name="id" size="6" maxlength="6"></td>
            </tr>
            <tr>
                <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Review Rating (1-10):</font></div></td>
            </tr>
            <tr>
                <td>		<select size="1" name="reviewRating">
                    <option>1</option>
                    <option>2</option>
                    <option>3</option>
                    <option>4</option>
                    <option>5</option>
                    <option>6</option>
                    <option>7</option>
                    <option>8</option>
                    <option>9</option>
                    <option>10</option>        
                </select></td>
            </tr>
            <tr>
                <td><div align="left"><font face="Arial, Helvetica, sans-serif" size="2">Review:</font></div></td>
            </tr>
            <tr>
                <td><textarea name="review" cols="70" rows="8" maxlength="1000"></textarea></td>
            </tr>
            <tr>
                <td align="center"><input type="submit" value="Submit"><input type="reset" value="Reset"></td>
            </tr>
        </tbody>
    </table>

    </form>
</br>
    <% String userName = (String) session.getAttribute("authenticatedUser"); %>

<%
    String prodId = request.getParameter("id");
    String revRat = request.getParameter("reviewRating");
    String rev = request.getParameter("review");
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
        Boolean bool_prodId = prodId != null && !prodId.equals("");
        Boolean bool_revRat = revRat != null && !revRat.equals("");
        Boolean bool_rev = rev != null && !rev.equals("");

        String sql_selectCustomer = "SELECT customerId FROM customer WHERE userID = ?";
		PreparedStatement pstmt = con.prepareStatement(sql_selectCustomer);
		pstmt.setString(1, userName);
    	ResultSet rst = pstmt.executeQuery();
        rst.next();
        int custId = rst.getInt(1);

        String sql_in = "INSERT INTO review (productId, customerId, reviewRating, reviewComment, reviewDate) VALUES (?, ?, ?, ?, ";
        if(bool_prodId){
            if(bool_revRat){
                if(bool_rev){
                    String sql_prod = "SELECT productId FROM product WHERE productId = " + prodId;
                    pstmt = con.prepareStatement(sql_prod);
                    rst = pstmt.executeQuery();

                    if(rst.next()  == true){
                        sql_prod = "SELECT productId FROM orderProduct P JOIN orderSummary S ON P.orderId = S.orderId WHERE productId = ? AND customerId = ?";
                        pstmt = con.prepareStatement(sql_prod);
                        pstmt.setString(1, prodId);
                        pstmt.setInt(2, custId);
                        rst = pstmt.executeQuery();
                        if(rst.next()){
                            sql_prod = "SELECT productId FROM review WHERE productId = ? AND customerId = ?";
                            pstmt = con.prepareStatement(sql_prod);
                            pstmt.setString(1, prodId);
                            pstmt.setInt(2, custId);
                            rst = pstmt.executeQuery();        
                            if(rst.next() == false){
                                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
                                Date date = new Date();
                                String val1 = "" + prodId;
                                String val2 = "" + custId;
                                String val3 = "" + revRat;
                                String val4 = "'"+formatter.format(date)+"'";
                                String val5 = "" + rev;
                                //out.println("<h2>"+val4+"</h2>");
                                sql_in += val4 + ")";
                                pstmt = con.prepareStatement(sql_in);
                                pstmt.setString(1, val1);
                                pstmt.setString(2, val2);
                                pstmt.setString(3, val3);
                                //pstmt.setString(4, val4);
                                pstmt.setString(4, val5);
                                pstmt.executeUpdate();
                                out.println("<h2>Review Has Been Submitted</h2>");
                                out.println("<h2><a href=\"product.jsp?id="+prodId+"\">Back to Product Page</a></h2>");
                            }else{
                                out.println("<h2>Cannot Write More Than One Review</h2>");
                            }
                        }else{
                            out.println("<h2>Have Not Purchased Product</h2>");
                        }

                    }else{
                        out.println("<h2>Invalid Product Id</h2>");
                    }
                    	
                }else{
                    out.println("<h2>Enter Product Id, Review Rating, and Review Comment</h2>");
                }
                
            }else{
                out.println("<h2>Enter Product Id, Review Rating, and Review Comment</h2>");
            }
            
        }else{
            out.println("<h2>Enter Product Id, Review Rating, and Review Comment</h2>");
        }
    }
    catch (SQLException ex) {
        out.println(ex); 
    }
    
    %>
    <h2><a href="index.jsp">Back to Main Page</a></h2>
</div>
</body>
</html>