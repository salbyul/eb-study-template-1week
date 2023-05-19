<%@ page import="com.study.repository.BoardRepositoryImpl" %>
<%@ page import="com.study.repository.BoardRepository" %>
<%@ page import="com.study.dto.board.BoardCreateDto" %>
<%@ page import="com.study.validator.CreateValidator" %>
<%@ page import="com.study.SHA256" %>
<%@ page import="java.util.Optional" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>

<%

    //    String path = "/Users/jh/Desktop/private/study/files";
//    String encType = "utf-8";
//    int maxSize = 15 * 1024 * 1024;
    SHA256 sha256 = new SHA256();
    request.setCharacterEncoding("utf-8");

    try {
        CreateValidator createValidator = new CreateValidator(request.getParameter("category"), request.getParameter("writer"), sha256.encrypt(request.getParameter("password")), request.getParameter("title"), request.getParameter("content"));
        BoardCreateDto boardDto = createValidator.getBoardDto();
        BoardRepository boardRepository = new BoardRepositoryImpl();
//        TODO file upload logic
        Long boardId = boardRepository.save(boardDto);
      System.out.println("boardId = " + boardId);
        response.sendRedirect("detail.jsp?i=" + boardId);
    } catch (IllegalArgumentException e) {
        e.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    }

%>
<script type="text/javascript">

</script>

</body>
</html>
