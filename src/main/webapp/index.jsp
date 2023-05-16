<%@ page import="com.study.connection.ConnectionTest" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.study.domain.Category" %>
<%@ page import="com.study.validator.IndexValidator" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>

<%
    ConnectionTest conn = new ConnectionTest();

//    null or blank or 유저 임의 값 집어 넣는 거 걸러야 함
    Optional<String> startDate = Optional.ofNullable(request.getParameter("start_d"));
    Optional<String> endDate = Optional.ofNullable(request.getParameter("end_d"));
    Optional<String> c = Optional.ofNullable(request.getParameter("c"));
    Optional<String> search = Optional.ofNullable(request.getParameter("search"));

//    out.println("[" + startDate.orElse("is null") + "]");
//    out.println("[" + endDate.orElse("is null") + "]");
//    out.println("[" + c.orElse("is null") + "]");
//    out.println("[" + search.orElse("is null") + "]");


    List<String> categoryList = new ArrayList<>();
    try (Connection connection = conn.getConnection()) {
        String query = "select * from category";
        PreparedStatement pstmt = connection.prepareStatement(query);
        ResultSet resultSet = pstmt.executeQuery();
        while (resultSet.next()) {
            categoryList.add(resultSet.getString("name"));
        }
        IndexValidator validator = new IndexValidator(startDate.orElse(""), endDate.orElse(""), c.orElse(""), search.orElse(""), categoryList);
        resultSet.close();
        pstmt.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<div>
    <form method="get" action="index.jsp">
    <div>등록일
        <input type="date" name="start_d"/> ~
        <input type="date" name="end_d"/>
        <select name="c">
            <option value="all">전체 카테고리</option>
            <% for (int i = 0; i < categoryList.size(); i++) {
                %>
            <option value=<%=categoryList.get(i)%>><%=categoryList.get(i)%></option>
                    <%
            }%>
        </select>
        <input type="text"placeholder="검색어를 입력하세요." name="search"/>
        <input type="submit" value="검색"/>
    </div>
    </form>
</div>
<br/>
<div>
    <div>총 NNN건</div>
    <br/>
    <div>
        <table>
            <thead>
            <tr>
                <th>카테고리</th>
                <th></th>
                <th>제목</th>
                <th>작성자</th>
                <th>조회수</th>
                <th>등록 일시</th>
                <th>수정 일시</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <th>JAVA</th>
                <th></th>
                <th>제목 예시입니다.</th>
                <th>홍길동</th>
                <th>12</th>
                <th>2022.04.08 16:32</th>
                <th>2022.04.08 16:32</th>
            </tr>
            <tr>
                <th>JAVA</th>
                <th>파일</th>
                <th>제목 예시입니다.</th>
                <th>홍길동</th>
                <th>12</th>
                <th>2022.04.08 16:32</th>
                <th>2022.04.08 16:32</th>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<br/>

<div>페이지 섹션</div>

<br/>

<div>
    <button type="button" onclick="create()">등록</button>
</div>



<script type="text/javascript">
    const create = () => {
        window.location.href = "create.jsp"
    }
</script>

</body>
</html>
