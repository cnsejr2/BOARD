<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-07
  Time: 오후 5:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>WRITE</title>
</head>
<body>
<%@ include file="/WEB-INF/views/nav.jsp" %>
<section class="content">
    <div class="container" style='width:1000px;'>
        <div class="row">
            <div class="col-md-6">
                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">General</h3>
                    </div>
                    <form action="/board/write.do" method="POST">
                        <div class="card-body">
                            <div class="form-group">
                                <label for="title">Project Name</label>
                                <input type="text" type="text" name="title" id="title" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="contents">Project Description</label>
                                <textarea type="text" name="contents" id="contents" class="form-control" rows="4"></textarea>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-outline-primary btn-sm login_button" value="submit"> 등록하기 </button>
                        <!-- /.card-body -->
                    </form>
                </div>
                <!-- /.card -->
            </div>
        </div>
    </div>
</section>

</body>
</html>
