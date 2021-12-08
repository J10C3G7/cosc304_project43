<%
	boolean authenticated = session.getAttribute("authenticatedUser") == null ? false : true;

	if (!authenticated)
	{
		String loginMessage = "You have not been authorized to access the URL "+request.getRequestURL().toString();
        session.setAttribute("loginMessage",loginMessage);        
		response.sendRedirect("loginadmin.jsp");
	} else {
		try {	
			// Load driver class
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		} catch (java.lang.ClassNotFoundException e) {
			out.println("ClassNotFoundException: " +e);
		}
	
		try ( Connection con = DriverManager.getConnection(url, uid, pw);
				Statement stmt = con.createStatement();) {
			String userName = (String) session.getAttribute("authenticatedUser");
			String sql_selectCustomer = "SELECT admin FROM customer WHERE userID = ? AND admin = ?";
			PreparedStatement pstmt = con.prepareStatement(sql_selectCustomer);
			pstmt.setString(1, userName);
			pstmt.setString(2, "true");
			ResultSet rst = pstmt.executeQuery();

			if(rst.next()==false){
				String loginMessage = "You have not been authorized to access the URL "+request.getRequestURL().toString();
				session.setAttribute("loginMessage",loginMessage);        
				response.sendRedirect("loginadmin.jsp");
			}
		}catch (SQLException ex) {
			out.println(ex);
		}
	}
%>
