<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-25
  Time: 오전 10:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<body class="hold-transition sidebar-mini layout-fixed">
    <%@ include file="/WEB-INF/views/nav.jsp" %>
    <div class="container" style='width:1000px;'>
        <div class="col-12">
            <div class="card card-primary">
                <div class="card-header">
                    <div class="card-title">
                        ITEM 목록
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <c:forEach var="wish" items="${itemList}">
                            <div class="col-md-10 col-sm-6 col-12">
                                <div class="info-box">
                                    <span class="bg-info">
                                        <div class="image_wrap" data-itemid="${wish.item.imageList[0].itemId}" data-path="${wish.item.imageList[0].upload}" data-uuid="${wish.item.imageList[0].uuid}" data-filename="${wish.item.imageList[0].fileName}">
                                            <img>
                                        </div>
                                    </span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">${wish.item.name}</span>
                                        <span class="info-box-number">${wish.item.price}</span>
                                        <div class="mt-4">
                                            <div class="btn btn-default btn-lg btn-flat">
                                                <i class="far fa-file-alt fa-lg mr-2"></i>
                                                <a href="/item/view/${wish.item.id}">View Product</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/views/footer.jsp" %>
<!-- Ekko Lightbox -->
<script src="../plugins/ekko-lightbox/ekko-lightbox.min.js"></script>
<script>
    /* 이미지 삽입 */
    $(".image_wrap").each(function(i, obj) {

        const itemObj = $(obj);

        const uploadPath = itemObj.data("path");
        const uuid = itemObj.data("uuid");
        const fileName = itemObj.data("filename");

        const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
        $(this).find("img").attr('src', '/display?dir=item&&fileName=' + fileCallPath);
        $(this).find("img").attr('style', 'width:150px; height:150px;');

    });
</script>

</body>
</html>
