<div class="row">
    
    <% 
    // TODO: Display user name that is logged in (or nothing if not logged in)
    if(session.getAttribute("authenticatedUser") != null) {
        String userName = ((String) session.getAttribute("authenticatedUser"));
        out.println("<H1 class=\"col-md-9\" align=\"left\"><font face=\"cursive\" color=\"#3399FF\"><a href=\"index.jsp\">The Nostalgic Gamer</a></font></H1>");
        out.println("<h2 class=\"col-md-1\" align=\"right\"><a href=\"showcart.jsp\">Cart</a></h2>");
        out.println("<h2 class=\"col-md-1\" align=\"center\"><a href=\"customer.jsp\">" + userName + "</a></h2>");
        out.println("<h2 class=\"col-md-1\" align=\"left\"><a href=\"logout.jsp\">Log out</a></h2>");
    }
    else{
        out.println("<H1 class=\"col-md-9\" align=\"left\"><font face=\"cursive\" color=\"#3399FF\"><a href=\"index.jsp\">The Nostalgic Gamer</a></font></H1>");
        out.println("<h2 class=\"col-md-1\" align=\"right\"><a href=\"showcart.jsp\">Cart</a></h2>");
        out.println("<h2 class=\"col-md-1\" align=\"center\"><a href=\"login.jsp\">Login</a></h2>");
        out.println("<h2 class=\"col-md-1\" align=\"left\"><a href=\"logout.jsp\">Log out</a></h2>");
    }
    %>
</div>
<hr>
