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
    <meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<body class="hold-transition sidebar-mini layout-fixed">
    <div class="container" style='width:1000px;'>
        <div class="row">
            <c:forEach var="wish" items="${wList}">
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
                            <div class="btn btn-light btn-lg btn-flat">
                                <i class="far fa-file-alt fa-lg mr-2"></i>
                                <a href="/item/view/${wish.item.id}">View Product</a>
                            </div>
                            <div class="btn btn-primary btn-lg btn-flat" onclick="removeBtn(${wish.item.id})">
                                <i class="fas fa-cut fa-lg mr-2"></i>
                                Remove from Cart
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
                    <c:if test="${pageWishMake.prev}">
                        <li class="pageInfo_btn previous"><a href="${pageWishMake.startPage-1}">Previous</a></li>
                    </c:if>
                    <c:forEach var="num" begin="${pageWishMake.startPage}" end="${pageWishMake.endPage}">
                        <li class="pageInfo_btn ${pageWishMake.cri.pageNum == num ? "active":"" }"><a href="${num}">${num}</a></li>
                    </c:forEach>
                    <c:if test="${pageWishMake.next}">
                        <li class="pageInfo_btn next"><a href="${pageWishMake.endPage + 1 }">Next</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
        <form id="moveForm" method="get">
            <input type="hidden" name="pageNum" value="${pageMake.cri.pageNum }">
            <input type="hidden" name="amount" value="${pageMake.cri.amount }">
            <input type="hidden" name="type" value="board">
        </form>
    </div>
<script src="../plugins/ekko-lightbox/ekko-lightbox.min.js"></script>
<script>
    $(document).ready(function () {
        $(".removeBtn").click(function(id) {
            removeBtn(id)
        })
    });
    function removeBtn(id) {
        let confirmAlert = confirm('정말로 삭제하시겠습니까?');
        if (confirmAlert) {
            $.ajax({
                type : 'DELETE',
                url : "/wish/delete",
                data : {'id' : id},
                success : function(result) {
                    alert("해당 아이템이 정상적으로 삭제되었습니다.");
                    location.reload();
                },
                error: function(request, status, error) {
                }
            })
        }
    }
    $(".image_wrap").each(function(i, obj){
        const itemObj = $(obj);

        const uploadPath = itemObj.data("path");
        const uuid = itemObj.data("uuid");
        const fileName = itemObj.data("filename");

        const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
        $(this).find("img").attr('src', '/display?dir=item&&fileName=' + fileCallPath);

    });

    let moveFormWish = $("#moveFormWish");

    $(".pageInfoWish a").on("click", function(e){
        e.preventDefault();
        moveFormWish.find("input[name='pageNum']").val($(this).attr("href"));
        moveFormWish.attr("action", "/admin/profile/${member.id}");
        moveFormWish.submit();

    });
</script>
</body>
</html>
