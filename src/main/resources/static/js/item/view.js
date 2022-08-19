
$(document).ready(function () {
    getReviewList();

    $(".cartBtn").click(function() {
        // itemSize = $("#size-select").val();
        // itemColor = $("#color-select").val();
        // itemCnt = $("#cnt-select").val();
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
    console.log("wish 클릭")
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

/* 이미지 삽입 */
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
            console.log(result)
            for (let i = 0; i < result.length; i++) {
                let str = "<div class=\"review" + result[i].reviewId + "\">";
                str += result[i].content;
                str += "<p>작성자 : " + result[i].memberId + "</p>" + "</div>";
                str += "<p>작성일 : " + result[i].wrdate + "</p>" + "</div>";
                str += "<p>별점 : " + result[i].star + "</p>" + "</div>";
                str += "<button type=\"button\" class=\"modalBtn\">더보기</button>";
                str += "<div class=\"modal\">";
                str += "<div class=\"modal_content\" title=\"클릭하면 창이 닫힙니다.\">";
                str += "<p>원래대로 돌아가고 싶다면 네모 안을 다시 클릭해주세요</p>" ;
                str += result[i].content + "<p>작성자 : " + result[i].memberId + "</p>";
                str += "<p>작성일 : " + result[i].wrdate + "</p></div></div></div>";
                str += "<hr>"
                $("#review").append(str);
            }
        },
        error: function (result) { },
        complete: function () { }
    })
}
$(document).on("click",".modalBtn", function() {
    $(".modalBtn").click(function(){
        $(".modal").fadeIn();
    });

    $(".modal_content").click(function(){
        $(".modal").fadeOut();
    });
})
$(document).on('click', '[data-toggle="lightbox"]', function(event) {
    event.preventDefault();
    $(this).ekkoLightbox();
})