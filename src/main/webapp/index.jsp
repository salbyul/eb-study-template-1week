<%@ page import="com.study.validator.IndexValidator" %>
<%@ page import="java.util.*" %>
<%@ page import="com.study.validator.SearchDto" %>
<%@ page import="com.study.repository.BoardRepositoryImpl" %>
<%@ page import="com.study.dto.board.BoardList" %>
<%@ page import="com.study.dto.board.BoardSearchDto" %>
<%@ page import="com.study.dto.board.PagingDto" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>

<%--TODO 검색 조건 쿠키?? 파라미터??--%>
<%
    Optional<String> p = Optional.ofNullable(request.getParameter("p"));
    String offset = p.orElse("0");

    Cookie[] cookies = request.getCookies();
    List<String> categoryList = new ArrayList<>();

    String startDate = null;
    String endDate = null;
    String category = null;
    String search = null;

    BoardList boardList = new BoardList();

    try {
        BoardRepositoryImpl boardRepository = new BoardRepositoryImpl();
        categoryList = boardRepository.findCategories();
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("startDate")) startDate = cookie.getValue();
            else if (cookie.getName().equals("endDate")) endDate = cookie.getValue();
            else if (cookie.getName().equals("category")) category = cookie.getValue();
            else if (cookie.getName().equals("search")) search = cookie.getValue();
        }
        IndexValidator validator = new IndexValidator(startDate, endDate, category, search);
        SearchDto searchDto = validator.getSearchDto();

        boardList.setPagingDto(new PagingDto(Integer.parseInt(offset), boardRepository.findCountBySearchDto(searchDto)));
        boardList.setBoardSearchDtoList(boardRepository.findPaging(Integer.parseInt(offset), 10, searchDto));
        boardList.getPagingDto().setPage();

        boardRepository.close();
    } catch (Exception e) {
        e.printStackTrace();
    }


%>
<div class="mx-auto mt-20 w-7/12">
    <%--    검색--%>
    <div class="border mb-5 text-center">
        <form method="get" action="index.jsp" onsubmit="return setCookies()">
            <div class="py-1">등록일
                <input type="date" name="start_d" class="border mx-7" id="startDate" <% if (startDate != null) {%> value="<%=startDate%>" <% }%>/> ~
                <input type="date" name="end_d" class="border mx-7" id="endDate" <% if (endDate != null) {%> value="<%=endDate%>" <% }%>/>
                <select name="c" class="border p-1" id="category">
                    <option value="all">전체 카테고리</option>
                    <% for (int i = 0; i < categoryList.size(); i++) {
                    %>
                    <option value=<%=categoryList.get(i)%> <% if (category != null && category.equals(categoryList.get(i))) { %> selected <% } %>><%=categoryList.get(i)%>
                    </option>
                    <%
                        }%>
                </select>
                <input type="text" placeholder="검색어를 입력하세요. (제목 + 작성자 + 내용)" name="search" class="border pl-2 w-5/12"
                       id="search" <% if (search != null) { %> value="<%=search%>" <% } %>/>
                <input type="submit" value="검색"
                       class="border rounded-sm bg-gray-100 px-5 duration-300 hover:duration-300 hover:bg-gray-200 hover:cursor-pointer"/>
            </div>
        </form>
    </div>
    <br/>

    <%--    글 목록--%>
    <div>
        <div>총 <%=boardList.getPagingDto().getTotalRowCount()%>건</div>
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
                    <td class="py-1"><%=dto.getCategory()%>
                    </td>
                    <% if (dto.hasFile()) {%>
                    <td>FILE</td>
                    <% } else {%>
                    <td></td>
                    <% } %>
                    <td>
                        <a href="detail.jsp?i=<%=dto.getId()%>&p=<%=offset%>"><%=dto.getTitle()%>
                        </a></td>
                    <td><%=dto.getWriter()%>
                    </td>
                    <td><%=dto.getViews()%>
                    </td>
                    <td><%=dto.getCreatedDate().substring(0, 16)%>
                    </td>
                    <% if (dto.getModifiedDate() == null) {%>
                    <td>-</td>
                    <% } else {%>
                    <td><%=dto.getModifiedDate().substring(0, 16)%>
                    </td>
                    <% } %>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <br/>

<%--    <div class="bg-red-100 text-center my-16 flex w-5/12 mx-auto">--%>
<%--        <div class="w-content mx-auto">--%>
<%--        <button class="mx-3"><<</button>--%>
<%--        <button class="mx-3"><</button>--%>
<%--        <%--%>
<%--            PagingDto pagingDto = boardList.getPagingDto();--%>
<%--            for (int i = pagingDto.getFirstPage(); i <= pagingDto.getLastPage(); i++) {--%>
<%--                %>--%>
<%--        <button class="ml-1"><%=i%></button>--%>
<%--        <%--%>
<%--            }--%>
<%--        %>--%>
<%--        <button class="mx-3">></button>--%>
<%--        <button class="mx-3">>></button>--%>
<%--        </div>--%>
<%--    </div>--%>

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

    const setCookies = () => {
        const startDate = document.getElementById("startDate");
        const endDate = document.getElementById("endDate");
        const category = document.getElementById("category");
        const search = document.getElementById("search");
        document.cookie = "startDate=" + startDate.value;
        document.cookie = "endDate=" + endDate.value;
        document.cookie = "category=" + category.value;
        document.cookie = "search=" + search.value;
        return true;
    }
</script>

</body>
</html>
