<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-05
  Time: 오후 3:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="container" style='width:1000px;'>
    <h1>댓글목록</h1>
    <table class="table">
        <tr>
            <th>ID</th>
            <th>BID</th>
        </tr>
        <c:forEach var="c" items="${cList}">
        <tr>
            <td>${c.ID}</td>
            <td><a href="/board/view/${c.BID}">${c.BID}</a></td>
        </tr>
        </c:forEach>
    </table>
    <div class="pageInfo_wrap" >
        <div class="pageInfo_area">
            <ul id="pageInfo" class="pageInfoCom">
                <!-- 이전페이지 버튼 -->
                <c:if test="${pageComMake.prev}">
                    <li class="pageInfo_btn previous"><a href="${pageComMake.startPage-1}">Previous</a></li>
                </c:if>
                <!-- 각 번호 페이지 버튼 -->
                <c:forEach var="num" begin="${pageComMake.startPage}" end="${pageComMake.endPage}">
                    <li class="pageInfo_btn ${pageComMake.cri.pageNum == num ? "active":"" }"><a href="${num}">${num}</a></li>
                </c:forEach>
                <!-- 다음페이지 버튼 -->
                <c:if test="${pageComMake.next}">
                    <li class="pageInfo_btn next"><a href="${pageComMake.endPage + 1 }">Next</a></li>
                </c:if>
            </ul>
        </div>
    </div>
    <form id="moveFormCom" method="get">
        <input type="hidden" name="pageNum" value="${pageComMake.cri.pageNum }">
        <input type="hidden" name="amount" value="${pageComMake.cri.amount }">
        <input type="hidden" name="type" value="comment">
    </form>
</div>

<script>
    let moveFormCom = $("#moveFormCom");

    $(".pageInfoCom a").on("click", function(e){
        console.log("댓글 동작")
        e.preventDefault();
        moveFormCom.find("input[name='pageNum']").val($(this).attr("href"));
        moveFormCom.attr("action", "/admin/profile/${member.id}");
        moveFormCom.submit();

    });
    //체크박스 전체 선택 클릭 이벤트
    function allChecked(target){

        if($(target).is(":checked")){
            //체크박스 전체 체크
            $(".chk").prop("checked", true);
        }
        else{
            //체크박스 전체 해제
            $(".chk").prop("checked", false);
        }
    }

    //자식 체크박스 클릭 이벤트
    function oneChkClicked() {

        // 체크박스 전체개수
        let allCount = $("input:checkbox[name=oneChk]").length;

        // 체크된 체크박스 전체개수
        let checkedCount = $("input:checkbox[name=oneChk]:checked").length;

        // 체크박스 전체개수와 체크된 체크박스 전체개수가 같으면 체크박스 전체 체크
        if(allCount == checkedCount) {
            $(".chk").prop("checked", true);
        }
        // 같지않으면 전체 체크박스 해제
        else {
            $("#allCheckBox").prop("checked", false);
        }
    }
    //게시판 삭제하기
    function boardDelete(){

        let boardIdxArray = [];

        $("input:checkbox[name='oneChk']:checked").each(function(){
            console.log("배열 추가" + $(this).val())
            boardIdxArray.push($(this).val())
            // boardIdxArray.push($(this).val());
        });

        console.log(boardIdxArray);

        if(boardIdxArray.length === 0){
            alert("삭제할 항목을 선택해주세요.");
            return false;
        }

        let confirmAlert = confirm('정말로 삭제하시겠습니까?');
        if(confirmAlert){

            $.ajax({
                type : 'DELETE'
                ,url : "/board/multi/delete"
                ,dataType : 'json'
                ,data : JSON.stringify(boardIdxArray)
                ,contentType: 'application/json'
                ,success : function(result) {
                    alert("해당글이 정상적으로 삭제되었습니다.");
                    location.href="/board/myList";
                },
                error: function(request, status, error) {

                }
            })
        }
    }
</script>
</body>
</html>
