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
                        <form id="boardForm" action="/board/write.do" method="POST">
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="title">Project Name</label>
                                    <input type="text" type="text" name="title" id="title" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label for="contents">Project Description</label>
                                    <textarea type="text" name="contents" id="contents" class="form-control" rows="4"></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="img">Project Image</label>
                                    <div class="form_section_content">
                                        <input type="file" multiple id ="img" name='uploadFile' style="height: 30px;">
                                        <div id="uploadResult">
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
        .create(document.querySelector('#contents'))
        .then( contents => {
            theEditor = contents;
        })
        .catch(error=>{
            console.error(error);
        });
    let tCheck = false;            // 이름
    let cCheck = false;            // 이메일
    $(document).ready(function() {
        $(".write_button").click(function () {
            const title = $('#title').val();                 // id 입력란
            const contents = theEditor.getData();
            if (title == "") {
                tCheck = false;
            } else {
                tCheck = true;
            }
            if (contents == "") {
                cCheck = false;
            } else {
                cCheck = true;
            }
            if ( tCheck&&cCheck ) {
                console.log("Error O")
                //회원가입 버튼(회원가입 기능 작동
                $("#boardForm").attr("action", "/board/write.do");
                $("#boardForm").submit();
            } else {
                alert("제목과 내용을 모두 입력해주세요");
            }
            return false;
        });
    });
    /* 이미지 업로드 */
    $("input[type='file']").on("change", function(e) {
        /* 이미지 존재시 삭제 */
        // if ($(".imgDeleteBtn").length > 0) {
        //     deleteFile();
        // }
        let formData = new FormData();
        let fileInput = $('input[name="uploadFile"]');
        let fileList = fileInput[0].files;
        let fileObj = fileList[0];
        if (!fileCheck(fileObj.name, fileObj.size)) {
            return false;
        }
        // formData.append("uploadFile", fileObj);
        for(let i = 0; i < fileList.length; i++){
            console.log("file : " + fileList[i])
            formData.append("uploadFile", fileList[i]);
        }
        $.ajax({
            url: '/uploadAjaxAction',
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
    let i = 0;
    /* 이미지 출력 */
    function showUploadImage(uploadResultArr) {
        console.log("showUploadImage : " + uploadResultArr);
        /* 전달받은 데이터 검증 */
        if (!uploadResultArr || uploadResultArr.length == 0) { return; }
        let uploadResult = $("#uploadResult");
        let str = "";
        for (; i < uploadResultArr.length; i++) {
            let obj = uploadResultArr[i];
            let fileCallPath = encodeURIComponent(obj.upload.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);
            str += "<div id='result_card'>";
            str += "<img src='/display?fileName=" + fileCallPath +"'>";
            str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
            str += "<input type='hidden' name='imageList[" + i + "].fileName' value='"+ obj.fileName +"'>";
            str += "<input type='hidden' name='imageList[" + i + "].uuid' value='"+ obj.uuid +"'>";
            str += "<input type='hidden' name='imageList[" + i + "].upload' value='"+ obj.upload +"'>";
            str += "</div>";
        }
        uploadResult.append(str);
    }
    /* var, method related with attachFile */
    let regex = new RegExp("(.*?)\.(jpg|png)$");
    let maxSize = 1048576; //1MB
    function fileCheck(fileName, fileSize) {
        if (fileSize >= maxSize) {
            alert("파일 사이즈 초과");
            return false;
        }
        if (!regex.test(fileName)) {
            alert("해당 종류의 파일은 업로드할 수 없습니다.");
            return false;
        }
        return true;
    }
    $("#uploadResult").on("click", ".imgDeleteBtn", function(e) {
        deleteFile();
    });
    function deleteFile() {
        // $("#result_card").remove();
        let targetFile = $(".imgDeleteBtn").data("file");
        let targetDiv = $("#result_card");
        $.ajax({
            url: '/deleteFile',
            data : {fileName : targetFile, id : null},
            dataType : 'text',
            type : 'POST',
            success : function(result) {
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