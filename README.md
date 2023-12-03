# DB_TERMPROJECT : SOCCERLINK
# TEAM6 : 김승준, 서동혁, 황두영

**개발환경**
  - Java : Java SE 10
  - Web : Html, JSP, CSS(tags)
  - Server : Tomcat 8.5.96
  - Maven : Junit 3.8.1
  - external lib : ojdbc10, orai18n, catalina, jsp-api, servlet-api, websocket-api, tomcat-websocket
  - IDE(JAVA, JSP, HTML) : Intellij IDEA Ultimate
  - IDE(SQL, Database) : SQL*Plus, SQL developer, DataGrip

**1. 메인화면** (로그인 링크, 현재 등록된 Match/Training 조회)

**2. 로그인창** (로그인 화면, 로그인 버튼, 가입 링크 버튼)

**3. 회원가입창** (회원가입 정보 입력, DB에 insert)

**4. admin_main** (관리자 모드로 로그인, 중요정보 열람 및 각 테이블 관리)
 - 4-1. User
 - 4-2. Team
 - 4-3. Owner
 - 4-4. Field
 - 4-5. Match
 - 4-6. Training
 - 4-7. Mainly Info

**5. member_main** (MEMBER 테이블에 속한 아이도로 로그인, 개인정보 수정, match/training 신청, 예치금 충전 등)
 - 5-1. match + matchmake (field pop-up, 꽉 차면 비활성화)
 - 5-2. Training + trainMake (꽉 차면 비활성화)
 - 5-3. Team teamMake
 - 5-4. ChangeInfo
 - 5-5. CashCharge
 - 5-6. MyTeam

**6. manager_main** (MANAGER 테이블에 속한 아이도로 로그인, 개인정보 수정, 멤버 평가, 계좌번호 확인 등)
 - 6-1. Evaluation (Match별 Member pop-up)
 - 6-2. match + matchApply
 - 6-3. ChangeInfo

**7. Secession (진짜 탈퇴함? 인증 pop-up)**

# Checker
- [X] 1+2+3+6+7 : Manager + Rest
- [X] 4 : Admin
- [ ] 5 : Member
