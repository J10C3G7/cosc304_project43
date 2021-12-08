<div class="row" style="background-color:#242424">
    <font color="#337ab7">
    <% 
    // TODO: Display user name that is logged in (or nothing if not logged in)
    if(session.getAttribute("authenticatedUser") != null) {
        String userName = ((String) session.getAttribute("authenticatedUser"));
        out.println("<h3 class=\"col-md-4\" align=\"left\" ><a href=\"index.jsp\">Home</a> | <a href=\"admin.jsp\">Admin Portal</a> | <a href=\"listprod.jsp\"> Shop</a> | <a href=\"showcart.jsp\"> Cart</a></h3>");
        out.println("<h2 class=\"col-md-4\" align=\"center\" >Nostalgic Gaming</h2>");
        out.println("<h3 class=\"col-md-4\" align=\"right\">Logged in as: <a href=\"customer.jsp\"> "+userName+"</a> | <a href=\"logout.jsp\">Log out </a></h3>");
    
    }else{
        out.println("<h3 class=\"col-md-4\" align=\"left\"><a href=\"index.jsp\">Home</a> | <a href=\"admin.jsp\">Admin Portal</a> | <a href=\"listprod.jsp\"> Shop</a> | <a href=\"showcart.jsp\"> Cart</a></h3>");
        out.println("<h2 class=\"col-md-4\" align=\"center\" >Nostalgic Gaming</h2>");
        out.println("<h3 class=\"col-md-4\" align=\"right\"><a href=\"login.jsp\">Login </a></h3>");
    }
    %>
</font>
</div>
