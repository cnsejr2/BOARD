<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-08
  Time: 오후 5:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>관리자 게시판목록</h1>
<table>
    <tr>
        <th>ID</th>
        <th>TITLE</th>
        <th>CONTENTS</th>
        <th>WRITER</th>
    </tr>
    <c:forEach var="b" items="${bList}">
        <tr>
            <td>${b.ID}</td>
            <td>${b.TITLE}</td>
            <td>${b.CONTENTS}</td>
            <td>${b.WRITER}</td>
        </tr>
    </c:forEach>
</table>
</body>
</html>

