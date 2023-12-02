<%@ include file="dbconn.jsp" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-01
  Time: 오후 10:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Soccer Link</title>
</head>
<body>
<%
    String user = (String) session.getAttribute(SessionConst.USER);
    if(user==null){

%>
<a href="common/login.jsp">login</a>
<%
    }
    else{
        String apx = "\'";
        StringBuilder where = new StringBuilder();
        where.append("ID_NUMBER = " + apx + user + apx);
        String checkMember = SQLx.Selectx("ID_NUMBER", "MEMBER", where.toString(), "");
        pst = conn.prepareStatement(checkMember);
        rs = pst.executeQuery();
        if (rs.next()) {
%>
<input type = "button" value="my page" onclick="window.location.href ='member.jsp'">
<%
        }
        else {
            // manager table에 존재하는지 확인
            String checkManager = SQLx.Selectx("ID_NUMBER", "MANAGER", where.toString(), "");
            pst = conn.prepareStatement(checkManager);
            rs = pst.executeQuery();
            if (rs.next()) {
%>
<input type = "button" value="my page" onclick="window.location.href ='manager.jsp'">
<%
            }
        }
%>
<input type="button" value="log out" onclick = "window.location.href='logOutProc.jsp'">
<%
    }
%>
<h2>SoccerLink</h2>
</br>
<label> Match or Training Date : </label>
<input type="date" name="date" id="date">
</br>
<input type ="button" onclick="searchMatch()" value="match">
<input type ="button" onclick="searchTraining()" value="training">
<%
    String category = request.getParameter("category");
    String date = request.getParameter("date");
    System.out.println("cate ="+category);
    System.out.println("date = "+date);

//    if(category == null||category.equals("match")){
//        String date = request.getParameter("date");
//        String apx = "\'";
//        StringBuilder where = new StringBuilder();
//        where.append("ID_NUMBER = " + apx + user + apx);
//        String checkMember = SQLx.Selectx("ID_NUMBER", "MEMBER", where.toString(), "");
//        pst = conn.prepareStatement(checkMember);
//        rs = pst.executeQuery();
//    }
//    else{
//
//    }
%>
<form id="searchForm">
</form>
<script>
    function searchMatch(){
        const searchForm = document.querySelector("#searchForm");
        const date = document.querySelector("#date");
        searchForm.appendChild(date)
        var categoryInput = document.createElement('input');
        categoryInput.type = 'text';
        categoryInput.name = 'category';
        categoryInput.value = 'match';
        searchForm.appendChild(categoryInput);
        searchForm.action = "index.jsp";
        searchForm.submit();
    }
    function searchTraining(){
        const searchForm = document.querySelector("#searchForm");
        const date = document.querySelector("#date");
        searchForm.appendChild(date)
        var categoryInput = document.createElement('input');
        categoryInput.type = 'text';
        categoryInput.name = 'category';
        categoryInput.value = 'training';
        searchForm.appendChild(categoryInput);
        searchForm.action = "index.jsp";
        searchForm.submit();
    }
</script>
</body>
</html>
