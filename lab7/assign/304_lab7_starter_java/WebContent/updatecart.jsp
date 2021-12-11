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
try{
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String price = request.getParameter("price");
	int prodQuantity = Integer.parseInt(request.getParameter("prodQuantity"));
	Integer quantity = new Integer(prodQuantity);
	// Store product information in an ArrayList
	ArrayList<Object> product = new ArrayList<Object>();

	// Update quantity if add same item to order again
	if (productList.containsKey(id))
	{	product = (ArrayList<Object>) productList.get(id);
		product.set(3, quantity);
	}

	session.setAttribute("productList", productList);
	//response.sendRedirect("showcart.jsp");
}catch (NumberFormatException ex){
	response.sendRedirect("showcart.jsp");
}

%>