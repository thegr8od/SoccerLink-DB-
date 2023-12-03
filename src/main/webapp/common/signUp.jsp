<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-01
  Time: 오후 10:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>sign up</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" >
</head>
<a href ="../index.jsp"><img src="../image/webLogo.png" style ="width: 200px; margin-top:10px"></a>
<hr>
<div class="d-flex align-items-center justify-content-center">
    <form action="signUpProc.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px ; margin-top:50px">
        <fieldset>
            <legend>Sign Up</legend>
            <div class="mb-3">
                <label for="pw" class="form-label">비밀번호</label>
                <input type="password" name="pw" id="pw" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="name" class="form-label">이름</label>
                <input type="text" name ="name" id="name" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="sex" class="form-label">성별</label>
                <select id="sex" name = "sex" class="form-select" required>
                    <option value="M">Male</option>
                    <option value="F">Female</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="year" class="form-label">출생년도 ex) 1998</label>
                <input type="text" name ="year" id="year" class="form-control" minLength ="4" maxLength="4" required>
            </div>
            <div class="mb-3">
                <label for="job" class="form-label">직업</label>
                <input type="text" name ="job" id="job" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="role" class="form-label">회원역할</label>
                <select id="role" name = "role" class="form-select" required>
                    <option value="manager">Manager</option>
                    <option value="member">Member</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="bankAccount" class="form-label">계좌번호</label>
                <input type="text" name ="bankAccount" id="bankAccount" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Sign Up</button>
        </fieldset>
    </form>
</div>

</body>
</html>
