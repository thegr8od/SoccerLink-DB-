<%--
  Created by IntelliJ IDEA.
  User: dongh
  Date: 2023-12-02
  Time: 오후 4:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="classes.SQLx, java.lang.Integer" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/dbconn.jsp" %>
<html>
<head>
    <title>Admin page - Check information</title>
</head>
<body>
<a href="checkInfo.jsp">Back</a><br>
<form action="checkInfo.jsp" method="get"></form>
<%
    String num = request.getParameter("checker");
    String sql;
    int cnt;
    ResultSetMetaData rsmd;
    if(num == null) return;
    switch (Integer.parseInt(num)){
        case 1:
            sql = SQLx.Selectx("*","FIELD");
            out.println("현재 계약되어 있는 필드들은 아래와 같습니다.");
            pst = conn.prepareStatement(sql);
            rs = pst.executeQuery();
            rsmd = rs.getMetaData();
            cnt = rsmd.getColumnCount();
            out.println("<table border=\"1\">");
            for(int i=1; i<=cnt; i++)
                out.println("<th>"+rsmd.getColumnName(i)+"</th>");
            while (rs.next()) {
                out.println("<tr>");
                for(int i=1; i<=cnt; i++)
                    out.println("<td>"+rs.getString(i)+"</td>");
                out.println("</tr>");
            }
            out.println("</table>");
            break;
        case 2 :
            sql = SQLx.Selectx("*","MATCH NATURAL JOIN MATCH_EVAL_VIEW NATURAL JOIN " +
                            "(SELECT MATCH_ID, COUNT(MEMBER_ID) FROM MATCH_APP_MEMBER GROUP BY MATCH_ID)",
                    "ORDER BY DATE_TIME DESC");
            out.println("현재 등록된 소셜매치는 아래와 같습니다.");
            pst = conn.prepareStatement(sql);
            rs = pst.executeQuery();
            rsmd = rs.getMetaData();
            cnt = rsmd.getColumnCount();
            out.println("<table border=\"1\">");
            for(int i=1; i<=cnt; i++)
                out.println("<th>"+rsmd.getColumnName(i)+"</th>");
            while (rs.next()) {
                out.println("<tr>");
                for(int i=1; i<=cnt; i++){
                    if(i==8 || i==9 || i==11 || i == 12|| i==5) out.println("<td>"+rs.getInt(i)+"</td>");
                    else if(i==2) out.println("<td>"+rs.getDate(i).toString()+"</td>");
                    else out.println("<td>"+rs.getString(i)+"</td>");
                }
                out.println("</tr>");
            }
            out.println("</table>");
            break;
        case 3:
            sql = SQLx.Selectx("*","TRAINING NATURAL JOIN " +
                            "(SELECT CLASS_ID, COUNT(TUTEE_ID) FROM TRAIN_ENROLLS GROUP BY CLASS_ID)",
                    "ORDER BY DATE_TIME DESC");
            out.println("현재 등록된 트레이닝은 아래와 같습니다.");
            pst = conn.prepareStatement(sql);
            rs = pst.executeQuery();
            rsmd = rs.getMetaData();
            cnt = rsmd.getColumnCount();
            out.println("<table border=\"1\">");
            for(int i=1; i<=cnt; i++)
                out.println("<th>"+rsmd.getColumnName(i)+"</th>");
            while (rs.next()) {
                out.println("<tr>");
                for(int i=1; i<=cnt; i++){
                    if(i==2) out.println("<td>"+rs.getDate(i).toString()+"</td>");
                    else if(i>=7) out.println("<td>"+rs.getInt(i)+"</td>");
                    else out.println("<td>"+rs.getString(i)+"</td>");
                }
                out.println("</tr>");
            }
            out.println("</table>");
            break;
    }
%>

</body>
</html>
