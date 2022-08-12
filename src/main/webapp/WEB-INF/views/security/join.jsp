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
<script>
    let idCheck = false;            // 아이디
    let idckCheck = false;            // 아이디 중복 검사
    let pwCheck = false;            // 비번
    let pwckCheck = false;            // 비번 확인
    let pwckcorCheck = false;        // 비번 확인 일치 확인
    let nameCheck = false;            // 이름
    let mailCheck = false;            // 이메일


    $(document).ready(function() {
        $(".join_button").click(function() {
            const id = $('.id_input').val();                 // id 입력란
            const pw = $('.pw_input').val();                // 비밀번호 입력란
            const pwck = $('.pwck_input').val();            // 비밀번호 확인 입력란
            const name = $('.user_input').val();            // 이름 입력란
            const email = $('.mail_input').val();            // 이메일 입력란

            /* 아이디 유효성검사 */
            if (id == "") {
                $('.final_id_ck_1').css('display','block');
                $('.final_id_ck_2').css('display', 'none');
                idCheck = false;
            } else if (id.length < 5) {
                $('.final_id_ck_2').css('display','block');
                idCheck = false;
            } else {
                $('.final_id_ck_1').css('display', 'none');
                $('.final_id_ck_2').css('display', 'none');
                idCheck = true;
            }
            /* 비밀번호 유효성 검사 */
            if (pw == "") {
                $('.final_pw_ck').css('display','block');
                pwCheck = false;
            } else {
                $('.final_pw_ck').css('display', 'none');
                pwCheck = true;
            }
            /* 비밀번호 확인 유효성 검사 */
            if (pwck == "") {
                $('.final_pwck_ck').css('display','block');
                pwckCheck = false;
            } else {
                $('.final_pwck_ck').css('display', 'none');
                pwckCheck = true;
            }
            /* 이름 유효성 검사 */
            if (name == "") {
                $('.final_name_ck').css('display','block');
                nameCheck = false;
            } else {
                $('.final_name_ck').css('display', 'none');
                nameCheck = true;
            }
            const warnMsg = $(".mail_input_box_warn")
            /* 이메일 유효성 검사 */
            if (email == "") {
                $('.final_mail_ck').css('display','block');
                $('.mail_input_box_warn').css('display','none');
                mailCheck = false;
            } else if (!mailFormCheck(email)) {
                $('.final_mail_ck').css('display', 'none');
                warnMsg.html("올바르지 못한 이메일 형식입니다.");
                warnMsg.css("display", "inline-block");
                mailCheck = false;
            } else {
                $('.final_mail_ck').css('display', 'none');
                $('.mail_input_box_warn').css('display','none');
                mailCheck = true;
            }
            /* 최종 유효성 검사 */
            if ( idCheck&&idckCheck&&pwCheck&&pwckCheck&&pwckcorCheck&&nameCheck&&mailCheck ) {
                console.log("Error O")
                //회원가입 버튼(회원가입 기능 작동
                    $("#join_form").attr("action", "/security/login/insert");
                    $("#join_form").submit();
            }
            return false;
        });
    });
    //아이디 중복검사
    $('.id_input').on("propertychange change keyup paste input", function() {

        const id = $('.id_input').val();			// .id_input에 입력되는 값
        const data = {id: id};				// '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'

        $.ajax({
            type : "POST",
            url : "/security/login/insert/IdChk",
            data : data,
            success : function(result){
                // console.log("성공 여부" + result);
                if (id.length >= 5) {
                    if(result != 'fail') {
                        // 아이디 중복이 없는 경우
                        idckCheck = true;
                        $('.id_input_re_1').css("display","inline-block");
                        $('.id_input_re_2').css("display", "none");
                        $('.final_id_ck_1').css("display", "none");
                        $('.final_id_ck_2').css('display','none');
                    } else {
                        // 아이디 중복된 경우
                        idckCheck = false;
                        $('.id_input_re_1').css("display","none");
                        $('.id_input_re_2').css("display", "inline-block");
                        $('.final_id_ck_1').css("display", "none");
                        $('.final_id_ck_2').css('display','none');
                    }
                } else {
                    idCheck = false;
                    $('.id_input_re_1').css("display","none");
                    $('.id_input_re_2').css("display", "none");
                    $('.final_id_ck_1').css("display", "none");
                    $('.final_id_ck_2').css('display','block');
                }

            }// success 종료
        }); // ajax 종료

    });// function 종료
    /* 비밀번호 확인 일치 유효성 검사 */

    $('.pwck_input').on("propertychange change keyup paste input", function() {
        const pw = $('.pw_input').val();
        const pwck = $('.pwck_input').val();
        $('.final_pwck_ck').css('display', 'none');

        if (pw == pwck) {
            $('.pwck_input_re_1').css('display','block');
            $('.pwck_input_re_2').css('display','none');
            pwckcorCheck = true;
        } else {
            $('.pwck_input_re_1').css('display','none');
            $('.pwck_input_re_2').css('display','block');
            pwckcorCheck = false;
        }
    });
    /* 입력 이메일 형식 유효성 검사 */
    function mailFormCheck(email) {
        const form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
        return form.test(email);
    }
</script>
</body>
</html>