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
</head>
<body>
    <form id="searchForm" class="form-inline ml-3" action="/getSearch" method="get">
        <div class="input-group input-group-sm">
            <c:set var="key" value="${keyword}" />
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
