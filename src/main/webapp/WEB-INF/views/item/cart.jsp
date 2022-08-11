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
            <span class="card card-primary">
                <div class="card-header">
                    <div class="card-title">
                        ITEM 목록
                    </div>
                </div>
                <span class="card-body">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th style="width: 10px;">
                                    <label class="checkbox-inline">
                                        <input type="checkbox" checked="checked" id="allCheckBox" class="chk" onclick="allChecked(this)">
                                    </label>
                                </th>
                                <th>ITEM</th>
                                <th style="width: 60px">COUNT</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${itemList}">
                                <tr>
                                    <td>
                                        <div class="cart_info">
                                            <input type="hidden" class="individual_price_input" value="${item.itemPrice}">
                                            <input type="hidden" class="individual_cnt_input" value="${item.cnt}">
                                            <input type="hidden" class="individual_total_input" value="${item.cnt * item.itemPrice}">
                                            <label class="checkbox-inline">
                                                <input type="checkbox" checked="checked" class="chk" name="oneChk" onclick="oneChkClicked()"  value="${item.itemId}">
                                            </label>
                                            </div>
                                    </td>
                                    <td>
                                        <table class="table-borderless">
                                            <tr>
                                                <td>
                                                    <div class="image_wrap" data-itemid="${item.imageList[0].itemId}" data-path="${item.imageList[0].upload}" data-uuid="${item.imageList[0].uuid}" data-filename="${item.imageList[0].fileName}">
                                                        <img>
                                                    </div>
                                                </td>
                                                <td>
                                                    <p><span class="info-box-text">${item.itemName}</span></p>
                                                    <p><span class="info-box-number">${item.itemPrice}</span></p>
                                                    <p>
                                                        <div class="mt-4">
                                                        <div class="btn btn-default btn-lg btn-flat">
                                                            <i class="far fa-file-alt fa-lg mr-2"></i>
                                                            <a href="/item/view/${item.itemId}">View Product</a>
                                                        </div>
                                                    </div>
                                                    </p>
                                                </td>
                                                <td>
                                                    <p><span class="info-box-text">${item.itemSize}</span></p>
                                                    <p><span class="info-box-text">${item.itemColor}</span></p>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <input type="number" id="num_${item.cartItemId}" min="1" max="9" value="${item.cnt}">
                                        <button type="button" class="btn btn-primary update-btn" onclick="updateItem(${item.cartItemId})">수정</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <button type="button" class="btn btn-primary update-btn float-right" onclick="cartItemDelete();"> 아이템 삭제 </button>
                </span>
            </span>
        </div>
        <!-- fix for small devices only -->
        <div class="clearfix hidden-md-up"></div>

        <div class="col-12 col-sm-6 col-md-12">
            <div class="info-box mb-3">
                <span class="info-box-icon bg-success elevation-1"><i class="fas fa-shopping-cart"></i></span>

                <div class="info-box-content">
                    <span class="info-box-text">Total Price</span>
                    <span class="info-box-number finalTotalPrice"></span>
                </div>
            </div>
        </div>
        <%@ include file="/WEB-INF/views/footer.jsp" %>
    </div>
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
        $(this).find("img").attr('src', '/displayItem?fileName=' + fileCallPath);

    });

    //체크박스 전체 선택 클릭 이벤트
    function allChecked(target) {

        if ($(target).is(":checked")) {
            $(".chk").prop("checked", true);
        } else {
            $(".chk").prop("checked", false);
        }
    }

    function oneChkClicked() {

        let allCount = $("input:checkbox[name=oneChk]").length;

        let checkedCount = $("input:checkbox[name=oneChk]:checked").length;

        if(allCount == checkedCount) {
            $(".chk").prop("checked", true);
        } else {
            $("#allCheckBox").prop("checked", false);
        }
    }
    $(document).ready(function () {
        calculateTotal();
    });

    $(".chk").on("change", function() {
        calculateTotal();
    });
    function calculateTotal() {
        let totalPrice = 0;

        $(".cart_info").each(function (index, element) {
            if ($(element).find(".chk").is(":checked") === true) {
                // 총 가격
                let total = $(element).find(".individual_total_input").val()
                totalPrice += parseInt(total);
            }
        });

        $(".finalTotalPrice").text(totalPrice.toLocaleString());
    }
    function cartItemDelete(){

        let itemIdxArray = [];

        $("input:checkbox[name='oneChk']:checked").each(function(){
            console.log("배열 추가" + $(this).val())
            itemIdxArray.push($(this).val())
        });

        if(itemIdxArray.length === 0){
            alert("삭제할 항목을 선택해주세요.");
            return false;
        }

        let confirmAlert = confirm('정말로 삭제하시겠습니까?');
        if(confirmAlert){

            $.ajax({
                type : 'DELETE',
                url : "/item/cart/multi/delete",
                dataType : 'json',
                data : JSON.stringify(itemIdxArray),
                contentType: 'application/json',
                success : function(result) {
                    alert("해당글이 정상적으로 삭제되었습니다.");
                    location.href="/item/cart";
                },
                error: function(request, status, error) {
                }
            })
        }
    }
    function updateItem(item) {
        const cnt = $("#num_" + item).val();

        $.ajax({
            type : 'PUT',
            url : "/item/cart/update/" + item,
            data : {'itemId' : item, 'cnt' : cnt },
            success : function(result) {
                alert("수정 완료되었습니다.");
                location.href="/item/cart";
            },
            error: function(request, status, error) {
            }
        })
    }
</script>
</body>
</html>
