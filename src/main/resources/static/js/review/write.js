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
let imageCheck = false;           // 이미지
$(document).ready(function() {
    $(".write_button").click(function () {
        console.log("리뷰 작성 버튼")
        const content = theEditor.getData();
        if (content == "") {
            rCheck = false;
        } else {
            rCheck = true;
        }
        if (fileUpload() > 0) {
            imageCheck = true;
        } else {
            imageCheck = false;
        }
        if ( rCheck&&imageCheck ) {
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
    if (fileUpload()) {
        let str = "";
        str += "<div class=\"file-group\"><input type=\"file\" name=\"file\" onchange=\"fileUpload()\">";
        str += "<a href=\"#this\" id=\"file-delete\">삭제<a></div>";
        $("#file-list").append(str);
        $("a[id='file-delete']").on("click", function(e) {
            e.preventDefault();
            deleteFile($(this));
        });
    }
}
function deleteFile(obj) {
    obj.parent().remove();
}
function fileUpload(){
    const size = $('input[name=file]').length;
    if (size > 5) { return false; }
    let sum = 0;
    for (let i = 0; i < size; i++) {
        const files = $('input[name="file"]')[i].files;
        for (let j = 0; j < files.length; j++) {
            sum++;
        }
    }
    if (size == sum) { return true; }
    return false;

}
// function addFile() {
//     console.log("addFile 실행됨");
//     let str = "";
//     str += "<div class=\"file-group\"><input type=\"file\" name=\"file\">";
//     str += "<a href=\"#this\" id=\"file-delete\">삭제<a></div>";
//     $("#file-list").append(str);
//     $("a[id='file-delete']").on("click", function(e) {
//         e.preventDefault();
//         deleteFile($(this));
//     });
// }
// function deleteFile(obj) {
//     obj.parent().remove();
// }