
$(document).ready(function () {
    let uploadResult = $("#uploadResult");
    $.getJSON("/getAttachList", { bId : boardId}, function(arr) {
        console.log(arr);
        if (arr.length === 0) {
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
    });
});
$("#uploadResult").on("click", ".imgDeleteBtn", function(e) {
    deleteFile();
});
function deleteFile() {
    let targetFile = $(".imgDeleteBtn").data("file");
    let targetDiv = $("#result_card");
    $.ajax({
        url: '/deleteFile',
        data : { fileName : targetFile, id : boardId },
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

$("input[type='file']").on("change", function(e) {
    if ($("#result_card").length > 0) {
        deleteFile();
    }
    let formData = new FormData();
    let fileInput = $('input[name="uploadFile"]');
    let fileList = fileInput[0].files;
    let fileObj = fileList[0];
    if (!fileCheck(fileObj.name, fileObj.size)) {
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

function showUploadImage(uploadResultArr) {

    if (!uploadResultArr || uploadResultArr.length == 0) { return; }
    let uploadResult = $("#uploadResult");
    let obj = uploadResultArr[0];
    let str = "";
    let fileCallPath = encodeURIComponent(obj.upload.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);

    str += "<div id='result_card'>";
    str += "<img src='/display?fileName=" + fileCallPath +"'>";
    str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
    str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
    str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
    str += "<input type='hidden' name='imageList[0].upload' value='"+ obj.upload +"'>";
    str += "</div>";
    uploadResult.append(str);
}
