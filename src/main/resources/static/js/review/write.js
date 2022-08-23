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
            $("#reviewForm").attr("action", "/item/${itemId}/review/write.do");
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