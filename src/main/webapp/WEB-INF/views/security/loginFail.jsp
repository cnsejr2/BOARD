<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-06
  Time: 오후 2:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<%
    session = request.getSession();
    out.println(session.getAttribute("msg"));
%>

로그인 실패

<a href="/security/login">로그인</a>
</body>
</html>
