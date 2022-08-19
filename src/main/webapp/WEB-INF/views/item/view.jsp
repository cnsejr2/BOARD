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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/ekko-lightbox/5.3.0/ekko-lightbox.css" rel="stylesheet">

    <style>
        .modal{
            position:absolute; width:100px; height:100px; background: rgba(199, 199, 199, 0.29); top:0; left:0; display:none;
        }
        .modal_content{
            width:600px; height:400px;
            background:#fff; border-radius:10px;
            position:relative; top:35%; left:50%;
            margin-top:-100px; margin-left:-200px;
            text-align:center;
            box-sizing:border-box; padding:74px 0;
            line-height:23px; cursor:pointer;
        }

    </style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
    <%@ include file="/WEB-INF/views/nav.jsp" %>
    <div class="content-wrapper">
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
            </div>
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
                                    <a class="nav-item nav-link" id="product-comments-tab" data-toggle="tab" href="#product-comments" role="tab" aria-controls="product-comments" aria-selected="false">Review</a>
                                    <a class="nav-item nav-link" id="product-rating-tab" data-toggle="tab" href="#product-rating" role="tab" aria-controls="product-rating" aria-selected="false">Rating</a>
                                </div>
                            </nav>
                            <div class="tab-content p-3" id="nav-tabContent">
                                <div class="tab-pane fade show active" id="product-desc" role="tabpanel" aria-labelledby="product-desc-tab"> ${item.info} | ${item.regDate}</div>
                                <div class="tab-pane fade" id="product-comments" role="tabpanel" aria-labelledby="product-comments-tab">
                                    <div class="card-body" id="review">
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="product-rating" role="tabpanel" aria-labelledby="product-rating-tab">
                                    <div class="row justify-content-center">
                                        <div class="col-md-8">
                                            <div class="row">
                                                <a href="https://unsplash.it/1200/768.jpg?image=251" data-toggle="lightbox" class="col-sm-4" data-title="모달 제목" data-footer="모달 푸터내용">
                                                    <img src="https://unsplash.it/600.jpg?image=251" class="img-fluid rounded">
                                                </a>
                                                <a href="https://unsplash.it/1200/768.jpg?image=252" data-toggle="lightbox" data-gallery="example-gallery" class="col-sm-4">
                                                    <img src="https://unsplash.it/600.jpg?image=252" class="img-fluid rounded">
                                                </a>
                                                <a href="https://unsplash.it/1200/768.jpg?image=253" data-toggle="lightbox" data-gallery="example-gallery" class="col-sm-4">
                                                    <img src="https://unsplash.it/600.jpg?image=253" class="img-fluid rounded">
                                                </a>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </section>
    </div>

    <%@ include file="/WEB-INF/views/footer.jsp" %>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ekko-lightbox/5.3.0/ekko-lightbox.min.js"></script>
<script>
    let itemSize = $("#size-select").val();
    let itemColor = $("#color-select").val();
    let itemCnt = $("#cnt-select").val();
    let itemId = ${item.id};
    let itemName = ${item.name};
    let itemPrice = ${item.price};
</script>
<script type="text/javascript" src="/js/item/view.js"></script>
</body>
</html>
