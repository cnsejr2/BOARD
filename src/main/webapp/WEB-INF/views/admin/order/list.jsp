
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
    <%@ include file="/WEB-INF/views/nav.jsp" %>
    <div class="content-wrapper">
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-6">
                        <div class="col-md-12 flat-center">
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">Latest Orders</h3>
                                </div>
                                <div class="card-body p-0">
                                    <div class="table">
                                        <table class="table m-0">
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
                                                            <button type="button" class="btn btn-default dropdown-toggle dropdown-icon" data-toggle="dropdown" style="background-color: white;">
                                                                <span class="sr-only">Toggle Dropdown</span>
                                                                <div class="dropdown-menu" role="menu">
                                                                    <a class="dropdown-item" href="#" onclick="updateOrderState(0, ${order.orderId})">배송준비</a>
                                                                    <a class="dropdown-item" href="#" onclick="updateOrderState(1, ${order.orderId})">배송중</a>
                                                                    <a class="dropdown-item" href="#" onclick="updateOrderState(2, ${order.orderId})">배송완료</a>
                                                                </div>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <%@ include file="/WEB-INF/views/footer.jsp" %>
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
