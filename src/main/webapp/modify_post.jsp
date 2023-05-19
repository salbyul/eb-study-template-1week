<%@ page import="java.util.Optional" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>

<%
    Optional<String> index = Optional.ofNullable(request.getParameter("i"));
    Optional<String> password = Optional.ofNullable(request.getParameter("password"));

%>


<script type="text/javascript">
</script>

</body>
</html>
