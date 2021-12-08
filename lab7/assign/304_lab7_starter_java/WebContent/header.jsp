<div class="row">
    
    <% 
    // TODO: Display user name that is logged in (or nothing if not logged in)
    if(session.getAttribute("authenticatedUser") != null) {
        String userName = ((String) session.getAttribute("authenticatedUser"));
        out.println("<h2 class=\"col-md-9\" align=\"left\"><a href=\"index.jsp\">The Nostalgic Gamer</a></h2>");
        out.println("<h3 class=\"col-md-3\" align=\"right\"><a href=\"admin.jsp\">Admin Portal</a> | <a href=\"listprod.jsp\"> Shop</a> | <a href=\"showcart.jsp\"> Cart</a> | <a href=\"login.jsp\"> "+userName+"</a> | <a href=\"logout.jsp\">Log out</a></h3>");
    
    }else{
        out.println("<h2 class=\"col-md-9\" align=\"left\"><a href=\"index.jsp\">The Nostalgic Gamer</a></h2>");
        out.println("<h3 class=\"col-md-3\" align=\"right\"><a href=\"admin.jsp\">Admin Portal</a> | <a href=\"listprod.jsp\"> Shop</a> | <a href=\"showcart.jsp\"> Cart</a> | <a href=\"login.jsp\"> Login</a> | <a href=\"logout.jsp\">Log out</a></h3>");
    }
    %>
</div>
<hr>
