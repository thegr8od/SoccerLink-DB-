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
    <form action="proc/match/update.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px ; margin-top:50px">
        <fieldset>
            <legend>매치정보 수정</legend>
            <div class="mb-3">
                <label for="key" class="form-label">매치 ID</label>
                <input type="text" name="key" id="key" class="form-control" placeholder="수정할 매치의 ID를 입력하시오." required>
            </div>
            <div class="mb-3">
                <label class="form-label">수정할 속성을 고르시오</label>
                <div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr1" value="Date_Time" required>
                        <label class="form-check-label" for="attr1">날짜</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr2" value="Place_id" required>
                        <label class="form-check-label" for="attr2">구장ID</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr3" value="Type" required>
                        <label class="form-check-label" for="attr3">유형</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr4" value="Max_num" required>
                        <label class="form-check-label" for="attr4">최대인원</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr5" value="Sex_constraint" required>
                        <label class="form-check-label" for="attr5">성별제한</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr6" value="Manager_id" required>
                        <label class="form-check-label" for="attr6">매니저ID</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr7" value="Wage" required>
                        <label class="form-check-label" for="attr7">매니저 임금</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr8" value="Cost_per_one" required>
                        <label class="form-check-label" for="attr8">1경기당 비용</label>
                    </div>
                </div>
            </div>
            <div class="mb-3">
                <label for="value" class="form-label">새로운 값</label>
                <input type="text" name="value" id="value" class="form-control" placeholder="새로운 값을 입력하시오." required>
            </div>
            <button type    ="submit" class="btn btn-primary">submit</button>
        </fieldset>
    </form>
</div>
<%}else if(method.equals("delete")) {  %>
<div class="d-flex align-items-center justify-content-center">
    <form action="proc/match/delete.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px ; margin-top:50px">
        <fieldset>
            <legend>매치 삭제</legend>
            <div class="mb-3">
                <label for="key3" class="form-label">MATCH ID 입력</label>
                <input type="text" name="key" id="key3" class="form-control" placeholder="삭제할 소유자의 ID_NUMBER을 입력하시오." required>
            </div>
            <button type="submit" class="btn btn-primary">submit</button>
        </fieldset>
    </form>
</div>
<%} else if (method.equals("insert")) {
%>
<div class="d-flex align-items-center justify-content-center">
    <form action="proc/match/insert.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px ; margin-top:50px">
        <fieldset>
            <legend>매치 등록</legend>
            <div class="mb-3">
                <label for="key4" class="form-label">매치일자</label>
                <input type="text" name="Date_Time" id="key4" class="form-control" placeholder="매치일자를 입력하시오." required>
            </div>
            <div class="mb-3">
                <label for="key5" class="form-label">장소ID</label>
                <input type="text" name="Place_id" id="key5" class="form-control" placeholder="장소ID를 입려하시오.(장소가 등록되어 있어야 합니다)" required>
            </div>
            <div class="mb-3">
                <label for="TYPE" class="form-label">매치유형</label>
                <select id="TYPE" name = "TYPE" class="form-select" required>
                    <option value="F" selected>풋살</option>
                    <option value="S">축구</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="key6" class="form-label">최대인원</label>
                <input type="number" name="Max_num" id="key6" class="form-control" placeholder="최대인원을 입력하시오." required>
            </div>
            <div class="mb-3">
                <label for="key7" class="form-label">성별제한</label>
                <select id="key7" name="Sex_constraint" class="form-select" required>
                    <option value="M">남자만</option>
                    <option value="F">여자만</option>
                    <option value="A">제한없음</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="Wage" class="form-label">매니저 임금</label>
                <input type="text" name="Wage" id="Wage" class="form-control" placeholder="매니저 임금" required>
            </div>
            <div class="mb-3">
                <label for="Cost_per_one" class="form-label">1인당 비용</label>
                <input type="text" name="Cost_per_one" id="Cost_per_one" class="form-control" placeholder="1인당 비용" required>
            </div>
            <button type="submit" class="btn btn-primary">submit</button>
        </fieldset>
    </form>
</div>
<%}%>
</body>
</html>
