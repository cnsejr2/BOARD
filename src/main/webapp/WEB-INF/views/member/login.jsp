<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap');
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Poppins', sans-serif
    }
    .container {
        width : 30%;
        margin: 20px auto;
        border: 1px solid #dddd;
        border-radius: 18px;
        box-shadow: rgba(0, 0, 0, 0.24) 0px 3px 8px;
    }

    .loginBtn {
        padding:10px;
    }
    .box-2 {
        width: 100%;
    }

    .h-1 {
        font-size: 24px;
        font-weight: 700;
    }

    .mt-5, .c {
        text-align : center;
    }
    t {
        display:block;
        border: 2px solid transparent;
        color: #615f5fdd;
        margin : 15px auto;
    }
    #login2, #join {
        display: inline-block;
        border-radius:5px;
    }
    #login2 > a, #join > a {
        text-decoration:none;
        color: white;
    }
    .space {
        height : 80px;
    }
</style>


<div class="container">
    <div class="body d-md-flex align-items-center justify-content-between">
        <div class="box-2 d-flex flex-column h-100" id="t">
            <div class="mt-5">
                <p class="mb-1 h-1">로그인</p>
                <form method="post" action="/member/login">
                        <div class="form-group">
                            <label for="id">userId</label>
                            <input type="text" class="form-control" id="id" name="id" placeholder="사용자 아이디">
                        </div>
                        <div class="form-group">
                            <label for="password">password</label>
                            <input type="text" class="form-control" id="password" name="password" placeholder="사용자 비밀번호">
                        </div>
                        <button type="submit" class="btn btn-primary">로그인</button>

                </form>
                <button onclick="location.href='/member/signup'" class="btn btn-primary">회원가입</button>
                <br>
                <div class="space">&nbsp;</div>
            </div>
        </div>
    </div>
</div>