<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	// No products currently in list.  Create a list.
	productList = new HashMap<String, ArrayList<Object>>();
}

// Add new product selected
// Get product information
String id = request.getParameter("id");

// Update quantity if add same item to order again
if (productList.containsKey(id)){
	if(productList.size()==1){
		session.removeAttribute("productList");
	}else{
		productList.remove(id);
		session.setAttribute("productList", productList);
	}
}
	
response.sendRedirect("showcart.jsp");
%>