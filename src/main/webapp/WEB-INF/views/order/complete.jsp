<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-08-11
  Time: 오후 1:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                        <div class="callout callout-info">
                            <h5><i class="fas fa-truck"></i> Note:</h5>
                            <p>주문을 완료했습니다.</p>
                            <p>배송 중에는 주문 취소 불가능합니다. </p>
                            <input type="button" class="btn btn-primary " onclick="location.href='/main'" value="메인으로">
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>
