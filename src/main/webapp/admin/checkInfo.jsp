<%@ include file="../common/dbconn.jsp" %>
<%@ page import="classes.SQLx" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin page - Check information</title>
    <a href="../index.jsp">Soccer Link</a>
    <a href="../common/logOutProc.jsp">Log Out</a>
</head>
<body>
<br>
<input type="button" value="User" name="1" onclick="location.href='userMod.jsp'"/>
<input type="button" value="Team" name="2" onclick="location.href='teamMod.jsp'"/>
<input type="button" value="Owner" name="3" onclick="location.href='ownerMod.jsp'"/>
<input type="button" value="Field" name="4" onclick="location.href='fieldMod.jsp'"/>
<input type="button" value="Match" name="5" onclick="location.href='matchMod.jsp'"/>
<input type="button" value="Training" name="6" onclick="location.href='trainMod.jsp'"/>
<input type="button" value="Check Information" onclick="location.href='checkInfo.jsp'"/>
<br> 조회할 것을 선택해 주세요.
<a href="admin.jsp">Back</a><br>
<input type ="button" onclick="searchField()" value="Owner & Field">
<input type ="button" onclick="searchMatch()" value="Match">
<input type ="button" onclick="searchTrain()" value="Training">
<br>
<%
    String category = request.getParameter("category");
    LinkedList<String> meta = new LinkedList<>();
    LinkedList<LinkedList<String>> arr = new LinkedList<>();
    String sql;
    ResultSetMetaData rsmd = null;
    StringBuilder metadata = new StringBuilder();
    int cnt = 0;
    int rscnt = 0;
    if (category == null);
    else if(category.equals("Owner & Field")){
        sql = SQLx.Selectx("*","FIELD");
        out.println("현재 계약되어 있는 필드들은 아래와 같습니다.");
        pst = conn.prepareStatement(sql);
        rs = pst.executeQuery();
        rsmd = rs.getMetaData();
        cnt = rsmd.getColumnCount();
        for(int i=1; i<=cnt; i++)
            meta.add(rsmd.getColumnName(i));
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
        out.println("현재 등록된 소셜매치는 아래와 같습니다.");
        pst = conn.prepareStatement(sql);
        rs = pst.executeQuery();
        rsmd = rs.getMetaData();
        cnt = rsmd.getColumnCount();
        for(int i=1; i<=cnt; i++)
            meta.add(rsmd.getColumnName(i));
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
        out.println("현재 등록된 트레이닝은 아래와 같습니다.");
        pst = conn.prepareStatement(sql);
        rs = pst.executeQuery();
        rsmd = rs.getMetaData();
        cnt = rsmd.getColumnCount();
        for(int i=1; i<=cnt; i++)
            meta.add(rsmd.getColumnName(i));
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
<%
    for(int i=0; i<cnt; i++) metadata.append(meta.get(i)).append("   ");
%>
<p>
    <%=metadata%>
</p>
<%
    for (int i=0; i<rscnt; i++) {
        StringBuilder data = new StringBuilder();
        for (int j = 0; j < cnt; j++) data.append(arr.get(i).get(j)).append("   ");
%>
<p>
    <%=data%>
</p>
<%}%>
<form id="searchForm">
</form>
<script>
    function searchField(){
        const searchForm = document.querySelector("#searchForm");
        var categoryInput = document.createElement('input');
        categoryInput.type = 'text';
        categoryInput.name = 'category';
        categoryInput.value = 'Owner & Field';
        searchForm.appendChild(categoryInput);
        searchForm.action = "checkInfo.jsp";
        searchForm.submit();
    }
    function searchMatch(){
        const searchForm = document.querySelector("#searchForm");
        var categoryInput = document.createElement('input');
        categoryInput.type = 'text';
        categoryInput.name = 'category';
        categoryInput.value = 'Match';
        searchForm.appendChild(categoryInput);
        searchForm.action = "checkInfo.jsp";
        searchForm.submit();
    }
    function searchTrain(){
        const searchForm = document.querySelector("#searchForm");
        var categoryInput = document.createElement('input');
        categoryInput.type = 'text';
        categoryInput.name = 'category';
        categoryInput.value = 'Training';
        searchForm.appendChild(categoryInput);
        searchForm.action = "checkInfo.jsp";
        searchForm.submit();
    }
</script>
</body>
</html>
