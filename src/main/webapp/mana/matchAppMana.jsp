<%@ page import="classes.dto.MatchDto" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %>
<%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-03
  Time: 오전 3:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Match Apply</title>
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

<h3>매치 매니저 신청</h3>
<div class = "ms-3">
    <div class="d-flex align-items-center justify-content-start">
                <div class="mw-3 d-flex align-items-center" >
                    <label for="date" class="form-label me-2">날짜</label>
                    <input type="date" name="date" id="date">
                </div>
                <input type ="button" class ="ms-3 btn btn-primary"  onclick ="matchReload()" value="검색">
                <input type="button" class="ms-3 btn btn-primary" onclick ="myMatch()" value="나의 매치">
    </div>
</div>
    <hr>
<table class="table">
    <tr>
        <th>매치 ID</th>
        <th>날짜</th>
        <th>구장이름</th>
        <th>주소</th>
        <th>종목</th>
        <th>임금</th>
        <th>신청</th>
    </tr>
<%
    String myMatchFind = request.getParameter("myMatchFind");
    boolean myMatchFindBoolean = Boolean.parseBoolean(myMatchFind);
    String date = request.getParameter("date");
    String matchSearch = "";
    if(myMatchFindBoolean){
        matchSearch ="SELECT M.*, F.NAME,F.ADDRESS FROM MATCH M \n" +
                "INNER JOIN FIELD F ON M.PLACE_ID = F.FIELD_ID\n" +
                "WHERE M.manager_id = '"+(String)session.getAttribute(SessionConst.USER)+"'AND\n" +
                "M.MATCH_ID IN (SELECT DISTINCT MATCH_ID\n" +
                "FROM MATCH M1\n";
        StringBuilder matchSb= new StringBuilder(matchSearch);
        if(date!=null&&!date.equals("")) {
            matchSb.append("WHERE M1.DATE_TIME = '" + date+"\'");
        }
        matchSb.append(") order by M.date_time desc");

        pst = conn.prepareStatement(matchSb.toString());
        rs = pst.executeQuery();
        while(rs.next()){
//            if(rs.getString(7) ==null || rs.getString(7).equals("null")){
%>
    <tr>
        <td><%= rs.getString((1)) %></td>
        <td><%= rs.getDate(2) %></td>
        <td><%= rs.getString(10) %></td>
        <td><%= rs.getString(11) %></td>
        <td><%= rs.getString(4) %></td>
        <td><%= rs.getInt(8) %>원</td>
        <td>
            <form action="proc/matchDeleteManaProc.jsp" method="post">
                <input type="hidden" name="matchId" value="<%= rs.getString(1) %>">
                <button type="submit" class="btn btn-sm btn-primary">신청취소</button>
            </form>
        </td>
    </tr>
    <%
//            }
    }
}
    else {
        matchSearch = "SELECT M.*, F.NAME,F.ADDRESS FROM MATCH M \n" +
            "INNER JOIN FIELD F ON M.PLACE_ID = F.FIELD_ID\n" +
            "WHERE M.MATCH_ID IN\n" +
            "(SELECT DISTINCT MATCH_ID\n" +
            "FROM MATCH M1\n";
    StringBuilder matchSb= new StringBuilder(matchSearch);
    if(date!=null&&!date.equals("")) {
        matchSb.append("WHERE M1.DATE_TIME = '" + date+"\'");
    }
    matchSb.append(") order by M.date_time desc");

    pst = conn.prepareStatement(matchSb.toString());
    rs = pst.executeQuery();
    while(rs.next()){
        if(rs.getString(7) ==null || rs.getString(7).equals("null")){
        %>
    <tr>
        <td><%= rs.getString((1)) %></td>
        <td><%= rs.getDate(2) %></td>
        <td><%= rs.getString(10) %></td>
        <td><%= rs.getString(11) %></td>
        <td><%= rs.getString(4) %></td>
        <td><%= rs.getInt(8) %>원</td>
        <td>
            <form action="proc/matchAppManaProc.jsp" method="post">
                <input type="hidden" name="matchId" value="<%= rs.getString(1) %>">
                <input type = "hidden" name = "userId" value = "<%=(String) session.getAttribute(SessionConst.USER)%>">
                <button type="submit" class="btn btn-sm btn-primary">신청하기</button>
            </form>
        </td>
    </tr>
    <%
        }
        else {
    %>
    <tr>
        <td><%= rs.getString((1)) %></td>
        <td><%= rs.getDate(2) %></td>
        <td><%= rs.getString(10) %></td>
        <td><%= rs.getString(11) %></td>
        <td><%= rs.getString(4) %></td>
        <td><%= rs.getInt(8) %>원</td>
        <td>
            <span>신청불가</span>
        </td>
    </tr>
    <%
        }
    }
}
%>
</table>

<script>
    function matchReload(){
    const date = document.querySelector("#date").value;
    window.location.href ="matchAppMana.jsp?date="+date
    }

    function myMatch(){
    window.location.href ="matchAppMana.jsp?myMatchFind="+true
    }
</script>

</body>
</html>
