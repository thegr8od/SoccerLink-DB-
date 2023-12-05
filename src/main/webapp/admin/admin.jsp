<%@ page import="classes.SQLx" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/dbconn.jsp" %>
<%@ include file="proc/loginCtrl.jsp"%>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <title>Admin page</title>
    <%
        String sqlIncome = SQLx.Selectx("SUM(PREPAID_MONEY)", "MEMBER");
        String sqlOutMatch = SQLx.Selectx("SUM(WAGE)", "MATCH");
        String sqlOutTrain = SQLx.Selectx("SUM(WAGE)", "TRAINING");
        pst = conn.prepareStatement(sqlIncome);
        rs = pst.executeQuery();
        rs.next();
        Integer totalDeposit = rs.getInt(1);//총 예치금
        pst = conn.prepareStatement(sqlOutMatch);
        rs = pst.executeQuery();
        rs.next();
        Integer socialMatchPaymentExpectedAmount = rs.getInt(1);//소셜매치 지불예정금액
        pst = conn.prepareStatement(sqlOutTrain);
        rs = pst.executeQuery();
        rs.next();
        Integer expectedTrainingPaymentAmount = rs.getInt(1);//트레이닝 지불예정금액
    %>
</head>
<body>
<jsp:include page="menu.jsp"/>
<br>
<br>
</body>
</html>