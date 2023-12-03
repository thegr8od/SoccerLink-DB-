<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SQLx" %>
<%@ include file="../common/dbconn.jsp" %>

<html>
<head>
    <title>정보 변경</title>
</head>
<body>
<%
    String memberId = (String) session.getAttribute("USER");
    String fieldToUpdate = request.getParameter("fieldToUpdate");
    String newValue = request.getParameter("newValue");
    String confirmValue = request.getParameter("confirmValue");

    if (memberId != null && fieldToUpdate != null && !fieldToUpdate.trim().isEmpty() && newValue != null && confirmValue != null) {
        if (newValue.equals(confirmValue)) {
            try {
                String updateQuery = SQLx.Updatex("USERS", fieldToUpdate, newValue, new String[]{memberId});
                pst = conn.prepareStatement(updateQuery);
                int updated = pst.executeUpdate();

                if (updated > 0) {
                    out.println(fieldToUpdate + "이(가) 업데이트되었습니다.");
                } else {
                    out.println("정보 업데이트에 실패했습니다.");
                }
            } catch (Exception e) {
                out.println("정보 업데이트 중 오류가 발생했습니다: " + e.getMessage());
            }
        } else {
            out.println("입력한 값이 일치하지 않습니다. 다시 시도해주세요.");
        }
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
</body>
</html>
