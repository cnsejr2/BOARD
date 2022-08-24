<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-08-23
  Time: 오후 4:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="container" style='width:1000px;'>
    <h1>리뷰 작성 목록</h1>
    <table class="table">
        <thead>
        <tr>
            <th>Item ID</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="review" items="${rList}">
            <tr>
                <td><a href="/admin/order/info?orderId=${order.orderId}&memberId=${order.memberId}">${order.orderId}</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<script>
    function updateOrderState(state, id) {
        console.log("상태 변화");
        let param = {};
        param = {"state" : state, "id" : id};

        console.log(param);

        $.ajax({
            type : 'PUT',
            url : "/admin/order/state/update",
            data : {state : state, id : id},
            success: function(result) {
                console.log("수정 완료");
                location.reload();
            }
        });
    }
</script>
</body>
</html>
