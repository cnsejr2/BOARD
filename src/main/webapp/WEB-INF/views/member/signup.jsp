<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<html>
<head>
    <meta charset="UTF-8">
</head>
<body>
<form method="post" action="/member/signup">
    <div class="container">
        <h1>회원가입</h1>
<%--        <div class="form-group">--%>
<%--            <label for="id">userId</label>--%>
<%--            <input type="text" class="form-control" id="id" name="id" placeholder="사용자 아이디">--%>
<%--        </div>--%>
<%--        <div class="form-group">--%>
<%--            <label for="name">userName</label>--%>
<%--            <input type="text" class="form-control" id="name" name="name" placeholder="사용자 이름">--%>
<%--        </div>--%>
<%--        <div class="form-group">--%>
<%--            <label for="password">password</label>--%>
<%--            <input type="password" class="form-control" id="password" name="password" placeholder="사용자 비밀번호">--%>
<%--        </div>--%>
        <form:form method="POST"
                   action="/singup" modelAttribute="member">
            <table>
                <tr>
                    <td><form:label path="name">Name</form:label></td>
                    <td><form:input path="name"/></td>
                </tr>
                <tr>
                    <td><form:label path="id">Id</form:label></td>
                    <td><form:input path="id"/></td>
                </tr>
                <tr>
                    <td><form:label path="password">
                        password</form:label></td>
                    <td><form:input path="password"/></td>
                </tr>
                <tr>
                    <td><input type="submit" value="Submit"/></td>
                </tr>
            </table>
        </form:form>
        <button type="submit" class="btn btn-primary">가입 완료</button>
    </div>
</form>
</body>
</html>