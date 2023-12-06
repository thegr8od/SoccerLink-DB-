<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %>
<%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-03
  Time: 오전 3:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Member Evaluation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" >
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #fff;
            color: #333;
        }

        .container {
            margin-top: 20px;
        }

        .card {
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
            margin-top: 20px;
            transition: transform 0.3s ease-in-out;
        }

        .btn {
            background-color: #fff;
            color: #333;
            border: 1px solid #333;
            padding: 10px 20px;
            margin: 5px;
            border-radius: 5px;
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }

        .btn:hover, .btn:focus {
            background-color: #ccc;
            color: #333;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th, .table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        .table th {
            background-color: #f2f2f2;
        }

        .apply-btn {
            display: inline-block;
            padding: 10px 20px;
            border: 1px solid #333;
            border-radius: 5px;
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }

        .apply-btn:hover, .apply-btn:focus {
            background-color: #ccc;
            color: #333;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
<jsp:include page="backgroundImage.jsp"/>
<h3>플레이어 평가</h3>
<table class="table">
    <tr>
        <th>매치 ID</th>
        <th>날짜</th>
        <th>플레이어 ID</th>
        <th>플레이어 이름</th>
        <th>현재 티어</th>
        <th>티어</th>
        <th>신청</th>
    </tr>

<%
    String userId = (String) session.getAttribute(SessionConst.USER);
    String memberSearchSql = "select m.DATE_TIME,m.MATCH_ID, a.MEMBER_ID, u.NAME, ev.TIER\n" +
            "from match m inner join MATCH_APP_MEMBER a on m.MATCH_ID = a.MATCH_ID\n" +
            "inner join users u on a.MEMBER_ID=u.ID_NUMBER\n" +
            "inner join MEMBER_EVAL_VIEW  ev on ev.MEM_ID = u.ID_NUMBER " +
            "where m.MANAGER_ID = '"+userId+"\'";
    pst = conn.prepareStatement(memberSearchSql);
    rs = pst.executeQuery();
    while(rs.next()){
%>
    <tr>
            <form action="proc/memberEvalProc.jsp" method="post">
            <td><%=rs.getString(2)%></td>
            <td><%=rs.getDate(1)%></td>
            <td><%=rs.getString(3)%></td>
            <td><%=rs.getString(4)%></td>
            <td><%=rs.getString(5)%></td>
            <td>
                <select name="tier" required>
                    <option value="A">A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                </select>
            </td>
            <td>
                <input type ="hidden" name="memberId" value ="<%=rs.getString(3)%>">
                <input type="submit" value="평가하기">
            </form>
        </td>
    </tr>
<tabel/>
<%
    }
%>
</body>
</html>
