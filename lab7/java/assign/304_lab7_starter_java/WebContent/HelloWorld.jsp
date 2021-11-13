<html>
<head>
<title>Hello World in JSP</title>
</head>
<body>

<% out.println("Hello World!"); %>

<% 
out.println("<pre>");
for (int i=1; i < 5; i++)
	out.println(i);
out.println("</pre>");
%>

</body>
</html>