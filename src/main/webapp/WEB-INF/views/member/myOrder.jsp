<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-08-12
  Time: 오후 3:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
                    <th>Review</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${oList}">
                <tr>
                    <sec:authorize access="hasAnyRole('ROLE_ADMIN')">
                    <td><a href="/admin/order/info?orderId=${order.orderId}&memberId=${order.memberId}&review=${order.state}">${order.orderId}</a></td>
                    </sec:authorize>
                    <sec:authorize access="hasAnyRole('ROLE_USER')">
                        <td><a href="/profile/order/info?orderId=${order.orderId}&memberId=${order.memberId}&review=${order.state}">${order.orderId}</a></td>
                    </sec:authorize>
                    <td>${order.memberId}</td>
                    <td>
                        <div class="btn-group">
                        <c:if test="${order.state == 0}"><button type="button" class="btn btn-default" style="background-color: #f3b7bd;">배송준비</button></c:if>
                        <c:if test="${order.state == 1}"><button type="button" class="btn btn-default" style="background-color: #f8bb86;">배송중</button></c:if>
                        <c:if test="${order.state == 2}"><button type="button" class="btn btn-default" style="background-color: #fff3cd;">배송완료</button></c:if>
                        </div>
                    </td>
                    <td>
                        <c:if test="${order.state == 0}"><button type="button" class="btn btn-default" style="background-color: #f3b7bd;">리뷰작성불가능</button></c:if>
                        <c:if test="${order.state == 1}"><button type="button" class="btn btn-default" style="background-color: #f8bb86;">리뷰작성불가능</button></c:if>
                        <c:if test="${order.state == 2}"><button type="button" class="btn btn-default reviewBtn" style="background-color: #fff3cd;">리뷰작성가능</button></c:if>
                    </td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
<script>

    $(document).ready(function () {
        $(".reviewBtn").click(function() {
            location.href="/item/${item.id}/review/write.do";
        })
    });

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
