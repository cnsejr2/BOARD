<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-25
  Time: 오전 10:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Title</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- overlayScrollbars -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- Google Font: Source Sans Pro -->
  <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
  <script
          src="https://code.jquery.com/jquery-3.4.1.js"
          integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
          crossorigin="anonymous">
  </script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
  <link rel="stylesheet" type="text/css" href="/css/profile.css">
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<%@ include file="/WEB-INF/views/nav.jsp" %>
<div class="content-wrapper">
  <!-- Content Header (Page header) -->
  <section class="content-header">
    <div class="container-fluid">
      <div class="row mb-2">
        <div class="col-sm-6">
          <h1>Profile</h1>
        </div>
        <div class="col-sm-6">
          <ol class="breadcrumb float-sm-right">
            <li class="breadcrumb-item"><a href="#">Home</a></li>
            <li class="breadcrumb-item active">User Profile</li>
          </ol>
        </div>
      </div>
    </div><!-- /.container-fluid -->
  </section>

  <!-- Main content -->
  <section class="content">
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-3">

          <!-- Profile Image -->
          <div class="card card-primary card-outline">
            <div class="card-body box-profile">
              <div class="text-center">
                <img class="profile-user-img img-fluid img-circle"
                     src="../../dist/img/user4-128x128.jpg"
                     alt="User profile picture">
              </div>

              <h3 class="profile-username text-center">${member.id}</h3>

              <p class="text-muted text-center">Software Engineer</p>

              <ul class="list-group list-group-unordered mb-3">
                <li class="list-group-item">
                  <b>Followers</b> <a class="float-right">1,322</a>
                </li>
                <li class="list-group-item">
                  <b>Following</b> <a class="float-right">543</a>
                </li>
                <li class="list-group-item">
                  <b>Friends</b> <a class="float-right">13,287</a>
                </li>
              </ul>

              <a href="#" class="btn btn-primary btn-block"><b>Follow</b></a>
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->

          <!-- About Me Box -->
          <div class="card card-primary">
            <div class="card-header">
              <h3 class="card-title">About Me</h3>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
              <strong><i class="fas fa-book mr-1"></i> Education</strong>

              <p class="text-muted">
                B.S. in Computer Science from the University of Tennessee at Knoxville
              </p>

              <hr>

              <strong><i class="fas fa-map-marker-alt mr-1"></i> Location</strong>

              <p class="text-muted">Malibu, California</p>

              <hr>

              <strong><i class="fas fa-pencil-alt mr-1"></i> Skills</strong>

              <p class="text-muted">
                <span class="tag tag-danger">UI Design</span>
                <span class="tag tag-success">Coding</span>
                <span class="tag tag-info">Javascript</span>
                <span class="tag tag-warning">PHP</span>
                <span class="tag tag-primary">Node.js</span>
              </p>

              <hr>

              <strong><i class="far fa-file-alt mr-1"></i> Notes</strong>

              <p class="text-muted">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam fermentum enim neque.</p>
            </div>
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
        </div>
        <!-- /.col -->
        <div class="col-md-9">
          <div class="card">
            <div class="card-header p-2">
              <ul class="nav nav-pills">
                <li class="nav-item"><a class="nav-link active" href="#activity" data-toggle="tab">Activity</a></li>
                <li class="nav-item"><a class="nav-link" href="#timeline" data-toggle="tab">Timeline</a></li>
                <li class="nav-item"><a class="nav-link" href="#settings" data-toggle="tab">Settings</a></li>
              </ul>
            </div><!-- /.card-header -->
            <div class="card-body">
              <div class="tab-content">
                <div class="active tab-pane" id="activity">
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
                          <c:if test="${pageMaker.prev}">
                            <li class="pageInfo_btn previous"><a href="${pageMaker.startPage-1}">Previous</a></li>
                          </c:if>
                          <!-- 각 번호 페이지 버튼 -->
                          <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                            <li class="pageInfo_btn ${pageMaker.cri.pageNum == num ? "active":"" }"><a href="${num}">${num}</a></li>
                          </c:forEach>
                          <!-- 다음페이지 버튼 -->
                          <c:if test="${pageMaker.next}">
                            <li class="pageInfo_btn next"><a href="${pageMaker.endPage + 1 }">Next</a></li>
                          </c:if>
                        </ul>
                      </div>
                    </div>
                    <form id="moveForm" method="get">
                      <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
                      <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
                    </form>
                  </div>
                  <div class="container" style='width:1000px;'>
                    <h1>댓글 목록</h1>
                    <table class="table">
                      <tr>
                        <th>ID</th>
                        <th>BID</th>
                        <th>WRITER</th>
                      </tr>
                      <c:forEach var="c" items="${cList}">
                        <tr>
                          <td>${c.ID}</td>
                          <td><a href="/board/view/${c.BID}">${c.BID}</a></td>
                          <td>${c.writer}</td>
                        </tr>
                      </c:forEach>
                    </table>
                    <div class="pageInfo_wrap" >
                      <div class="pageInfo_area">
                        <ul id="pageInfoCom" class="pageInfo">
                          <!-- 이전페이지 버튼 -->
                          <c:if test="${pageComMaker.prev}">
                            <li class="pageInfo_btn previous"><a href="${pageComMaker.startPage-1}">Previous</a></li>
                          </c:if>
                          <!-- 각 번호 페이지 버튼 -->
                          <c:forEach var="num" begin="${pageComMaker.startPage}" end="${pageComMaker.endPage}">
                            <li class="pageInfo_btn ${pageComMaker.cri.pageNum == num ? "active":"" }"><a href="${num}">${num}</a></li>
                          </c:forEach>
                          <!-- 다음페이지 버튼 -->
                          <c:if test="${pageComMaker.next}">
                            <li class="pageInfo_btn next"><a href="${pageComMaker.endPage + 1 }">Next</a></li>
                          </c:if>
                        </ul>
                      </div>
                    </div>
                    <form id="moveFormCom" method="get">
                      <input type="hidden" name="pageNumCom" value="${pageComMaker.cri.pageNum }">
                      <input type="hidden" name="amount" value="${pageComMaker.cri.amount }">
                    </form>
                  </div>
                </div>

                <!-- /.tab-pane -->
                <div class="tab-pane" id="timeline">
                  <!-- The timeline -->
                  <div class="timeline timeline-inverse">
                    <!-- timeline time label -->
                    <div class="time-label">
                        <span class="bg-danger">
                          10 Feb. 2014
                        </span>
                    </div>
                    <!-- /.timeline-label -->
                    <!-- timeline item -->
                    <div>
                      <i class="fas fa-envelope bg-primary"></i>

                      <div class="timeline-item">
                        <span class="time"><i class="far fa-clock"></i> 12:05</span>

                        <h3 class="timeline-header"><a href="#">Support Team</a> sent you an email</h3>

                        <div class="timeline-body">
                          Etsy doostang zoodles disqus groupon greplin oooj voxy zoodles,
                          weebly ning heekya handango imeem plugg dopplr jibjab, movity
                          jajah plickers sifteo edmodo ifttt zimbra. Babblely odeo kaboodle
                          quora plaxo ideeli hulu weebly balihoo...
                        </div>
                        <div class="timeline-footer">
                          <a href="#" class="btn btn-primary btn-sm">Read more</a>
                          <a href="#" class="btn btn-danger btn-sm">Delete</a>
                        </div>
                      </div>
                    </div>
                    <!-- END timeline item -->
                    <!-- timeline item -->
                    <div>
                      <i class="fas fa-user bg-info"></i>

                      <div class="timeline-item">
                        <span class="time"><i class="far fa-clock"></i> 5 mins ago</span>

                        <h3 class="timeline-header border-0"><a href="#">Sarah Young</a> accepted your friend request
                        </h3>
                      </div>
                    </div>
                    <!-- END timeline item -->
                    <!-- timeline item -->
                    <div>
                      <i class="fas fa-comments bg-warning"></i>

                      <div class="timeline-item">
                        <span class="time"><i class="far fa-clock"></i> 27 mins ago</span>

                        <h3 class="timeline-header"><a href="#">Jay White</a> commented on your post</h3>

                        <div class="timeline-body">
                          Take me to your leader!
                          Switzerland is small and neutral!
                          We are more like Germany, ambitious and misunderstood!
                        </div>
                        <div class="timeline-footer">
                          <a href="#" class="btn btn-warning btn-flat btn-sm">View comment</a>
                        </div>
                      </div>
                    </div>
                    <!-- END timeline item -->
                    <!-- timeline time label -->
                    <div class="time-label">
                        <span class="bg-success">
                          3 Jan. 2014
                        </span>
                    </div>
                    <!-- /.timeline-label -->
                    <!-- timeline item -->
                    <div>
                      <i class="fas fa-camera bg-purple"></i>

                      <div class="timeline-item">
                        <span class="time"><i class="far fa-clock"></i> 2 days ago</span>

                        <h3 class="timeline-header"><a href="#">Mina Lee</a> uploaded new photos</h3>

<%--                        <div class="timeline-body">--%>
<%--                          <img src="http://placehold.it/150x100" alt="...">--%>
<%--                          <img src="http://placehold.it/150x100" alt="...">--%>
<%--                          <img src="http://placehold.it/150x100" alt="...">--%>
<%--                          <img src="http://placehold.it/150x100" alt="...">--%>
<%--                        </div>--%>
                      </div>
                    </div>
                    <!-- END timeline item -->
                    <div>
                      <i class="far fa-clock bg-gray"></i>
                    </div>
                  </div>
                </div>
                <!-- /.tab-pane -->

                <div class="tab-pane" id="settings">
                  <form class="form-horizontal">
                    <div class="form-group row">
                      <label for="inputName" class="col-sm-2 col-form-label">Name</label>
                      <div class="col-sm-10">
                        <input type="email" class="form-control" id="inputName" placeholder="Name">
                      </div>
                    </div>
                    <div class="form-group row">
                      <label for="inputEmail" class="col-sm-2 col-form-label">Email</label>
                      <div class="col-sm-10">
                        <input type="email" class="form-control" id="inputEmail" placeholder="Email">
                      </div>
                    </div>
                    <div class="form-group row">
                      <label for="inputName2" class="col-sm-2 col-form-label">Name</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" id="inputName2" placeholder="Name">
                      </div>
                    </div>
                    <div class="form-group row">
                      <label for="inputExperience" class="col-sm-2 col-form-label">Experience</label>
                      <div class="col-sm-10">
                        <textarea class="form-control" id="inputExperience" placeholder="Experience"></textarea>
                      </div>
                    </div>
                    <div class="form-group row">
                      <label for="inputSkills" class="col-sm-2 col-form-label">Skills</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" id="inputSkills" placeholder="Skills">
                      </div>
                    </div>
                    <div class="form-group row">
                      <div class="offset-sm-2 col-sm-10">
                        <div class="checkbox">
                          <label>
                            <input type="checkbox"> I agree to the <a href="#">terms and conditions</a>
                          </label>
                        </div>
                      </div>
                    </div>
                    <div class="form-group row">
                      <div class="offset-sm-2 col-sm-10">
                        <button type="submit" class="btn btn-danger">Submit</button>
                      </div>
                    </div>
                  </form>
                </div>
                <!-- /.tab-pane -->
              </div>
              <!-- /.tab-content -->
            </div><!-- /.card-body -->
          </div>
          <!-- /.nav-tabs-custom -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
    </div><!-- /.container-fluid -->
  </section>
  <!-- /.content -->
</div>

<script>
  let moveForm = $("#moveForm");

  $(".pageInfo a").on("click", function(e){
    e.preventDefault();
    moveForm.find("input[name='pageNum']").val($(this).attr("href"));
    moveForm.attr("action", "/admin/profile/${member.id}");
    moveForm.submit();

  });

  let moveFormCom = $("#moveFormCom");

  $(".pageInfoCom a").on("click", function(e){
    e.preventDefault();
    moveFormCom.find("input[name='pageNumCom']").val($(this).attr("href"));
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
  <%@ include file="/WEB-INF/views/footer.jsp" %>

</body>
</html>
