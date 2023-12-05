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
    <form action="proc/owner/update.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px ; margin-top:50px">
        <fieldset>
            <legend>소유주 정보 수정</legend>
            <div class="mb-3">
                <label for="key" class="form-label">소유주 휴대폰번호</label>
                <input type="text" name="key" id="key" class="form-control" placeholder="소유주의 휴대폰번호를 입력하시오." required>
            </div>
            <div class="mb-3">
                <label class="form-label">수정할 속성을 고르시오</label>
                <div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr1" value="Owner_HP" required>
                        <label class="form-check-label" for="attr1">소유주 핸드폰번호</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr2" value="Name" required>
                        <label class="form-check-label" for="attr2">소유주 이름</label>
                    </div>
                </div>
            </div>
            <div class="mb-3">
                <label for="value" class="form-label">새로운 값</label>
                <input type="text" name="value" id="value" class="form-control" placeholder="새로운 값을 입력하시오." required>
            </div>
            <button type="submit" class="btn btn-primary">submit</button>
        </fieldset>
    </form>
</div>

<%}else if(method.equals("delete")) {  %>
<div class="d-flex align-items-center justify-content-center">
    <form action="proc/team/delete.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px ; margin-top:50px">
        <fieldset>
            <legend>소유주 삭제</legend>
            <div class="mb-3">
                <label for="key3" class="form-label">소유주 핸드폰 번호</label>
                <input type="text" name="key" id="key3" class="form-control" placeholder="삭제할 소유주의 ID_NUMBER을 입력하시오." required>
            </div>
            <button type="submit" class="btn btn-primary">submit</button>
        </fieldset>
    </form>
</div>
<%} else if (method.equals("insert")) {%>
<div class="d-flex align-items-center justify-content-center">
    <form action="proc/owner/insert.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px ; margin-top:50px">
        <fieldset>
            <legend>소유주 등록</legend>
            <div class="mb-3">
                <label for="key4" class="form-label">휴대폰번호</label>
                <input type="text" name="Owner_HP" id="key4" class="form-control" placeholder="휴대폰번호를 입력하시오." required>
            </div>
            <div class="mb-3">
                <label for="key5" class="form-label">이름</label>
                <input type="text" name="Name" id="key5" class="form-control" placeholder="이름을 입력하시오." required>
            </div>
            <button type="submit" class="btn btn-primary">submit</button>
        </fieldset>
    </form>
</div>
<%}%>
</body>
</html>
