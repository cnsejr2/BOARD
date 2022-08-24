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
    <link rel="stylesheet" type="text/css" href="/css/main.css">
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
                        <c:forEach var="item" items="${itemList}">
                            <div class="col-md-12 col-sm-6 col-12">
                                <div class="info-box">
                                    <span class="bg-info">
                                        <div class="image_wrap" data-itemid="${item.imageList[0].itemId}" data-path="${item.imageList[0].upload}" data-uuid="${item.imageList[0].uuid}" data-filename="${item.imageList[0].fileName}">
                                            <img>
                                        </div>
                                    </span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">${item.name}</span>
                                        <span class="info-box-number">${item.price}</span>
                                        <div class="mt-4">
                                            <div class="btn btn-default btn-lg btn-flat">
                                                <i class="far fa-file-alt fa-lg mr-2"></i>
                                                <a href="/item/view/${item.id}">View Product</a>
                                            </div>
                                            <div class="btn btn-default btn-lg btn-flat wishBtn" onclick="wishBtn(${item.id})">
                                                <i class="fas fa-heart fa-lg mr-2"></i>
                                                Add to Wishlist
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="pageInfo_wrap" >
                        <div class="pageInfo_area">
                            <ul id="pageInfo" class="pageInfo">
                                <!-- 이전페이지 버튼 -->
                                <c:if test="${pageMake.prev}">
                                    <li class="pageInfo_btn previous"><a href="${pageMake.startPage-1}">Previous</a></li>
                                </c:if>
                                <!-- 각 번호 페이지 버튼 -->
                                <c:forEach var="num" begin="${pageMake.startPage}" end="${pageMake.endPage}">
                                    <li class="pageInfo_btn ${pageMake.cri.pageNum == num ? "active":"" }"><a href="${num}">${num}</a></li>
                                </c:forEach>
                                <!-- 다음페이지 버튼 -->
                                <c:if test="${pageMake.next}">
                                    <li class="pageInfo_btn next"><a href="${pageMake.endPage + 1 }">Next</a></li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                    <form id="moveForm" method="get">
                        <input type="hidden" name="pageNum" value="${pageMake.cri.pageNum }">
                        <input type="hidden" name="amount" value="${pageMake.cri.amount }">
                    </form>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/views/footer.jsp" %>
<script src="../plugins/ekko-lightbox/ekko-lightbox.min.js"></script>
<script>

    $(document).ready(function () {
        $(".wishBtn").click(function(id) {
            wishBtn(id)
        })
    });

    let moveForm = $("#moveForm");

    $(".pageInfo a").on("click", function(e) {
        e.preventDefault();
        moveForm.find("input[name='pageNum']").val($(this).attr("href"));
        moveForm.attr("action", "/item/list");
        moveForm.submit();

    });

    /* 이미지 삽입 */
    $(".image_wrap").each(function(i, obj) {

        const itemObj = $(obj);

        const uploadPath = itemObj.data("path");
        const uuid = itemObj.data("uuid");
        const fileName = itemObj.data("filename");

        const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
        console.log("fileCallPath : " + fileCallPath);
        $(this).find("img").attr('src', '/displayItem?fileName=' + fileCallPath);
        $(this).find("img").attr('style', 'width:150px; height:150px;');

    });
    function wishBtn(id) {
        console.log("wish 클릭")
        $.ajax({
            type : "GET",
            url : "/item/hadWishItem",
            data : {'id' : id },
            success : function(likeCheck) {
                if (likeCheck != 1) {
                    alert("wish 추가완료.");
                    location.reload();
                } else {
                    alert("이미 추가한 아이템입니다");
                    location.reload();
                }
            },
            error : function() {
                alert("통신 에러");
            }
        });
    }
</script>

</body>
</html>
