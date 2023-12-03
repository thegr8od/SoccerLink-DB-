<%@ include file="../common/dbconn.jsp" %>
<%@ page import="classes.SQLx" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin page - Check information</title>
    <a href="../index.jsp">Soccer Link</a>
    <a href="admin.jsp">Back</a>
    <a href="../common/logOutProc.jsp">Log Out</a>

</head>
<body>
<br>
<br>
<div style="display:flex;justify-content: center;width: 100%;gap: 100px">
<input type="button" value="User" name="1" onclick="location.href='userMod.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey"/>
<input type="button" value="Team" name="2" onclick="location.href='teamMod.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey"/>
<input type="button" value="Owner" name="3" onclick="location.href='ownerMod.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color:grey"/>
<input type="button" value="Field" name="4" onclick="location.href='fieldMod.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey"/>
<input type="button" value="Match" name="5" onclick="location.href='matchMod.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey"/>
<input type="button" value="Training" name="6" onclick="location.href='trainMod.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey"/>
<input type="button" value="Check Information" onclick="location.href='checkInfo.jsp'" style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px; border-color: grey"/>
</div>
<br>
<div style="width: 80%; height: 1px; background-color: grey; margin: 0 auto"></div>
<br>
<div style="display:flex;justify-content: center;width: 100%;gap: 80px">
    <div style="font-size: 25pt; font-family: Consolas serif; background-color: white; border-radius: 8px">
        오른쪽 버튼으로 조회할 것을 클릭해 주세요.</div>
<input type ="button" onclick="searchField()" value="Owner & Field" style="font-size: 20pt; font-family: Consolas serif; background-color: white; border-radius: 8px"/>
<input type ="button" onclick="searchMatch()" value="Match" style="font-size: 20pt; font-family: Consolas serif; background-color: white; border-radius: 8px"/>
<input type ="button" onclick="searchTrain()" value="Training" style="font-size: 20pt; font-family: Consolas serif; background-color: white; border-radius: 8px"/>
</div>
<%
    String category = request.getParameter("category");
    LinkedList<LinkedList<String>> arr = new LinkedList<>();
    String sql;
    ResultSetMetaData rsmd = null;
    StringBuilder metadata = new StringBuilder();
    int cnt = 0;
    int rscnt = 0;
    if (category == null);
    else if(category.equals("Owner & Field")){
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
<%for (int i=0; i<=rscnt; i++) {%>
<div style="display:flex;justify-content: center;width: 100%;gap: 20px">
    <%if(cnt == 5){%>
    <div style="float: left;width: 8%;">
        <%out.print(arr.get(i).get(0));%>
    </div>
    <div style="float: left;width: 16%;">
        <%out.print(arr.get(i).get(1));%>
    </div>
    <div style="float: left;width: 8%;">
        <%out.print(arr.get(i).get(2));%>
    </div>
    <div style="float: left;width: 8%;">
        <%out.print(arr.get(i).get(3));%>
    </div>
    <div style="float: left;width: 16%;">
        <%out.print(arr.get(i).get(4));%>
    </div>
    <%}%>
    <%if(cnt == 11){%>
    <div style="float: left;width: 8%;">
        <%out.print(arr.get(i).get(0));%>
    </div>
    <div style="float: left;width: 8%;">
        <%out.print(arr.get(i).get(1));%>
    </div>
    <div style="float: left;width: 8%;">
        <%out.print(arr.get(i).get(2));%>
    </div>
    <div style="float: left;width: 4%;">
        <%out.print(arr.get(i).get(3));%>
    </div>
    <div style="float: left;width: 4%;">
        <%out.print(arr.get(i).get(4));%>
    </div>
    <div style="float: left;width: 7%;">
        <%out.print(arr.get(i).get(5));%>
    </div>
    <div style="float: left;width: 8%;">
        <%out.print(arr.get(i).get(6));%>
    </div>
    <div style="float: left;width: 6%;">
        <%out.print(arr.get(i).get(7));%>
    </div>
    <div style="float: left;width: 6%;">
        <%out.print(arr.get(i).get(8));%>
    </div>
    <div style="float: left;width: 6%;">
        <%out.print(arr.get(i).get(9));%>
    </div>
    <div style="float: left;width: 6%;">
        <%out.print(arr.get(i).get(10));%>
    </div>
    <%}%>
    <%if(cnt == 10){%>
    <div style="float: left;width: 8%;">
        <%out.print(arr.get(i).get(0));%>
    </div>
    <div style="float: left;width: 8%;">
        <%out.print(arr.get(i).get(1));%>
    </div>
    <div style="float: left;width: 8%;">
        <%out.print(arr.get(i).get(2));%>
    </div>
    <div style="float: left;width: 8%;">
        <%out.print(arr.get(i).get(3));%>
    </div>
    <div style="float: left;width: 8%;">
        <%out.print(arr.get(i).get(4));%>
    </div>
    <div style="float: left;width: 16%;">
        <%out.print(arr.get(i).get(5));%>
    </div>
    <div style="float: left;width: 6%;">
        <%out.print(arr.get(i).get(6));%>
    </div>
    <div style="float: left;width: 6%;">
        <%out.print(arr.get(i).get(7));%>
    </div>
    <div style="float: left;width: 6%;">
        <%out.print(arr.get(i).get(8));%>
    </div>
    <div style="float: left;width: 3%;">
        <%out.print(arr.get(i).get(9));%>
    </div>
    <%}%>
</div>
    <%if(cnt == 5){%>
    <div style="width: 62%; height: 1px; background-color: grey; margin: 0 auto">
    <%}%>
    <%if(cnt == 11){%>
    <div style="width: 83%; height: 1px; background-color: grey; margin: 0 auto">
    <%}%>
    <%if(cnt == 10){%>
    <div style="width: 88%; height: 1px; background-color: grey; margin: 0 auto">
    <%}%>
</div>
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
