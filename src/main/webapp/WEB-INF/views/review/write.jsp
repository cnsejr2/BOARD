<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-08-17
  Time: 오후 5:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>REVIEW WRITE</title>
    <style>
        .ck-content {						/* ckeditor 높이 */
            height: 170px;
        }
        #result_card img {
            max-width: 100%;
            height: auto;
            display: block;
            padding: 5px;
            margin-top: 10px;
            margin: auto;
        }
        #result_card {
            position: relative;
        }
        .imgDeleteBtn{
            position: absolute;
            top: 0;
            right: 5%;
            background-color: #ef7d7d;
            color: wheat;
            font-weight: 900;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            line-height: 26px;
            text-align: center;
            border: none;
            display: block;
            cursor: pointer;
        }
        .insert {
            padding: 20px 30px;
            display: block;
            width: 600px;
            margin: 5vh auto;
            height: 90vh;
            border: 1px solid #dbdbdb;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
        }
        .insert .file-list {
            height: 200px;
            overflow: auto;
            border: 1px solid #989898;
            padding: 10px;
        }
        .insert .file-list .filebox p {
            font-size: 14px;
            margin-top: 10px;
            display: inline-block;
        }
        .insert .file-list .filebox .delete i{
            color: #ff5353;
            margin-left: 5px;
        }
    </style>

    <script
            src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous">
    </script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <script src="https://cdn.ckeditor.com/ckeditor5/34.2.0/classic/ckeditor.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/star.css">
</head>
<body class="hold-transition sidebar-mini layout-fixed">
    <%@ include file="/WEB-INF/views/nav.jsp" %>
    <section class="content">
        <div class="container" style='width:1000px;'>
            <div class="row">
                <div class="col-md-6">
                    <div class="card card-primary">
                        <div class="card-header">
                            <h3 class="card-title">General</h3>
                        </div>
                        <form id="reviewForm" action="/item/review/write.do" method="POST" enctype="multipart/form-data">
                            <div class="card-body">
                                <fieldset>
                                    <span class="text-bold">별점을 선택해주세요</span>
                                    <input type="radio" name="reviewStar" value="5" id="rate1"><label
                                        for="rate1">★</label>
                                    <input type="radio" name="reviewStar" value="4" id="rate2"><label
                                        for="rate2">★</label>
                                    <input type="radio" name="reviewStar" value="3" id="rate3"><label
                                        for="rate3">★</label>
                                    <input type="radio" name="reviewStar" value="2" id="rate4"><label
                                        for="rate4">★</label>
                                    <input type="radio" name="reviewStar" value="1" id="rate5"><label
                                        for="rate5">★</label>
                                </fieldset>
                                <div class="form-group">
                                    <label for="content">Review</label>
                                    <textarea type="text" name="content" id="content" class="form-control" rows="4"></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="file-list">Review multipartFile</label>
                                    <div class="form-group" id="file-list">
                                        <a href="#this" onclick="addFile()">파일추가</a>
                                        <div class="file-group">
                                            <input type="file" name="file" multiple="multiple">
                                            <a href="#this" id="file-delete">삭제</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input type="button" class="btn btn-outline-primary btn-sm write_button" value="등록하기" />
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <%@ include file="/WEB-INF/views/footer.jsp" %>
<script>
    let theEditor = "";
    ClassicEditor
        .create(document.querySelector('#content'))
        .then( content => {
            theEditor = content;
        })
        .catch(error=>{
            console.error(error);
        });
    let rCheck = false;            // 이름
    $(document).ready(function() {
        $(".write_button").click(function () {
            console.log("리뷰 작성 버튼")
            const content = theEditor.getData();
            if (content == "") {
                rCheck = false;
            } else {
                rCheck = true;
            }

            if ( rCheck ) {
                $("#reviewForm").attr("action", "/item/review/write.do");
                $("#reviewForm").submit();
            } else {
                alert("제목과 내용을 모두 입력해주세요");
            }
            return false;
        });
        $("a[id='file-delete']").on("click", function(e) {
            e.preventDefault();
            deleteFile($(this));
        });
    });
    function addFile() {
        console.log("addFile 실행됨");
        let str = "";
        str += "<div class=\"file-group\"><input type=\"file\" name=\"file\">";
        str += "<a href=\"#this\" id=\"file-delete\">삭제<a></div>";
        $("#file-list").append(str);
        $("a[id='file-delete']").on("click", function(e) {
            e.preventDefault();
            deleteFile($(this));
        });
    }
    function deleteFile(obj) {
        obj.parent().remove();
    }
</script>
</body>
</html>