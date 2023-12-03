<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %>
<%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-03
  Time: 오전 3:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<jsp:include page="backgroundCategory.jsp"/>
<%
    String userId = (String) session.getAttribute(SessionConst.USER);
    String memberSearchSql = "select m.DATE_TIME,m.MATCH_ID, a.MEMBER_ID, u.NAME\n" +
            "from match m inner join MATCH_APP_MEMBER a on m.MATCH_ID = a.MATCH_ID\n" +
            "inner join users u on a.MEMBER_ID=u.ID_NUMBER\n" +
            "where m.MANAGER_ID = '"+userId+"\'";
    pst = conn.prepareStatement(memberSearchSql);
    rs = pst.executeQuery();
    while(rs.next()){
%>
<form action ="proc/memberEvalProc.jsp" method = 'post'>
    날짜: <%=rs.getDate(1)%>
    경기번호: <%=rs.getString(2)%>
    플레이어 ID: <%=rs.getString(3)%>
    플레이어 이름: <%=rs.getString(4)%>
    <select name="tier" required>
        <option value="A">A</option>
        <option value="B">B</option>
        <option value="C">C</option>
        <option value="D">D</option>
    </select>
    <input type ="hidden" name="memberId" value ="<%=rs.getString(3)%>">
    <input type="submit" value="평가하기">
</form>
<%
    }
%>
</body>
</html>
