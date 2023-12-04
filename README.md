# DB_TERMPROJECT : SOCCERLINK
**TEAM6 : 김승준, 서동혁, 황두영**
  - Youtube Demo :
  - GitHub Repository : https://github.com/eutopia115/DB_Project

**Tips**
  - GitHub Repository의 README.md와 Lms에 제출된 Team6-ReadMe.txt는 같은 파일입니다.
  - GitHub의 Repository 창에서 보기 편하게 작성했으니, 위 GitHub Repository에 접속하시어 읽으시는 편이 좋습니다.
  - 최종 제출, 즉 Phase4의 내용만을 포함하고 있습니다
  - 이전 제출과 관련한 부분은 이전 제출본의 Team6-ReadMe.txt를 확인해주시길 부탁드립니다.

**개발환경**
  - Java : Java SE 10
  - Web : Html, JSP, CSS(tags)
  - Server : Tomcat 8.5.96
  - Maven : Junit 3.8.1
  - external lib : ojdbc10, orai18n, catalina, jsp-api, servlet-api, websocket-api, tomcat-websocket
  - IDE(JAVA, JSP, HTML) : Intellij IDEA Ultimate
  - IDE(SQL, Database) : SQL*Plus, SQL developer, DataGrip

**Checker (Functional) 12.04 complete**
- [X] 1+2+3+6+7 : Manager + Rest - 황두영
- [X] 4 : Admin - 서동혁
- [X] 5 : Member - 김승준

**Checker (Others)**
- [ ] CSS Design - 황두영
- [ ] txt fiies (ReadMe, Task1, Additional_Task1) - 서동혁
- [ ] ppt, presentation preparing - 김승준
- [ ] Youtube Demo Make

# 기본 설계
**1. 메인 화면** (로그인 링크, 현재 등록된 Match/Training 조회)

**2. 로그인** (로그인 화면, 로그인 버튼, 가입 링크 버튼)

**3. 회원가입/탈퇴** (회원가입 정보 입력, DB에 insert/탈퇴의사 재확인, DB에서 Delete)

**4. admin_main** (관리자 모드로 로그인, 중요정보 열람 및 각 테이블 관리)
 - 4-1. User
 - 4-2. Team
 - 4-3. Owner
 - 4-4. Field
 - 4-5. Match
 - 4-6. Training
 - 4-7. Mainly Info

**5. member_main** (MEMBER 테이블에 속한 아이도로 로그인, 개인정보 수정, match/training 신청, 예치금 충전 등)
 - 5-1. match (꽉 차면 비활성화)
 - 5-2. Training + trainMake (꽉 차면 비활성화)
 - 5-3. Team + teamMake
 - 5-4. ChangeInfo
 - 5-5. CashCharge
 - 5-6. MyTeam

**6. manager_main** (MANAGER 테이블에 속한 아이도로 로그인, 개인정보 수정, 멤버 평가, 계좌번호 확인 등)
 - 6-1. Evaluation (Match별 Member pop-up)
 - 6-2. match + matchApply
 - 6-3. ChangeInfo

# 설계 구현(소스코드 별 상세 설명)
**imported Class**
  - SQLx.java : 쿼리문을 직접 작성하지 않아도 되도록, Parameter만 전달하면 SQL문을 String 형태로 return 하는 class
  - SessionConst : jsp에서 이용하는 상수들이 포함된 Class
  - MatchDto : Match를 조회하는 데 쓰이는 자료구조가 포함된 Class
    
**include Page**
  - dbconn.jsp : Oracle DB에 연결하는 페이지로, SQL을 이용하는 jsp에 include되어 DB를 가동합니다.
    
**1. 메인 화면** 
  - 1-1. Main page (index.jsp): SoccerLink Web의 메인페이지로, 로그인 화면으로 이동이 가능합니다. 또한 로그인을 하지 않아도 날짜와 Match/Training을 고르면 그 날짜에 개설된 Match/Training을 확인가능합니다.
    
**2. 로그인** 
  - 2-1. Log in screen (/common/login.jsp): 로그인 화면입니다. Member/Manager/Admin으로 로그인이 가능하며, 회원가입 화면으로 Redirect할 수 있는 Button이 있습니다.
  - 2-2. Log in process (/common/logInProc.jsp): Member/Manager/Admin을 구분해 Log in하여 웹에 접속하도록 합니다.
  - 2-3. Log out Process (/common/logInProc.jsp): 버튼을 누르면 invalidate를 통해 Log out하고 메인 화면으로 Redirect합니다.
    
**3. 회원가입/탈퇴**
  - 3-1. Sign Up Screen (/common/signUp.jsp): 회원가입 화면입니다. Member/Manager를 구분하여 회원가입에 필요한 정보를 입력받습니다.
  - 3-2. Sign Up Process (/common/signUpProc.jsp): 회원가입 화면에서 post된 정보를 Users/Member/Manager table에 삽입합니다.
  - 3-3. Secession Process (/common/sessionProc.jsp): 버튼을 눌러 탈퇴의사를 재확인하고, 확인될 시에 접속하고 있는 USER를 table에서 delete합니다.
   
**4. Admin**
  - 4-1. 메인 화면
    - 4-1-1. Admin Screen (/admin/admin.jsp): 관리자 모드의 메인 화면입니다. 각 메뉴로 이동할 수 있습니다.
  - 4-2. Users 메뉴 : Delete만 가능, User 정보 Update 및 Insert는 각각 Member/Manager Mypage와 SignUp을 통해 가능합니다.
    - 4-2-1. User Management Screen (/admin/userMod.jsp): Users table 관리 메인 화면입니다. 
    - 4-2-2. User Delete Process (/admin/proc/user/delete.jsp): primary key를 입력받아 target user를 DB에서 삭제합니다.
  - 4-3. Team 메뉴 : Update/Delete 가능, Team은 Member의 makeTeam를 통해 가능합니다.
    - 4-3-1. Team Management Screen (/admin/teamMod.jsp): Team table 관리 메인 화면입니다. 
    - 4-3-2. Team Delete Process (/admin/proc/team/delete.jsp): primary key를 입력받아 target user를 DB에서 삭제합니다.
    - 4-3-3. Team Update Process (/admin/proc/team/update.jsp): primary key를 입력, target attribute를 선택하고 new value를 입력하여 tuple을 update합니다.
  - 4-4. Owner 메뉴
    - 4-4-1. Owner Management Screen (/admin/ownerMod.jsp): Owner table 관리 메인 화면입니다. 
    - 4-4-2. Owner Delete Process (/admin/proc/owner/delete.jsp): primary key를 입력받아 target user를 DB에서 삭제합니다.
    - 4-4-3. Owner Update Process (/admin/proc/owner/update.jsp): primary key를 입력, target attribute를 선택하고 new value를 입력하여 tuple을 update합니다. 
    - 4-4-4. Owner Insert Process (/admin/proc/owner/insert.jsp): attribute별 value를 입력하여 DB에 record를 insert합니다.
  - 4-5. Field 메뉴
    - 4-5-1. Field Management Screen (/admin/fieldMod.jsp): Owner table 관리 메인 화면입니다. 
    - 4-5-2. Field Delete Process (/admin/proc/field/delete.jsp): primary key를 입력받아 target user를 DB에서 삭제합니다.
    - 4-5-3. Field Update Process (/admin/proc/field/update.jsp): primary key를 입력, target attribute를 선택하고 new value를 입력하여 tuple을 update합니다. 
    - 4-5-4. Field Insert Process (/admin/proc/field/insert.jsp): attribute별 value를 입력하여 DB에 record를 insert합니다.
  - 4-6. Match 메뉴
    - 4-6-1. Match Management Screen (/admin/matchMod.jsp): Owner table 관리 메인 화면입니다. 
    - 4-6-2. Match Delete Process (/admin/proc/match/delete.jsp): primary key를 입력받아 target user를 DB에서 삭제합니다.
    - 4-6-3. Match Update Process (/admin/proc/match/update.jsp): primary key를 입력, target attribute를 선택하고 new value를 입력하여 tuple을 update합니다. 
    - 4-6-4. Match Insert Process (/admin/proc/match/insert.jsp): attribute별 value를 입력하여 DB에 record를 insert합니다.
  - 4-7. Training 메뉴 : Update/Delete 가능, Team은 Member의 makeTrain를 통해 가능합니다.
    - 4-7-1. Training Management Screen (/admin/trainMod.jsp): Team table 관리 메인 화면입니다. 
    - 4-7-2. Training Delete Process (/admin/proc/train/delete.jsp): primary key를 입력받아 target user를 DB에서 삭제합니다.
    - 4-7-3. Training Update Process (/admin/proc/train/update.jsp): primary key를 입력, target attribute를 선택하고 new value를 입력하여 tuple을 update합니다.
  - 4-8. 필요한 정보 조회
    - 4-8-1. Check Information (/admin/checkInfo.jsp): Owner&field, Match, Training에 관한 정보를 조회합니다.

**5. Member**
  - 5-1. 마이페이지 기능
    - 5-1-1. Member Screen (/member/member.jsp): 멤버의 개인 정보 페이지로, 자신의 정보 조회 및 다른 파트로 이동이 가능합니다. 이 페이지를 통해 멤버는 자신의 계정을 관리할 수 있습니다.
  - 5-2. 금전 관련 기능
    - 5-2-1. Cash Charge (/member/cashCharge.jsp): 멤버가 자신의 계정에 금액을 충전할 수 있는 페이지입니다. 충전하고자 하는 금액을 입력하여 계정의 잔액을 늘릴 수 있습니다.
  - 5-3. 개인 정보 변경 기능
    - 5-3-1. Change Info (/member/changeInfo.jsp): 멤버가 자신의 개인 정보를 수정할 수 있는 페이지입니다. 이 페이지를 통해 멤버는 이름, 직업, 생년월일 등의 정보를 최신 상태로 유지할 수 있습니다.
  - 5-4. 경기 관련 기능
    - 5-4-1. Match list (/member/match.jsp): 모든 경기의 목록을 보여주며, 멤버는 다가오는 경기들에 대한 정보를 확인할 수 있습니다.
    - 5-4-2. My match (/member/viewMyMatch.jsp): 멤버가 참가하고 있는 경기의 목록을 보여주어, 자신의 경기 일정을 한눈에 확인할 수 있습니다.
    - 5-4-3. Match enroll (/member/enrollMatch.jsp): 새로운 경기에 등록할 수 있는 페이지로, 멤버가 원하는 경기를 선택하여 참가 신청을 할 수 있습니다. 경기에 필요한 금액만큼 자신의 잔액이 차감됩니다.
    - 5-4-4. Match delete (/member/deleteMyMatch.jsp): 멤버가 등록한 경기를 취소할 수 있습니다. 경기에 사용한 금액만큼 자신의 잔액이 환불됩니다.
  - 5-5. 트레이닝 관련 기능
    - 5-5-1. Training list (/member/training.jsp): 제공되는 모든 트레이닝 프로그램의 목록을 보여줍니다.
    - 5-5-2. My training (/member/viewMyTraining.jsp): 멤버가 등록한 트레이닝 프로그램의 목록으로, 개인별 맞춤 트레이닝 일정을 관리할 수 있습니다.
    - 5-5-3. Training enroll (/member/nrollTrain.jsp): 새로운 트레이닝 프로그램에 참가 신청을 할 수 있습니다. 트레이닝에 필요한 금액만큼 멤버의 잔액이 차감됩니다.
    - 5-5-4. Training make (/member/makeTrain.jsp): 멤버가 자신만의 트레이닝 프로그램을 설계하고 만들 수 있는 기능입니다. 이를통해 멤버에게 레슨을 제공할 수 있습니다.
  - 5-6. 팀 관련 기능
    - 5-6-1. Team list (/member/team.jsp): 등록된 모든 팀의 목록을 보여주며, 멤버는 다양한 팀을 탐색하고 정보를 얻을 수 있습니다.
    - 5-6-2. My team (/member/viewMyTeam.jsp): 멤버가 속한 팀의 정보를 보여줍니다.
    - 5-6-3. Team enroll (/member/processTeamApplication.jsp): 새로운 팀에 가입 신청을 할 수 있습니다.
    - 5-6-4. Team delete (/member/deleteMyTeam.jsp): 멤버가 속한 팀을 탈퇴할 수 있습니다.

**6. Manager**
  - 5-1. 마이페이지 기능
    - 5-1-1. Manager Screen (/mana/manager.jsp): 매니저의 개인 정보 페이지로, 자신의 정보 조회 및 다른 파트로 이동이 가능합니다. 이 페이지를 통해 매니저는 자신의 계정을 관리할 수 있습니다.
  - 5-2. 개인 정보 변경 기능
    - 5-2-1. Change Info (/mana/changeInfo.jsp): 매니저가 자신의 개인 정보를 수정할 수 있는 페이지입니다. 이 페이지를 통해 매니저는 이름, 직업, 생년월일, 계좌번호 등의 정보를 최신 상태로 유지할 수 있습니다.
    - 5-2-2. Change Info Process (/mana/proc/changeManaInfoProc.jsp): 페이지에서 Post된 정보를 바탕으로 접속된 ID_Number를 key로 가지는 tuple을 update합니다.
  - 5-3. 경기 관련 기능
    - 5-3-1. Match Apply (/mana/matchAppMana.jsp): 모든 경기의 목록을 보여주며, 매니저는 다가오는 경기들에 대한 정보를 확인해 매치의 매니저로 apply할 수 있습니다.
    - 5-3-2. Match Apply Process (/mana/proc/matchAppManaProc.jsp): 페이지에서 클릭한 Match_ID를 확인하여 Match tuple의 manager attribute에 ID_Number를 update합니다
  - 5-4. 평가 관련 기능
    - 5-5-1. Member Evlauate (/mana/memberEval.jsp): 매니저로 참가한 경기에 참가한 멤버들의 정보를 보여주고, 티어를 평가합니다.
    - 5-5-2. Member Evlauate Process (/mana/proc/memberEvalProc.jsp): 페이지에서 Post된 정보를 바탕으로 Man_Eval_Mem table을 update하거나, insert합니다.

**Design** : 이미지 파일, jsp 내부 태그 등을 이용하여 구현함.
  



