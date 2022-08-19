<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-08-12
  Time: 오후 3:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
    <div class="container" style='width:1000px;'>
        <h1>주문목록</h1>
        <table class="table">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Member ID</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${oList}">
                <tr>
                    <td><a href="/admin/order/info?orderId=${order.orderId}&memberId=${order.memberId}">${order.orderId}</a></td>
                    <td>${order.memberId}</td>
                    <td>
                        <div class="btn-group">
                        <c:if test="${order.state == 0}"><button type="button" class="btn btn-default" style="background-color: #f3b7bd;">배송준비</button></c:if>
                        <c:if test="${order.state == 1}"><button type="button" class="btn btn-default" style="background-color: #f8bb86;">배송중</button></c:if>
                        <c:if test="${order.state == 2}"><button type="button" class="btn btn-default" style="background-color: #fff3cd;">배송완료</button></c:if>
                        </div>
                    </td>
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
