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
<head>
    <title>User Modify</title>
    <a href="../index.jsp">Soccer Link</a>
    <a href="../common/logOutProc.jsp">Log Out</a>
<body>
<br>
<input type="button" value="User" name="1" onclick="location.href='userMod.jsp'"/>
<input type="button" value="Team" name="2" onclick="location.href='teamMod.jsp'"/>
<input type="button" value="Owner" name="3" onclick="location.href='ownerMod.jsp'"/>
<input type="button" value="Field" name="4" onclick="location.href='fieldMod.jsp'"/>
<input type="button" value="Match" name="5" onclick="location.href='matchMod.jsp'"/>
<input type="button" value="Training" name="6" onclick="location.href='trainMod.jsp'"/>
<input type="button" value="Check Information" onclick="location.href='checkInfo.jsp'"/>
<br>
User MANAGEMENT
<br><a href="admin.jsp">Back</a>
<br>
<input type ="button" onclick="Delete()" value="Delete">
<br>
<%
    String category = request.getParameter("category");
    String sql;
    if (category == null);
    else if(category.equals("Delete")) { out.println("Delete, Target ID_Number를 입력하세요"); %>
<form action="proc/user/delete.jsp" method="post">
    <p>
        <br>ID_Number <input type="text" name="key">
        <br><input type="submit" name="Submit" value="submit">
    </p>
</form>
<%}%>

<form id="searchForm">
</form>
<script>
    function Delete(){
        const searchForm = document.querySelector("#searchForm");
        var categoryInput = document.createElement('input');
        categoryInput.type = 'text';
        categoryInput.name = 'category';
        categoryInput.value = 'Delete';
        searchForm.appendChild(categoryInput);
        searchForm.action = "userMod.jsp";
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

