<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SQLx" %>
<%@ include file="../common/dbconn.jsp" %>
<%@ page import="java.util.UUID" %>

<html>
<head>
    <title>트레이닝 생성</title>
</head>
<body>
<h1>트레이닝 생성</h1>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // 폼 데이터 처리
        String dateTime = request.getParameter("dateTime");
        String subject = request.getParameter("subject");
        String recommendTier = request.getParameter("recommendTier");
        String place = request.getParameter("place");
        int maxNum = Integer.parseInt(request.getParameter("maxNum"));
        double wage = Double.parseDouble(request.getParameter("wage"));
        double costPerOne = Double.parseDouble(request.getParameter("costPerOne"));
        String tutorId = (String) session.getAttribute("USER");
        String classId = "C" + UUID.randomUUID().toString().substring(0, 8);

        // SQLx를 사용하여 INSERT 쿼리 생성
        String insertQuery = SQLx.Insertx("TRAINING", new String[]{classId, dateTime, tutorId, recommendTier, subject, place, String.valueOf(maxNum), String.valueOf(wage), String.valueOf(costPerOne)});
        PreparedStatement trainingPst = conn.prepareStatement(insertQuery);
        int result = trainingPst.executeUpdate();

        if (result > 0) {
            out.println("<p>트레이닝이 성공적으로 생성되었습니다. 클래스 ID: " + classId + "</p>");
        } else {
            out.println("<p>트레이닝 생성에 실패했습니다.</p>");
        }
    }
%>

<form action="makeTrain.jsp" method="post">
    <label for="dateTime">날짜 및 시간:</label>
    <input type="datetime-local" id="dateTime" name="dateTime" required><br><br>

    <label for="subject">주제:</label>
    <input type="text" id="subject" name="subject" required><br><br>

    <label for="recommendTier">추천 티어:</label>
    <input type="text" id="recommendTier" name="recommendTier" required><br><br>

    <label for="place">장소:</label>
    <input type="text" id="place" name="place" required><br><br>

    <label for="maxNum">최대 인원:</label>
    <input type="number" id="maxNum" name="maxNum" required><br><br>

    <label for="wage">강사 비용:</label>
    <input type="number" id="wage" name="wage" step="0.01" required><br><br>

    <label for="costPerOne">수강료(1인당):</label>
    <input type="number" id="costPerOne" name="costPerOne" step="0.01" required><br><br>

    <input type="submit" value="트레이닝 생성">
</form>

</body>
</html>
