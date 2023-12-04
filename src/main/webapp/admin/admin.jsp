<%@ page import="classes.SQLx" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/dbconn.jsp" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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

<%--<div style="display:flex;justify-content: center;width: 100%;gap: 100px">--%>
<%--    <input type="button" value="User" name="1" onclick="location.href='userMod.jsp'" style="font-size: 25pt; font-family: Arial serif; background-color: white; border-radius: 8px; border-color: grey"/>--%>
<%--    <input type="button" value="Team" name="2" onclick="location.href='teamMod.jsp'" style="font-size: 25pt; font-family: Arial serif; background-color: white; border-radius: 8px; border-color: grey"/>--%>
<%--    <input type="button" value="Owner" name="3" onclick="location.href='ownerMod.jsp'" style="font-size: 25pt; font-family: Arial serif; background-color: white; border-radius: 8px; border-color:grey"/>--%>
<%--    <input type="button" value="Field" name="4" onclick="location.href='fieldMod.jsp'" style="font-size: 25pt; font-family: Arial serif; background-color: white; border-radius: 8px; border-color: grey"/>--%>
<%--    <input type="button" value="Match" name="5" onclick="location.href='matchMod.jsp'" style="font-size: 25pt; font-family: Arial serif; background-color: white; border-radius: 8px; border-color: grey"/>--%>
<%--    <input type="button" value="Training" name="6" onclick="location.href='trainMod.jsp'" style="font-size: 25pt; font-family: Arial serif; background-color: white; border-radius: 8px; border-color: grey"/>--%>
<%--    <input type="button" value="Check Information" onclick="location.href='checkInfo.jsp'" style="font-size: 25pt; font-family: Arial serif; background-color: white; border-radius: 8px; border-color: grey"/>--%>
<%--</div>--%>
<%--<br>--%>
<%--<div style="width: 80%; height: 1px; background-color: grey; margin: 0 auto"></div>--%>
<%--<br>--%>
<%--<div style="display:flex;justify-content: center; margin: 0 auto; font-family: Arial serif; font-size: 20pt; font-style: italic">--%>
<%--    <br>--%>
<%--    <br>--%>
<%--    안녕하세요, 관리자님<br><br>--%>
<%--    관리 모드로 로그인하셨습니다.<br><br>--%>
<%--    상단 메뉴를 통해 관리하고자 하는 테이블을 선택해주십시오.<br><br>--%>
<%--</div>--%>



</body>
</html>