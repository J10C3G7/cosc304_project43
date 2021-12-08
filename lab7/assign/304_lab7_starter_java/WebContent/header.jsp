<div class="row">
    
    <% 
    // TODO: Display user name that is logged in (or nothing if not logged in)
    if(session.getAttribute("authenticatedUser") != null) {
        String userName = ((String) session.getAttribute("authenticatedUser"));
        out.println("<h2 class=\"col-md-6\" align=\"left\"><a href=\"index.jsp\">The Nostalgic Gamer</a></h2>");
        out.println("<h2 class=\"col-md-2\" align=\"right\"><a href=\"admin.jsp\">Admin Portal</a></h2>");
        out.println("<h2 class=\"col-md-1\" align=\"center\"><a href=\"showcart.jsp\">Cart</a></h2>");
        out.println("<h2 class=\"col-md-1\" align=\"center\"><a href=\"customer.jsp\">" + userName + "</a></h2>");
        out.println("<h2 class=\"col-md-2\" align=\"left\"><a href=\"logout.jsp\">Log out</a></h2>");
    }
    else{
        out.println("<h2 class=\"col-md-6\" align=\"left\"><a href=\"index.jsp\">The Nostalgic Gamer</a></h2>");
        out.println("<h3 class=\"col-md-2\" align=\"right\"><a href=\"admin.jsp\">Admin Portal</a></h3>");
        out.println("<h3 class=\"col-md-1\" align=\"center\"><a href=\"showcart.jsp\">Cart</a></h3>");
        out.println("<h3 class=\"col-md-1\" align=\"center\"><a href=\"login.jsp\">Login</a></h3>");
        out.println("<h3 class=\"col-md-2\" align=\"center\"><a href=\"logout.jsp\">Log out</a></h3>");
    }
    %>
</div>
<hr>
