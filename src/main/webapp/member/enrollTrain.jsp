<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %>

<html>
<head>
    <title>트레이닝 신청 처리</title>
</head>
<body>
<%
    String userId = (String) session.getAttribute(SessionConst.USER);
    String classId = request.getParameter("classId");

    if (userId != null && classId != null) {
        // 트레이닝 비용 조회
        String costQuery = SQLx.Selectx("COST_PER_ONE", "TRAINING", "CLASS_ID = '" + classId + "'", "");
        PreparedStatement costPstmt = conn.prepareStatement(costQuery);
        ResultSet costRs = costPstmt.executeQuery();
        double costPerOne = 0;

        if (costRs.next()) {
            costPerOne = costRs.getDouble("COST_PER_ONE");
        }

        // 사용자 잔액 차감
        String updateMoneyQuery = "UPDATE MEMBER SET PREPAID_MONEY = PREPAID_MONEY - ? WHERE ID_NUMBER = ?";
        PreparedStatement updateMoneyPstmt = conn.prepareStatement(updateMoneyQuery);
        updateMoneyPstmt.setDouble(1, costPerOne);
        updateMoneyPstmt.setString(2, userId);
        int moneyUpdateResult = updateMoneyPstmt.executeUpdate();

        if (moneyUpdateResult > 0) {
            // TRAIN_ENROLLS에 신청 데이터 추가
            String enrollQuery = SQLx.Insertx("TRAIN_ENROLLS", new String[]{classId, userId});
            PreparedStatement enrollPstmt = conn.prepareStatement(enrollQuery);
            int enrollResult = enrollPstmt.executeUpdate();

            if (enrollResult > 0) {
                out.println("<p>트레이닝 신청이 완료되었습니다.</p>");
            } else {
                out.println("<p>트레이닝 신청에 실패했습니다.</p>");
            }
        } else {
            out.println("<p>잔액이 부족합니다.</p>");
        }
    }
%>
<a href="training.jsp">뒤로 가기</a>
</body>
</html>