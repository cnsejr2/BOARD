<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-06
  Time: 오후 1:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <script
            src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous">
    </script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/css/main.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="/board/write.do">글쓰기</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/board/myList">내가 쓴 글</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/doLogout">로그아웃</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

    <%
        session = request.getSession();
        out.println(session.getAttribute("greeting") + "님, 반갑습니다.");
    %>
    <sec:authorize access="hasAnyRole('ROLE_ADMIN')">
        <div class="grid-sample" style="height: 600px;">
            <div id="grid_data" style="height: 600px;">
                관리자 입니다.
                <a href="/admin/board/list"> 회원 전체 글 목록</a>
            </div>
        </div>
    </sec:authorize>

    <div class="container">
        <h1>게시판목록</h1>
        <table class="table">
            <tr>
                <th>ID</th>
                <th>TITLE</th>
                <th>WRITER</th>
                <th>VIEW</th>
            </tr>
            <c:forEach var="b" items="${bList}">
                <tr>
                    <td>${b.ID}</td>
                    <td><a href="/board/view/${b.ID}">${b.TITLE}</a></td>
                    <td>${b.WRITER}</td>
                    <td>${b.VIEW_CNT}</td>
                </tr>
            </c:forEach>
        </table>
        <div class="pageInfo_wrap" >
            <div class="pageInfo_area">
                <ul id="pageInfo" class="pageInfo">
                    <!-- 이전페이지 버튼 -->
                    <c:if test="${pageMaker.prev}">
                        <li class="pageInfo_btn previous"><a href="${pageMaker.startPage-1}">Previous</a></li>
                    </c:if>
                    <!-- 각 번호 페이지 버튼 -->
                    <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                        <li class="pageInfo_btn ${pageMaker.cri.pageNum == num ? "active":"" }"><a href="${num}">${num}</a></li>
                    </c:forEach>
                    <!-- 다음페이지 버튼 -->
                    <c:if test="${pageMaker.next}">
                        <li class="pageInfo_btn next"><a href="${pageMaker.endPage + 1 }">Next</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
        <form id="moveForm" method="get">
            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
            <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
        </form>
    </div>
<script>
    let moveForm = $("#moveForm");

    $(".pageInfo a").on("click", function(e){
        e.preventDefault();
        moveForm.find("input[name='pageNum']").val($(this).attr("href"));
        moveForm.attr("action", "/security/main");
        moveForm.submit();

    });
</script>
</body>
</html>
