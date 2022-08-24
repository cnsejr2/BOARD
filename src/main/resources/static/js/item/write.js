let theEditor = "";
ClassicEditor
    .create(document.querySelector('#info'))
    .then( contents  => {
        theEditor = contents ;
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
        if (fileUpload() > 0) {
            imageCheck = true;
        } else {
            imageCheck = false;
        }
        console.log("nameCheck : " + nameCheck);
        console.log("infoCheck : " + infoCheck);
        console.log("imageCheck : " + imageCheck);
        console.log("sizeCheck : " + sizeCheck);
        if ( nameCheck&&infoCheck&&imageCheck&&sizeCheck ) {
            console.log("Error O");
            $("#itemForm").attr("action", "/item/write.do");
            $("#itemForm").submit();
        } else {
            alert("제목과 내용, 사이즈, 이미지를 모두 입력해주세요");
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