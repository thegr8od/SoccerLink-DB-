<%--
  Created by IntelliJ IDEA.
  User: dongh
  Date: 2023-12-02
  Time: 오후 4:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/dbconn.jsp" %>
<%@ page import="classes.SQLx" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<html>
<head>
    <title>Admin page - Check information</title>
    <a href="../index.jsp">SoccerLink</a>
    |
    <a href="../common/logOutProc.jsp">LogOut</a>
    |
    <a href="admin.jsp">Back</a>
</head>
<body>
<br>
<br>
<div style="display:flex;justify-content: center;width: 100%;gap: 100px">
    <input type="button" value="User" name="1" onclick="location.href='userMod.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey"/>
    <input type="button" value="Team" name="2" onclick="location.href='teamMod.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey"/>
    <input type="button" value="Owner" name="3" onclick="location.href='ownerMod.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color:grey"/>
    <input type="button" value="Field" name="4" onclick="location.href='fieldMod.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey"/>
    <input type="button" value="Match" name="5" onclick="location.href='matchMod.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey"/>
    <input type="button" value="Training" name="6" onclick="location.href='trainMod.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey"/>
    <input type="button" value="Check Information" onclick="location.href='checkInfo.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey"/>
</div>
<br>
<div style="width: 80%; height: 1px; background-color: grey; margin: 0 auto"></div>
<br>
<div style="display:flex;justify-content: center;width: 100%;gap: 80px">
    <div style="font-family: Arial serif; font-size: 20pt; font-style: italic">
        Match Management : 실행할 명령을 클릭해주세요</div>
    <input type ="button" onclick="Update()" value="Update" style="font-size: 20pt; font-family: Consolas serif; background-color: white; border-radius: 8px"/>
    <input type ="button" onclick="Delete()" value="Delete" style="font-size: 20pt; font-family: Consolas serif; background-color: white; border-radius: 8px"/>
    <input type ="button" onclick="Insert()" value="Insert" style="font-size: 20pt; font-family: Consolas serif; background-color: white; border-radius: 8px"/>
    <br>
</div>
<br>
<div style="width: 80%; height: 1px; background-color: grey; margin: 0 auto"></div>
<%
    String category = request.getParameter("category");
    String sql;
    if (category == null);
    else if(category.equals("Update")){
%>
<div style="display:flex; justify-content: center; font-size: 15pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey; margin: 0 auto">
<form action="proc/match/update.jsp" method="post">

    <br>
    * UPDATE * <br><br>
        Match_ID <br> <input type="text" name="key"> <br><br>
        Select Attribute (Only 1) <BR>
        <input type="checkbox" name="attr" value="Date_Time" onclick="checkOnlyOne(this)">Match_Date
        <input type="checkbox" name="attr" value="Place_id" onclick="checkOnlyOne(this)">Place_id
        <input type="checkbox" name="attr" value="Type" onclick="checkOnlyOne(this)">Game_Type
    <br><input type="checkbox" name="attr" value="Max_num" onclick="checkOnlyOne(this)">Max_Number
        <input type="checkbox" name="attr" value="Sex_constraint" onclick="checkOnlyOne(this)">Sex_Constraint
        <input type="checkbox" name="attr" value="Manager_id" onclick="checkOnlyOne(this)">Manager_ID
    <br><input type="checkbox" name="attr" value="Wage" onclick="checkOnlyOne(this)">Manager_wage
        <input type="checkbox" name="attr" value="Cost_per_one" onclick="checkOnlyOne(this)">Cost_per_Member
        <br><br> New Value <br><input type="text" name="value"><br><br>
    <input type="submit" name="Submit" value="submit" style="font-size: 12pt; font-family: Consolas serif; background-color: white; border-radius: 8px; font-style: italic; margin: 0 auto"/>
</form>
</div>
<%}else if(category.equals("Delete")) {  %>
<div style="display:flex; justify-content: center; font-size: 15pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey; margin: 0 auto">
<form action="proc/match/delete.jsp" method="post">

    <br>
    * DELETE * <br><br>
        match_ID <br><input type="text" name="key"><br><br>
    <input type="submit" name="Submit" value="submit" style="font-size: 12pt; font-family: Consolas serif; background-color: white; border-radius: 8px; font-style: italic; margin: 0 auto"/>
</form>
</div>
<%} else if (category.equals("Insert")) {
%>
<div style="display:flex; justify-content: center; font-size: 15pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey; margin: 0 auto">
<form action="proc/match/insert.jsp" method="post">
    <br>
    * INSERT * <br><br>
        Date_Time <br> <input type="text" name="Date_Time"> <br><br>
        Place_id <br> Field Table에 존재해야 합니다. <BR> <input type="text" name="Place_id"> <br><br>
        Type<BR>
        <select name="Type">
            <option value="F">Futsal</option>
            <option value="S">Soccer</option>
        </select><br><br>
        Max_number <br> <input type="text" name="Max_num"> <br><br>
        Sex_Constraint<br>
        <select name="Sex_constraint">
            <option value="M">Only Male</option>
            <option value="F">Only Female</option>
            <option value="A">Free For All</option>
        </select><br><br>
        Manager_wage <br><input type="text" name="Wage"> <br><br>
        Cost_per_Member <br><input type="text" name="Cost_per_one"><br><br>
    <input type="submit" name="Submit" value="submit" style="font-size: 12pt; font-family: Consolas serif; background-color: white; border-radius: 8px; font-style: italic; margin: 0 auto"/>
</form>
</div>
<%}%>

<form id="searchForm">
</form>
<script>
    function Update(){
        const searchForm = document.querySelector("#searchForm");
        var categoryInput = document.createElement('input');
        categoryInput.type = 'text';
        categoryInput.name = 'category';
        categoryInput.value = 'Update';
        searchForm.appendChild(categoryInput);
        searchForm.action = "matchMod.jsp";
        searchForm.submit();
    }
    function Delete(){
        const searchForm = document.querySelector("#searchForm");
        var categoryInput = document.createElement('input');
        categoryInput.type = 'text';
        categoryInput.name = 'category';
        categoryInput.value = 'Delete';
        searchForm.appendChild(categoryInput);
        searchForm.action = "matchMod.jsp";
        searchForm.submit();
    }
    function Insert(){
        const searchForm = document.querySelector("#searchForm");
        var categoryInput = document.createElement('input');
        categoryInput.type = 'text';
        categoryInput.name = 'category';
        categoryInput.value = 'Insert';
        searchForm.appendChild(categoryInput);
        searchForm.action = "matchMod.jsp";
        searchForm.submit();
    }
    function checkOnlyOne(element) {
        const checkboxes
            = document.getElementsByName("attr");
        checkboxes.forEach((cb) => {
            cb.checked = false;
        })
        element.checked = true;
    }
</script>
</body>
</html>

