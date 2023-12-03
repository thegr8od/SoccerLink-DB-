<%@ page import="java.sql.*" %>
<%@ page import="classes.SQLx" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/dbconn.jsp" %>

<html>
<head>
    <title>Cash Charge</title>
</head>
<body>
<%
    String memberId = (String) session.getAttribute("USER");
    String amountStr = request.getParameter("amount");
    if (memberId != null && amountStr != null && !amountStr.trim().isEmpty()) {
        int amount = Integer.parseInt(amountStr);

        // 이미 선언된 pst와 rs를 사용하여 쿼리 실행
        try {
            String query = "SELECT PREPAID_MONEY FROM MEMBER WHERE ID_NUMBER = ?";
            pst = conn.prepareStatement(query);
            pst.setString(1, memberId);
            rs = pst.executeQuery();

            if (rs.next()) {
                int currentAmount = rs.getInt(1);
                int newAmount = currentAmount + amount;

                String updateQuery = "UPDATE MEMBER SET PREPAID_MONEY = ? WHERE ID_NUMBER = ?";
                pst = conn.prepareStatement(updateQuery);
                pst.setInt(1, newAmount);
                pst.setString(2, memberId);
                int updated = pst.executeUpdate();

                if (updated > 0) {
                    out.println("충전이 완료되었습니다. 현재 잔액: " + newAmount + "원");
                }
            }
        } catch (Exception e) {
            out.println("충전 처리 중 오류가 발생했습니다: " + e.getMessage());
        }
    } else {
        out.println("충전할 금액을 입력해주세요.");
    }
%>
<form action="cashCharge.jsp" method="post">
    <label for="amount">충전 금액:</label>
    <input type="text" id="amount" name="amount">
    <input type="submit" value="충전하기">
</form>
<a href="member.jsp">뒤로 가기</a>
</body>
</html>
