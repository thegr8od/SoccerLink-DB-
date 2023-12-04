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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title>Soccer Link</title>
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp"><img src="../image/webLogo.png" style ="width: 200px"></a>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            </ul>
            <div class="d-flex" role="search">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 justify-content-end">
<%
    String user = (String) session.getAttribute(SessionConst.USER);
    if(user==null){

%>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="common/login.jsp">login</a>
                    </li>
<%
    }
    else{
        if(user.equals("SOCCERLINK")) {
%>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="admin/admin.jsp">My page</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="common/logOutProc.jsp">Log out</a>
                    </li>
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
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="member/member.jsp">My page</a>
                    </li>

<%
        }
        else {
            // manager table에 존재하는지 확인
            String checkManager = SQLx.Selectx("ID_NUMBER", "MANAGER", where.toString(), "");
            pst = conn.prepareStatement(checkManager);
            rs = pst.executeQuery();
            if (rs.next()) {
%>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="mana/manager.jsp">My page</a>
                    </li>
<%
            }
        }
%>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="common/logOutProc.jsp">Log out</a>
                    </li>
<%
    }
}
%>
                </ul>
            </div>
        </div>
    </div>
</nav>
<hr>
</br>
<div class = "ms-3">
    <h5>검색을 위해 Match 또는 Training을 선택하고 날짜를 선택해주세요.</h5>
    <div class="d-flex align-items-center justify-content-start">
        <form action="index.jsp" class="d-flex align-items-center">
            <fieldset class="d-flex align-items-center">
                <div class=" d-flex align-items-center" >
                    <label for="date" class="form-label me-2">날짜</label>
                    <input type="date" name="date" id="date">
                </div>
                <div class="ms-3 d-flex align-items-center" >
                    <label for="category" class="form-label me-2 text-nowrap">매치/트레이닝</label>
                    <select id="category" name="category" class="form-select">
                        <option value="match" selected>Match</option>
                        <option value="training">Training</option>
                    </select>
                </div>
                <input type="submit" class="ms-3 btn btn-primary" value="search">
            </fieldset>
        </form>
    </div>
</div>

<div class="row mt-3 p-2 g-3">
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
            matchDto.setDate(rs.getDate(2));
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
//                System.out.println(matchId + " : " + matchCurrNum.get(matchId));
                Integer currentNum = matchCurrNum.get(matchId);
                matchDto.setCurrentNum(currentNum == null? 0:currentNum);
            }
        }

        for(int i =0; i<matchDtoList.size();i++){
%>
    <div class="col-4">
        <div class="card">
            <div class="card-body justify-content-start" style="display: flex; justify-content: space-between;">
                <div style="display: flex;justify-content: center;align-items: center;">
                    <span><%=matchDtoList.get(i).getDate()%></span>
                </div>
                <div class ="ms-3">
                    <h5 class="card-title"><%=matchDtoList.get(i).getfName()%></h5>
                    <p class="card-text">
                        경기 번호: <%=matchDtoList.get(i).getMatchId()%>
                        주소: <%=matchDtoList.get(i).getfAddress()%>
                    </br>
                        종목: <%=matchDtoList.get(i).getType()%>
                        참여인원: <%=matchDtoList.get(i).getCurrentNum()%> / <%=matchDtoList.get(i).getMaxNum()%>
                        성별제한: <%=matchDtoList.get(i).getSex()%>
                        참가비용: <%=matchDtoList.get(i).getCost()%>
                    </p>
                </div>
            </div>
        </div>
    </div>

<%
        }
    }
    else{// Training
            String trainSearch = "select T.CLASS_ID,T.DATE_TIME,T.RECOMMEND_TIER,T.SUBJECT,T.COST_PER_ONE,T.MAX_NUM, U.NAME, count(E.CLASS_ID)\n" +
                    "from training T inner join TRAIN_ENROLLS E on T.CLASS_ID=E.CLASS_ID\n" +
                    "inner join USERS U on T.TUTOR_ID = U.ID_NUMBER\n" +
                    "where T.CLASS_ID IN(\n" +
                    "    select distinct T1.class_id\n" +
                    "    from TRAINING T1\n" ;
            StringBuilder trainSb= new StringBuilder(trainSearch);
            if(date!=null&&!date.equals("")) {
                trainSb.append("WHERE T1.DATE_TIME = '" + date+"\'");

            }
            trainSb.append(")GROUP BY T.CLASS_ID,T.DATE_TIME,T.RECOMMEND_TIER,T.SUBJECT,T.COST_PER_ONE,T.MAX_NUM,U.NAME ");
            trainSb.append("order by T.date_time desc");

            pst = conn.prepareStatement(trainSb.toString());
            rs = pst.executeQuery();

            while(rs.next()){
%>
<div class="col-4">
    <div class="card">
        <div class="card-body justify-content-start" style="display: flex; justify-content: space-between;">
            <div style="display: flex;justify-content: center;align-items: center;">
                <span><%=rs.getDate(2)%></span>
            </div>
            <div class ="ms-3">
                <h5 class="card-title"><%=rs.getString(4)%></h5>
                <p class="card-text">
                    수강번호: <%=rs.getString(1)%>
                    추천 티어: <%=rs.getString(3)%>
                    </br>
                    수강료: <%=rs.getString(5)%> 원
                    수강인원: <%=rs.getString(8)%> / <%=rs.getString(6)%>
                    강사: <%=rs.getString(7)%>
                </p>
            </div>
        </div>
    </div>
</div>
<%      }
    }
%>
</div>
<form id="searchForm">
</form>
</body>
</html>
