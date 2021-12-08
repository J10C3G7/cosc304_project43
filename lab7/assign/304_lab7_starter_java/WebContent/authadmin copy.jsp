<%
	boolean authenticated = session.getAttribute("authenticatedAdmin") == null ? false : true;

	if (!authenticated)
	{
		String loginMessage = "You have not been authorized to access the URL "+request.getRequestURL().toString();
        session.setAttribute("loginMessage",loginMessage);        
		response.sendRedirect("loginadmin.jsp");
	} else {
		String userName = (String) session.getAttribute("authenticatedUser");
		String sql_selectCustomer = "SELECT admin FROM customer WHERE userID = ?";
		PreparedStatement pstmt = con.prepareStatement(sql_selectCustomer);
		pstmt.setString(1, userName);
    	ResultSet rst = pstmt.executeQuery();
        rst.next();
        int custId = rst.getBoolean(1);
	}
%>
