<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-05
  Time: 오후 2:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<tr>
  <th>ID</th>
  <th>NAME</th>
  <th>PASSWORD</th>
</tr>
  <tr>
    <td>${member.id}</td>
    <td>${member.name}</td>
    <td>${member.password}</td>
  </tr>

  회원가입 성공!
  <a href="login">login</a>
</body>
</html>
