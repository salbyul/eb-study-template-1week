<%@ page import="com.study.repository.BoardRepositoryImpl" %>
<%@ page import="com.study.validator.ModifyValidator" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>

<%

    try {
        BoardRepositoryImpl boardRepository = new BoardRepositoryImpl();
        request.setCharacterEncoding("utf-8");
//        파일첨부 추가
        Long id = Long.valueOf(request.getParameter("i"));
        String writer = request.getParameter("writer");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        ModifyValidator validator = new ModifyValidator(id, writer, title, content);
        boardRepository.modifyBoard(validator.getBoardDto());
        boardRepository.close();
        response.sendRedirect("detail.jsp?i=" + id);
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("404.jsp");
    }
%>


<script type="text/javascript">
</script>

</body>
</html>
