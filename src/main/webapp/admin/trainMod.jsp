<%--
  Created by IntelliJ IDEA.
  User: dongh
  Date: 2023-12-02
  Time: 오후 4:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/dbconn.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%--    <title>Admin page - Check information</title>--%>
    <%--    <a href="../index.jsp">SoccerLink</a>--%>
    <%--    |--%>
    <%--    <a href="../common/logOutProc.jsp">LogOut</a>--%>
    <%--    |--%>
    <%--    <a href="admin.jsp">Back</a>--%>
</head>
<body>
<jsp:include page="menu.jsp"/>
<%--<br>--%>
<%--<br>--%>
<%--<div style="display:flex;justify-content: center;width: 100%;gap: 100px">--%>
<%--    <input type="button" value="User" name="1" onclick="location.href='userMod.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey"/>--%>
<%--    <input type="button" value="Team" name="2" onclick="location.href='teamMod.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey"/>--%>
<%--    <input type="button" value="Owner" name="3" onclick="location.href='ownerMod.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color:grey"/>--%>
<%--    <input type="button" value="Field" name="4" onclick="location.href='fieldMod.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey"/>--%>
<%--    <input type="button" value="Match" name="5" onclick="location.href='matchMod.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey"/>--%>
<%--    <input type="button" value="Training" name="6" onclick="location.href='trainMod.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey"/>--%>
<%--    <input type="button" value="Check Information" onclick="location.href='checkInfo.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey"/>--%>
<%--</div>--%>
<%--<br>--%>
<%--<div style="width: 80%; height: 1px; background-color: grey; margin: 0 auto"></div>--%>
<%--<br>--%>
<%--<div style="display:flex;justify-content: center;width: 100%;gap: 80px">--%>
<%--    <div style="font-family: Arial serif; font-size: 20pt; font-style: italic">--%>
<%--        Training Management : 실행할 명령을 클릭해주세요</div>--%>
<%--    <input type ="button" onclick="Update()" value="Update" style="font-size: 20pt; font-family: Consolas serif; background-color: white; border-radius: 8px"/>--%>
<%--    <input type ="button" onclick="Delete()" value="Delete" style="font-size: 20pt; font-family: Consolas serif; background-color: white; border-radius: 8px"/>--%>
<%--    <br>--%>
<%--</div>--%>
<%--<br>--%>
<%--<div style="width: 80%; height: 1px; background-color: grey; margin: 0 auto"></div>--%>
<%
    String method = request.getParameter("method");
//    String sql;
    if (method == null);
    else if(method.equals("update")){
%>
<%--<div style="display:flex; justify-content: center; font-size: 15pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey; margin: 0 auto">--%>
<%--<form action="proc/train/update.jsp" method="post">--%>

<%--    <br>--%>
<%--    * UPDATE * <br><br>--%>
<%--        <br>Class_ID <input type="text" name="key"> <BR><BR>--%>
<%--    Select Attribute (Only 1) <BR>--%>
<%--        <input type="checkbox" name="attr" value="Date_time" onclick="checkOnlyOne(this)">Training_Date--%>
<%--        <input type="checkbox" name="attr" value="Recommend_tier" onclick="checkOnlyOne(this)">Recommend_tier--%>
<%--    <br><input type="checkbox" name="attr" value="Subject" onclick="checkOnlyOne(this)">Subject--%>
<%--        <input type="checkbox" name="attr" value="Place" onclick="checkOnlyOne(this)">Place--%>
<%--        <input type="checkbox" name="attr" value="Max_num" onclick="checkOnlyOne(this)">Max_Number--%>
<%--    <br><input type="checkbox" name="attr" value="Wage" onclick="checkOnlyOne(this)">Tutor_wage--%>
<%--        <input type="checkbox" name="attr" value="Cost_per_one" onclick="checkOnlyOne(this)">Cost_per_Tutee--%>
<%--    <br><br> New Value <br> <input type="text" name="value"> <br><br>--%>
<%--        <input type="submit" name="Submit" value="submit" style="font-size: 12pt; font-family: Consolas serif; background-color: white; border-radius: 8px; font-style: italic; margin: 0 auto"/>--%>
<%--</form>--%>

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

<%--</div>--%>
<%}else if(method.equals("delete")) { %>
<%--<div style="display:flex; justify-content: center; font-size: 15pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey; margin: 0 auto">--%>
<%--<form action="proc/train/delete.jsp" method="post">--%>
<%--    <br>--%>
<%--    * DELETE * <br><br>--%>
<%--        Class_ID <br> <input type="text" name="key"> <br><br>--%>
<%--        <input type="submit" name="Submit" value="submit" style="font-size: 12pt; font-family: Consolas serif; background-color: white; border-radius: 8px; font-style: italic; margin: 0 auto"/>--%>
<%--</form>--%>
<%--</div>--%>

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

<%--<form id="searchForm">--%>
<%--</form>--%>
<%--<script>--%>
<%--    function Update(){--%>
<%--        const searchForm = document.querySelector("#searchForm");--%>
<%--        var categoryInput = document.createElement('input');--%>
<%--        categoryInput.type = 'text';--%>
<%--        categoryInput.name = 'category';--%>
<%--        categoryInput.value = 'Update';--%>
<%--        searchForm.appendChild(categoryInput);--%>
<%--        searchForm.action = "trainMod.jsp";--%>
<%--        searchForm.submit();--%>
<%--    }--%>
<%--    function Delete(){--%>
<%--        const searchForm = document.querySelector("#searchForm");--%>
<%--        var categoryInput = document.createElement('input');--%>
<%--        categoryInput.type = 'text';--%>
<%--        categoryInput.name = 'category';--%>
<%--        categoryInput.value = 'Delete';--%>
<%--        searchForm.appendChild(categoryInput);--%>
<%--        searchForm.action = "trainMod.jsp";--%>
<%--        searchForm.submit();--%>
<%--    }--%>
<%--    function checkOnlyOne(element) {--%>
<%--        const checkboxes--%>
<%--            = document.getElementsByName("attr");--%>
<%--        checkboxes.forEach((cb) => {--%>
<%--            cb.checked = false;--%>
<%--        })--%>
<%--        element.checked = true;--%>
<%--    }--%>
<%--</script>--%>
</body>
</html>
