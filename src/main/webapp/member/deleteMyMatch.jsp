<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %>

<html>
<head>
    <title>내 매치 취소</title>
</head>
<body>
<h1>내가 참가한 매치</h1>
<form method="post">
    <table border="1">
        <tr>
            <th>매치 ID</th>
            <th>선택</th>
        </tr>
        <%
            String userId = (String) session.getAttribute(SessionConst.USER);
            String selectedMatchId = request.getParameter("selectedMatchId");

            if (selectedMatchId != null && !selectedMatchId.isEmpty()) {
                // 매치 비용 조회
                String costQuery = SQLx.Selectx("COST_PER_ONE", "MATCH", "MATCH_ID = '" + selectedMatchId + "'", "");
                PreparedStatement costPstmt = conn.prepareStatement(costQuery);
                ResultSet costRs = costPstmt.executeQuery();
                double costPerOne = 0;

                if (costRs.next()) {
                    costPerOne = costRs.getDouble("COST_PER_ONE");
                }

                // MATCH_APP_MEMBER에서 선택된 매치 기록 삭제
                String deleteQuery = SQLx.Deletex("MATCH_APP_MEMBER", new String[]{selectedMatchId, userId});
                PreparedStatement deletePstmt = conn.prepareStatement(deleteQuery);
                int deleteResult = deletePstmt.executeUpdate();

                if (deleteResult > 0) {
                    // 사용자 잔액에 환불
                    String updateMoneyQuery = "UPDATE MEMBER SET PREPAID_MONEY = PREPAID_MONEY + ? WHERE ID_NUMBER = ?";
                    PreparedStatement updateMoneyPstmt = conn.prepareStatement(updateMoneyQuery);
                    updateMoneyPstmt.setDouble(1, costPerOne);
                    updateMoneyPstmt.setString(2, userId);
                    updateMoneyPstmt.executeUpdate();

                    out.println("<p>매치 취소 및 환불이 완료되었습니다.</p>");
                } else {
                    out.println("<p>매치 취소에 실패했습니다.</p>");
                }
            }

            // 현재 참여 중인 매치 목록 표시
            String query = SQLx.Selectx("MATCH_ID", "MATCH_APP_MEMBER", "MEMBER_ID = '" + userId + "'", "");
            PreparedStatement pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String matchId = rs.getString("MATCH_ID");
        %>
        <tr>
            <td><%= matchId %></td>
            <td><input type="radio" name="selectedMatchId" value="<%= matchId %>"></td>
        </tr>
        <%
            }
        %>
    </table>
    <input type="submit" value="매치 취소">
</form>
<a href="member.jsp">뒤로 가기</a>
</body>
</html>
