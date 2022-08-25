let rCheck = false;            // 수령인
let pCheck = false;            // 연락처
let a1Check = false;            // 우편번호 addr1
let a2Check = false;            // addr2
let a3Check = false;            // addr3
$(document).ready(function() {
    $(".writeBtn").click(function () {
        const orderRec = $('#orderRec').val();
        const phone = $('#phone').val();
        const addr1 = $('#addr1').val();
        const addr2 = $('#addr2').val();
        const addr3 = $('#addr3').val();

        if (orderRec == "") {
            rCheck = false;
        } else {
            rCheck = true;
        }
        if (phone == "") {
            pCheck = false;
        } else {
            pCheck = true;
        }
        if (addr1 == "") {
            a1Check = false;
        } else {
            a1Check = true;
        }
        if (addr2 == "") {
            a2Check = false;
        } else {
            a2Check = true;
        }
        if (addr3 == "") {
            a3Check = false;
        } else {
            a3Check = true;
        }
        if ( rCheck&&pCheck&&a1Check&&a2Check&&a3Check ) {
            $("#orderForm").attr("action", "/order/process");
            $("#orderForm").submit();
        } else {
            alert("빈칸을 모두 입력해주세요");
        }
        return false;
    });
});

/* 다음 주소 연동 */
function execution_daum_address() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = '';
            var extraAddr = '';

            if (data.userSelectedType === 'R') {
                addr = data.roadAddress;
                addr = data.jibunAddress;
            }
            if (data.userSelectedType === 'R') {
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraAddr += data.bname;
                }
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if (extraAddr !== '') {
                    extraAddr = ' (' + extraAddr + ')';
                }
                addr += extraAddr;

            } else {
                addr += ' ';
            }
            $("#addr1").val(data.zonecode);
            $("#addr2").val(addr);
            $("#addr3").attr("readonly",false);
            $("#addr3").focus();
        }
    }).open();
}
