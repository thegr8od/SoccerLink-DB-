<%@ include file="../common/dbconn.jsp" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%--

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
<%
    String currentJob = new String();
    String currentPw = new String();
    String currentAccount = new String();

    String userId = (String) session.getAttribute(SessionConst.USER);
    String manaInfoSql = "select u.job, u.passwd, m.BANK_ACCOUNT\n" +
            "from users u inner join manager m on u.ID_NUMBER = m.ID_NUMBER\n" +
            "where u.ID_NUMBER = '"+ userId +"'";
    pst = conn.prepareStatement(manaInfoSql);
    rs = pst.executeQuery();
    while(rs.next()){
        currentJob = rs.getString(1);
        currentPw = rs.getString(2);
        currentAccount = rs.getString(3);
    }
%>
<h3>매니저 정보 수정</h3>
<form action ="proc/changeManaInfoProc.jsp" method = "post">
    <label>직업: </label><input type = "text" name = "job" value ="<%=currentJob%>"></br>
    <label>비밀번호:</label><input type = "password" name = "pw" value ="<%=currentPw%>"></br>
    <label>계좌번호:</label><input type = "text" name = "account" value ="<%=currentAccount%>"></br>
    <input type="submit" value = "수정">
</form>

</body>
</html>
