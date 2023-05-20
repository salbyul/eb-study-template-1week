<%@ page import="java.util.Optional" %>
<%@ page import="com.study.SHA256" %>
<%@ page import="com.study.repository.BoardRepositoryImpl" %>
<%@ page import="com.study.dto.board.BoardDetailDto" %>
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
    String findPassword = null;
    BoardDetailDto boardDto = null;

    if (optionalIndex.isEmpty()) response.sendRedirect("404.jsp");
    else {
        if (optionalPassword.isEmpty()) response.sendRedirect("detail.jsp?i=" + optionalIndex.get() + "&btn=modify");
        password = optionalPassword.get();
        SHA256 sha256 = new SHA256();
        try {
            BoardRepositoryImpl boardRepository = new BoardRepositoryImpl();
            String encryptedPassword = sha256.encrypt(password);
            findPassword = boardRepository.findPasswordById(Long.valueOf(optionalIndex.get()));
            if (!findPassword.equals(encryptedPassword)) {
                response.sendRedirect("detail.jsp?i=" + optionalIndex.get() + "&btn=modify");
            }
            boardDto = boardRepository.findDetailByIndex(Long.valueOf(optionalIndex.get()));
            boardRepository.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
<% if (boardDto == null) {
    response.sendRedirect("404.jsp");
} %>

<div class="mt-20 w-7/12 mx-auto">

    <div>
        <%--        multipart/form-data로 변경해야 함--%>
        <form method="post" action="modify.jsp?i=<%=optionalIndex.get()%>" onsubmit="return verify()">

            <%--        카테고리--%>
            <div class="flex border-y">
                <div class="bg-gray-100 w-2/12 py-1 pl-2">
                    카테고리
                </div>
                <div class="py-1 w-9/12 pl-1">
                    <%=boardDto.getCategory()%>
                </div>
            </div>

<%--                등록 일시--%>
                <div class="flex border-y">
                    <div class="bg-gray-100 w-2/12 py-1 pl-2">
                        등록 일시
                    </div>
                    <div class="py-1 w-9/12 pl-1">
                        <%=boardDto.getCreatedDate().substring(0, 16)%>
                    </div>
                </div>

<%--                수정 일시--%>
                <div class="flex border-y">
                    <div class="bg-gray-100 w-2/12 py-1 pl-2">
                        수정 일시
                    </div>
                    <div class="py-1 w-9/12 pl-1">
                        <% if (boardDto.getModifiedDate() == null) {
                            out.println("-");
                        } else {
                            out.println(boardDto.getModifiedDate().substring(0, 16));
                        }%>
                    </div>
                </div>

<%--                조회수--%>
                <div class="flex border-y">
                    <div class="bg-gray-100 w-2/12 py-1 pl-2">
                        조회수
                    </div>
                    <div class="py-1 w-9/12 pl-1">
                        <%=boardDto.getViews()%>
                    </div>
                </div>

            <%--    작성자--%>
            <div class="flex border-b">
                <div class="bg-gray-100 w-2/12 py-1 pl-2">
                    작성자
                </div>
                <div class="py-1 w-9/12">
                    <input type="text" name="writer" class="border pl-1 ml-3 w-44" id="writer" value="<%=boardDto.getWriter()%>"/>
                </div>
            </div>

            <%--    비밀번호--%>
            <div class="flex border-b">
                <div class="bg-gray-100 w-2/12 py-1 pl-2">
                    비밀번호
                </div>
                <div class="py-1 w-9/12">
                    <input type="password" name="password" placeholder="비밀번호" class="border pl-1 ml-3 w-44" id="password"/>
                </div>
            </div>

            <%--    제목--%>
            <div class="flex border-b">
                <div class="bg-gray-100 w-2/12 py-1 pl-2">
                    제목
                </div>
                <div class="py-1 w-9/12">
                    <input type="text" name="title" class="border pl-1 ml-3 w-full" id="title" value="<%=boardDto.getTitle()%>"/>
                </div>
            </div>

            <%--                내용--%>
            <div class="flex border-b">
                <div class="bg-gray-100 w-2/12 py-1 pl-2">
                    <span class="align-middle">
                    내용
                    </span>
                </div>
                <div class="py-1 w-9/12">
                    <textarea class="resize-none w-full border pl-1 ml-3 h-32" name="content" id="content"><%=boardDto.getContent()%></textarea>
                </div>
            </div>

            <%--                파일 첨부--%>
            <div class="flex border-b">
                <div class="bg-gray-100 w-2/12 py-1 pl-2">
                    <span class="align-middle">
                    파일 첨부
                    </span>
                </div>
                <div class="py-1 w-9/12">
                    <div class="my-1">
                        <input type="text" class="border pl-1 ml-3 w-5/12 bg-white" disabled id="fileOneName"/>
                        <label for="fileOne">
                            <span class="border rounded-sm px-2">파일 찾기</span>
                        </label>
                        <input type="file" class="pl-1 ml-3 w-full" id="fileOne" name="fileOne" hidden onchange="onFileChange(1)"/>
                    </div>
                    <div class="my-1">
                        <input type="text" class="border pl-1 ml-3 w-5/12 bg-white" disabled id="fileTwoName"/>
                        <label for="fileTwo">
                            <span class="border rounded-sm px-2">파일 찾기</span>
                        </label>
                        <input type="file" class="pl-1 ml-3 w-full" id="fileTwo" name="fileTwo" hidden onchange="onFileChange(2)"/>
                    </div>
                    <div class="my-1">
                        <input type="text" class="border pl-1 ml-3 w-5/12 bg-white" disabled id="fileThreeName"/>
                        <label for="fileThree">
                            <span class="border rounded-sm px-2">파일 찾기</span>
                        </label>
                        <input type="file" class="pl-1 ml-3 w-full" id="fileThree" name="fileThree" hidden onchange="onFileChange(3)"/>
                    </div>
                </div>
            </div>
    </div>

    <br/>

    <div class="flex justify-between">
        <button onclick="window.location.href = 'detail.jsp?i=<%=boardDto.getId()%>'" class="px-5 rounded-sm border">취소</button>
        <input type="submit" value="저장" class="px-5 rounded-sm border bg-gray-100 hover:cursor-pointer"/>
    </div>
    </form>

</div>

<script type="text/javascript">

    const verify = () => {
        if (!verifyWriter()) return false;
        if (!verifyTitle()) return false;
        if (!verifyContent()) return false;
        if (!verifyPassword()) return false;
        return true;
    }

    const verifyWriter = () => {
        const writer = document.getElementById("writer");
        if (writer.value === null || writer.value === undefined || writer.value.length < 3 || writer.value.length > 4) {
            alert("작성자는 3글자 이상, 5글자 미만이어야 합니다.");
            return false;
        }
        return true;
    }

    const verifyTitle = () => {
        const title = document.getElementById("title");
        if (title.value === null || title.value === undefined || title.value.length < 4 || title.value.length > 99) {
            alert("제목은 4글자 이상, 100글자 미만이어야 합니다.");
            return false;
        }
        return true;
    }

    const verifyContent = () => {
        const content = document.getElementById("content");
        if (content.value === null || content.value === undefined || content.value.length < 4 || content.value.length > 1999) {
            alert("내용은 4글자 이상, 2000글자 미만이어야 합니다.");
            return false;
        }
        return true;
    }

    function SHA256(s){

        var chrsz   = 8;
        var hexcase = 0;

        function safe_add (x, y) {
            var lsw = (x & 0xFFFF) + (y & 0xFFFF);
            var msw = (x >> 16) + (y >> 16) + (lsw >> 16);
            return (msw << 16) | (lsw & 0xFFFF);
        }

        function S (X, n) { return ( X >>> n ) | (X << (32 - n)); }
        function R (X, n) { return ( X >>> n ); }
        function Ch(x, y, z) { return ((x & y) ^ ((~x) & z)); }
        function Maj(x, y, z) { return ((x & y) ^ (x & z) ^ (y & z)); }
        function Sigma0256(x) { return (S(x, 2) ^ S(x, 13) ^ S(x, 22)); }
        function Sigma1256(x) { return (S(x, 6) ^ S(x, 11) ^ S(x, 25)); }
        function Gamma0256(x) { return (S(x, 7) ^ S(x, 18) ^ R(x, 3)); }
        function Gamma1256(x) { return (S(x, 17) ^ S(x, 19) ^ R(x, 10)); }

        function core_sha256 (m, l) {

            var K = [0x428A2F98, 0x71374491, 0xB5C0FBCF, 0xE9B5DBA5, 0x3956C25B, 0x59F111F1,
                0x923F82A4, 0xAB1C5ED5, 0xD807AA98, 0x12835B01, 0x243185BE, 0x550C7DC3,
                0x72BE5D74, 0x80DEB1FE, 0x9BDC06A7, 0xC19BF174, 0xE49B69C1, 0xEFBE4786,
                0xFC19DC6, 0x240CA1CC, 0x2DE92C6F, 0x4A7484AA, 0x5CB0A9DC, 0x76F988DA,
                0x983E5152, 0xA831C66D, 0xB00327C8, 0xBF597FC7, 0xC6E00BF3, 0xD5A79147,
                0x6CA6351, 0x14292967, 0x27B70A85, 0x2E1B2138, 0x4D2C6DFC, 0x53380D13,
                0x650A7354, 0x766A0ABB, 0x81C2C92E, 0x92722C85, 0xA2BFE8A1, 0xA81A664B,
                0xC24B8B70, 0xC76C51A3, 0xD192E819, 0xD6990624, 0xF40E3585, 0x106AA070,
                0x19A4C116, 0x1E376C08, 0x2748774C, 0x34B0BCB5, 0x391C0CB3, 0x4ED8AA4A,
                0x5B9CCA4F, 0x682E6FF3, 0x748F82EE, 0x78A5636F, 0x84C87814, 0x8CC70208,
                0x90BEFFFA, 0xA4506CEB, 0xBEF9A3F7, 0xC67178F2];

            var HASH = new Array(0x6A09E667, 0xBB67AE85, 0x3C6EF372, 0xA54FF53A, 0x510E527F, 0x9B05688C, 0x1F83D9AB, 0x5BE0CD19);

            var W = new Array(64);
            var a, b, c, d, e, f, g, h, i, j;
            var T1, T2;

            m[l >> 5] |= 0x80 << (24 - l % 32);
            m[((l + 64 >> 9) << 4) + 15] = l;

            for ( var i = 0; i<m.length; i+=16 ) {
                a = HASH[0];
                b = HASH[1];
                c = HASH[2];
                d = HASH[3];
                e = HASH[4];
                f = HASH[5];
                g = HASH[6];
                h = HASH[7];

                for ( var j = 0; j<64; j++) {
                    if (j < 16) W[j] = m[j + i];
                    else W[j] = safe_add(safe_add(safe_add(Gamma1256(W[j - 2]), W[j - 7]), Gamma0256(W[j - 15])), W[j - 16]);

                    T1 = safe_add(safe_add(safe_add(safe_add(h, Sigma1256(e)), Ch(e, f, g)), K[j]), W[j]);
                    T2 = safe_add(Sigma0256(a), Maj(a, b, c));

                    h = g;
                    g = f;
                    f = e;
                    e = safe_add(d, T1);
                    d = c;
                    c = b;
                    b = a;
                    a = safe_add(T1, T2);
                }

                HASH[0] = safe_add(a, HASH[0]);
                HASH[1] = safe_add(b, HASH[1]);
                HASH[2] = safe_add(c, HASH[2]);
                HASH[3] = safe_add(d, HASH[3]);
                HASH[4] = safe_add(e, HASH[4]);
                HASH[5] = safe_add(f, HASH[5]);
                HASH[6] = safe_add(g, HASH[6]);
                HASH[7] = safe_add(h, HASH[7]);
            }
            return HASH;
        }

        function str2binb (str) {
            var bin = Array();
            var mask = (1 << chrsz) - 1;
            for(var i = 0; i < str.length * chrsz; i += chrsz) {
                bin[i>>5] |= (str.charCodeAt(i / chrsz) & mask) << (24 - i%32);
            }
            return bin;
        }

        function Utf8Encode(string) {
            string = string.replace(/\r\n/g,"\n");
            var utftext = "";

            for (var n = 0; n < string.length; n++) {

                var c = string.charCodeAt(n);

                if (c < 128) {
                    utftext += String.fromCharCode(c);
                }
                else if((c > 127) && (c < 2048)) {
                    utftext += String.fromCharCode((c >> 6) | 192);
                    utftext += String.fromCharCode((c & 63) | 128);
                }
                else {
                    utftext += String.fromCharCode((c >> 12) | 224);
                    utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                    utftext += String.fromCharCode((c & 63) | 128);
                }

            }

            return utftext;
        }

        function binb2hex (binarray) {
            var hex_tab = hexcase ? "0123456789ABCDEF" : "0123456789abcdef";
            var str = "";
            for(var i = 0; i < binarray.length * 4; i++) {
                str += hex_tab.charAt((binarray[i>>2] >> ((3 - i%4)*8+4)) & 0xF) +
                    hex_tab.charAt((binarray[i>>2] >> ((3 - i%4)*8  )) & 0xF);
            }
            return str;
        }

        s = Utf8Encode(s);
        return binb2hex(core_sha256(str2binb(s), s.length * chrsz));

    }

    const verifyPassword = () => {
        const password = document.getElementById("password");
        const encryptedPassword = SHA256(password);
        return encryptedPassword ===<%=findPassword%>;

    }
</script>

</body>
</html>
