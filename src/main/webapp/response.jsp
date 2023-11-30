<%--
  Created by IntelliJ IDEA.
  User: dongh
  Date: 2023-11-15
  Time: ���� 11:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=EUC-KR" language="java" pageEncoding="EUC-KR" %>
<%@ page language ="java" import="classes.SQLx, java.text.*, java.sql.*" %>
<html>
<head>
    <meta charset="EUC-KR">
    <title>Introduction to DB</title>
</head>
<body>
<%
    String[] server = new String[5]; // ip, sid, port, user, pass
    server[0] = "localhost";
    server[1] = "orcl";
    server[2] = "1521";
    server[3] = "UNIVERSITY";
    server[4] = "comp322";
    String url = "jdbc:oracle:thin:@"+server[0]+":"+server[2]+":"+server[1];
    Connection conn = null;
    PreparedStatement pst;
    ResultSet rs;
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection(url,server[3],server[4]);
%>
<h2> Lab #9: Repeating Lab #5-3 via JSP</h2>
<h3>------ Q1 Result ------</h3>
<%
    out.println("<table border=\"1\">");
    String[] x1 = new String[3];
    x1[0] = request.getParameter("pname1");
    x1[1] = request.getParameter("dnum1");
    x1[2] = request.getParameter("sal1");

    StringBuilder where = new StringBuilder();
    where.append("EMPLOYEE.DNO= "+x1[1]);
    where.append(" AND EMPLOYEE.SALARY >= "+x1[2]);
    where.append(" AND EMPLOYEE.SSN IN (SELECT ESSN FROM WORKS_ON WHERE WORKS_ON.PNO = "+x1[0]+")");
    String sql = SQLx.Selectx("FNAME, LNAME, SALARY", "EMPLOYEE", where.toString(), "");
    pst = conn.prepareStatement(sql);
    rs = pst.executeQuery();
    ResultSetMetaData rsmd = rs.getMetaData();
    int cnt = rsmd.getColumnCount();
    for (int i=1; i<=cnt; i++) out.println("<th>"+rsmd.getColumnName(i)+"</th>");
    while (rs.next()){
        out.println("<tr>");
        out.println("<td>"+rs.getString(1)+"</td>");
        out.println("<td>"+rs.getString(2)+"</td>");
        out.println("<td>"+rs.getFloat(3)+"</td>");
        out.println("</tr>");
    }
    out.println("</table>");
%>
<%
    rs.close();
    pst.close();
    conn.close();
%>
</body>
</html>
