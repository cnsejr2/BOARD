<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-07
  Time: 오후 5:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<html>
<head>
    <title>Title</title>
    <style>
        #comment {
            width : 75%;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/nav.jsp" %>
<sec:authentication property="principal" />
<input type="hidden" id="user" value="<sec:authentication property="principal" />">
<div class="container" style='width:1000px;'>
    <div class="mb-4">
        <div class="container px-4 px-lg-5">
            <div class="row gx-4 gx-lg-5 justify-content-center">
                <div class="container List-container">
                    <div class="row mt-1 header">
                        <h5 class="col-1 board-title">제목</h5>
                        <p class="col-8" style="word-break:break-all;">${board.title}</p>
                    </div>
                    <div class="board-container">
                        <h5 class="content-title">내용</h5>
                        <p class="content" style="word-break:break-all;">
                            ${board.contents}
                        </p>
                    </div>
                    <div class="board-footer">
                        <c:if test="${isWriter eq 1}">
                            <button type="button" class="btn btn-primary update-btn" onclick="location.href='/board/update/${board.id}'">수정</button>
                            <button type="button" class="btn btn-danger delete-btn" onclick="location.href='/board/delete/${board.id}'">삭제</button>
                        </c:if>
                        <button type="button" class="btn btn-primary list-btn" onclick="location.href='/security/main'">메인으로</button>
                        <button type="button" class="btn btn-primary list-btn" id="recommendBtn">추천 ${board.recom_cnt}</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="card my-4">
        <h5 class="card-header">Comments</h5>
        <div class="card-body" id="comment">
        </div>
    </div>

    <div id="updateComment"></div>
    <div id="writeComment">
        <div class="card my-4">
            <h5 class="card-header">Leave a Comment:</h5>
            <div class="card-body">
                <form name="comment-form" id="comment-form" action="/board/comment/write" method="post" autocomplete="off">
                    <div class="form-group">
                        <input type="hidden" name="id" value="${board.id}" />
                        <label>
                            <textarea name="contents" class="form-control cLeave" rows="3"></textarea>
                        </label>
                    </div>
                    <input type="button" class="btn btn-primary cSubmit" value="Submit">
                </form>
            </div>
        </div>
    </div>
</div>

<script>

    $(document).ready(function () {
        getCommentList();
        $(".cSubmit").click(function() {
            const com = $('.cLeave').val();
            if (com == "") {
                alert('내용을 입력해주세요');
            } else {
                $("#comment-form").attr("action", "/board/comment/write");
                $("#comment-form").submit();
            }
        })
        $("#recommendBtn").click(function() {
            recommendBoard();
        })
    })
    function recommendBoard() {
        console.log("추천 클릭")
        $.ajax({
            type : "GET",
            url : "/board/updateRecommend",
            data : {'id' : ${board.id} },
            success : function(likeCheck) {
                if(likeCheck != 1){
                    alert("추천완료.");
                    location.reload();
                }
                else {
                    alert("이미 추천한 글 입니다.");
                    location.reload();
                }
            },
            error : function(){
                alert("통신 에러");
            }
        });
    }
    let isOpen = true;
    function updateViewBtn(cid, contents, writer) {
        if (isOpen) {
            console.log("수정 버튼 click")
            let cView = "";
            cView += '<div class="card my-4" id="writeView">';
            cView += '<h5 class="card-header">Update a Comment:</h5>';
            cView += '<div class="card-body">';
            cView += '<form name="comment-form" action="/board/${board.id}/comment/update/' + cid + '"method="POST" autocomplete="off">';
            cView += '<div class="form-group">';
            cView += '<input type="hidden" name="id" value="${board.id}" />';
            cView += '<label> <textarea name="contents" class="form-control" rows="3">' + contents + '</textarea> </label> </div>';
            cView += '<button type="submit" class="btn btn-primary">수정 완료</button>';
            cView += '<button type="button" class="btn btn-primary" onclick="offDisplay()">수정 취소</button>';
            cView += '</form></div></div>';

            $("#updateComment").append(cView);
            isOpen = !isOpen;
        }

    }
    function offDisplay() {
        isOpen = true;
        document.getElementById("writeView").remove();
    }
    function getCommentList() {
        let id = $('input[name=id]').val();
        const name = $('#user').val();
        $.ajax({
            type: 'GET',
            url: '/getCommentList',
            data: {id},
            success: function (result) {
                console.log(result)
                console.log(name)
                for (let i = 0; i < result.length; i++) {
                    let str = "<div class=\"comment" + result[i].id + "\">";
                    str += result[i].contents + "</div>";
                    if (result[i].writer == name) {
                        str += "<button type=\"button\" class=\"btn btn-success \" onclick=\"updateViewBtn('" +  result[i].id + "','" + result[i].contents + "','" + result[i].writer +"')\">수정</button>";
                        str += "<button type=\"button\" class=\"btn btn-danger delete-btn\" onclick=\"location.href='/comment/delete?id=" + result[i].id + "&bid=${board.id}'\">삭제</button>";
                    }
                    $("#comment").append(str);
                }
            },
            error: function (result) { },
            complete: function () { }
        })

    }

</script>
</body>
</html>
