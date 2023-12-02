<%@ include file="common/dbconn.jsp" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ page import="classes.dto.MatchDto" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.stream.Collectors" %>
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
<input type = "button" value="my page" onclick="window.location.href ='member/member.jsp'">
<%
        }
        else {
            // manager table에 존재하는지 확인
            String checkManager = SQLx.Selectx("ID_NUMBER", "MANAGER", where.toString(), "");
            pst = conn.prepareStatement(checkManager);
            rs = pst.executeQuery();
            if (rs.next()) {
%>
<input type = "button" value="my page" onclick="window.location.href ='mana/manager.jsp'">
<%
            }
        }
%>
<input type="button" value="log out" onclick = "window.location.href='common/logOutProc.jsp'">
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
    List <MatchDto> matchDtoList = new ArrayList<>();

    if(category == null||category.equals("match")){
        String matchSearch = "SELECT M.*, F.NAME,F.ADDRESS FROM MATCH M \n" +
                "INNER JOIN FIELD F ON M.PLACE_ID = F.FIELD_ID\n" +
                "WHERE M.MATCH_ID IN\n" +
                "(SELECT DISTINCT MATCH_ID\n" +
                "FROM MATCH M1\n" +
                "WHERE M1.DATE_TIME = '"+date+
                "')";
        pst = conn.prepareStatement(matchSearch);
        rs = pst.executeQuery();
        while(rs.next()){
            MatchDto matchDto = new MatchDto();
            matchDto.setMatchId(rs.getString("MATCH_ID"));
            matchDto.setfName(rs.getString("NAME"));
            matchDto.setfAddress(rs.getString("ADDRESS"));
            matchDto.setType(rs.getString("TYPE"));
//            matchDto.setCurrentNum(rs.getString("MATCH_ID"));
            matchDto.setMaxNum(rs.getInt("MAX_NUM"));
            matchDto.setSex(rs.getString("SEX_CONSTRAINT"));
            matchDto.setCost(rs.getInt("COST_PER_ONE"));
//            String searchCurNum = "select count(MATCH_ID)\n" +
//                    "from MATCH_APP_MEMBER\n" +
//                    "where MATCH_ID = \'"+rs.getString("MATCH_ID")+"\'";
            matchDtoList.add(matchDto);
        }
        matchDtoList.stream().map(item->item.getMatchId()).collect(Collectors.toList());
    }
    else{

    }
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
