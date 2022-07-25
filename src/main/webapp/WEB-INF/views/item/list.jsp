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
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../plugins/fontawesome-free/css/all.min.css">
    <!-- Ekko Lightbox -->
    <link rel="stylesheet" href="../plugins/ekko-lightbox/ekko-lightbox.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../dist/css/adminlte.min.css">
    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
    <script
            src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous">
    </script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <script src="https://cdn.ckeditor.com/ckeditor5/34.2.0/classic/ckeditor.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/nav.jsp" %>
<div class="col-12">
    <div class="card card-primary">
        <div class="card-header">
            <div class="card-title">
                ITEM 목록
            </div>
        </div>
        <div class="card-body">
            <div class="row">
                <c:forEach var="item" items="itemList">
                <div class="col-sm-2" >
<%--                    <a href="https://via.placeholder.com/1200/FFFFFF.png?text=1" data-toggle="lightbox" data-title="sample 1 - white" data-gallery="gallery">--%>
<%--                        <img src="https://via.placeholder.com/300/FFFFFF?text=1" class="img-fluid mb-2" alt="white sample"/>--%>
<%--                    </a>--%>

                </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/footer.jsp" %>
<!-- jQuery -->
<script src="../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- jQuery UI -->
<script src="../plugins/jquery-ui/jquery-ui.min.js"></script>
<!-- Ekko Lightbox -->
<script src="../plugins/ekko-lightbox/ekko-lightbox.min.js"></script>
<!-- AdminLTE App -->
<script src="../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../dist/js/demo.js"></script>
<!-- Filterizr-->
<script src="../plugins/filterizr/jquery.filterizr.min.js"></script>
<!-- Page specific script -->
<script>
    $(function () {
        $(document).on('click', '[data-toggle="lightbox"]', function(event) {
            event.preventDefault();
            $(this).ekkoLightbox({
                alwaysShowClose: true
            });
        });

        $('.filter-container').filterizr({gutterPixels: 3});
        $('.btn[data-filter]').on('click', function() {
            $('.btn[data-filter]').removeClass('active');
            $(this).addClass('active');
        });
    })

    /* 이미지 정보 호출 */
    let miniItem = $("#miniItem");
    $.getJSON("/getItemImageList", { itemId : ${item.itemId}}, function(arr){
        console.log("view : " + arr);
        if(arr.length === 0){
            return;
        }
        let str = "";
        let obj = arr[0];

        let fileCallPath = encodeURIComponent(obj.upload + "/s_" + obj.uuid + "_" + obj.fileName);
        str += "<div id='result_card'";
        str += "data-path='" + obj.upload + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
        str += ">";
        str += "<div type='hidden' class='imgDeleteBtn' data-file='" + fileCallPath + "'></div>";
        str += "<img src='/display?fileName=" + fileCallPath +"'>";
        str += "</div>";
        miniItem.html(str);
        let deleteHidden = $("#deleteBoardForm");
        let delStr = "<input type='hidden' name='filename' value='" + fileCallPath+ "'/>"
        deleteHidden.append(delStr);
    });


</script>

</body>
</html>
