<%@ page import="com.study.repository.CommentRepositoryImpl" %>
<%@ page import="com.study.dto.comment.CommentSaveDto" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>

<%
    request.setCharacterEncoding("utf-8");
    try {
        CommentRepositoryImpl commentRepository = new CommentRepositoryImpl();
        CommentSaveDto commentSaveDto = new CommentSaveDto(request.getParameter("writer"), request.getParameter("content"), Long.parseLong(request.getParameter("i")));
        commentRepository.save(commentSaveDto);

        commentRepository.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    response.sendRedirect("detail.jsp?i=" + request.getParameter("i") + "&start_d=" + request.getParameter("start_d") + "&end_d=" + request.getParameter("end_d") + "&c=" + request.getParameter("c") + "&search=" + request.getParameter("search"));
%>
<script type="text/javascript">

</script>

</body>
</html>
