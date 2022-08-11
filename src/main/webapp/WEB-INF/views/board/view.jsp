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
    <title>게시글 상세보기</title>
    <style>
        #comment {
            width : 75%;
        }
        #result_card img{
            max-width: 100%;
            height: auto;
            display: block;
            padding: 5px;
            margin: auto;
        }
    </style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
    <div class="wrapper">
        <%@ include file="/WEB-INF/views/nav.jsp" %>
        <%--<sec:authentication property="principal" />--%>
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
                            <div class="form_section">
                                <div class="form_section_title">
                                    <label>이미지</label>
                                </div>
                                <div class="form_section_content">
                                    <div id="uploadResult">
                                    </div>
                                </div>
                            </div>
                            <div class="board-footer">
                                <c:if test="${isWriter eq 1}">
                                    <button type="button" class="btn btn-primary update-btn" onclick="location.href='/board/update/${board.id}'">수정</button>
                                    <form id = "deleteBoardForm" action="/board/delete/${board.id}" method="post">
                                        <input type="hidden" name="_method" value="delete"/>
                                        <button type="button" class="btn btn-danger deleteBoardBtn">삭제</button>
                                    </form>
                                </c:if>
                                <button type="button" class="btn btn-primary list-btn" onclick="location.href='/board/myList'">내 글 쓴 목록으로</button>
                                <button type="button" class="btn btn-primary list-btn" onclick="location.href='/main'">메인으로</button>
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
    </div>
    <%@ include file="/WEB-INF/views/footer.jsp" %>
<script>
    $(document).ready(function () {
        getCommentList();
        $(".cSubmit").click(function() {
            const com = $('.cLeave').val();
            if (com == "") {
                alert('내용을 입력해주세요');
            } else {
                if (!isOpen) {
                    alert("댓글 수정을 완료해주세요");
                } else {
                    alert("댓글 등록 완료");
                    $("#comment-form").attr("action", "/board/comment/write");
                    $("#comment-form").submit();
                }
            }
        })
        $("#recommendBtn").click(function() {
            recommendBoard();
        })
        $(".deleteBoardBtn").click(function() {
            deleteBoardBtn()
        })
        /* 이미지 정보 호출 */;
        let uploadResult = $("#uploadResult");
        $.getJSON("/getAttachList", {bId : ${board.id}}, function(arr){
            if (arr.length === 0) {
                return;
            }
            let str = "";
            let obj = arr[0];
            let fileCallPath = encodeURIComponent(obj.upload + "/s_" + obj.uuid + "_" + obj.fileName);
            str += "<div id='result_card'";
            str += "data-path='" + obj.upload + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
            str += ">";
            str += "<div type='hidden' class='imgDeleteBtn' data-file='" + fileCallPath + "'></div>";
            str += "<img src='/display?fileName=" + fileCallPath +"'>";
            str += "</div>";
            uploadResult.html(str);
            let deleteHidden = $("#deleteBoardForm");
            let delStr = "<input type='hidden' name='filename' value='" + fileCallPath+ "'/>"
            deleteHidden.append(delStr);
        });
    })
    function recommendBoard() {
        $.ajax({
            type : "GET",
            url : "/board/updateRecommend",
            data : {'id' : ${board.id} },
            success : function(likeCheck) {
                if (likeCheck != 1) {
                    alert("추천완료.");
                    location.reload();
                } else {
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
            cView += '<input type="hidden" name="_method" value="put"/>';
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
    function deleteBoardBtn() {
        $("#deleteBoardForm").attr("action", "/board/delete/${board.id}");
        $("#deleteBoardForm").submit();
    }
    function offDisplay() {
        isOpen = true;
        document.getElementById("writeView").remove();
    }
    function deleteBtn() {
        if (isOpen) {
            $("#delete-form").attr("action", "/comment/delete");
            $("#delete-form").submit();
        } else {
            alert("수정을 완료해 주세요");
        }
    }
    function getCommentList() {
        let id = $('input[name=id]').val();
        const name = $('#user').val();
        $.ajax({
            type: 'GET',
            url: '/getCommentList',
            data: {id},
            success: function (result) {
                for (let i = 0; i < result.length; i++) {
                    let str = "<div class=\"comment" + result[i].id + "\">";
                    str += result[i].contents + "</div>";
                    if (result[i].writer == name) {
                        str += "<button type=\"button\" class=\"btn btn-success \" onclick=\"updateViewBtn('" +  result[i].id + "','" + result[i].contents + "','" + result[i].writer +"')\">수정</button>";
                        str += "<form id=\"delete-form\" action=\"/comment/delete\" method=\"delete\">";
                        str += "<input type=\"hidden\" name=\"_method\" value=\"delete\"/>";
                        str += "<input type=\"hidden\" name=\"id\" value=\"" + result[i].id + "\"/>"
                        str += "<input type=\"hidden\" name=\"bid\" value=\"${board.id}\"/>"
                        str += "<input type=\"button\" class=\"btn btn-danger delete-btn \" onclick=\"deleteBtn()\" value=\"삭제\" />";
                        str += "</form>"
                    }
                    str += "<hr>"
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