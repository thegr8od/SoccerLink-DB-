<%@ page import="java.util.Random" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="classes.SQLx" %>
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-01
  Time: 오후 10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
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

<%
    char apx = '\'';
    String ID;
    String pw = request.getParameter("pw");
    String name = request.getParameter("name");
    String sex = request.getParameter("sex");
    String year = request.getParameter("year");
    String job = request.getParameter("job");
    String role = request.getParameter("role");
    while(true) {
        Random rand = new Random(System.currentTimeMillis());
        StringBuilder sb = new StringBuilder();
        StringBuilder where = new StringBuilder();
        sb.append("U").append(Math.abs(rand.nextInt()%10)).append(Math.abs(rand.nextInt()%10)).append(Math.abs(rand.nextInt()%10));
        sb.append("-").append(Math.abs(rand.nextInt()%10)).append(Math.abs(rand.nextInt()%10));
        sb.append("-").append(Math.abs(rand.nextInt()%10)).append(Math.abs(rand.nextInt()%10)).append(Math.abs(rand.nextInt()%10)).append(Math.abs(rand.nextInt()%10));
        ID = sb.toString();
        where.append("ID_NUMBER = "+ apx + ID+ apx);
        int rows = 0;
        String sql = SQLx.Selectx("ID_NUMBER",  "USERS", where.toString(), "");
        pst = conn.prepareStatement(sql);
        rs = pst.executeQuery();
        rs.last();
        rows = rs.getRow();
        sb.setLength(0);
        if(rows==0) break;
    }
    String[] data = {ID,name,sex,year,job,pw};
    String sql2 = SQLx.Insertx("USERS",data);
%>

</body>
</html>
