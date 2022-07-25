<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-25
  Time: 오전 10:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="container" style='width:1000px;'>
    <h1>게시판목록</h1>
    <table class="table">
        <tr>
            <th>ID</th>
            <th>NAME</th>
        </tr>
        <c:forEach var="item" items="${itemList}">
            <tr>
                <td>${item.ID}</td>
                <td>${item.NAME}</td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
