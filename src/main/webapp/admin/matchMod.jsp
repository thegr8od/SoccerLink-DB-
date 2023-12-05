<%--
  Created by IntelliJ IDEA.
  User: dongh
  Date: 2023-12-02
  Time: 오후 4:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/dbconn.jsp" %>
<%--<%@ page import="classes.SQLx" %>--%>
<%--<%@ page import="java.util.*" %>--%>
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
<%--        Match Management : 실행할 명령을 클릭해주세요</div>--%>
<%--    <input type ="button" onclick="Update()" value="Update" style="font-size: 20pt; font-family: Consolas serif; background-color: white; border-radius: 8px"/>--%>
<%--    <input type ="button" onclick="Delete()" value="Delete" style="font-size: 20pt; font-family: Consolas serif; background-color: white; border-radius: 8px"/>--%>
<%--    <input type ="button" onclick="Insert()" value="Insert" style="font-size: 20pt; font-family: Consolas serif; background-color: white; border-radius: 8px"/>--%>
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
<%--<form action="proc/match/update.jsp" method="post">--%>
<%--    <br>--%>
<%--    * UPDATE * <br><br>--%>
<%--        Match_ID <br> <input type="text" name="key"> <br><br>--%>
<%--        Select Attribute (Only 1) <BR>--%>
<%--        <input type="checkbox" name="attr" value="Date_Time" onclick="checkOnlyOne(this)">Match_Date--%>
<%--        <input type="checkbox" name="attr" value="Place_id" onclick="checkOnlyOne(this)">Place_id--%>
<%--        <input type="checkbox" name="attr" value="Type" onclick="checkOnlyOne(this)">Game_Type--%>
<%--    <br><input type="checkbox" name="attr" value="Max_num" onclick="checkOnlyOne(this)">Max_Number--%>
<%--        <input type="checkbox" name="attr" value="Sex_constraint" onclick="checkOnlyOne(this)">Sex_Constraint--%>
<%--        <input type="checkbox" name="attr" value="Manager_id" onclick="checkOnlyOne(this)">Manager_ID--%>
<%--    <br><input type="checkbox" name="attr" value="Wage" onclick="checkOnlyOne(this)">Manager_wage--%>
<%--        <input type="checkbox" name="attr" value="Cost_per_one" onclick="checkOnlyOne(this)">Cost_per_Member--%>
<%--        <br><br> New Value <br><input type="text" name="value"><br><br>--%>
<%--    <input type="submit" name="Submit" value="submit" style="font-size: 12pt; font-family: Consolas serif; background-color: white; border-radius: 8px; font-style: italic; margin: 0 auto"/>--%>
<%--</form>--%>

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
                        <label class="form-check-label" for="attr1">소유자 핸드폰번호</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr2" value="Place_id" required>
                        <label class="form-check-label" for="attr2">장소ID</label>
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
                        <label class="form-check-label" for="attr5">성별제약</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr6" value="Manager_id" required>
                        <label class="form-check-label" for="attr6">매니저ID</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr7" value="Wage" required>
                        <label class="form-check-label" for="attr7">비용</label>
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
            <button type="submit" class="btn btn-primary">submit</button>
        </fieldset>
    </form>
</div>
<%--</div>--%>
<%}else if(method.equals("delete")) {  %>
<%--<div style="display:flex; justify-content: center; font-size: 15pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey; margin: 0 auto">--%>
<%--<form action="proc/match/delete.jsp" method="post">--%>
<%--    <br>--%>
<%--    * DELETE * <br><br>--%>
<%--        match_ID <br><input type="text" name="key"><br><br>--%>
<%--    <input type="submit" name="Submit" value="submit" style="font-size: 12pt; font-family: Consolas serif; background-color: white; border-radius: 8px; font-style: italic; margin: 0 auto"/>--%>
<%--</form>--%>
<div class="d-flex align-items-center justify-content-center">
    <form action="proc/match/delete.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px ; margin-top:50px">
        <fieldset>
            <legend>매치 삭제</legend>
            <div class="mb-3">
                <label for="key3" class="form-label">소유자 핸드폰 번호</label>
                <input type="text" name="key" id="key3" class="form-control" placeholder="삭제할 소유자의 ID_NUMBER을 입력하시오." required>
            </div>
            <button type="submit" class="btn btn-primary">submit</button>
        </fieldset>
    </form>
</div>
<%--</div>--%>
<%} else if (method.equals("insert")) {
%>
<%--<div style="display:flex; justify-content: center; font-size: 15pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey; margin: 0 auto">--%>
<%--<form action="proc/match/insert.jsp" method="post">--%>
<%--    <br>--%>
<%--    * INSERT * <br><br>--%>
<%--        Date_Time <br> <input type="text" name="Date_Time"> <br><br>--%>
<%--        Place_id <br> Field Table에 존재해야 합니다. <BR> <input type="text" name="Place_id"> <br><br>--%>
<%--        Type<BR>--%>
<%--        <select name="Type">--%>
<%--            <option value="F">Futsal</option>--%>
<%--            <option value="S">Soccer</option>--%>
<%--        </select><br><br>--%>
<%--        Max_number <br> <input type="text" name="Max_num"> <br><br>--%>
<%--        Sex_Constraint<br>--%>
<%--        <select name="Sex_constraint">--%>
<%--            <option value="M">Only Male</option>--%>
<%--            <option value="F">Only Female</option>--%>
<%--            <option value="A">Free For All</option>--%>
<%--        </select><br><br>--%>
<%--        Manager_wage <br><input type="text" name="Wage"> <br><br>--%>
<%--        Cost_per_Member <br><input type="text" name="Cost_per_one"><br><br>--%>
<%--    <input type="submit" name="Submit" value="submit" style="font-size: 12pt; font-family: Consolas serif; background-color: white; border-radius: 8px; font-style: italic; margin: 0 auto"/>--%>
<%--</form>--%>

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
                <label for="role" class="form-label">매치유형</label>
                <select id="role" name = "role" class="form-select" required>
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
                <label for="Wage" class="form-label">비용</label>
                <input type="text" name="Wage" id="Wage" class="form-control" placeholder="비용" required>
            </div>
            <div class="mb-3">
                <label for="Cost_per_one" class="form-label">1인당 비용</label>
                <input type="text" name="Cost_per_one" id="Cost_per_one" class="form-control" placeholder="1인당 비용" required>
            </div>
            <button type="submit" class="btn btn-primary">submit</button>
        </fieldset>
    </form>
</div>
<%--</div>--%>
<%}%>
<script>
    // function Update(){
    //     const searchForm = document.querySelector("#searchForm");
    //     var categoryInput = document.createElement('input');
    //     categoryInput.type = 'text';
    //     categoryInput.name = 'category';
    //     categoryInput.value = 'Update';
    //     searchForm.appendChild(categoryInput);
    //     searchForm.action = "matchMod.jsp";
    //     searchForm.submit();
    // }
    // function Delete(){
    //     const searchForm = document.querySelector("#searchForm");
    //     var categoryInput = document.createElement('input');
    //     categoryInput.type = 'text';
    //     categoryInput.name = 'category';
    //     categoryInput.value = 'Delete';
    //     searchForm.appendChild(categoryInput);
    //     searchForm.action = "matchMod.jsp";
    //     searchForm.submit();
    // }
    // function Insert(){
    //     const searchForm = document.querySelector("#searchForm");
    //     var categoryInput = document.createElement('input');
    //     categoryInput.type = 'text';
    //     categoryInput.name = 'category';
    //     categoryInput.value = 'Insert';
    //     searchForm.appendChild(categoryInput);
    //     searchForm.action = "matchMod.jsp";
    //     searchForm.submit();
    // }
    // function checkOnlyOne(element) {
    //     const checkboxes
    //         = document.getElementsByName("attr");
    //     checkboxes.forEach((cb) => {
    //         cb.checked = false;
    //     })
    //     element.checked = true;
    // }
</script>
</body>
</html>
