<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-02
  Time: 오전 12:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String[] server = new String[5]; // ip, sid, port, user, pass
    server[0] = "localhost";
    server[1] = "orcl";
    server[2] = "1521";
    server[3] = "university";
    server[4] = "comp322";
    String url = "jdbc:oracle:thin:@"+server[0]+":"+server[2]+":"+server[1];
    Connection conn = null;
    PreparedStatement pst;
    ResultSet rs;
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection(url,server[3],server[4]);
%>