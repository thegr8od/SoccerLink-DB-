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
    <form action="proc/train/update.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px ; margin-top:50px">
        <fieldset>
            <legend>트레이닝 수정</legend>
            <div class="mb-3">
                <label for="key" class="form-label">클래스ID</label>
                <input type="text" name="key" id="key" class="form-control" placeholder="수정할 트레이닝의 클래스ID를 입력하시오.">
            </div>
            <div class="mb-3">
                <label class="form-label">수정할 속성을 고르시오</label>
                <div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr1" value="Date_time">
                        <label class="form-check-label" for="attr1">트레이닝 날짜</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr2" value="Recommend_tier">
                        <label class="form-check-label" for="attr2">추천 티어</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr3" value="Subject">
                        <label class="form-check-label" for="attr3">주제</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr4" value="Place">
                        <label class="form-check-label" for="attr4">장소</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr5" value="Max_num">
                        <label class="form-check-label" for="attr5">최대숫자</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr6" value="Wage">
                        <label class="form-check-label" for="attr6">비용</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr7" value="Cost_per_one">
                        <label class="form-check-label" for="attr7">1인당비용</label>
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

<%}else if(method.equals("delete")) { %>

<div class="d-flex align-items-center justify-content-center">
    <form action="proc/train/delete.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px ; margin-top:50px">
        <fieldset>
            <legend>트레이닝 삭제</legend>
            <div class="mb-3">
                <label for="key3" class="form-label">클래스ID</label>
                <input type="text" name="key" id="key3" class="form-control" placeholder="삭제할 트레이닝의 클래스ID를 입력하시오." required>
            </div>
            <button type="submit" class="btn btn-primary">submit</button>
        </fieldset>
    </form>
</div>
<%}%>
</body>
</html>
