<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-05
  Time: 오후 3:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>

</head>
<body>
<%@ include file="/WEB-INF/views/nav.jsp" %>
<div class="container" style='width:1000px;'>
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
    <button type="button" class="btn btn-primary update-btn float-right" onclick="location.href='/security/main'"> 메인 페이지로 </button>
</div>
</body>
</html>
