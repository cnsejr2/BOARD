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
    <script
            src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous">
    </script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">

</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="container" style='width:1000px;'>
    <h1>게시판목록</h1>
    <table class="table">
        <tr>
            <th>
                <label class="checkbox-inline">
                    <input type="checkbox" id="allCheckBox" class="chk" onclick="allChecked(this)">
                </label>
            </th>
            <th>ID</th>
            <th>TITLE</th>
            <th>WRITER</th>
            <th>VIEW</th>
        </tr>
        <c:forEach var="b" items="${bList}">
        <tr>
            <td>
                <label class="checkbox-inline">
                    <input type="checkbox" class="chk" name="oneChk" onclick="oneChkClicked()"  value="${b.ID}">
                </label>
            </td>
            <td>${b.ID}</td>
            <td><a href="/board/view/${b.ID}">${b.TITLE}</a></td>
            <td>${b.WRITER}</td>
            <td>${b.VIEW_CNT}</td>
        </tr>
        </c:forEach>
    </table>
    <div class="pageInfo_wrap" >
        <div class="pageInfo_area">
            <ul id="pageInfo" class="pageInfo">
                <!-- 이전페이지 버튼 -->
                <c:if test="${pageMake.prev}">
                    <li class="pageInfo_btn previous"><a href="${pageMake.startPage-1}">Previous</a></li>
                </c:if>
                <!-- 각 번호 페이지 버튼 -->
                <c:forEach var="num" begin="${pageMake.startPage}" end="${pageMake.endPage}">
                    <li class="pageInfo_btn ${pageMake.cri.pageNum == num ? "active":"" }"><a href="${num}">${num}</a></li>
                </c:forEach>
                <!-- 다음페이지 버튼 -->
                <c:if test="${pageMake.next}">
                    <li class="pageInfo_btn next"><a href="${pageMake.endPage + 1 }">Next</a></li>
                </c:if>
            </ul>
        </div>
    </div>
    <form id="moveForm" method="get">
        <input type="hidden" name="pageNum" value="${pageMake.cri.pageNum }">
        <input type="hidden" name="amount" value="${pageMake.cri.amount }">
        <input type="hidden" name="type" value="board">
    </form>
</div>

<script>
    let moveForm = $("#moveForm");

    $(".pageInfo a").on("click", function(e){
        e.preventDefault();
        moveForm.find("input[name='pageNum']").val($(this).attr("href"));
        moveForm.attr("action", "/admin/profile/${member.id}");
        moveForm.submit();

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
