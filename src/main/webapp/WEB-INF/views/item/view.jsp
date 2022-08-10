<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-25
  Time: 오전 10:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<%@ include file="/WEB-INF/views/nav.jsp" %>
<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>E-commerce</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item active">E-commerce</li>
                    </ol>
                </div>
            </div>
        </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        <form>
            <!-- Default box -->
            <div class="card card-solid">
                <div class="card-body">
                    <div class="row">
                        <div class="col-12 col-sm-6">
                            <h3 class="d-inline-block d-sm-none"></h3>
                            <div>
                                <div class="image_wrap" data-itemid="${item.imageList[0].itemId}" data-path="${item.imageList[0].upload}" data-uuid="${item.imageList[0].uuid}" data-filename="${item.imageList[0].fileName}">
                                    <img>
                                </div>
                            </div>
<%--                            <div class="col-12 product-image-thumbs">--%>
<%--                                <div class="product-image-thumb active"><img src="../../dist/img/prod-1.jpg" alt="Product Image"></div>--%>
<%--                                <div class="product-image-thumb" ><img src="../../dist/img/prod-2.jpg" alt="Product Image"></div>--%>
<%--                                <div class="product-image-thumb" ><img src="../../dist/img/prod-3.jpg" alt="Product Image"></div>--%>
<%--                                <div class="product-image-thumb" ><img src="../../dist/img/prod-4.jpg" alt="Product Image"></div>--%>
<%--                                <div class="product-image-thumb" ><img src="../../dist/img/prod-5.jpg" alt="Product Image"></div>--%>
<%--                            </div>--%>
                        </div>
                        <div class="col-12 col-sm-6">
                            <h3 class="my-3">${item.name}</h3>
                            <p>Raw denim you probably haven't heard of them jean shorts Austin. Nesciunt tofu stumptown aliqua butcher retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui irure terr.</p>

                            <hr>
                            <h4>Available Colors</h4>
                            <div class="row">
                                <div class="col-sm-6">
                                    <!-- select -->
                                    <div class="form-group">
                                        <label>
                                            Select
                                            <select id="color-select" class="form-control">
                                                <option value="">Check Color</option>
                                                <c:forEach var="color" items="${iColor}">
                                                    <option id="color_${color}" value="${color}" class="fas"
                                                            style="font-size:15px; color:${color};"> ${color}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <h4 class="mt-3">Size <small>Please select one</small></h4>
                            <div class="row">
                                <div class="col-sm-6">
                                    <!-- select -->
                                    <div class="form-group">
                                        <label>
                                            Select
                                            <select id="size-select" class="form-control">
                                                <option value="">Check Size</option>
                                                <c:forEach var="size" items="${iSize}">
                                                    <option id="size_${size}" value="${size}" class="fas"
                                                            style="font-size:15px; color:${color};"> ${size}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </label>

                                    </div>
                                </div>
                            </div>
                            <h4 class="mt-3">Count <small>Min one Max nine</small></h4>
                            <div class="row">
                                <div class="col-sm-6">
                                    <!-- select -->
                                    <div class="form-group">
                                        Select
                                        <input type="number" id="cnt-select" min="1" max="9" value="1">
                                    </div>
                                </div>
                            </div>

                            <div class="bg-gray py-2 px-3 mt-4">
                                <h2 class="mb-0">
                                    <i class="fas fa-comment-dollar"></i>${item.price}
                                </h2>
                                <h4 class="mt-0">
                                    <small>Ex Tax: ${item.price} </small>
                                </h4>
                            </div>

                            <div class="mt-4">
                                <div class="btn btn-primary btn-lg btn-flat cartBtn">
                                    <i class="fas fa-cart-plus fa-lg mr-2"></i>
                                    Add to Cart
                                </div>

                                <div class="btn btn-default btn-lg btn-flat wishBtn">
                                    <i class="fas fa-heart fa-lg mr-2"></i>
                                    Add to Wishlist
                                </div>
                            </div>

                            <div class="mt-4 product-share">
                                <a href="#" class="text-gray">
                                    <i class="fab fa-facebook-square fa-2x"></i>
                                </a>
                                <a href="#" class="text-gray">
                                    <i class="fab fa-twitter-square fa-2x"></i>
                                </a>
                                <a href="#" class="text-gray">
                                    <i class="fas fa-envelope-square fa-2x"></i>
                                </a>
                                <a id="btnKakao" href="javascript:shareSNSKakao();" class="text-gray">
                                    <i class="fas fa-rss-square fa-2x"></i>
                                </a>
                            </div>

                        </div>
                    </div>
                    <div class="row mt-4">
                        <nav class="w-100">
                            <div class="nav nav-tabs" id="product-tab" role="tablist">
                                <a class="nav-item nav-link active" id="product-desc-tab" data-toggle="tab" href="#product-desc" role="tab" aria-controls="product-desc" aria-selected="true">Description</a>
                                <a class="nav-item nav-link" id="product-comments-tab" data-toggle="tab" href="#product-comments" role="tab" aria-controls="product-comments" aria-selected="false">Comments</a>
                                <a class="nav-item nav-link" id="product-rating-tab" data-toggle="tab" href="#product-rating" role="tab" aria-controls="product-rating" aria-selected="false">Rating</a>
                            </div>
                        </nav>
                        <div class="tab-content p-3" id="nav-tabContent">
                            <div class="tab-pane fade show active" id="product-desc" role="tabpanel" aria-labelledby="product-desc-tab"> ${item.info}</div>
                            <div class="tab-pane fade" id="product-comments" role="tabpanel" aria-labelledby="product-comments-tab"> Vivamus rhoncus nisl sed venenatis luctus. Sed condimentum risus ut tortor feugiat laoreet. Suspendisse potenti. Donec et finibus sem, ut commodo lectus. Cras eget neque dignissim, placerat orci interdum, venenatis odio. Nulla turpis elit, consequat eu eros ac, consectetur fringilla urna. Duis gravida ex pulvinar mauris ornare, eget porttitor enim vulputate. Mauris hendrerit, massa nec aliquam cursus, ex elit euismod lorem, vehicula rhoncus nisl dui sit amet eros. Nulla turpis lorem, dignissim a sapien eget, ultrices venenatis dolor. Curabitur vel turpis at magna elementum hendrerit vel id dui. Curabitur a ex ullamcorper, ornare velit vel, tincidunt ipsum. </div>
                            <div class="tab-pane fade" id="product-rating" role="tabpanel" aria-labelledby="product-rating-tab"> Cras ut ipsum ornare, aliquam ipsum non, posuere elit. In hac habitasse platea dictumst. Aenean elementum leo augue, id fermentum risus efficitur vel. Nulla iaculis malesuada scelerisque. Praesent vel ipsum felis. Ut molestie, purus aliquam placerat sollicitudin, mi ligula euismod neque, non bibendum nibh neque et erat. Etiam dignissim aliquam ligula, aliquet feugiat nibh rhoncus ut. Aliquam efficitur lacinia lacinia. Morbi ac molestie lectus, vitae hendrerit nisl. Nullam metus odio, malesuada in vehicula at, consectetur nec justo. Quisque suscipit odio velit, at accumsan urna vestibulum a. Proin dictum, urna ut varius consectetur, sapien justo porta lectus, at mollis nisi orci et nulla. Donec pellentesque tortor vel nisl commodo ullamcorper. Donec varius massa at semper posuere. Integer finibus orci vitae vehicula placerat. </div>
                        </div>
                    </div>
                </div>
                <!-- /.card-body -->
            </div>
            <!-- /.card -->
        </form>
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->

<%@ include file="/WEB-INF/views/footer.jsp" %>
<!-- Ekko Lightbox -->
<script src="../plugins/ekko-lightbox/ekko-lightbox.min.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>

    let itemSize
    let itemColor
    let itemCnt
    $(document).ready(function () {
        $(".cartBtn").click(function() {
            itemSize = $("#size-select").val();
            itemColor = $("#color-select").val();
            itemCnt = $("#cnt-select").val();
            if (itemColor == "" || itemSize == "") {
                alert("사이즈와 색상을 선택해주세요")
            } else {
                cartItem()
            }
        });

        $(".wishBtn").click(function() {
            wishBtn()
        })
    });

    function wishBtn() {
        console.log("wish 클릭")
        $.ajax({
            type : "GET",
            url : "/item/hadWishItem",
            data : {'id' : ${item.id}},
            success : function(likeCheck) {
                if(likeCheck != 1){
                    alert("wish 추가완료.");
                    location.reload();
                }
                else {
                    alert("이미 추가한 아이템입니다");
                    location.reload();
                }
            },
            error : function(){
                alert("통신 에러");
            }
        });
    }

    function cartItem() {
        $.ajax({
            type : "GET",
            url : "/item/saveCartItem",
            data : {'id' : ${item.id}, 'itemSize' : itemSize, 'itemColor' : itemColor,
                'itemCnt' : itemCnt, 'itemName' : '${item.name}', 'itemPrice' : '${item.price}'},
            success : function(cartCheck) {
                if(cartCheck != 1){
                    alert("카트추가완료.");
                    location.reload();
                }
                else {
                    alert("이미 추가한 아이템 입니다");
                    location.reload();
                }
            },
            error : function(){
                alert("통신 에러");
            }
        });
    }

    /* 이미지 삽입 */
    $(".image_wrap").each(function(i, obj){

        const itemObj = $(obj);

        const uploadPath = itemObj.data("path");
        const uuid = itemObj.data("uuid");
        const fileName = itemObj.data("filename");

        const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
        console.log("file" + fileCallPath)
        $(this).find("img").attr('src', '/displayItem?fileName=' + fileCallPath);

    });

    function shareSNSKakao() {
        // 사용할 앱의 JavaScript 키 설정
        Kakao.init('c17b5563968f2fffd356919521833ce2');

        // 카카오링크 버튼 생성
        Kakao.Link.createDefaultButton({
            container: '#btnKakao', // 카카오공유버튼ID
            objectType: 'feed',
            content: {
                title: "${item.name}", // 보여질 제목
                description: "아이템 정보 공유", // 보여질 설명
                imageUrl: "https://mud-kage.kakao.com/dn/NTmhS/btqfEUdFAUf/FjKzkZsnoeE4o19klTOVI1/openlink_640x640s.jpg", // 콘텐츠 URL
                link: {
                    mobileWebUrl: "http://localhost:8080/item/view/${item.id}",
                    webUrl: "http://localhost:8080/item/view/${item.id}"
                }
            }
        });
    }

</script>
</body>
</html>
