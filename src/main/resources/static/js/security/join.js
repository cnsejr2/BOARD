
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