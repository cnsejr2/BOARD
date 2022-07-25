<%--
  Created by IntelliJ IDEA.
  User: D-005
  Date: 2022-07-18
  Time: 오후 2:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
<%--    <script--%>
<%--            src="https://code.jquery.com/jquery-3.4.1.js"--%>
<%--            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="--%>
<%--            crossorigin="anonymous">--%>
<%--    </script>--%>
<%--    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">--%>

</head>
<body>
<c:set var="key" value="${keyword}" />
<form id="searchForm" class="form-inline ml-3" action="/getSearch" method="get">
    <div class="input-group input-group-sm">
        <input class="form-control form-control-navbar" id="keyword" name="keyword" type="search"
               placeholder="<c:out value="${key}" default="Search"/>" aria-label="Search">
        <div class="input-group-append">
            <button class="btn btn-navbar" id="btnSearch" type="submit">
                <i class="fas fa-search"></i>
            </button>
        </div>
    </div>
</form>
</body>
</html>
