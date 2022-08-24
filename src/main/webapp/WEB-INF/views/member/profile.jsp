<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-25
  Time: 오전 10:26
  To change this template use File | MyWish | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Title</title>
  <link rel="stylesheet" type="text/css" href="/css/profile.css">
</head>
<body class="hold-transition sidebar-mini layout-fixed">
  <%@ include file="/WEB-INF/views/nav.jsp" %>
  <div class="content-wrapper">
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
      </div>
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
                <ul class="list-group list-group-unbordered mb-3">
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
            </div>

            <!-- About Me Box -->
            <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">About Me</h3>
              </div>
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
            </div>
          </div>
          <div class="col-md-9">
            <div class="card">
              <div class="card-header p-2">
                <ul class="nav nav-pills">
                  <li class="nav-item"><a class="${type == 0 ? "active":"" } nav-link" href="#MyBoard" data-toggle="tab">MyBoard</a></li>
                  <li class="nav-item"><a class="${type == 1 ? "active":"" } nav-link" href="#MyComment" data-toggle="tab">MyComment</a></li>
                  <li class="nav-item"><a class="${type == 2 ? "active":"" } nav-link" href="#MyWish" data-toggle="tab">MyWish</a></li>
                  <li class="nav-item"><a class="${type == 3 ? "active":"" } nav-link" href="#MyOrder" data-toggle="tab">MyOrder</a></li>
                  <li class="nav-item"><a class="${type == 4 ? "active":"" } nav-link" href="#MyReview" data-toggle="tab">MyReview</a></li>
                </ul>
              </div>
              <div class="card-body">
                <div class="tab-content">
                  <div class="${type == 0 ? "active":"" } tab-pane" id="MyBoard">
                    <%@ include file="/WEB-INF/views/member/myList.jsp" %>
                  </div>
                  <div class="${type == 1 ? "active":"" } tab-pane" id="MyComment">
                    <%@ include file="/WEB-INF/views/member/myComment.jsp" %>
                  </div>
                  <div class="${type == 2 ? "active":"" } tab-pane" id="MyWish">
                    <%@ include file="/WEB-INF/views/member/myWish.jsp" %>
                  </div>
                  <div class="${type == 3 ? "active":"" } tab-pane" id="MyOrder">
                    <%@ include file="/WEB-INF/views/member/myOrder.jsp" %>
                  </div>
                  <div class="${type == 4 ? "active":"" } tab-pane" id="MyReview">
                    <%@ include file="/WEB-INF/views/member/myReview.jsp" %>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
  <%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>
