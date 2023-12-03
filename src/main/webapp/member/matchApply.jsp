<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %>

<%
    // 현재 세션에서 사용자 ID 가져오기
    String userId = (String) session.getAttribute(SessionConst.USER);
    // 매치 ID 가져오기
    String matchId = request.getParameter("matchId");

    // 매치 신청 여부를 검사하고 이미 신청한 경우 처리
    String checkMatchApplicationQuery = SQLx.Selectx("MEMBER_ID", "MATCH_APP_MEMBER", "MATCH_ID = '" + matchId + "' AND MEMBER_ID = '" + userId + "'", "");
    PreparedStatement checkPstmt = conn.prepareStatement(checkMatchApplicationQuery);
    ResultSet checkRs = checkPstmt.executeQuery();

    if (checkRs.next()) {
        // 이미 매치에 신청한 경우 처리
%><script type="text/javascript">
    alert('이미 매치에 신청하셨습니다.');
    window.location.href = 'match.jsp';
</script><%
} else {
    // 선수의 잔액 조회
    String getPrepaidMoneyQuery = SQLx.Selectx("PREPAID_MONEY", "MEMBER", "ID_NUMBER = '" + userId + "'", "");
    PreparedStatement getMoneyPstmt = conn.prepareStatement(getPrepaidMoneyQuery);
    ResultSet moneyRs = getMoneyPstmt.executeQuery();
    double prepaidMoney = 0.0;

    if (moneyRs.next()) {
        prepaidMoney = moneyRs.getDouble("PREPAID_MONEY");
    }

    // 매치 비용 조회
    String getMatchCostQuery = SQLx.Selectx("COST_PER_ONE", "MATCH", "MATCH_ID = '" + matchId + "'", "");
    PreparedStatement getCostPstmt = conn.prepareStatement(getMatchCostQuery);
    ResultSet costRs = getCostPstmt.executeQuery();
    double matchCost = 0.0;

    if (costRs.next()) {
        matchCost = costRs.getDouble("COST_PER_ONE");
    }

    // 잔액과 비용 비교
    if (prepaidMoney < matchCost) {
        // 잔액 부족한 경우
%><script type="text/javascript">
    alert('잔액이 부족합니다.');
    window.location.href = 'match.jsp';
</script><%
} else {
    // 매치 비용 차감
    double newPrepaidMoney = prepaidMoney - matchCost;
    String updatePrepaidMoneyQuery = SQLx.Updatex("MEMBER", "PREPAID_MONEY", String.valueOf(newPrepaidMoney), new String[]{userId});
    PreparedStatement updateMoneyPstmt = conn.prepareStatement(updatePrepaidMoneyQuery);
    int moneyUpdateResult = updateMoneyPstmt.executeUpdate();

    if (moneyUpdateResult > 0) {
        // 매치 신청을 데이터베이스에 저장
        String insertMatchApplicationQuery = SQLx.Insertx("MATCH_APP_MEMBER", new String[]{matchId, userId});
        PreparedStatement insertPstmt = conn.prepareStatement(insertMatchApplicationQuery);
        int rowsAffected = insertPstmt.executeUpdate();

        if (rowsAffected > 0) {
            // 매치 신청 성공
%><script type="text/javascript">
    alert('매치 신청이 완료되었습니다.');
    window.location.href = 'member.jsp';
</script><%
} else {
    // 매치 신청 실패
%><script type="text/javascript">
    alert('매치 신청 중 오류가 발생했습니다.');
    window.location.href = 'match.jsp';
</script><%
    }
} else {
    // 잔액 차감 실패
%><script type="text/javascript">
    alert('잔액 차감 중 오류가 발생했습니다.');
    window.location.href = 'match.jsp';
</script><%
            }
        }
    }
%>
