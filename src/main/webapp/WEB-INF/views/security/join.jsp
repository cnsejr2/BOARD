<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script
            src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous">

    </script>
<%--    <link rel="stylesheet" type="text/css" href="/css/join.css">--%>
    <link rel="stylesheet" type="text/css" href="/css/joinForm.css">
</head>
<body>
    <div class="wrapper fadeInDown">
        <div id="formContent">
            <form id="join_form" action="/security/login/insert" method="post">
                <div class="wrap">
                    <div class="subject">
                        <h1>회원가입</h1>
                    </div>
                    <div class="id_wrap">
                        <div class="id_name">아이디</div>
                        <div class="id_input_box">
                            <input type="text" class="id_input fadeIn second" name="id">
                        </div>
                        <span class="id_input_re_1">사용 가능한 아이디입니다.</span>
                        <span class="id_input_re_2">아이디가 이미 존재합니다.</span>
                        <span class="final_id_ck_1">아이디를 입력해주세요.</span>
                        <span class="final_id_ck_2">아이디는 5글자 이상이여야 합니다.</span>
                    </div>
                    <div class="pw_wrap">
                        <div class="pw_name">비밀번호</div>
                        <div class="pw_input_box">
                            <input type="password" class="pw_input fadeIn second" name="password">
                        </div>
                        <span class="final_pw_ck">비밀번호를 입력해주세요.</span>
                    </div>
                    <div class="pwck_wrap">
                        <div class="pwck_name">비밀번호 확인</div>
                        <div class="pwck_input_box">
                            <input type="password" class="pwck_input fadeIn second" name="pwck_input">
                        </div>
                        <span class="final_pwck_ck">비밀번호 확인을 입력해주세요.</span>
                        <span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
                        <span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
                    </div>
                    <div class="user_wrap">
                        <div class="user_name">이름</div>
                        <div class="user_input_box">
                            <input type="text" class="user_input fadeIn second" name="memberName">
                        </div>
                        <span class="final_name_ck">이름을 입력해주세요.</span>
                    </div>
                    <div class="mail_wrap">
                        <div class="mail_name">이메일</div>
                        <div class="mail_input_box">
                            <input type="text" class="mail_input fadeIn second" name="email">
                        </div>
                        <span class="final_mail_ck">이메일을 입력해주세요.</span>
                        <span class="mail_input_box_warn"></span>
                    </div>
                    <input type="hidden" id="userRole" name="userRole" value="ROLE_USER">
                    <input class="underlineHover join_button" type="button" value="가입하기">
                </div>
            </form>
        </div>
    </div>
<script type="text/javascript" src="/js/security/join.js"></script>
</body>
</html>