<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-06
  Time: 오후 1:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/loginForm.css">


</head>
<body>
<%--<div class="wrapper fadeInDown">--%>
<div class="wrapper">
    <div id="formContent">
        <h5>로그인</h5>
        <!-- Login Form -->
        <form id="login_form" action="/doLogin" method="POST">
            <input class="form-control id_input second" type="text" name="username" id="id" placeholder="아이디"/>
            <input class="form-control pw_input third" type="password" name="pw" id="pwd" placeholder="비밀번호"/>
            <p class=" fourth "><input type="checkbox" name="remember"> 로그인 유지</p>
            <input type="button" id="login_button" class="fourth" value="로그인">
            <c:if test="${result eq 'fail'}">
                <p>ID 또는 비밀번호가 잘못입력되었습니다.</p>
                <% session.invalidate(); %>
            </c:if>
        </form>
        <div id="formFooter">
            <a class="underlineHover" href="/security/login/insert" style="text-decoration-line : none;">회원가입</a>
        </div>
    </div>
</div>
<script>

    let idCheck = false;            // 아이디
    let pwCheck = false;
    $(document).ready(function() {
        $("#login_button").click(function() {
            const id = $('.id_input').val();                 // id 입력란
            const pw = $('.pw_input').val();
            if (id == "") {
                idCheck = false;
            } else {
                idCheck = true;
            }
            /* 비밀번호 유효성 검사 */
            if (pw == "") {
                pwCheck = false;
            } else {
                pwCheck = true;
            }
            if (idCheck&&pwCheck ) {
                //회원가입 버튼(회원가입 기능 작동
                $("#login_form").attr("action", "/doLogin");
                $("#login_form").submit();
            } else {
                alert('ID 와 비밀번호 둘다 입력해주세요');
            }
        });
    });
</script>
</body>
</html>
