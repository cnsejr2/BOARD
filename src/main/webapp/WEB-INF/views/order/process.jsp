<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-07
  Time: 오후 5:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="item" items="${cList}">
                                    <tr>
                                        <div class="cart_info">
                                            <input type="hidden" class="individual_price_input" value="${item.itemPrice}">
                                            <input type="hidden" class="individual_cnt_input" value="${item.cnt}">
                                            <input type="hidden" class="individual_total_input" value="${item.cnt * item.itemPrice}">
                                            <c:set var="total" value="${total + (item.cnt * item.itemPrice) }" />
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
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th>총 합</th>
                                <th style="width: 500px"><c:out value="${ total }원"></c:out></th>
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
                            <input type="hidden" name="orderId" value="${orderId}">
                            <input type="hidden" name="memberId" value="${memberId}">
                            <input type="hidden" name="amount" value="${amount}">
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="orderRec">수령인</label>
                                    <input type="text" name="orderRec" id="orderRec" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label for="phone">수령인 연락처</label>
                                    <input type="text" name="phone" id="phone" class="form-control" placeholder="-없이 입력하세요.">
                                </div>
                                <div class="form-group">
                                    <label for="addr1">우편번호</label>
                                    <input type="text" name="addr1" id="addr1" class="form-control" readonly>
                                    <input type="button" class="btn btn-outline-primary btn-sm" onclick="execution_daum_address()" value="주소찾기" />
                                </div>
                                <div class="form-group">
                                    <label for="addr2">주소</label>
                                    <input type="text" name="addr2" id="addr2" class="form-control" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="addr3">상세주소</label>
                                    <input type="text" name="addr3" id="addr3" class="form-control">
                                </div>
                            </div>
                            <input type="button" class="btn btn-outline-primary btn-sm writeBtn" value="주문완료" />
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <%@ include file="/WEB-INF/views/footer.jsp" %>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="/js/order/process.js"></script>

</body>
</html>