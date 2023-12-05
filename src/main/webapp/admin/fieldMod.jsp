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
<%--        Field Management : 실행할 명령을 클릭해주세요</div>--%>
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
<%--    <form action="proc/field/update.jsp" method="post">--%>
<%--        <br>--%>
<%--        * UPDATE * <br><br>--%>
<%--        Field_ID<br><input type="text" name="key"><br><br>--%>
<%--        Select Attribute (Only 1) <br>--%>
<%--        <input type="checkbox" name="attr" value="Name" onclick="checkOnlyOne(this)">Name--%>
<%--        <input type="checkbox" name="attr" value="Field_HP" onclick="checkOnlyOne(this)">Field_HP--%>
<%--        <input type="checkbox" name="attr" value="Address" onclick="checkOnlyOne(this)">Address<br><br>--%>
<%--        New Value<br><input type="text" name="value"><br><br>--%>
<%--        <input type="submit" name="Submit" value="submit" style="font-size: 12pt; font-family: Consolas serif; background-color: white; border-radius: 8px; font-style: italic; margin: 0 auto"/>--%>
<%--    </form>--%>
<%--</div>--%>

<div class="d-flex align-items-center justify-content-center">
    <form action="proc/field/update.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px ; margin-top:50px">
        <fieldset>
            <legend>필드정보 수정</legend>
            <div class="mb-3">
                <label for="key" class="form-label">필드ID</label>
                <input type="text" name="key" id="key" class="form-control" placeholder="수정할 필드의 ID를 입력하시오." required>
            </div>
            <div class="mb-3">
                <label class="form-label">수정할 속성을 고르시오</label>
                <div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr1" value="Name" required>
                        <label class="form-check-label" for="attr1">필드명</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr2" value="Field_HP" required>
                        <label class="form-check-label" for="attr2">핸드폰번호</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr3" value="Address" required>
                        <label class="form-check-label" for="attr3">주소</label>
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

<%}else if(method.equals("delete")){ %>
<%--<div style="display:flex; justify-content: center; font-size: 15pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey; margin: 0 auto">--%>
<%--<form action="proc/field/delete.jsp" method="post">--%>

<%--    <br>--%>
<%--    * DELETE * <br><br>--%>
<%--    Field_ID<br><input type="text" name="key"><br><br>--%>
<%--    <input type="submit" name="Submit" value="submit" style="font-size: 12pt; font-family: Consolas serif; background-color: white; border-radius: 8px; font-style: italic; margin: 0 auto"/>--%>
<%--</form>--%>
<%--</div>--%>
<div class="d-flex align-items-center justify-content-center">
    <form action="proc/field/delete.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px ; margin-top:50px">
        <fieldset>
            <legend>필드 삭제</legend>
            <div class="mb-3">
                <label for="key3" class="form-label">필드ID</label>
                <input type="text" name="key" id="key3" class="form-control" placeholder="삭제할 필드의 ID_NUMBER을 입력하시오." required>
            </div>
            <button type="submit" class="btn btn-primary">submit</button>
        </fieldset>
    </form>
</div>
<%} else if (method.equals("insert")) {%>
<%--<div style="display:flex; justify-content: center; font-size: 15pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey; margin: 0 auto">--%>
<%--<form action="proc/field/insert.jsp" method="post">--%>
<%--    <br>--%>
<%--    * INSERT * <br><br>--%>
<%--        Name <br> <input type="text" name="Name"><br><br>--%>
<%--        Field_HP <br> <input type="text" name="Field_HP"><br><br>--%>
<%--        Owner_HP <BR> Owner Table에 존재해야 합니다.<br> <input type="text" name="Owner_HP"><br><br>--%>
<%--        Address <br> <input type="text" name="Address"><br><br>--%>
<%--    <input type="submit" name="Submit" value="submit" style="font-size: 12pt; font-family: Consolas serif; background-color: white; border-radius: 8px; font-style: italic; margin: 0 auto"/>--%>
<%--</form>--%>
<%--</div>--%>
<div class="d-flex align-items-center justify-content-center">
    <form action="proc/field/insert.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px ; margin-top:50px">
        <fieldset>
            <legend>필드 등록</legend>
            <div class="mb-3">
                <label for="key4" class="form-label">필드명</label>
                <input type="text" name="Name" id="key4" class="form-control" placeholder="필드명을 입력하시오." required>
            </div>
            <div class="mb-3">
                <label for="key5" class="form-label">필드 전화번호</label>
                <input type="text" name="Field_HP" id="key5" class="form-control" placeholder="필드 전화번호를 입력하시오." required>
            </div>
            <div class="mb-3">
                <label for="key6" class="form-label">필드 주소</label>
                <input type="text" name="Field_HP" id="key6" class="form-control" placeholder="필드 주소를 입력하시오." required>
            </div>
            <button type="submit" class="btn btn-primary">submit</button>
        </fieldset>
    </form>
</div>
<%}%>

<%--<form id="searchForm">--%>
<%--</form>--%>
<script>
    // function Update(){
    //     const searchForm = document.querySelector("#searchForm");
    //     var categoryInput = document.createElement('input');
    //     categoryInput.type = 'text';
    //     categoryInput.name = 'category';
    //     categoryInput.value = 'Update';
    //     searchForm.appendChild(categoryInput);
    //     searchForm.action = "fieldMod.jsp";
    //     searchForm.submit();
    // }
    // function Delete(){
    //     const searchForm = document.querySelector("#searchForm");
    //     var categoryInput = document.createElement('input');
    //     categoryInput.type = 'text';
    //     categoryInput.name = 'category';
    //     categoryInput.value = 'Delete';
    //     searchForm.appendChild(categoryInput);
    //     searchForm.action = "fieldMod.jsp";
    //     searchForm.submit();
    // }
    // function Insert(){
    //     const searchForm = document.querySelector("#searchForm");
    //     var categoryInput = document.createElement('input');
    //     categoryInput.type = 'text';
    //     categoryInput.name = 'category';
    //     categoryInput.value = 'Insert';
    //     searchForm.appendChild(categoryInput);
    //     searchForm.action = "fieldMod.jsp";
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
