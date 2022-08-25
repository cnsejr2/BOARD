
$(document).ready(function () {

    getReviewList();
    $(".cartBtn").click(function() {
        if ($("#color-select").val() == "" || $("#size-select").val() == "") {
            alert("사이즈와 색상을 선택해주세요")
        } else {
            cartItem()
        }
    });

    $(".wishBtn").click(function() {
        wishBtn()
    })
});

function wishBtn() {
    $.ajax({
        type : "GET",
        url : "/item/hadWishItem",
        data : {'id' : itemId},
        success : function(likeCheck) {
            if (likeCheck != 1) {
                alert("wish 추가완료.");
                location.reload();
            } else {
                alert("이미 추가한 아이템입니다");
                location.reload();
            }
        },
        error : function() {
            alert("통신 에러");
        }
    });
}

function cartItem() {
    $.ajax({
        type : "GET",
        url : "/item/saveCartItem",
        data : {'id' : itemId, 'itemSize' : $("#size-select").val(), 'itemColor' : $("#color-select").val(),
            'itemCnt' : $("#cnt-select").val(), 'itemName' : itemName, 'itemPrice' : itemPrice},
        success : function(cartCheck) {
            if (cartCheck != 1) {
                if (!confirm("장바구니 추가 완료! 장바구니로 이동하시겠습니까?")) {
                } else {
                    location.href="/item/cart"
                }
            } else {
                alert("이미 추가한 아이템 입니다");
            }
        },
        error : function() {
            alert("통신 에러");
        }
    });
}

$(".image_wrap").each(function(i, obj) {

    const itemObj = $(obj);

    const uploadPath = itemObj.data("path");
    const uuid = itemObj.data("uuid");
    const fileName = itemObj.data("filename");

    const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
    $(this).find("img").attr('src', '/display?dir=item&&fileName=' + fileCallPath);
    $(this).find("img").attr('style', 'width:900px; height:500px;');

});

function shareSNSKakao() {
    // 사용할 앱의 JavaScript 키 설정
    Kakao.init('c17b5563968f2fffd356919521833ce2');

    // 카카오링크 버튼 생성
    Kakao.Link.createDefaultButton({
        container: '#btnKakao', // 카카오공유버튼ID
        objectType: 'feed',
        content: {
            title: "${item.name}", // 보여질 제목
            description: "아이템 정보 공유", // 보여질 설명
            imageUrl: "https://mud-kage.kakao.com/dn/NTmhS/btqfEUdFAUf/FjKzkZsnoeE4o19klTOVI1/openlink_640x640s.jpg", // 콘텐츠 URL
            link: {
                mobileWebUrl: "http://localhost:8080/item/view/${item.id}",
                webUrl: "http://localhost:8080/item/view/${item.id}"
            }
        }
    });
}
function getReviewList() {
    $.ajax({
        type: 'GET',
        url: '/getReviewList',
        data: {itemId : itemId},
        success: function (result) {
            for (let i = 0; i < result.length; i++) {
                let str = "<div class=\"review" + result[i].reviewId + "\">";
                str += result[i].content;
                str += "<p>작성자 : " + result[i].memberId + "</p>";
                str += "<p>작성일 : " + result[i].wrdate + "</p>";
                str += "<p>별점 : " + result[i].star + "</p>";
                if (result[i].reviewFileList.length > 0) {
                    str += "<button type=\"button\" class=\"showBtn" + result[i].reviewId + "\" onclick=\"appearModal(" + result[i].reviewId + ")\">사진보기</button>";
                    str += "<button type=\"button\" class=\"hideBtn" + result[i].reviewId + "\" style=\"display:none;\" onclick=\"disappearModal(" + result[i].reviewId + ")\">사진숨기기</button>";
                    str += "<div class=\"row\">";
                    for (let j = 0; j < result[i].reviewFileList.length; j++) {
                        str += "<div class=\"review_file_wrap_" + result[i].reviewId + "\" data-filepath=\"" + result[i].reviewFileList[j].FILEPATH + "\" >";
                        str += "<img class=\"review_file\">";
                        str += "</div>";
                    }
                    str += "</div>";
                }
                str += "</div></div></div>";
                str += "<hr>"
                $("#review").append(str);
            }
        },
        error: function (result) { },
        complete: function () { }
    })
}

function appearModal(e) {
    const showBtn = ".showBtn" + e;
    const reviewFile = ".review_file_wrap_" + e;
    const hideBtn = ".hideBtn" + e;
    $(showBtn).click(function(){
        $(reviewFile).each(function(i, obj) {
            $(reviewFile).show();
            const reviewObj = $(obj);
            const uploadPath = reviewObj.data("filepath");

            const fileCallPath = encodeURIComponent(uploadPath);
            $(this).find(".review_file").attr('src', '/display?dir=review&&fileName=' + fileCallPath);
            $(this).find(".review_file").attr('style', 'width:350px; height:300px;');
            $(hideBtn).show();
            $(showBtn).hide();
        });
    });
}

function disappearModal(e) {
    const showBtn = ".showBtn" + e;
    const hideBtn = ".hideBtn" + e;
    const reviewFile = ".review_file_wrap_" + e;
    $(hideBtn).click(function(){
        $(reviewFile).hide();
        $(showBtn).show();
        $(hideBtn).hide();
    });
}

$(document).on('click', '[data-toggle="lightbox"]', function(event) {
    event.preventDefault();
    $(this).ekkoLightbox();
})