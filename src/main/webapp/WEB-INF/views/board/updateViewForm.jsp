<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-13
  Time: 오후 2:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <title>Title</title>
    <script
            src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous">
    </script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <script src="https://cdn.ckeditor.com/ckeditor5/34.2.0/classic/ckeditor.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/updateViewForm.css">
</head>
<body>
<%@ include file="/WEB-INF/views/nav.jsp" %>
<div class="container container-table">
    <div class="body d-md-flex align-items-center justify-content-center">
        <div class="box-2 d-flex flex-column h-100">
            <div class="mt-5">
                <h3 class="mb-1 h-1">글 수정</h3>
                <form action="/board/update/${board.id}" method="POST">
                    <input type="hidden" name="_method" value="put"/>
                    <div class="mb-5">
                        <label class="form-label" for="title">제목</label>
                        <input class="form-control" type="text" name="title" id="title" value="${board.title}"/>
                    </div>
                    <div class="mb-5">
                        <label class="form-label" for="contents">내용</label>
                        <input class="form-control" type="text" name="contents" id="contents" value="${board.contents}"/>
                    </div>
                    <div class="mb-5">
                        <div class="form_section">
                            <div class="form_section_title">
                                <label>상품 이미지</label>
                            </div>
                            <div class="form_section_content">
                                <input type="file" id ="fileItem" name='uploadFile' style="height: 30px;">
                                <div id="uploadResult">
                                </div>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="id" value="${board.id}">
                    <button type="submit" class="btn btn-outline-primary btn-sm update_button" value="submit"> 수정 완료</button>
                </form>
            </div>
        </div>
    </div>
</div>
</form>
<script>
    $(document).ready(function () {
        /* 기존 이미지 출력 */
        let uploadResult = $("#uploadResult");

        $.getJSON("/getAttachList", { bId : ${board.id}}, function(arr){
            console.log(arr);
            if(arr.length === 0){
                return;
            }

            let str = "";
            let obj = arr[0];

            let fileCallPath = encodeURIComponent(obj.upload + "/s_" + obj.uuid + "_" + obj.fileName);
            str += "<div id='result_card'";
            str += "data-path='" + obj.upload + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
            str += ">";
            str += "<img src='/display?fileName=" + fileCallPath +"'>";
            str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
            str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
            str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
            str += "<input type='hidden' name='imageList[0].upload' value='"+ obj.upload +"'>";
            str += "</div>";

            uploadResult.html(str);

        });// GetJSON
    });
    /* 이미지 삭제 버튼 동작 */
    $("#uploadResult").on("click", ".imgDeleteBtn", function(e){
        deleteFile();
    });

    /* 파일 삭제 메서드 */
    function deleteFile(){
        // $("#result_card").remove();
        let targetFile = $(".imgDeleteBtn").data("file");
        let targetDiv = $("#result_card");
        $.ajax({
            url: '/deleteFile',
            data : {fileName : targetFile, id : ${board.id}},
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
    /* 이미지 업로드 */
    $("input[type='file']").on("change", function(e){

        /* 이미지 존재시 삭제 */
        if($("#result_card").length > 0){
            deleteFile();
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


    });

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

    /* 이미지 출력 */
    function showUploadImage(uploadResultArr){

        /* 전달받은 데이터 검증 */
        if(!uploadResultArr || uploadResultArr.length == 0){ return; }

        let uploadResult = $("#uploadResult");

        let obj = uploadResultArr[0];

        let str = "";

        let fileCallPath = encodeURIComponent(obj.upload.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);
        //replace 적용 하지 않아도 가능
        //let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);

        str += "<div id='result_card'>";
        str += "<img src='/display?fileName=" + fileCallPath +"'>";
        str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
        str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
        str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
        str += "<input type='hidden' name='imageList[0].upload' value='"+ obj.upload +"'>";
        str += "</div>";

        uploadResult.append(str);

    }
</script>
</body>
</html>
