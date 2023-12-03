<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ page import="java.util.Random" %>
<%@ include file="../common/dbconn.jsp" %>

<%
    // "C"로 시작하는 랜덤한 CLASS_ID 생성 메서드
    String generateRandomClassId() {
    Random random = new Random();
    return "C" + (100 + random.nextInt(900)) + "-" + (10 + random.nextInt(90)) + "-" + (1000 + random.nextInt(9000));
}

    String userId = (String) session.getAttribute(SessionConst.USER);

    // 사용자로부터 입력 받은 트레이닝 정보를 가져옵니다.
    String classId = generateRandomClassId(); // "C"로 시작하는 랜덤한 CLASS_ID 생성
    String date = request.getParameter("date");
    String trainer = request.getParameter("trainer");
    String category = request.getParameter("category");
    String description = request.getParameter("description");
    String location = request.getParameter("location");
    int maxParticipants = Integer.parseInt(request.getParameter("maxParticipants"));
    double cost = Double.parseDouble(request.getParameter("cost"));

    // 트레이닝 정보를 데이터베이스에 추가
    String insertTrainingQuery = SQLx.Insertx("TRAINING", new String[]{classId, date, userId, category, description, location, String.valueOf(maxParticipants), String.valueOf(cost), trainer});
    PreparedStatement insertTrainingPstmt = conn.prepareStatement(insertTrainingQuery);
    insertTrainingPstmt.executeUpdate();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>트레이닝 만들기</title>
</head>
<body>
<h1>트레이닝 만들기 완료</h1>
<p>트레이닝 정보가 성공적으로 생성되었습니다.</p>
<a href="training.jsp">트레이닝 페이지로 돌아가기</a>
</body>
</html>
