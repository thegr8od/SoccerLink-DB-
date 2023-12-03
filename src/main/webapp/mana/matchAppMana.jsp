<%@ page import="classes.dto.MatchDto" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %><%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-03
  Time: 오전 3:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<jsp:include page="backgroundCategory.jsp"/>
<h3>매치 매니저 신청</h3>
    <label> Match Date : </label>
    <input type="date" name="date" id="date">
    <input type ="button" onclick ="matchReload()" value="검색">
    <input type="button" onclick ="myMatch()" value="나의 매치">
    <hr>
<%
    String myMatchFind = request.getParameter("myMatchFind");
    boolean myMatchFindBoolean = Boolean.parseBoolean(myMatchFind);
    String date = request.getParameter("date");
    String matchSearch = "";
    if(myMatchFindBoolean){
        matchSearch ="SELECT M.*, F.NAME,F.ADDRESS FROM MATCH M \n" +
                "INNER JOIN FIELD F ON M.PLACE_ID = F.FIELD_ID\n" +
                "WHERE M.manager_id = '"+(String)session.getAttribute(SessionConst.USER)+"'AND\n" +
                "M.MATCH_ID IN (SELECT DISTINCT MATCH_ID\n" +
                "FROM MATCH M1\n";
    }
    else {
        matchSearch = "SELECT M.*, F.NAME,F.ADDRESS FROM MATCH M \n" +
            "INNER JOIN FIELD F ON M.PLACE_ID = F.FIELD_ID\n" +
            "WHERE M.MATCH_ID IN\n" +
            "(SELECT DISTINCT MATCH_ID\n" +
            "FROM MATCH M1\n";
    }
    StringBuilder matchSb= new StringBuilder(matchSearch);
    if(date!=null&&!date.equals("")) {
        matchSb.append("WHERE M1.DATE_TIME = '" + date+"\'");
    }
    matchSb.append(") order by M.date_time desc");

    pst = conn.prepareStatement(matchSb.toString());
    rs = pst.executeQuery();
    while(rs.next()){
        %>
<p>

    <%
        if(rs.getString(7) ==null || rs.getString(7).equals("null")){
    %>
    <form action ="proc/matchAppManaProc.jsp" method ="post">
    날짜: <%=rs.getDate(2)%>
    경기 번호: <%=rs.getString(1)%>
    구장 이름: <%=rs.getString(10)%>
    주소: <%=rs.getString(11)%>
    종목: <%=rs.getString(4)%>
    임금: <%=rs.getString(8)%>
    <input type = "hidden" name = "matchId" value = "<%=rs.getString(1)%>">
    <input type = "hidden" name = "userId" value = "<%=(String) session.getAttribute(SessionConst.USER)%>">
    <input type ="submit" value ="신청하기">
    </form>
    <%
        }
        else {
    %>
    날짜: <%=rs.getDate(2)%>
    경기 번호: <%=rs.getString(1)%>
    구장 이름: <%=rs.getString(10)%>
    주소: <%=rs.getString(11)%>
    종목: <%=rs.getString(4)%>
    임금: <%=rs.getString(8)%>
    <span>신청불가</span>
    <%
        }
    %>

</p>
<%
    }
%>


<script>
    function matchReload(){
    const date = document.querySelector("#date").value;
    window.location.href ="matchAppMana.jsp?date="+date
    }

    function myMatch(){
    window.location.href ="matchAppMana.jsp?myMatchFind="+true
    }
</script>

</body>
</html>
