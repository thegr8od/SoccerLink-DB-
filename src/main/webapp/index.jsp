<%@ include file="common/dbconn.jsp" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ page import="classes.dto.MatchDto" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>
<%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-01
  Time: 오후 10:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Soccer Link</title>
</head>
<body>
<%
    String user = (String) session.getAttribute(SessionConst.USER);
    if(user==null){

%>
<a href="common/login.jsp">login</a>
<hr>
<%
    }
    else{
        String apx = "\'";
        StringBuilder where = new StringBuilder();
        where.append("ID_NUMBER = " + apx + user + apx);
        String checkMember = SQLx.Selectx("ID_NUMBER", "MEMBER", where.toString(), "");
        pst = conn.prepareStatement(checkMember);
        rs = pst.executeQuery();
        if (rs.next()) {
%>
<input type = "button" value="my page" onclick="window.location.href ='member/member.jsp'">
<%
        }
        else {
            // manager table에 존재하는지 확인
            String checkManager = SQLx.Selectx("ID_NUMBER", "MANAGER", where.toString(), "");
            pst = conn.prepareStatement(checkManager);
            rs = pst.executeQuery();
            if (rs.next()) {
%>
<input type = "button" value="my page" onclick="window.location.href ='mana/manager.jsp'">
<%
            }
        }
%>
<input type="button" value="log out" onclick = "window.location.href='common/logOutProc.jsp'">
<%
    }
%>
<h2>SoccerLink</h2>
<hr>
</br>
<label> Match or Training Date : </label>
<input type="date" name="date" id="date">
</br>
<input type ="button" onclick="searchMatch()" value="match">
<input type ="button" onclick="searchTraining()" value="training">
<hr>
<%
    String category = request.getParameter("category");
    String date = request.getParameter("date");

    List <MatchDto> matchDtoList = new ArrayList<>();
    List <String> matchIdList = new ArrayList<>();
    if(category == null||category.equals("match")){
        String matchSearch = "SELECT M.*, F.NAME,F.ADDRESS FROM MATCH M \n" +
                "INNER JOIN FIELD F ON M.PLACE_ID = F.FIELD_ID\n" +
                "WHERE M.MATCH_ID IN\n" +
                "(SELECT DISTINCT MATCH_ID\n" +
                "FROM MATCH M1\n";
        StringBuilder matchSb= new StringBuilder(matchSearch);
                if(date!=null) {
                    matchSb.append("WHERE M1.DATE_TIME = '" + date+"\'");
                }
                matchSb.append(") order by M.date_time desc");

        pst = conn.prepareStatement(matchSb.toString());
        rs = pst.executeQuery();
        while(rs.next()){
            MatchDto matchDto = new MatchDto();
            String matchId = rs.getString((1));
            matchDto.setMatchId(matchId);
            matchDto.setfName(rs.getString(10));
            matchDto.setfAddress(rs.getString(11));
            matchDto.setType(rs.getString(4));
            matchDto.setMaxNum(rs.getInt(5));
            matchDto.setSex(rs.getString(6));
            matchDto.setCost(rs.getInt(9));
            matchDto.setDate(rs.getString(2));
            matchIdList.add(matchId);
            matchDtoList.add(matchDto);
        }
        if(matchDtoList.size()!=0) {
            StringBuilder where = new StringBuilder("MATCH_ID IN (");
            for (int i = 0; i < matchIdList.size(); i++) {
                if (i == matchIdList.size() - 1) {
                    where.append("\'" + matchIdList.get(i) + "\')");
                } else {
                    where.append("\'" + matchIdList.get(i) + "\',");
                }
            }
            String currNumSql = SQLx.Selectx("MATCH_ID, COUNT(MATCH_ID)", "MATCH_APP_MEMBER", where.toString(), " GROUP BY MATCH_ID");
            pst = conn.prepareStatement(currNumSql);
            rs = pst.executeQuery();
            Map<String,Integer> matchCurrNum = new HashMap<>();
            while(rs.next()){
                matchCurrNum.put(rs.getString(1),rs.getInt(2));
            }
            for(int i = 0 ; i<matchDtoList.size();i++){
                MatchDto matchDto = matchDtoList.get(i);
                String matchId = matchDto.getMatchId();
                Integer currentNum = matchCurrNum.get(matchId);
                matchDto.setCurrentNum(currentNum);
            }
        }
        %>
<%--<p>--%>
<%--    Selected Date: <%=date%>--%>
<%--</p>--%>
<%
        for(int i =0; i<matchDtoList.size();i++){
%>
<p>
    Date = <%=matchDtoList.get(i).getDate()%>
    <%=matchDtoList.get(i).getMatchId()%>
    <%=matchDtoList.get(i).getfName()%>
    <%=matchDtoList.get(i).getfAddress()%>
    <%=matchDtoList.get(i).getType()%>
    Current Number = <%=matchDtoList.get(i).getCurrentNum()%>/
    Max Number = <%=matchDtoList.get(i).getMaxNum()%>
    Sex Constraint = <%=matchDtoList.get(i).getSex()%>
    Cost = <%=matchDtoList.get(i).getCost()%>
</p>
<%
        }
    }
    else{// Training
            String trainSearch = "select T.CLASS_ID,T.DATE_TIME,T.RECOMMEND_TIER,T.SUBJECT,T.COST_PER_ONE,T.MAX_NUM, count(E.CLASS_ID)\n" +
                    "from training T inner join TRAIN_ENROLLS E on T.CLASS_ID=E.CLASS_ID\n" +
                    "where T.CLASS_ID IN(\n" +
                    "    select distinct T1.class_id\n" +
                    "    from TRAINING T1\n" ;
                    /*"    where T1.DATE_TIME = '2022-12-07')\n" +*/
//
//            "GROUP BY T.CLASS_ID,T.DATE_TIME,T.RECOMMEND_TIER,T.SUBJECT,T.COST_PER_ONE,T.MAX_NUM\n" +
//                    "order by T.date_time desc;";
            StringBuilder trainSb= new StringBuilder(trainSearch);
            if(date!=null&&!date.equals("")) {
                trainSb.append("WHERE T1.DATE_TIME = '" + date+"\'");

            }
            trainSb.append(")GROUP BY T.CLASS_ID,T.DATE_TIME,T.RECOMMEND_TIER,T.SUBJECT,T.COST_PER_ONE,T.MAX_NUM ");
            trainSb.append("order by T.date_time desc");

            pst = conn.prepareStatement(trainSb.toString());
            rs = pst.executeQuery();

            while(rs.next()){
%>
<p>
    <%=rs.getString(1)%>
    <%=rs.getString(2)%>
    <%=rs.getString(3)%>
    <%=rs.getString(4)%>
    <%=rs.getString(5)%>
    <%=rs.getString(6)%>
    <%=rs.getString(7)%>
</p>
<%      }
    }
%>
<hr>
<form id="searchForm">
</form>
<script>
    function searchMatch(){
        const searchForm = document.querySelector("#searchForm");
        const date = document.querySelector("#date");
        searchForm.appendChild(date)
        var categoryInput = document.createElement('input');
        categoryInput.type = 'text';
        categoryInput.name = 'category';
        categoryInput.value = 'match';
        searchForm.appendChild(categoryInput);
        searchForm.action = "index.jsp";
        searchForm.submit();
    }
    function searchTraining(){
        const searchForm = document.querySelector("#searchForm");
        const date = document.querySelector("#date");
        searchForm.appendChild(date)
        var categoryInput = document.createElement('input');
        categoryInput.type = 'text';
        categoryInput.name = 'category';
        categoryInput.value = 'training';
        searchForm.appendChild(categoryInput);
        searchForm.action = "index.jsp";
        searchForm.submit();
    }
</script>
</body>
</html>
