<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SessionConst" %>
<%@ page import="classes.SQLx" %>
<%@ include file="../common/dbconn.jsp" %>

<%
    String userId = (String) session.getAttribute(SessionConst.USER);
    String errorMessage = "";

    if (request.getParameter("updateInfo") != null) {
        String selectedField = request.getParameter("selectedField");
        String newValue = request.getParameter("newValue");

        try {
            String updateQuery = "";
            if (selectedField.equals("sex")) {
                if (newValue.equals("M") || newValue.equals("F")) {
                    updateQuery = SQLx.Updatex("USERS", "SEX", newValue, new String[]{userId});
                } else {
                    errorMessage = "올바른 성별 값을 입력하세요 (M 또는 F).";
                }
            } else if (selectedField.equals("yob")) {
                updateQuery = SQLx.Updatex("USERS", "YOB", newValue, new String[]{userId});
            } else if (selectedField.equals("job")) {
                updateQuery = SQLx.Updatex("USERS", "JOB", newValue, new String[]{userId});
            } else if (selectedField.equals("passwd")) {
                updateQuery = SQLx.Updatex("USERS", "PASSWD", newValue, new String[]{userId});
            } else {
                errorMessage = "올바른 필드를 선택하세요.";
            }

            if (!updateQuery.isEmpty()) {
                PreparedStatement pstmt = conn.prepareStatement(updateQuery);
                int updateCount = pstmt.executeUpdate();
                if (updateCount > 0) {
                    errorMessage = "사용자 정보가 업데이트되었습니다.";
                } else {
                    errorMessage = "업데이트할 데이터가 없습니다.";
                }
            }
        } catch (SQLException e) {
            errorMessage = "오류 발생: " + e.getMessage();
        }
    }
    // 사용자 정보 조회 SQL
    String selectQuery = SQLx.Selectx("NAME, SEX, YOB, JOB", "USERS", "ID_NUMBER='" + userId + "'", "");
    PreparedStatement selectPstmt = conn.prepareStatement(selectQuery);
    rs = selectPstmt.executeQuery();

    String name = "";
    String sex = "";
    String yob = "";
    String job = "";

    if (rs.next()) {
    name = rs.getString("NAME");
    sex = rs.getString("SEX");
    yob = rs.getString("YOB");
    job = rs.getString("JOB");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사용자 정보 수정</title>
</head>
<body>
<h1>사용자 정보 수정</h1>

<!-- 에러 메시지 출력 -->
<% if (!errorMessage.isEmpty()) { %>
<p style="color: red;"><%= errorMessage %></p>
<% } %>

<!-- 사용자 정보 입력 폼 -->
<form method="post">
    <label for="name">이름:</label>
    <input type="text" name="name" id="name" value="<%= name %>" disabled><br>

    <label for="selectedField">수정할 항목 선택:</label>
    <select name="selectedField" id="selectedField">
        <option value="sex">성별</option>
        <option value="yob">출생년도</option>
        <option value="job">직업</option>
        <option value="passwd">비밀번호</option>
    </select><br>

    <label for="newValue">새로운 값:</label>
    <input type="text" name="newValue" id="newValue" required><br>

    <input type="submit" name="updateInfo" value="정보 수정">
</form>

<!-- 뒤로 가기 버튼 -->
<a href="member.jsp">뒤로 가기</a>
</body>
</html>
