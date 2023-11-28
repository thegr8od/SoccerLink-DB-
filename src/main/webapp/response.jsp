<%--
  Created by IntelliJ IDEA.
  User: dongh
  Date: 2023-11-15
  Time: ���� 11:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=EUC-KR" language="java" pageEncoding="EUC-KR" %>
<%@ page language="java" import="java.text.*,java.sql.*" %>
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
    String qry = "";
    StringBuilder sb1 = new StringBuilder();
    sb1.append("SELECT ");
    sb1.append("FNAME, LNAME, SALARY ");
    sb1.append("FROM EMPLOYEE ");
    sb1.append("WHERE ");
    sb1.append("EMPLOYEE.DNO= "+x1[1]);
    sb1.append(" AND EMPLOYEE.SALARY >= "+x1[2]);
    sb1.append(" AND EMPLOYEE.SSN IN (SELECT ESSN FROM WORKS_ON WHERE WORKS_ON.PNO = "+x1[0]+")");
    qry = sb1.toString();
    pst = conn.prepareStatement(qry);
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
<h3>------ Q2 Result ------</h3>
<%
    out.println("<table border=\"1\">");
    String[] x2 = new String[2];
    x2[0] = request.getParameter("sssn2");
    x2[1] = request.getParameter("addr2");
    StringBuilder sb2 = new StringBuilder();
    sb2.append("SELECT D.DNAME, E.SSN, E.FNAME, E.LNAME ");
    sb2.append("FROM EMPLOYEE E, DEPARTMENT D ");
    sb2.append("WHERE E.DNO = D.DNUMBER");
    sb2.append(" AND E.SUPER_SSN = \'"+ x2[0] + "\'");
    sb2.append(" AND E.ADDRESS LIKE \'%" + x2[1] + "%\'");

    qry = sb2.toString();
    pst = conn.prepareStatement(qry);
    rs = pst.executeQuery();
    rsmd = rs.getMetaData();
    cnt = rsmd.getColumnCount();
    for (int i=1; i<=cnt; i++) out.println("<th>"+rsmd.getColumnName(i)+"</th>");
    while (rs.next()){
        out.println("<tr>");
        out.println("<td>"+rs.getString(1)+"</td>");
        out.println("<td>"+rs.getString(2)+"</td>");
        out.println("<td>"+rs.getString(3)+"</td>");
        out.println("<td>"+rs.getString(4)+"</td>");
        out.println("</tr>");
    }
    out.println("</table>");
%>
<h3>------ Q3 Result ------</h3>
<%
    out.println("<table border=\"1\">");
    String[] x3 = new String[2];
    x3[0] = request.getParameter("pname3");
    x3[1] = request.getParameter("work3");
    StringBuilder sb3 = new StringBuilder();
    sb3.append("SELECT E.FNAME, E.LNAME, X.HOURS ");
    sb3.append("FROM EMPLOYEE E INNER JOIN ");
    sb3.append("(SELECT ESSN, HOURS FROM WORKS_ON WHERE PNO ="+x3[0]+" AND HOURS >="+x3[1]+")");
    sb3.append(" X ON E.SSN = X.ESSN ");
    sb3.append("ORDER BY X.HOURS");
    qry = sb3.toString();
    pst = conn.prepareStatement(qry);
    rs = pst.executeQuery();
    rsmd = rs.getMetaData();
    cnt = rsmd.getColumnCount();
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
<h3>------ Q4 Result ------</h3>
<%
    out.println("<table border=\"1\">");
    String[] x4 = new String[2];
    x4[0] = request.getParameter("pname4");
    x4[1] = request.getParameter("work4");
    StringBuilder sb4 = new StringBuilder();
    sb4.append("SELECT D.DNAME, E.FNAME, E.LNAME FROM EMPLOYEE E INNER JOIN DEPARTMENT D ON E.DNO = D.DNUMBER WHERE E.SSN IN (");
    sb4.append("SELECT DISTINCT W.ESSN FROM WORKS_ON W INNER JOIN ");
    sb4.append("(SELECT PNAME, PNUMBER FROM PROJECT WHERE PNAME LIKE \'"+x4[0]+"%\')");
    sb4.append(" X ON X.PNUMBER = W.PNO WHERE HOURS >= "+x4[1]+")");
    sb4.append(" ORDER BY LNAME");
    qry = sb4.toString();
    pst = conn.prepareStatement(qry);
    rs = pst.executeQuery();
    rsmd = rs.getMetaData();
    cnt = rsmd.getColumnCount();
    for (int i=1; i<=cnt; i++) out.println("<th>"+rsmd.getColumnName(i)+"</th>");
    while (rs.next()){
        out.println("<tr>");
        out.println("<td>"+rs.getString(1)+"</td>");
        out.println("<td>"+rs.getString(2)+"</td>");
        out.println("<td>"+rs.getString(3)+"</td>");
        out.println("</tr>");
    }
    out.println("</table>");
%>
<h3>------ Q5 Result ------</h3>
<%
    out.println("<table border=\"1\">");
    String x5 = request.getParameter("sssn5");
    StringBuilder sb5 = new StringBuilder();
    sb5.append("SELECT DNAME, LNAME, FNAME, DEPENDENT_NAME ");
    sb5.append("FROM EMPLOYEE E" +
            " INNER JOIN DEPARTMENT D ON D.DNUMBER = E.DNO" +
            " INNER JOIN DEPENDENT DP ON DP.ESSN = E.SSN");
    sb5.append(" WHERE E.SSN IN (" +
            "    SELECT SSN" +
            "    FROM EMPLOYEE" +
            "    WHERE SUPER_SSN = \'" +x5+"\'" +
            "    ) AND DP.RELATIONSHIP = \'" + "Spouse" +"\'");
    qry = sb5.toString();
    pst = conn.prepareStatement(qry);
    rs = pst.executeQuery();
    rsmd = rs.getMetaData();
    cnt = rsmd.getColumnCount();
    for (int i=1; i<=cnt; i++) out.println("<th>"+rsmd.getColumnName(i)+"</th>");
    while (rs.next()){
        out.println("<tr>");
        out.println("<td>"+rs.getString(1)+"</td>");
        out.println("<td>"+rs.getString(2)+"</td>");
        out.println("<td>"+rs.getString(3)+"</td>");
        out.println("<td>"+rs.getString(4)+"</td>");
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
