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
    <title>PROCESS</title>
    <script
            src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous">
    </script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <script src="https://cdn.ckeditor.com/ckeditor5/34.2.0/classic/ckeditor.js"></script>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
    <%@ include file="/WEB-INF/views/nav.jsp" %>
    <section class="content">
        <div class="container" style='width:1000px;'>
            <div class="row">
                <div class="col-md-6">
                    <div class="card card-primary">
                        <div class="card-header">
                            <h3 class="card-title">General</h3>
                        </div>
                        <form id="boardForm" action="/board/write.do" method="POST">
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
                            <input type="button" class="btn btn-outline-primary btn-sm write_button" value="등록하기" />
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <%@ include file="/WEB-INF/views/footer.jsp" %>
<script>
    let theEditor = "";
    ClassicEditor
        .create(document.querySelector('#contents'))
        .then( contents => {
            theEditor = contents;
        })
        .catch(error=>{
            console.error(error);
        });
    let tCheck = false;            // 이름
    let cCheck = false;            // 이메일
    $(document).ready(function() {
        $(".write_button").click(function () {
            const title = $('#title').val();                 // id 입력란
            const contents = theEditor.getData();
            if (title == "") {
                tCheck = false;
            } else {
                tCheck = true;
            }
            if (contents == "") {
                cCheck = false;
            } else {
                cCheck = true;
            }
            if ( tCheck&&cCheck ) {
                console.log("Error O")
                //회원가입 버튼(회원가입 기능 작동
                $("#boardForm").attr("action", "/board/write.do");
                $("#boardForm").submit();
            } else {
                alert("제목과 내용을 모두 입력해주세요");
            }
            return false;
        });
    });
</script>
</body>
</html>