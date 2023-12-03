<%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-01
  Time: 오후 10:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" >
</head>
<body>
<button type="button" class="btn btn-outline-danger ms-2 mt-2" onclick ="window.location.href='../index.jsp'">Soccer Link</button>
<hr>
<div class="d-flex align-items-center justify-content-center">
<form action="logInProc.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px ; margin-top:50px">
    <fieldset>
        <legend>Log In</legend>
        <div class="mb-3">
            <label for="id" class="form-label">ID</label>
            <input type="text" name="id" id="id" class="form-control" placeholder="아이디를 입력해주세요.">
        </div>
        <div class="mb-3">
            <label for="pw" class="form-label">PW</label>
            <input type="password" name ="pw" id="pw" class="form-control" placeholder="비밀번호를 입력해주세요.">
        </div>
        <button type="submit" class="btn btn-primary">Log In</button>
        <button type="button" class="btn btn-secondary" onclick="window.location.href='signUp.jsp'">Sign Up</button>
    </fieldset>
</form>
</div>
</body>
</html>

