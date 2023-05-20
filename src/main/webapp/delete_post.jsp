<%@ page import="com.study.repository.BoardRepositoryImpl" %>
<%@ page import="java.util.Optional" %>
<%@ page import="com.study.SHA256" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>

<%
    Optional<String> optionalIndex = Optional.ofNullable(request.getParameter("i"));
    Optional<String> optionalPassword = Optional.ofNullable(request.getParameter("password"));
    String password;
    String findPassword;

    if (optionalIndex.isEmpty()) response.sendRedirect("404.jsp");
    else {
        if (optionalPassword.isEmpty()) response.sendRedirect("detail.jsp?i=" + optionalIndex.get() + "&btn=delete");
        password = optionalPassword.get();
        SHA256 sha256 = new SHA256();
        try {
            BoardRepositoryImpl boardRepository = new BoardRepositoryImpl();
            String encryptedPassword = sha256.encrypt(password);
            findPassword = boardRepository.findPasswordById(Long.valueOf(optionalIndex.get()));
            if (!findPassword.equals(encryptedPassword)) {
                response.sendRedirect("detail.jsp?i=" + optionalIndex.get() + "&btn=delete");
                return;
            }

            boardRepository.delete(Long.valueOf(optionalIndex.get()));
            boardRepository.close();
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<script type="text/javascript">
</script>

</body>
</html>
