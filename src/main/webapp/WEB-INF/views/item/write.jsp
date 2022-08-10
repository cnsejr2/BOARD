<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-07
  Time: 오후 5:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>WRITE</title>
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

    </style>
    <script
            src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous">
    </script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <script src="https://cdn.ckeditor.com/ckeditor5/34.2.0/classic/ckeditor.js"></script>
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
                    <form id="itemForm" action="/item/write.do" method="POST">
                        <div class="card-body">
                            <div class="form-group">
                                <label for="name">Item Name</label>
                                <input type="text" name="name" id="name" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="info">Item Description</label>
                                <textarea type="text" name="info" id="info" class="form-control" rows="4"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="price">Item Price</label>
                                <input type="text" placeholder="숫자만 입력가능" name="price" id="price" class="form-control" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                            </div>
                            <div class="form-group">
                                <label for="color">Item Color</label>
                                <input type="text" placeholder="색명 뒤에 바로,를 쓰고 띄어쓰기를 해주세요, 예)Black, Green, " name="color" id="color" class="form-control">
                            </div>
                            <div class="form-group">
                                Item Size
                                <input type="checkbox" name="itemSize" id="S" value="S">S
                                <input type="checkbox" name="itemSize" id="M" value="M">M
                                <input type="checkbox" name="itemSize" id="L" value="L">L
                                <input type="checkbox" name="itemSize" id="XL" value="XL">XL
                            </div>
                            <div class="form-group">
                                <label for="img">Item Image</label>
                                <div class="form_section_content">
                                    <input type="file" id ="img" name='uploadFile' style="height: 30px;">
                                    <div id="uploadResult">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <input type="button" class="btn btn-outline-primary btn-sm write_button" value="등록하기" />
                        <!-- /.card-body -->
                    </form>
                </div>
                <!-- /.card -->
            </div>
        </div>
    </div>
</section>
<script>
    let theEditor = "";
    ClassicEditor
        .create(document.querySelector('#info'))
        .then( contents => {
            theEditor = contents;
        })
        .catch(error=>{
            console.error(error);
        });

    let nameCheck = false;            // 이름
    let infoCheck = false;            // 이메일
    let imageCheck = false;           // 이미지
    let sizeCheck = false;           // 사이즈
    $(document).ready(function() {
        $(".write_button").click(function () {
            console.log("쓰기 클릭");
            const name = $('#name').val();                 // id 입력란
            const info = theEditor.getData();
            const image = $('#name').val();

            if (name == "") {
                nameCheck = false;
            } else {
                nameCheck = true;
            }
            if (info == "") {
                infoCheck = false;
            } else {
                infoCheck = true;
            }
            const arr = new Array();

            $('input:checkbox[name=itemSize]:checked').each(function() {
                arr.push(this.value);
            });
            if (arr.length == 0) {
                sizeCheck = false;
            } else {
                sizeCheck = true;
            }
            if ( nameCheck&&infoCheck&&imageCheck&&sizeCheck ) {
                console.log("Error O");
                alert(arr);
                //회원가입 버튼(회원가입 기능 작동
                $("#itemForm").attr("action", "/item/write.do");
                $("#itemForm").submit();
            } else {
                alert("제목과 내용, 사이즈, 이미지를 모두 입력해주세요");
            }
            return false;
        });
    });

    /* 이미지 업로드 */
    $("input[type='file']").on("change", function(e){
        imageCheck = true;
        /* 이미지 존재시 삭제 */
        if($(".imgDeleteBtn").length > 0){
            deleteFile();
            imageCheck = false;
        }

        let formData = new FormData();
        let fileInput = $('input[name="uploadFile"]');
        let fileList = fileInput[0].files;
        let fileObj = fileList[0];

        if(!fileCheck(fileObj.name, fileObj.size)){
            return false;
        }
        formData.append("uploadFile", fileObj);

        $.ajax({
            url: '/uploadItemAjaxAction',
            processData : false,
            contentType : false,
            data : formData,
            type : 'POST',
            dataType : 'json',
            success : function(result){
                console.log(result);
                showUploadImage(result);
            },
            error : function(result){
                alert("이미지 파일이 아닙니다.");
            }
        });

        alert("통과");
    });
    /* 이미지 출력 */
    function showUploadImage(uploadResultArr){
        console.log("showUploadImage : " + uploadResultArr);
        /* 전달받은 데이터 검증 */
        if(!uploadResultArr || uploadResultArr.length == 0){ return; }

        let uploadResult = $("#uploadResult");

        let obj = uploadResultArr[0];

        let str = "";

        let fileCallPath = encodeURIComponent(obj.upload.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);

        str += "<div id='result_card'>";
        str += "<img src='/displayItem?fileName=" + fileCallPath +"'>";
        str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
        str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
        str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
        str += "<input type='hidden' name='imageList[0].upload' value='"+ obj.upload +"'>";
        str += "</div>";

        uploadResult.append(str);
    }
    /* var, method related with attachFile */
    let regex = new RegExp("(.*?)\.(jpg|png)$");
    let maxSize = 1048576; //1MB

    function fileCheck(fileName, fileSize){
        if(fileSize >= maxSize){
            alert("파일 사이즈 초과");
            return false;
        }
        if(!regex.test(fileName)){
            alert("해당 종류의 파일은 업로드할 수 없습니다.");
            return false;
        }
        return true;

    }
    /* 이미지 삭제 버튼 동작 */
    $("#uploadResult").on("click", ".imgDeleteBtn", function(e){
        deleteFile();
    });
    /* 파일 삭제 메서드 */
    function deleteFile(){
        // $("#result_card").remove();
        let targetFile = $(".imgDeleteBtn").data("file");

        let targetDiv = $("#result_card");

        console.log("targetFile : " + targetFile)
        console.log("targetDiv : " + targetDiv)

        $.ajax({
            url: '/deleteItemFile',
            data : {fileName : targetFile, id : null},
            dataType : 'text',
            type : 'POST',
            success : function(result){
                console.log(result);

                targetDiv.remove();
                $("input[type='file']").val("");

            },
            error : function(result){
                console.log(result);

                alert("파일을 삭제하지 못하였습니다.")
            }
        });
    }
</script>
</body>
</html>
