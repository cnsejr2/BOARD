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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/ekko-lightbox/5.3.0/ekko-lightbox.css" rel="stylesheet">
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

        <section class="content">
            <form>
                <div class="card card-solid">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-12 col-sm-6">
                                <h3 class="d-inline-block d-sm-none"></h3>
                                <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
                                    <div class="carousel-inner">
                                        <div class="carousel-item active image_wrap" data-itemid="${item.imageList[0].itemId}" data-path="${item.imageList[0].upload}" data-uuid="${item.imageList[0].uuid}" data-filename="${item.imageList[0].fileName}">
                                            <img>
                                        </div>
                                        <c:forEach var="item" items="${item.imageList}" begin="1">
                                            <div class="carousel-item image_wrap" data-itemid="${item.itemId}" data-path="${item.upload}" data-uuid="${item.uuid}" data-filename="${item.fileName}">
                                                <img>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Previous</span>
                                    </button>
                                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Next</span>
                                    </button>
                                </div>
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
                                    <a href="/item/${item.id}/review/write.do"> 리뷰작성</a>

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
                                </div>
                            </nav>
                            <div class="tab-content p-3" id="nav-tabContent">
                                <div class="tab-pane fade show active" id="product-desc" role="tabpanel" aria-labelledby="product-desc-tab"> ${item.info} | ${item.regDate}</div>
                                <div class="tab-pane fade" id="product-comments" role="tabpanel" aria-labelledby="product-comments-tab">
                                    <div class="card-body" id="review">
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
<%--<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>--%>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ekko-lightbox/5.3.0/ekko-lightbox.min.js"></script>
<script>
    let itemSize = $("#size-select").val();
    let itemColor = $("#color-select").val();
    let itemCnt = $("#cnt-select").val();
    let itemId = ${item.id};
    let itemName = '${item.name}';
    let itemPrice = ${item.price};
</script>
<script type="text/javascript" src="/js/item/view.js"></script>
</body>
</html>
