<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %>

<html>
<head>
    <title>Cash Charge</title>
</head>
<body>
<%
    String userId = (String) session.getAttribute(SessionConst.USER);
    String amountStr = request.getParameter("amount");
    if (userId != null && amountStr != null && !amountStr.trim().isEmpty()) {
        int amount = Integer.parseInt(amountStr);

        String query = "SELECT PREPAID_MONEY FROM MEMBER WHERE ID_NUMBER = ?";
        pst = conn.prepareStatement(query);
        pst.setString(1, userId);
        rs = pst.executeQuery();

        if (rs.next()) {
            int currentAmount = rs.getInt(1);
            int newAmount = currentAmount + amount;

            String updateQuery = "UPDATE MEMBER SET PREPAID_MONEY = ? WHERE ID_NUMBER = ?";
            pst = conn.prepareStatement(updateQuery);
            pst.setInt(1, newAmount);
            pst.setString(2, userId);
            int updated = pst.executeUpdate();

            if (updated > 0) {
                out.println("<script type='text/javascript'>alert('충전이 완료되었습니다. 현재 잔액: " + newAmount + "원'); window.location.href = 'member.jsp';</script>");
            } else {
                out.println("<script type='text/javascript'>alert('충전 처리 중 오류가 발생했습니다.'); window.location.href = 'cashCharge.jsp';</script>");
            }
        }
    } else {
        out.println("<script type='text/javascript'>alert('충전할 금액을 입력해주세요.'); window.location.href = 'cashCharge.jsp';</script>");
    }
%>

<form action="changeInfo.jsp" method="post">
    <p>
        <label for="fieldToUpdate">변경할 정보 선택:</label>
        <select id="fieldToUpdate" name="fieldToUpdate" required>
            <option value="PASSWD">비밀번호</option>
            <option value="SEX">성별</option>
            <option value="YOB">생년월일</option>
            <option value="JOB">직업</option>
        </select>
    </p>
    <p>
        <label for="newValue">새로운 값:</label>
        <input type="text" id="newValue" name="newValue" required>
    </p>
    <p>
        <label for="confirmValue">새로운 값 확인:</label>
        <input type="text" id="confirmValue" name="confirmValue" required>
    </p>
    <p>
        <input type="submit" value="정보 변경하기">
    </p>
</form>
<a href="member.jsp">뒤로 가기</a>

</body>
</html>