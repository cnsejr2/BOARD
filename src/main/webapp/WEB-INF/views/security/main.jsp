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
        <ul class="paging">
            <c:if test="${paging.prev}">
                <span><a href='<c:url value="/security/main?page=${paging.startPage-1}"/>'>이전</a></span>
            </c:if>
            <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="num">
                <span><a href='<c:url value="/security/main?page=${num}"/>'>${num}</a></span></c:forEach>
            <c:if test="${paging.next && paging.endPage>0}">
                <span><a href='<c:url value="/security/main?page=${paging.endPage+1}"/>'>다음</a></span>
            </c:if>
        </ul>

    </div>
</body>
</html>
