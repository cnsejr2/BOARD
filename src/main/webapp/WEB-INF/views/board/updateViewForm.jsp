<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-13
  Time: 오후 2:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

</head>
<body>
<%@ include file="/WEB-INF/views/nav.jsp" %>
<div class="container container-table">
    <div class="body d-md-flex align-items-center justify-content-center">
        <div class="box-2 d-flex flex-column h-100">
            <div class="mt-5">
                <h3 class="mb-1 h-1">글 수정</h3>
                <form action="/board/update/${board.id}" method="POST">
                    <div class="mb-5">
                        <label class="form-label" for="title">제목</label>
                        <input class="form-control" type="text" name="title" id="title" value="${board.title}"/>
                    </div>
                    <div class="mb-5">
                        <label class="form-label" for="contents">내용</label>
                        <input class="form-control" type="text" name="contents" id="contents" value="${board.contents}"/>
                    </div>
                    <input type="hidden" name="memberId" value="${board.id }">
                    <button type="submit" class="btn btn-outline-primary btn-sm login_button" value="submit"> 수정 완료</button>
                </form>
            </div>
        </div>
    </div>
</div>
</form>
</body>
</html>
