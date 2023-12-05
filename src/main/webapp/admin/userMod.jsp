<%--
  Created by IntelliJ IDEA.
  User: dongh
  Date: 2023-12-02
  Time: 오후 4:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="proc/loginCtrl.jsp"%>
<html>
<head>
</head>
<body>
<jsp:include page="menu.jsp"/>
<%
    String method = request.getParameter("method");
    if (method == null);
    else if(method.equals("delete")) {
%>
<div class="d-flex align-items-center justify-content-center">
    <form action="proc/user/delete.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px ; margin-top:50px">
        <fieldset>
            <legend>사용자 삭제</legend>
            <div class="mb-3">
                <label for="key" class="form-label">유저 ID</label>
                <input type="text" name="key" id="key" class="form-control" placeholder="삭제시킬 유저의 ID_NUMBER을 입력하시오.">
            </div>
            <button type="submit" class="btn btn-primary">submit</button>
        </fieldset>
    </form>
</div>
<%}%>
</body>
</html>
