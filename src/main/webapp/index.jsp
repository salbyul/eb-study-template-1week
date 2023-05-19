<%@ page import="com.study.connection.ConnectionTest" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.study.domain.Category" %>
<%@ page import="com.study.validator.IndexValidator" %>
<%@ page import="java.util.*" %>
<%@ page import="com.study.validator.SearchDto" %>
<%@ page import="com.study.repository.BoardRepositoryImpl" %>
<%@ page import="com.study.repository.BoardRepository" %>
<%@ page import="com.study.dto.board.BoardList" %>
<%@ page import="com.study.dto.board.BoardSearchDto" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <script src="https://cdn.tailwindcss.com"></script>
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
    BoardList boardList = new BoardList();
    try (Connection connection = conn.getConnection()) {
        BoardRepositoryImpl boardRepository = new BoardRepositoryImpl();
        String query = "select name from category";
        PreparedStatement pstmt = connection.prepareStatement(query);
        ResultSet resultSet = pstmt.executeQuery();
        while (resultSet.next()) {
            categoryList.add(resultSet.getString("name"));
        }
        IndexValidator validator = new IndexValidator(startDate.orElse(""), endDate.orElse(""), c.orElse(""), search.orElse(""));
        SearchDto searchDto = validator.getSearchDto();
        if (searchDto.isNull()) {
            boardList.setCount(boardRepository.countAll());
            boardList.setBoardSearchDtoList(boardRepository.findPaging(0, 10));
        }
        resultSet.close();
        pstmt.close();
        boardRepository.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<div class="mx-auto mt-20 w-7/12">
    <div class="border mb-5 text-center">
        <form method="get" action="index.jsp">
            <div class="py-1">등록일
                <input type="date" name="start_d" class="border mx-7"/> ~
                <input type="date" name="end_d" class="border mx-7"/>
                <select name="c" class="border p-1">
                    <option value="all">전체 카테고리</option>
                    <% for (int i = 0; i < categoryList.size(); i++) {
                    %>
                    <option value=<%=categoryList.get(i)%>><%=categoryList.get(i)%>
                    </option>
                    <%
                        }%>
                </select>
                <input type="text" placeholder="검색어를 입력하세요. (제목 + 작성자 + 내용)" name="search" class="border pl-2 w-5/12"/>
                <input type="submit" value="검색"
                       class="border rounded-sm bg-gray-100 px-5 duration-300 hover:duration-300 hover:bg-gray-200 hover:cursor-pointer"/>
            </div>
        </form>
    </div>
    <br/>
    <div>
        <div>총 <%=boardList.getCount()%>건</div>
        <br/>
        <div>
            <table class="mx-auto text-center w-full">
                <thead>
                <tr class="border-y">
                    <th class="py-1">카테고리</th>
                    <th></th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>등록 일시</th>
                    <th>수정 일시</th>
                </tr>
                </thead>
                <tbody>
                <% for (BoardSearchDto dto : boardList.getBoardSearchDtoList()) {%>
                <tr class="border-b">
                    <td class="py-1"><%=dto.getCategory()%></td>
                    <% if (dto.hasFile()) {%>
                    <td>OO</td>
                    <% } else {%>
                    <td></td>
                    <% } %>
                    <td><a href="detail.jsp?i=<%=dto.getId()%>&start_d=<%=startDate.orElse("")%>&end_d=<%=endDate.orElse("")%>&c=<%=c.orElse("")%>&search=<%=search.orElse("")%>"> <%=dto.getTitle()%></a></td>
                    <td><%=dto.getWriter()%></td>
                    <td><%=dto.getViews()%></td>
                    <td><%=dto.getCreatedDate().substring(0, 16)%></td>
                    <% if (dto.getModifiedDate() == null) {%>
                    <td>-</td>
                    <% } else {%>
                    <td><%=dto.getModifiedDate().substring(0, 16)%></td>
                    <% } %>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <br/>

    <div class="bg-red-100 text-center my-16">페이지 섹션</div>

    <br/>

    <div class="flex justify-end">
        <button type="button" onclick="create()"
                class="px-5 bg-gray-200 rounded-sm duration-300 hover:duration-300 hover:bg-gray-300">등록
        </button>
    </div>

</div>

<script type="text/javascript">
    const create = () => {
        window.location.href = "create.jsp"
    }
</script>

</body>
</html>
