<%@ page import="classes.dto.MatchDto" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="classes.SQLx" %>
<%@ include file="../common/dbconn.jsp" %><%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-03
  Time: 오전 3:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<a href="../index.jsp">Soccer Link</a>
<hr>
<label> Match or Training Date : </label>
<input type="date" name="date" id="date">
<input type ="button" value="검색">
</br>
매치 아이디를 입력하시오: <input type="text" name="matchId" id = "matchId">
<input type ="button" value="신청" onclick ="window.location.href ='matchAppProc.jsp'">
<hr>
</br>
<%
    String date = request.getParameter("date");
    List<MatchDto> matchDtoList = new ArrayList<>();
    List <String> matchIdList = new ArrayList<>();
    String matchSearch = "SELECT M.*, F.NAME,F.ADDRESS FROM MATCH M \n" +
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
        날짜: <%=matchDtoList.get(i).getDate()%>
        경기 번호: <%=matchDtoList.get(i).getMatchId()%>
        구장 이름: <%=matchDtoList.get(i).getfName()%>
        주소: <%=matchDtoList.get(i).getfAddress()%>
        종목: <%=matchDtoList.get(i).getType()%>
        참여인원: <%=matchDtoList.get(i).getCurrentNum()%> /
        <%=matchDtoList.get(i).getMaxNum()%>
        성별제한: <%=matchDtoList.get(i).getSex()%>
        참가비용: <%=matchDtoList.get(i).getCost()%>
    </p>
    <%
            }
            %>


</body>
</html>
