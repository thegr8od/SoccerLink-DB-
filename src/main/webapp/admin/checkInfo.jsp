<%@ include file="../common/dbconn.jsp" %>
<%@ page import="classes.SQLx" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="proc/loginCtrl.jsp"%>
<html>
<head>
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
<jsp:include page="menu.jsp"/>
<%
    String category = request.getParameter("category");
    LinkedList<LinkedList<String>> arr = new LinkedList<>();
    String sql;
    ResultSetMetaData rsmd = null;
    StringBuilder metadata = new StringBuilder();
    int cnt = 0;
    int rscnt = 0;
    if (category == null);
    else if(category.equals("Owner")){
        sql = SQLx.Selectx("*","FIELD");
        pst = conn.prepareStatement(sql);
        rs = pst.executeQuery();
        rsmd = rs.getMetaData();
        cnt = rsmd.getColumnCount();
        arr.add(new LinkedList<String>());
        for(int i=1; i<=cnt; i++)
            arr.get(0).add(rsmd.getColumnName(i));
        while (rs.next()) {
            arr.add(new LinkedList<String>());
            for(int i=1; i<=cnt; i++)
                arr.get(rscnt).add(rs.getString(i));
            rscnt++;
        }
    }
     else if (category.equals("Match")){
        sql = SQLx.Selectx("*","MATCH NATURAL JOIN MATCH_EVAL_VIEW NATURAL JOIN " +
                        "(SELECT MATCH_ID, COUNT(MEMBER_ID) FROM MATCH_APP_MEMBER GROUP BY MATCH_ID)",
                "ORDER BY DATE_TIME DESC");
        pst = conn.prepareStatement(sql);
        rs = pst.executeQuery();
        rsmd = rs.getMetaData();
        cnt = rsmd.getColumnCount();
        arr.add(new LinkedList<String>());
        for(int i=1; i<=cnt; i++)
            arr.get(0).add(rsmd.getColumnName(i));
        while (rs.next()) {
            arr.add(new LinkedList<String>());
            for(int i=1; i<=cnt; i++){
                if(i==8 || i==9 || i==11 || i == 12|| i==5) arr.get(rscnt).add(Integer.toString(rs.getInt(i)));
                else if(i==2) arr.get(rscnt).add(rs.getDate(i).toString());
                else arr.get(rscnt).add(rs.getString(i));
            }
            rscnt++;
        }
    }
    else if (category.equals("Training")){
        sql = SQLx.Selectx("*","TRAINING NATURAL JOIN " +
                        "(SELECT CLASS_ID, COUNT(TUTEE_ID) FROM TRAIN_ENROLLS GROUP BY CLASS_ID)",
                "ORDER BY DATE_TIME DESC");
        pst = conn.prepareStatement(sql);
        rs = pst.executeQuery();
        rsmd = rs.getMetaData();
        cnt = rsmd.getColumnCount();
        arr.add(new LinkedList<String>());
        for(int i=1; i<=cnt; i++)
            arr.get(0).add(rsmd.getColumnName(i));
        while (rs.next()) {
            arr.add(new LinkedList<String>());
            for(int i=1; i<=cnt; i++){
                if(i>=7) arr.get(rscnt).add(Integer.toString(rs.getInt(i)));
                else if(i==2) arr.get(rscnt).add(rs.getDate(i).toString());
                else arr.get(rscnt).add(rs.getString(i));
            }
            rscnt++;
        }
    }
%>
<br>
<table class="table">
    <%if(cnt == 5){%>
    <tr>
        <th>구장 ID</th>
        <th>구장명</th>
        <th>구장 전화번호</th>
        <th>소유주 전화번호</th>
        <th>주소</th>
    </tr>
    <%}
    if (cnt==10) {
        %>
    <tr>
        <th>강의 ID</th>
        <th>날짜</th>
        <th>강사 ID</th>
        <th>추천 티어</th>
        <th>강의 주제</th>
        <th>장소</th>
        <th>최대 인원</th>
        <th>수업 임금</th>
        <th>1인당 수강 요금</th>
        <th>학생 인원</th>
    </tr>
    <%
    }
    if (cnt==11) {
    %>
    <tr>
        <th>경기 ID</th>
        <th>날짜</th>
        <th>구장 ID</th>
        <th>경기 타입</th>
        <th>최대 인원</th>
        <th>성별 제한</th>
        <th>매치 매니저 ID</th>
        <th>매니저 임금</th>
        <th>1인당 참가비</th>
        <th>매치 티어</th>
        <th>현재 인원</th>
    </tr>
    <%
        }
    %>
<%for (int i=1; i<=rscnt; i++) {%>
    <%if(cnt == 5){%>
    <tr>
        <td><%= arr.get(i).get(0) %></td>
        <td><%= arr.get(i).get(1) %></td>
        <td><%= arr.get(i).get(2) %></td>
        <td><%= arr.get(i).get(3) %></td>
        <td><%= arr.get(i).get(4) %></td>
    </tr>
    <%}%>
    <%if(cnt == 11){%>
    <tr>
    <td><%= arr.get(i).get(0) %></td>
    <td><%= arr.get(i).get(1) %></td>
    <td><%= arr.get(i).get(2) %></td>
    <td><%= arr.get(i).get(3) %></td>
    <td><%= arr.get(i).get(4) %></td>
    <td><%= arr.get(i).get(5) %></td>
    <td><%= arr.get(i).get(6) %></td>
    <td><%= arr.get(i).get(7) %></td>
    <td><%= arr.get(i).get(8) %></td>
    <td><%= arr.get(i).get(9) %></td>
    <td><%= arr.get(i).get(10) %></td>
    </tr>
    <%}%>
    <%if(cnt == 10){%>
    <tr>
        <td><%= arr.get(i).get(0) %></td>
        <td><%= arr.get(i).get(1) %></td>
        <td><%= arr.get(i).get(2) %></td>
        <td><%= arr.get(i).get(3) %></td>
        <td><%= arr.get(i).get(4) %></td>
        <td><%= arr.get(i).get(5) %></td>
        <td><%= arr.get(i).get(6) %></td>
        <td><%= arr.get(i).get(7) %></td>
        <td><%= arr.get(i).get(8) %></td>
        <td><%= arr.get(i).get(9) %></td>
    </tr>
    <%}
    }
%>
</table>
</body>
</html>