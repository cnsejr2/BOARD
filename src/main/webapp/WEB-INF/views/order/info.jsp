<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-07
  Time: 오후 5:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>PROCESS</title>
    <script
            src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous">
    </script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <script src="https://cdn.ckeditor.com/ckeditor5/34.2.0/classic/ckeditor.js"></script>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<%@ include file="/WEB-INF/views/nav.jsp" %>
<section class="content">
    <div class="container" style='width:1000px;'>
        <div class="row">
            <div class="col-md-12">
                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">ITEM INFO</h3>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th>ITEM</th>
                                <th style="width: 60px">COUNT</th>
                                <c:if test="${state == 2}">
                                <th style="width: 60px">REVIEW</th>
                                </c:if>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${cList}">
                                <tr>
                                    <div class="cart_info">
                                        <input type="hidden" class="individual_price_input" value="${item.itemPrice}">
                                        <input type="hidden" class="individual_cnt_input" value="${item.cnt}">
                                        <input type="hidden" class="individual_total_input" value="${item.cnt * item.itemPrice}">
                                    </div>
                                    <td>
                                        <table class="table-borderless">
                                            <tr>
                                                <td>
                                                    <p><span class="info-box-text">${item.itemName}</span></p>
                                                    <p><span class="info-box-number">${item.itemPrice}</span></p>
                                                </td>
                                                <td>
                                                    <p><span class="info-box-text">${item.itemSize}</span></p>
                                                    <p><span class="info-box-text">${item.itemColor}</span></p>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <p><span class="info-box-text">${item.cnt}</span></p>
                                    </td>
                                    <c:if test="${state == 2}">
                                    <td>
                                        <p><span class="info-box-text"><a href="/item/${item.itemId}/review/write.do"> 리뷰작성</a></span></p>
                                    </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th>총 합</th>
                                <th style="width: 500px">${order.amount}</th>
                            </tr>
                            </thead>

                        </table>
                    </div>
                </div>
                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">ORDER</h3>
                    </div>
                    <form id="orderForm" action="/order/process" method="POST">
                        <input type="hidden" name="_method" value="put"/>
                        <input type="hidden" name="orderId" value="${order.orderId}">
                        <input type="hidden" name="memberId" value="${order.memberId}">
                        <input type="hidden" name="amount" value="${order.amount}">
                        <div class="card-body">
                            <div class="form-group">
                                <label for="orderRec">수령인</label>
                                <input type="text" name="orderRec" id="orderRec" class="form-control" value="${order.orderRec}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="phone">수령인 연락처</label>
                                <input type="text" name="phone" id="phone" class="form-control" placeholder="-없이 입력하세요." value="${order.phone}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="addr1">우편번호</label>
                                <input type="text" name="addr1" id="addr1" class="form-control" value="${order.addr1}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="addr2">주소</label>
                                <input type="text" name="addr2" id="addr2" class="form-control" value="${order.addr2}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="addr3">상세주소</label>
                                <input type="text" name="addr3" id="addr3" class="form-control" value="${order.addr3}" readonly>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
<%@ include file="/WEB-INF/views/footer.jsp" %>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    let rCheck = false;            // 수령인
    let pCheck = false;            // 연락처
    let a1Check = false;            // 우편번호 addr1
    let a2Check = false;            // addr2
    let a3Check = false;            // addr3
    $(document).ready(function() {
        console.log("state : " + '${state}');
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
                alert("a1check : " + addr1);
                alert("a2check : " + addr2);
                $("#orderForm").attr("action", "/admin/order/info/update");
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

</script>
</body>
</html>