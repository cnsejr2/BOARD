
$(document).ready(function () {
    getReviewList();

    $(".cartBtn").click(function() {
        if (itemColor == "" || itemSize == "") {
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
        data : {'id' : itemId, 'itemSize' : itemSize, 'itemColor' : itemColor,
            'itemCnt' : itemCnt, 'itemName' : itemName, 'itemPrice' : itemPrice},
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
    $(this).find("img").attr('src', '/displayItem?fileName=' + fileCallPath);

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
                str += "<button type=\"button\" class=\"modalBtn" + result[i].reviewId + "\" onclick=\"appearModal(" + result[i].reviewId + ")\">더보기</button>";
                str += "<div class=\"row\">";
                for (let j = 0; j < result[i].reviewFileList.length; j++) {
                    str += "<div class=\"review_file_wrap\" data-filepath=\"" + result[i].reviewFileList[j].FILEPATH + "\" >";
                    str += "<img class=\"review_file\">";
                    str += "</div>";
                }
                str += "</div>";
                // str += "<div class=\"modal\" id=\"" + result[i].reviewId + "\">";
                // str += "<div class=\"modal_content\" title=\"클릭하면 창이 닫힙니다.\">";
                // str += "<p>원래대로 돌아가고 싶다면 네모 안을 다시 클릭해주세요</p>" ;
                // str += result[i].content + "<p>작성자 : " + result[i].memberId + "</p>";
                // str += "<p>작성일 : " + result[i].wrdate + "</p>";

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
    const classBtn = ".modalBtn" + e;
    const info = "#" + e;
    $(classBtn).click(function(){
        $(info).fadeIn();
        $(".review_file_wrap").each(function(i, obj) {

            const reviewObj = $(obj);
            const uploadPath = reviewObj.data("filepath");

            const fileCallPath = encodeURIComponent(uploadPath);
            $(this).find(".review_file").attr('src', '/displayReview?fileName=' + fileCallPath);
            $(this).find(".review_file").attr('style', 'width:300px; height:300px;');
            // $(this).find(".review_href").attr('href', '/displayReview?fileName=' + fileCallPath);
            // $(this).find(".review_href").attr('style', 'width:300px; height:300px;');

        });
    });

    $(".modal_content").click(function(){
        $(".modal").fadeOut();
    });
}

$(document).on('click', '[data-toggle="lightbox"]', function(event) {
    event.preventDefault();
    $(this).ekkoLightbox();
})