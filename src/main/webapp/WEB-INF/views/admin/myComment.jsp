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
                <th>
                    <label class="checkbox-inline">
                        <input type="checkbox" id="allCheckBox" class="chk" onclick="allChecked(this)">
                    </label>
                </th>
                <th>ID</th>
                <th>BID</th>
            </tr>
            <c:forEach var="c" items="${cList}">
            <tr>
                <td>
                    <label class="checkbox-inline">
                        <input type="checkbox" class="chk" name="oneChk" onclick="oneChkClicked()"  value="${c.ID}">
                    </label>
                </td>
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
        <button type="button" class="btn btn-primary update-btn float-right" onclick="commentDelete();"> 댓글 삭제 </button>
    </div>

<script>
    let moveFormCom = $("#moveFormCom");

    $(".pageInfoCom a").on("click", function(e) {
        e.preventDefault();
        moveFormCom.find("input[name='pageNum']").val($(this).attr("href"));
        moveFormCom.attr("action", "/admin/profile/${member.id}");
        moveFormCom.submit();

    });
    function allChecked(target) {

        if ($(target).is(":checked")) {
            $(".chk").prop("checked", true);
        } else {
            $(".chk").prop("checked", false);
        }
    }

    function oneChkClicked() {
        let allCount = $("input:checkbox[name=oneChk]").length;

        let checkedCount = $("input:checkbox[name=oneChk]:checked").length;

        if (allCount == checkedCount) {
            $(".chk").prop("checked", true);
        } else {
            $("#allCheckBox").prop("checked", false);
        }
    }
    function commentDelete() {

        let comIdxArray = [];

        $("input:checkbox[name='oneChk']:checked").each(function() {
            comIdxArray.push($(this).val())
        });

        if (comIdxArray.length === 0) {
            alert("삭제할 항목을 선택해주세요.");
            return false;
        }

        let confirmAlert = confirm('정말로 삭제하시겠습니까?');
        if (confirmAlert) {

            $.ajax({
                type : 'DELETE',
                url : "/comment/multi/delete",
                dataType : 'json',
                data : JSON.stringify(comIdxArray),
                contentType: 'application/json',
                success : function(result) {
                    alert("해당글이 정상적으로 삭제되었습니다.");
                    location.reload();
                },
                error: function(request, status, error) {
                }
            })
        }
    }
</script>
</body>
</html>
