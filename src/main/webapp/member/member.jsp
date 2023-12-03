<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="../common/dbconn.jsp" %>
<%@ page import="classes.SessionConst" %>

<html>
<head>
    <title>마이 페이지</title>
</head>
<body>
<!-- 기존 버튼들 -->
<a href="../index.jsp">Soccer Link</a>
<a href="match.jsp">Match</a>
<a href="training.jsp">Training</a>
<a href="team.jsp">Team</a>
<a href="cashCharge.jsp">Cashcharge</a>
<a href="changeInfo.jsp">Changeinfo</a>
<input type="button" onclick="secession()" value="Secession">

<!-- 사용자 정보 및 충전 금액 표시 -->
<%
    String userId = (String) session.getAttribute(SessionConst.USER);
    if (userId != null) {
        String query = "SELECT NAME, SEX, YOB, JOB, PREPAID_MONEY FROM USERS JOIN MEMBER ON USERS.ID_NUMBER = MEMBER.ID_NUMBER WHERE USERS.ID_NUMBER = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, userId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String name = rs.getString("NAME");
            String sex = rs.getString("SEX");
            String yob = rs.getString("YOB");
            String job = rs.getString("JOB");
            int prepaidMoney = rs.getInt("PREPAID_MONEY");
%>
<h2>내 정보</h2>
<p>이름: <%= name %></p>
<p>성별: <%= sex %></p>
<p>생년월일: <%= yob %></p>
<p>직업: <%= job %></p>
<p>충전된 금액: <%= prepaidMoney %>원</p>
<%
        }
        rs.close();
        pstmt.close();
    }
%>

<script>
    function secession(){
        const askTwice = prompt("정말로 탈퇴를 원하시면 '탈퇴'를 입력하십시오.");
        if(askTwice === '탈퇴'){
            window.location.href = "../common/secessionProc.jsp";
        } else {
            alert("잘못 입력했습니다.");
        }
    }
</script>
</body>
</html>
