<%@ page import="com.study.connection.ConnectionTest" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>

<%
    ConnectionTest conn = new ConnectionTest();

%>

<div>
    글작성 섹션
</div>

<br/>

<div style="display: flex">
    <button>취소</button>
    <button>저장</button>
</div>

<script type="text/javascript">
</script>

</body>
</html>
