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
    else if(method.equals("update")){
%>
<div class="d-flex align-items-center justify-content-center">
    <form action="proc/team/update.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px ; margin-top:50px">
        <fieldset>
            <legend>팀정보 수정</legend>
            <div class="mb-3">
                <label for="key" class="form-label">팀 ID</label>
                <input type="text" name="key" id="key" class="form-control" placeholder="수정하실 팀의 ID_NUMBER를 입력하시오." required>
            </div>
            <div class="mb-3">
                <label for="attr" class="form-label">수정할 속성을 고르시오</label>
                <div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr" value="Team_Name" required>
                        <label class="form-check-label" for="attr">팀명</label>
                    </div>
                </div>
            </div>
            <div class="mb-3">
                <label for="value" class="form-label">새로운 값</label>
                <input type="text" name="key" id="value" class="form-control" placeholder="새로운 값을 입력하시오." required>
            </div>
            <button type="submit" class="btn btn-primary">submit</button>
        </fieldset>
    </form>
</div>
<%}else if(method.equals("delete")) {  %>
<div class="d-flex align-items-center justify-content-center">
    <form action="proc/team/delete.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px ; margin-top:50px">
        <fieldset>
            <legend>팀 삭제</legend>
            <div class="mb-3">
                <label for="key2" class="form-label">팀 ID</label>
                <input type="text" name="key" id="key2" class="form-control" placeholder="삭제시킬 팀의 ID_NUMBER를 입력하시오." required>
            </div>
            <button type="submit" class="btn btn-primary">submit</button>
        </fieldset>
    </form>
</div>
<%}%>
</body>
</html>
