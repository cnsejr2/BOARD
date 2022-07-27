<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-18
  Time: 오후 3:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<%@ include file="/WEB-INF/views/nav.jsp" %>

<div class="container" style='width:1000px;'>
    <h1>" ${keyword} " 검색 결과 목록 ${sort}</h1>
    <div class="col-auto">
        <a id="view_cnt" href="/getSearch?keyword=${keyword}&sort=view_cnt" style="text-decoration-line: none; text-decoration-color: darkgrey">조회수 순</a> |
<%--        <a class="btn btn-primary" href="">좋아요 순</a>--%>
        <a id="id" href="/getSearch?keyword=${keyword}&sort=id" style="text-decoration-line: none; text-decoration-color: darkgrey">최신 순</a>
    </div>
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
    <a href="/security/main">메인으로가기</a>
</div>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>
