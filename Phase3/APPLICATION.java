package Phase3;

import Phase3.ProjectMain;

import javax.xml.transform.Result;
import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;


import java.util.Calendar;
import java.util.Random;

import static Phase3.SQLx.*;
import static Phase3.ProjectMain.bf;

public class APPLICATION {
    protected static void MyPage(String id, boolean role) {
        // 사용자 정보를 데이터베이스에서 가져오기
        while (true) {
            System.out.println("----------------------------------------------------");
            if (role) { // 멤버일 경우
                System.out.println("1. Change My Info");
                System.out.println("2. Cash Charge");
                System.out.println("3. Check My Info");
                System.out.println("4. Check My Team");
                System.out.println("5. Secession");
                System.out.println("6. Exit");
            } else { // 매니저일 경우
                System.out.println("1. Change My Info");
                System.out.println("2. Check My Info");
                System.out.println("3. Secession");
                System.out.println("4. Exit");
            }
            System.out.println("----------------------------------------------------");
            System.out.print("Enter the number: ");

            try {
                int opt = Integer.parseInt(bf.readLine());
                if (role) { // 멤버용 로직
                    switch (opt) {
                        case 1:
                            System.out.println("----------------------------------------------------");
                            System.out.println("Choose an option to update:");
                            System.out.println("1. Password");
                            System.out.println("2. Sex");
                            System.out.println("3. Year of Birth");
                            System.out.println("4. Job");
                            System.out.println("----------------------------------------------------");
                            System.out.print("select your choice (1-4): ");
                            int changeOption = Integer.parseInt(bf.readLine());


                            String newValue1, newValue2;
                            do {
                                System.out.println("----------------------------------------------------");
                                System.out.print("Enter the new value for the chosen option: ");
                                newValue1 = bf.readLine();
                                System.out.println("----------------------------------------------------");
                                System.out.print("Re-enter the new value to confirm: ");
                                newValue2 = bf.readLine();
                                //무결성 처리 해야함
                                if (!newValue1.equals(newValue2)) {
                                    System.out.println("The entered values do not match. Please try again.");
                                }
                            } while (!newValue1.equals(newValue2));
                            ChangeMyInfo(id, changeOption, newValue1);
                            break;
                        case 2:
                            System.out.println("----------------------------------------------------");
                            System.out.print("Enter the amount to charge: ");
                            try {
                                int amount = Integer.parseInt(bf.readLine());
                                CashCharge(id, amount);
                                System.out.println("----------------------------------------------------");
                                System.out.println("Charge completed successfully.");
                            } catch (NumberFormatException e) {
                                System.out.println("----------------------------------------------------");
                                System.out.println("Invalid input. Please enter a valid number.");
                            }
                            break;
                        case 3:
                            // 자신의 정보 확인 (Check 메서드 사용)
                            Check(1, id);
                            break;
                        case 4:
                            // 자신이 속한 팀 확인 (Check 메서드 사용)
                            Check(3, id);
                            break;
                        case 5:
                            System.out.println("----------------------------------------------------");
                            System.out.println("Are you sure you want to delete your account? Type 'I want to delete my account' to confirm.");
                            System.out.println("----------------------------------------------------");
                            String confirmation = bf.readLine();
                            System.out.print("Type : ");
                            if ("I want to delete my account".equals(confirmation)) {
                                Secession(id);
                                System.out.println("Your account has been successfully deleted.");
                                return; // 탈퇴 후 메뉴 종료
                            } else {
                                System.out.println("Account deletion cancelled.");
                            }
                            break;
                        case 6:
                            System.out.println("Exiting MyPage...");

                            return; // 루프 종료
                    }
                } else { // 매니저용 로직
                    switch (opt) {
                        case 1:
                            System.out.println("----------------------------------------------------");
                            System.out.println("Choose an option to update:");
                            System.out.println("1. Password");
                            System.out.println("2. Sex");
                            System.out.println("3. Year of Birth");
                            System.out.println("4. Job");
                            System.out.println("----------------------------------------------------");
                            System.out.print("select your choice (1-4): ");
                            int changeOption = Integer.parseInt(bf.readLine());


                            String newValue1, newValue2;
                            do {
                                System.out.println("----------------------------------------------------");
                                System.out.print("Enter the new value for the chosen option: ");
                                newValue1 = bf.readLine();
                                System.out.println("----------------------------------------------------");
                                System.out.print("Re-enter the new value to confirm: ");
                                newValue2 = bf.readLine();
                                //무결성 처리 해야함
                                if (!newValue1.equals(newValue2)) {
                                    System.out.println("The entered values do not match. Please try again.");
                                }
                            } while (!newValue1.equals(newValue2));
                            ChangeMyInfo(id, changeOption, newValue1);
                            break;
                        case 2:
                            // 은행 계좌 확인 (Check 메서드 사용)
                            Check(2, id);
                            break;
                        case 3:
                            System.out.println("----------------------------------------------------");
                            System.out.println("Are you sure you want to delete your account? Type 'I want to delete my account' to confirm.");
                            System.out.println("----------------------------------------------------");
                            String confirmation = bf.readLine();
                            System.out.print("Type : ");
                            if ("I want to delete my account".equals(confirmation)) {
                                Secession(id);
                                System.out.println("Your account has been successfully deleted.");
                                return; // 탈퇴 후 메뉴 종료
                            } else {
                                System.out.println("Account deletion cancelled.");
                            }
                            break;
                        case 4:
                            System.out.println("Exiting MyPage...");
                            return; // 루프 종료
                        case 7: // 이스터 에그
                            System.out.println("⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⣠⣖⣿⣿⣭⣿⣿⣷⣦⣄");
                            System.out.println("⢀⢀⢀⢀⢀⢀⣀⡤⣺⣭⣾⣿⣿⣿⣿⣭⣿⣿⣿⣿⣷⣄");
                            System.out.println("⢀⢀⢀⣠⣾⣿⣿⣿⣭⣿⣿⣿⣭⣿⣿⣭⣿⣿⣿⣭⣿⣿⡇");
                            System.out.println("⢀⢀⣞⣿⣿⣿⣭⣿⣿⣿⡿⠟⠛⠛⠛⠛⠛⠛⠻⣿⣿⣿⣿");
                            System.out.println("⢀⣼⣿⣿⣭⣿⣿⣿⠛⠁⢀⢀⢀⢀⢀⢀⢀⢀⢀⢀⠹⣿⣿");
                            System.out.println("⢀⣿⣿⣭⣿⣿⣿⣧⢀⢀⢀⣤⣤⣤⣄⡀⢀⢀⢀⣠⣤⣹⣿");
                            System.out.println("⢀⣿⣿⣿⣭⣿⣿⠟⢀⢀⠈⢀⣀⣠⣍⡃⢀⢀⠘⢉⣁⠙⣿");
                            System.out.println("⢀⢸⣿⣿⣿⣿⣯⢀⢀⢀⠈⢀⠒⠚⢀⢀⢀⠐⠭⠭⠃⢻⡀");
                            System.out.println("⢀⢀⣿⣭⡉⠙⡗⢀⢀⢀⢀⢀⢀⢀⢀⡔⢀⢀⢀⣂⢀⢀⢀⣷");
                            System.out.println("⢀⢸⠙⠈⣅⢀⢀⢀⢀⢀⢀⢀⢀⣴⠏⠻⠿⣿⣿⣿⣆⢀⢀⣿");
                            System.out.println("⢀⠘⣆⢀⠉⢀⣠⢀⢀⢀⢀⢀⣿⡟⢀⣠⣤⢬⣭⣅⢸⡀⢀⣿");
                            System.out.println("⢀⢀⢀⢀⢀⢿⠨⠁⢀⢀⢀⢀⢀⠹⠿⣿⣿⣭⣿⣿⠁⢀⣼⠃");
                            System.out.println("⢀⢀⢀⢀⢀⢸⢀⢀⢀⠸⢀⢀⢀⢀⢀⢀⣄⣉⣠⡅⢀⣰⠋");
                            System.out.println("⢀⢀⢀⢀⢀⣸⢀⢀⡄⢠⣤⣶⣄⢀⢀⠈⠙⠛⠛⠃⢠⡇");
                            System.out.println("⢀⢀⣀⣤⠾⠃⢀⠸⣵⣾⣿⡟⢿⣿⣶⣦⣤⣶⣶⡶⠋\n");
                            return; // 루프 종료
                    }
                }
            } catch (NumberFormatException e) {
                System.out.println("Invalid input. Please enter a number.");
            } catch (IOException e) {
                System.out.println("Error reading from input.");
            }
        }
    }


    protected static void UserEval(String managerId) throws IOException, SQLException {

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String currentDate = dateFormat.format(new Date()); // 현재 날짜

        System.out.println("----------------------------------------------------");
        System.out.println("Manager Evaluation");
        System.out.print("Enter Member ID for evaluation: ");
        String memberId = bf.readLine();

        System.out.print("Enter Evaluation Tier (A/B/C/D): ");
        String evalTier = bf.readLine().toUpperCase();

        // 유효성 검사
        if (!(evalTier.equals("A") || evalTier.equals("B") || evalTier.equals("C") || evalTier.equals("D"))) {
            System.out.println("Invalid Evaluation Tier. Please enter A, B, C, or D.");
            return;
        }

        // 평가 존재 여부 확인
        ResultSet rs = Selectx("*", "MAN_EVAL_MEM", "MEM_ID = '" + memberId + "' AND MAN_ID = '" + managerId + "'", "");

        if (rs.next()) { // 평가가 이미 존재하면 업데이트
            String[] key = {memberId, managerId};
            SQLx.Updatex("MAN_EVAL_MEM", "EVAL_TIER", evalTier, key);
            SQLx.Updatex("MAN_EVAL_MEM", "UPDATE_TIME", currentDate, key); // 현재 날짜 사용
            System.out.println("Evaluation Updated.");
        } else { // 새로운 평가면 삽입
            String[] data = {memberId, managerId, evalTier, currentDate}; // 현재 날짜 포함
            Insertx("MAN_EVAL_MEM", data);
            System.out.println("Evaluation Inserted.");
        }
        rs.close();
    }

    private static void ChangeMyInfo(String userId, int option, String newValue) {
        String targetField;
        boolean isValidInput = true; // 입력 값이 유효한지 확인하는 플래그

        // 입력 값 검증
        switch (option) {
            case 1: // Password
                targetField = "PASSWD";
                if (newValue.length() < 9) {
                    System.out.println("Invalid password. It must be at least 10 characters long.");
                    isValidInput = false;
                }
                break;
            case 2: // Sex
                targetField = "SEX";
                if (!newValue.toUpperCase().equals("M") && !newValue.toUpperCase().equals("F")) {
                    System.out.println("Invalid sex. Please enter 'M' for Male or 'F' for Female.");
                    isValidInput = false;
                }
                break;
            case 3: // Year of Birth
                targetField = "YOB";
                try {
                    int yearOfBirth = Integer.parseInt(newValue);
                    int currentYear = Calendar.getInstance().get(Calendar.YEAR);
                    if (yearOfBirth < 1900 || yearOfBirth >= currentYear) {
                        System.out.println("Invalid Year of Birth. Please enter a year between 1900 and " + (currentYear - 1) + ".");
                        isValidInput = false;
                    }
                } catch (NumberFormatException e) {
                    System.out.println("Invalid Year of Birth. Please enter a valid year.");
                    isValidInput = false;
                }
                break;
            case 4:
                targetField = "JOB";
                break;
            default:
                System.out.println("Invalid option");
                return;
        }

        if (!isValidInput) {
            return; // 유효하지 않은 입력이면 업데이트를 중단
        }

        // 데이터베이스 업데이트
        String[] key = {userId}; // 키 배열에는 변경할 사용자 ID를 지정
        SQLx.Updatex("USERS", targetField, newValue, key); // 업데이트 실행
        System.out.println(targetField + " updated for user: " + userId);
    }

    private static void CashCharge(String memberId, int amount) {
        try {
            // 기존의 PREPAID_MONEY 값을 먼저 조회
            ResultSet rs = Selectx("PREPAID_MONEY", "MEMBER", "ID_NUMBER = '" + memberId + "'", "");
            if (rs.next()) {
                int currentAmount = rs.getInt("PREPAID_MONEY");
                int newAmount = currentAmount + amount;

                // key 배열에는 타겟이 되는 행의 기본키나 조건을 지정
                String[] key = {memberId};
                // SQLx 클래스의 Updatex 메소드를 사용하여 PREPAID_MONEY 업데이트
                SQLx.Updatex("MEMBER", "PREPAID_MONEY", String.valueOf(newAmount), key);
                System.out.println("Your new prepaid money balance is: " + newAmount + " units.");
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }// ONLY FOR USER, UPDATE PREPAID_MONEY

    private static void Secession(String userId) {
        // key 배열에는 삭제할 행의 기본키나 조건을 지정
        String[] key = {userId};
        // SQLx 클래스의 Deletex 메소드를 사용하여 사용자 삭제
        Deletex("USERS", key);
        System.out.println("User deleted: " + userId);
    }// DELETE USER ON CASCADE

    protected static void Screen(String id, boolean role, int opt) throws IOException, SQLException {

        // false -> Manager, true -> Member
        // opt = 2. Training, 3. Match, 4. Team
        // TRAINING, MATCH, TEAM relation control

        if(role) {
            if(opt ==2){
                System.out.println("Enter the option which you want to do");
                System.out.println("------------------------------------=");
                System.out.println("1. View My training");
                System.out.println("2. Search training");
                System.out.println("3. make training"); // training에 만들고자 하는 트레이닝 insert
                System.out.println("4. delete training"); // training에 없애고자 하는 트레이팅 delete
                System.out.println("5. apply training"); // training id와 member id를 training 테이블에 새로운 튜플로 insert
                System.out.println("6. cancel training"); // traniing id와 member id를 가지는 튜플을 delete
                System.out.println("7. Quit");
                System.out.println("------------------------------------=");
                System.out.printf("Enter the number: ");
                while(true) {
                    String detail = bf.readLine();
                    if (detail.equals("1")) {
                        Check(6,id);
                        break;
                    } else if (detail.equals("2")) {
                        Check(7,id);
                        break;
                    }else if (detail.equals("3")) {
                        Make_training(id);
                        break;
                    }else if (detail.equals("4")) {
                        Delete_training(id);
                        break;
                    } else if (detail.equals("5")) {
                        Apply_training(id);
                        break;
                    } else if (detail.equals("6")) {
                        Cancel_training(id);
                        break;
                    } else if (detail.equals("7")) {
                        break;
                    }
                    else
                        System.out.printf("Re Enter the number: ");
                }
            }
            else if(opt == 3){
                System.out.println("Enter the option which you want to do");
                System.out.println("------------------------------------=");
                System.out.println("1. Search Match");
                System.out.println("2. View My Match");
                System.out.println("3. Apply Match");
                System.out.println("4. Cancel Match");
                System.out.println("5. Quit");
                System.out.println("------------------------------------=");
                System.out.printf("Enter the number: ");
                while(true) {
                    String detail = bf.readLine();
                    if(detail.equals("1")){
                        Check(4,id);
                        break;
                    }
                    else if (detail.equals("2")) {
                        Check(5,id);
                        break;
                    }
                    else if (detail.equals("3")) {
                        Apply_match(id);
                        break;
                    }
                    else if (detail.equals("4")) {
                        Cancel_match(id);
                        break;
                    }
                    else if (detail.equals("5")) {
                        break;
                    }
                    else
                        System.out.printf("Re Enter the number: ");
                }

            }
            else if(opt == 4){
                System.out.println("Enter the option which you want to do");
                System.out.println("------------------------------------=");
                System.out.println("1. make team"); // team_id 랜덤으로 만들어주고 team_id와 team_name을 team에 insert, temam_mem에 만든 사람 자동 삽입
                System.out.println("2. delete team"); // team, team_mem 둘 다 delete (cascade 한다면)
                System.out.println("3. apply team"); // team_mem에서 team_id와 mem_id를 delete
                System.out.println("4. cancel team"); // team_mem에서 team_id와 mem_id를 insert
                System.out.println("5. Quit");
                System.out.println("------------------------------------=");
                System.out.printf("Enter the number: ");
                while(true) {
                    String detail = bf.readLine();
                    if (detail.equals("1")) {
                        Make_team(id);
                        break;
                    } else if (detail.equals("2")) {
                        Delete_team(id);
                        break;
                    } else if (detail.equals("3")) {
                        Apply_team(id);
                        break;
                    } else if (detail.equals("4")) {
                        Cancel_team(id);
                        break;
                    }else if (detail.equals("5")) {
                        break;
                    }
                    else
                        System.out.printf("Re Enter the number: ");
                }
            }

        }
        else{
            // manager match apply
            Apply(id);
        }

    }

    public static void Make_training(String tutor_id) throws IOException, SQLException {

        Random rand = new Random(System.currentTimeMillis());
        StringBuilder sb = new StringBuilder(); // class_id
        while(true) {
            sb.append("C").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
            sb.append("-").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
            sb.append("-").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
            ResultSet rs= Selectx("*","TRAINING","where Class_id = '"+sb+"'");
            if(rs.next())
                sb.setLength(0);
            else
                break;
        }
        System.out.printf("Enter the Date_Time ex) 1998-08-31: ");
        String date_time = bf.readLine();
        System.out.printf("Enter the RECOMMEND_TIER: ");
        String rec_tier = bf.readLine();
        System.out.printf("Enter the SUBJECT: ");
        String subject = bf.readLine();
        System.out.printf("Enter the Place: ");
        String place = bf.readLine();
        System.out.printf("Enter the maximum number of tutee: ");
        String max_num = bf.readLine();
        System.out.printf("Enter the wage: ");
        String wage = bf.readLine();
        System.out.printf("Enter the cost per one: ");
        String cost = bf.readLine();
        String[] result = new String[9];
        result[0] = String.valueOf(sb);
        result[1] = date_time;
        result[2] = tutor_id;
        result[3] = rec_tier;
        result[4] = subject;
        result[5] = place;
        result[6] = max_num;
        result[7] = wage;
        result[8] = cost;
        Insertx("TRAINING", result);
        System.out.println("Training data inserted successfully!");
        System.out.println("Your Class ID is "+sb);
    }


    private static void Delete_training(String id) throws IOException {

        int iter = 0;
        int cost = 0;
        while (true) {
            if (iter == 0)
                System.out.printf("Enter the Class_ID which you want to delete (Quit for 'Q'): ");
            else
                System.out.printf("Re Enter the Class_ID which you want to delete (Quit for 'Q'): ");
            iter++;
            String Class_id = bf.readLine();
            if (Class_id.toUpperCase().equals("Q"))
                break;
            try {
                ResultSet rs = Selectx("*", "TRAINING", " where Class_id = '" + Class_id + "' and tutor_id = '" + id + "'");
                if (rs.next()) {
                    String[] key = new String[1];
                    key[0] = Class_id;
                    Deletex("TRAINING", key);
                    System.out.println("Training tuple deleted successfully!");
                    String[] key2 = new String[2];
                    key2[0] = Class_id;
                    ResultSet rs1 = Selectx("tutee_ID", "TRAIN_ENROLLS", "where class_id = '" + Class_id + "'");
                    cost = rs.getInt("COST_PER_ONE");
                    while (rs1.next()) {
                        key2[1] = rs1.getString("tutee_id");

                        String updatePrepaidMoneyQuery = "UPDATE member SET prepaid_money = prepaid_money + ? WHERE id_number = ?";

                        // 2. PrepareStatement 객체 생성
                        try (PreparedStatement updatePrepaidMoneyStmt = ProjectMain.conn.prepareStatement(updatePrepaidMoneyQuery)) {
                            // 3. PreparedStatement에 매개변수 할당
                            updatePrepaidMoneyStmt.setInt(1, cost);
                            updatePrepaidMoneyStmt.setString(2, key2[1]);

                            // 4. prepaid_money 갱신 실행
                            int updateResult = updatePrepaidMoneyStmt.executeUpdate();
                            Deletex("TRAIN_ENROLLS", key2);
                        }
                    }
                }
                else{
                    System.out.println("You are not Tutor of this Class");
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    private static void Apply_training(String id) throws IOException, SQLException {

        int iter = 0;
        int maxNum = 0;
        int nowNum = 0;
        int cost = 0;
        while (true) {
            if (iter == 0)
                System.out.printf("Enter the Class_ID which you want to apply (Quit for 'Q'): ");
            else
                System.out.printf("Re Enter the Class_ID which you want to apply (Quit for 'Q'): ");
            String Class_id = bf.readLine();
            iter++;
            if (Class_id.toUpperCase().equals("Q"))
                break;
            ResultSet rs = Selectx("MAX_NUM", "TRAINING", "where CLASS_ID = '" + Class_id + "'");
            ResultSet rs1 = Selectx("COUNT(CLASS_ID)", "TRAIN_ENROLLS", "where CLASS_ID = '" + Class_id + "'");
            ResultSet rs2 = Selectx("COST_PER_ONE", "TRAINING","where CLASS_ID = '"+Class_id+"'");

            if (rs.next()) {
                maxNum = rs.getInt("MAX_NUM");
                if (rs1.next()) {
                    nowNum = rs1.getInt("COUNT(CLASS_ID)");
                    if (maxNum <= nowNum) {
                        System.out.println("The Training you chosen is full");
                        continue;
                    }
                } else
                    nowNum = 0;

                if(rs2.next())
                    cost = rs2.getInt("COST_PER_ONE");
                // 1. 멤버의 prepaid_money를 갱신하는 쿼리를 PreparedStatement로 작성
                rs = Selectx("PREPAID_MONEY", "MEMBER", "WHERE ID_NUMBER = '"+ id +"'");
                rs.next();
                int pm = rs.getInt(1);
                if(pm < cost) {
                    System.out.println("You don't have enough money, please Charge first");
                    break;
                }
                // 1. 멤버의 prepaid_money를 갱신하는 쿼리를 PreparedStatement로 작성
                String updatePrepaidMoneyQuery = "UPDATE member SET prepaid_money = prepaid_money - ? WHERE id_number = ?";

                // 2. PrepareStatement 객체 생성
                try (PreparedStatement updatePrepaidMoneyStmt = ProjectMain.conn.prepareStatement(updatePrepaidMoneyQuery)) {
                    // 3. PreparedStatement에 매개변수 할당
                    updatePrepaidMoneyStmt.setInt(1, cost);
                    updatePrepaidMoneyStmt.setString(2, id);

                    // 4. prepaid_money 갱신 실행
                    int updateResult = updatePrepaidMoneyStmt.executeUpdate();

                    if (updateResult > 0) {
                        String[] data = new String[2];
                        data[0] = Class_id;
                        data[1] = id;
                        Insertx("TRAIN_ENROLLS", data); // 어차피 여기서 한번에 commit
                        System.out.println("Training is successfully applied!");
                        break;

                    }
                }
            }
            else{
                System.out.println("The Training ID you entered does not exist.");
            }
        }
    }
    private static void Cancel_training(String id) throws IOException, SQLException {
        try {

            int cost = 0;
            int iter = 0;
            while (true) {
                if (iter == 0)
                    System.out.printf("Enter the Class_ID which you want to cancel (Quit for 'Q'): ");
                else
                    System.out.printf("Re Enter the Class_ID which you want to cancel (Quit for 'Q'): ");
                String Class_id = bf.readLine();
                iter++;
                if (Class_id.toUpperCase().equals("Q"))
                    break;
                ResultSet rs = Selectx("*", "TRAIN_ENROLLS", "where CLASS_ID = '" + Class_id + "' and tutee_id = '" + id + "'");
                ResultSet rs1 = Selectx("COST_PER_ONE", "TRAINING", "where CLASS_ID = '" + Class_id + "'");

                if (rs1.next())
                    cost = rs1.getInt("COST_PER_ONE");
                // 1. 멤버의 prepaid_money를 갱신하는 쿼리를 PreparedStatement로 작성
                String updatePrepaidMoneyQuery = "UPDATE member SET prepaid_money = prepaid_money + ? WHERE id_number = ?";

                // 2. PrepareStatement 객체 생성
                try (PreparedStatement updatePrepaidMoneyStmt = ProjectMain.conn.prepareStatement(updatePrepaidMoneyQuery)) {
                    // 3. PreparedStatement에 매개변수 할당
                    updatePrepaidMoneyStmt.setInt(1, cost);
                    updatePrepaidMoneyStmt.setString(2, id);

                    // 4. prepaid_money 갱신 실행
                    int updateResult = updatePrepaidMoneyStmt.executeUpdate();

                    if (rs.next()) {
                        String[] key = new String[2];
                        key[0] = Class_id;
                        key[1] = id;
                        Deletex("TRAIN_ENROLLS", key);

                        System.out.println("Training cancellation successful!");
                        break;
                    } else {
                        System.out.println("You are not tutee of this training");
                    }
                }
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    private static void Apply_match(String id) throws SQLException, IOException {
        try {
            int iter = 0;
            int cost = 0;
            int maxNum = 0;
            int nowNum = 0;
            String sexCon;

            while(true) {
                if (iter == 0)
                    System.out.printf("Enter the Match_ID which you want to apply (Quit for q): ");
                else
                    System.out.printf("Re Enter the Match_ID which you want to apply (Quit for q):");

                String match_id = bf.readLine().trim(); // 공백 제거
                if(match_id.toUpperCase().equals("Q"))
                    break;
                iter++;

                ResultSet rs = Selectx("M.MATCH_ID, M.COST_PER_ONE, M.MAX_NUM, M.SEX_CONSTRAINT, X.CNT",
                        "MATCH M LEFT OUTER JOIN (SELECT MATCH_ID, COUNT(MEMBER_ID) AS CNT FROM MATCH_APP_MEMBER GROUP BY MATCH_ID) X ON M.MATCH_ID = X.MATCH_ID",
                        "where M.Match_ID = '"+match_id+"'");

                if(rs.next()) {
                    cost = rs.getInt("COST_PER_ONE");
                    maxNum = rs.getInt("MAX_NUM");
                    sexCon = rs.getString("SEX_CONSTRAINT");
                    nowNum = rs.getInt("CNT");
                } else {
                    System.out.println("The match ID you entered does not exist.");
                    continue;
                }

                rs = Selectx("PREPAID_MONEY", "MEMBER", "WHERE ID_NUMBER = '"+ id +"'");
                rs.next();
                int pm = rs.getInt(1);
                if(pm < cost) {
                    System.out.println("You don't have enough money, please Charge first");
                    break;
                }
                if(nowNum == maxNum) {
                    System.out.println("Match is already full");
                    break;
                }
                rs = Selectx("SEX", "USERS", "WHERE ID_NUMBER = '"+ id +"'");
                rs.next();
                String sex = rs.getString(1);
                if(!sex.equals(sexCon)){
                    System.out.println("You cannot satisfy sex constraint");
                    break;
                }

                String updatePrepaidMoneyQuery = "UPDATE member SET prepaid_money = prepaid_money - ? WHERE id_number = ?";

                try (PreparedStatement updatePrepaidMoneyStmt = ProjectMain.conn.prepareStatement(updatePrepaidMoneyQuery)) {
                    updatePrepaidMoneyStmt.setInt(1, cost);
                    updatePrepaidMoneyStmt.setString(2, id);

                    int updateResult = updatePrepaidMoneyStmt.executeUpdate();

                    if (updateResult > 0) {
                        String[] key = new String[2];
                        key[0] = match_id;
                        key[1] = id;
                        Insertx("MATCH_APP_MEMBER", key);

                        System.out.println("Apply Match successful!");
                        break;
                    } else {
                        System.out.println("Error applying match: Failed to update prepaid_money for member " + id);
                    }
                }
            }
        } catch (IOException | SQLException e) {
            System.err.println("Error Apply Match: " + e.getMessage());
        }
    }

    private static void Cancel_match(String id) {
        try {

            int cost = 0;
            int iter = 0;
            while (true) {
                if (iter == 0)
                    System.out.printf("Enter the Match_ID which you want to cancel (Quit for q): ");
                else
                    System.out.printf("Re Enter the Match_ID which you want to cancel (Quit for q):");
                String match_id = bf.readLine();
                if (match_id.toUpperCase().equals("Q"))
                    break;
                iter++;
                ResultSet rs = Selectx("M.COST_PER_ONE",
                        "MATCH M JOIN MATCH_APP_MEMBER MA ON M.MATCH_ID = MA.MATCH_ID",
                        "WHERE M.MATCH_ID = '" + match_id + "' AND MA.MEMBER_ID = '" + id + "'");

                if (rs.next()) {
                    cost = rs.getInt("COST_PER_ONE");
                    // 멤버의 prepaid_money를 갱신하는 쿼리를 PreparedStatement로 작성
                    String updatePrepaidMoneyQuery = "UPDATE member SET prepaid_money = prepaid_money + ? WHERE id_number = ?";

                    // PrepareStatement 객체 생성
                    try (PreparedStatement updatePrepaidMoneyStmt = ProjectMain.conn.prepareStatement(updatePrepaidMoneyQuery)) {
                        // PreparedStatement에 매개변수 할당
                        updatePrepaidMoneyStmt.setInt(1, cost);
                        updatePrepaidMoneyStmt.setString(2, id);

                        // prepaid_money 갱신 실행
                        int updateResult = updatePrepaidMoneyStmt.executeUpdate();

                        if (updateResult > 0) {
                            // prepaid_money 갱신이 성공하면 MATCH_APP_MEMBER의 데이터 제거
                            String[] key = new String[2];
                            key[0] = match_id;
                            key[1] = id;
                            Deletex("MATCH_APP_MEMBER", key);
                            System.out.println("Cancel Match successful!");
                        } else {
                            System.out.println("Error applying match: Failed to update prepaid_money for member " + id);
                        }
                    }
                }
                else
                    System.out.println("You are not the member of this match");
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private static void Apply(String id) throws SQLException {
        try {

            int i = 0;
            String match_id;
            while (true) {
                if (i == 0) {
                    System.out.print("Enter the Match_ID which you want to apply (Enter 'Q' for Quit): ");
                } else {
                    System.out.print("Re-Enter the Match_ID which you want to apply (Enter 'Q' for Quit): ");
                }
                match_id = bf.readLine();

                if (match_id.toUpperCase().equals("Q")) {
                    break;
                } else {
                    // 수정된 SQL 쿼리 조건 구문
                    ResultSet rs = Selectx("*", "MATCH", "WHERE MATCH_ID = '" + match_id + "' AND MANAGER_ID IS NULL");

                    // 무결성 제약 조건 위배 해결
                    if (rs.next()) {
                        String updatePrepaidMoneyQuery = "UPDATE MATCH SET MANAGER_ID = ? WHERE MATCH_ID = ?";
                        try (PreparedStatement updatePrepaidMoneyStmt = ProjectMain.conn.prepareStatement(updatePrepaidMoneyQuery)) {
                            updatePrepaidMoneyStmt.setString(1, id);
                            updatePrepaidMoneyStmt.setString(2, match_id);
                            updatePrepaidMoneyStmt.executeUpdate();
                            ProjectMain.conn.commit();

                            System.out.println("Apply Match successful!");
                            break;
                        }
                    }
                    else{
                        System.out.println("This match is already applied!");
                    }
                    i++;
                }
            }
        } catch (IOException | SQLException e) {
            System.err.println("Error Apply Match: " + e.getMessage());
        }
    }
    private static void Make_team(String id) throws IOException, SQLException {

        Random rand = new Random(System.currentTimeMillis());
        StringBuilder sb = new StringBuilder(); // class_id
        while(true){
            sb.append("T").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
            sb.append("-").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
            sb.append("-").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
            ResultSet rs= Selectx("*","TEAM","where team_id = '"+sb+"'");
            if(rs.next())
                sb.setLength(0);
            else
                break;
        }

        String team_id = sb.toString();

        System.out.printf("Enter the Team name : ");
        String team_name = bf.readLine();
        String[] key = new String[2];
        key[0]=team_id;
        key[1]=team_name;
        Insertx("TEAM",key);


        String[] key2 = new String[2];
        key2[0] = sb.toString();
        key2[1] = id;
        System.out.println(key2[0]);
        System.out.println(key2[1]);

        Insertx("TEAM_MEM",key2);
        System.out.println("Team data inserted successfully!");
        System.out.println("Your Team ID is "+sb);
    }
    private static void Delete_team(String id) throws IOException {
        int condition = 0;
        System.out.printf("Enter the Team_ID which you want to delete: ");
        String team_id = bf.readLine();
        try {
            // 첫 번째 쿼리 실행
            ResultSet rs = Selectx("COUNT(mem_id)", "TEAM_MEM", "where team_id = '" + team_id + "'");
            if (rs.next()) {
                condition = rs.getInt(1); // 첫 번째 컬럼의 값을 가져옵니다.
            }

            // 팀에 멤버가 한 명만 있는지 확인
            if (condition == 1) {
                // 두 번째 쿼리 실행
                ResultSet rs1 = Selectx("mem_id", "TEAM_MEM", "where team_id = '" + team_id + "'");
                if (rs1.next()) {
                    String mem_id = rs1.getString(1); // 첫 번째 컬럼의 값을 가져옵니다.

                    // TEAM_MEM 테이블에서 해당 팀 삭제
                    String[] key2 = {team_id, mem_id};
                    Deletex("TEAM_MEM", key2);

                    // TEAM 테이블에서 해당 팀 삭제
                    String[] key = {team_id};
                    Deletex("TEAM", key);

                    System.out.println("Delete team successfully!");
                }
            } else {
                System.out.println("You can't delete it because members still exists in the team.");
            }
        } catch (SQLException e) {
            System.err.println("Error deleting team tuple: " + e.getMessage());
        }
    }

    private static void Apply_team(String id) throws IOException {

        System.out.println("Enter the Team_ID which you want to apply: ");
        String team_id = bf.readLine();
        String[] key2 = new String[2];
        key2[0] = team_id;
        key2[1] = id;
        Insertx("TEAM_MEM",key2);
        System.out.println("Apply team successfully!");
    }
    private static void Cancel_team(String id) throws IOException {
        try {

            System.out.printf("Enter the Team ID which you want to cancel: ");
            String team_id = bf.readLine();

            String[] key = new String[2];
            key[0] = team_id;
            key[1] = id;
            Deletex("TEAM_MEM", key);

            System.out.println("Team cancellation successful!");
        } catch (IOException e) {
            System.err.println("Error canceling training: " + e.getMessage());
        }
    }

    private static void Check(int opt, String id) throws IOException {
        try {

            switch (opt) {
                case 1: // Member의 자기 정보 및 캐시 정보 조회 P2_3.2.2

                    String attr = "U.*, M.PREPAID_MONEY, MV.TIER";
                    String tbl = "USERS U, MEMBER M, MEMBER_EVAL_VIEW MV";
                    String where = "U.ID_NUMBER = M.ID_NUMBER and U.ID_NUMBER = MV.MEM_ID and U.ID_NUMBER = '" + id + "'";
                    ResultSet rsMember = SQLx.Selectx(attr, tbl, where, "");
                    if (rsMember.next()) {
                        System.out.println("Member Information:");
                        System.out.println("ID: " + rsMember.getString("ID_NUMBER"));
                        System.out.println("Name: " + rsMember.getString("NAME"));
                        System.out.println("Sex: " + rsMember.getString("SEX"));
                        System.out.println("Year of Birth: " + rsMember.getString("YOB"));
                        System.out.println("Job: " + rsMember.getString("JOB"));
                        System.out.println("Cash: " + rsMember.getString("PREPAID_MONEY"));
                        System.out.println("Evaluation Tier: " + rsMember.getString("TIER"));
                        // 다른 필요한 멤버 정보 추가
                    } else {
                        System.out.println("No member information available.");
                    }
                    rsMember.close();
                    break;

                case 2: // Manager의 자기 정보 조회 P2_3.7.1
                    ResultSet rsManager = Selectx("*", "USERS U INNER JOIN MANAGER M ON U.ID_NUMBER = M.ID_NUMBER", "U.ID_NUMBER = '" + id + "'", "");
                    if (rsManager.next()) {
                        System.out.println("Manager Information:");
                        System.out.println("ID: " + rsManager.getString("ID_NUMBER"));
                        System.out.println("Name: " + rsManager.getString("NAME"));
                        System.out.println("Sex: " + rsManager.getString("SEX"));
                        System.out.println("Year of Birth: " + rsManager.getString("YOB"));
                        System.out.println("Job: " + rsManager.getString("JOB"));
                        System.out.println("Bank Account: " + rsManager.getString("BANK_ACCOUNT"));
                    } else {
                        System.out.println("No manager information available.");
                    }
                    rsManager.close();

                    // 매니저가 참여하고 있는 매치 정보 조회
                    String matchQuery = "SELECT * FROM MATCH WHERE MANAGER_ID = '" + id + "'";
                    try {
                        PreparedStatement matchStmt = ProjectMain.conn.prepareStatement(matchQuery);
                        ResultSet rsMatch = matchStmt.executeQuery();
                        System.out.println("Manager's Matches:");
                        while (rsMatch.next()) {
                            System.out.println("Match ID: " + rsMatch.getString("MATCH_ID"));
                            System.out.println("Date and Time: " + rsMatch.getDate("DATE_TIME").toString());
                            System.out.println("Place ID: " + rsMatch.getString("PLACE_ID"));
                            System.out.println("Type: " + rsMatch.getString("TYPE"));
                            System.out.println("Max Participants: " + rsMatch.getInt("MAX_NUM"));
                            System.out.println("Sex Constraint: " + rsMatch.getString("SEX_CONSTRAINT"));
                            System.out.println("Wage: " + rsMatch.getInt("WAGE"));
                            System.out.println("Cost per Person: " + rsMatch.getInt("COST_PER_ONE"));
                            System.out.println("----------------------------------------------------");
                        }
                        rsMatch.close();
                    } catch (SQLException e) {
                        System.err.println("Error retrieving manager's match information: " + e.getMessage());
                    }
                    break;

                case 3: // Member가 속한 Team 조회 P2_3.7.2
                    String attrT = "T.TEAM_NAME, E.TEAM_TIER";
                    String atlT = "TEAM T INNER JOIN TEAM_MEM TM ON T.TEAM_ID = TM.TEAM_ID LEFT JOIN TEAM_EVAL_VIEW E ON T.TEAM_ID = E.TEAM_ID";
                    String whereT = "TM.MEM_ID = '" + id + "'";
                    ResultSet rsTeam = SQLx.Selectx(attrT, atlT, whereT, "");
                    if(!rsTeam.next()) {
                        System.out.println("No team information available.");
                        break;
                    }
                    while (rsTeam.next()) {
                        System.out.println("Team Information:");
                        System.out.println("Team Name: " + rsTeam.getString("TEAM_NAME"));
                        System.out.println("Team Tier: " + rsTeam.getString("TEAM_TIER"));
                        // 필요한 팀 정보 추가
                    }
                    rsTeam.close();
                    break;

                case 4: // Time/Place에 따른 Match 검색 P2_3.10.1
                    System.out.printf("Enter the date you want to know: ");
                    String time = bf.readLine();
                    System.out.printf("Enter the place you want to know: ");
                    String place = bf.readLine();
                    String sqlQuery = "SELECT M.*, F.NAME FROM MATCH M " +
                            "INNER JOIN FIELD F ON M.PLACE_ID = F.FIELD_ID " +
                            "WHERE M.MATCH_ID IN (" +
                            "    (SELECT DISTINCT MATCH_ID " +
                            "     FROM MATCH M1 " +
                            "     WHERE M1.DATE_TIME = '" + time + "')" +
                            "    INTERSECT " +
                            "    (SELECT DISTINCT M2.MATCH_ID " +
                            "     FROM MATCH M2 " +
                            "     WHERE M2.PLACE_ID IN (" +
                            "         SELECT FIELD_ID " +
                            "         FROM FIELD " +
                            "         WHERE FIELD.ADDRESS LIKE '%" + place + "%' ))" +
                            ") AND M.MATCH_ID IN (SELECT MATCH_ID FROM MATCH_EVAL_VIEW)";
                    try {
                        PreparedStatement stmt = ProjectMain.conn.prepareStatement(sqlQuery);
                        ResultSet rsMatch = stmt.executeQuery();
                        int row = 1;
                        if(rsMatch.next()) {
                            System.out.printf("%-3s | %-15s | %-15s | %-20s | %-5s | %-7s | %-15s | %-12s\n",
                                    "ROW", "MATCH_ID", "TIME", "PLACE", "TYPE", "MAX_NUM", "SEX_CONSTRAINT", "COST_PER_ONE");
                            System.out.println("---------------------------------------------------------------------------------------------------------------");

                            System.out.printf("%-3d | %-15s | %-15s | %-20s | %-5s | %-7s | %-15s | %-12s\n",
                                    row, rsMatch.getString(1), rsMatch.getDate(2).toString(), rsMatch.getString("NAME"),
                                    rsMatch.getString(4), rsMatch.getString(5), rsMatch.getString(6), rsMatch.getString(9));
                            row++;
                            while (rsMatch.next()) {
                                System.out.printf("%-3d | %-15s | %-15s | %-20s | %-5s | %-7s | %-15s | %-12s\n",
                                        row, rsMatch.getString(1), rsMatch.getDate(2).toString(), rsMatch.getString("NAME"),
                                        rsMatch.getString(4), rsMatch.getString(5), rsMatch.getString(6), rsMatch.getString(9));
                                row++;
                            }
                        }
                        else {
                            System.out.println("No match exists for the selected date and place.");
                        }
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                    break;
                case 5: // P2_3.6.1 자기가 속한 Match의 list 출력
                    String sqlQuery2 ="SELECT m.*, f.NAME\n" +
                            "FROM MATCH m\n" +
                            "         INNER JOIN FIELD f ON m.PLACE_ID = f.FIELD_ID\n" +
                            "WHERE m.MATCH_ID IN (\n" +
                            "    SELECT mm.MATCH_ID\n" +
                            "    FROM MATCH_APP_MEMBER mm\n" +
                            "    WHERE mm.MEMBER_ID = '" + id +"')" +
                            " ORDER BY DATE_TIME DESC";
                    try{
                        PreparedStatement stmt = ProjectMain.conn.prepareStatement(sqlQuery2);
                        ResultSet rsMatch = stmt.executeQuery();
                        int row = 1;
                        if(rsMatch.next()) { System.out.printf("%-3s | %-15s | %-15s | %-20s | %-5s | %-7s | %-15s | %-12s\n",
                                "ROW", "MATCH_ID", "TIME", "PLACE", "TYPE", "MAX_NUM", "SEX_CONSTRAINT", "COST_PER_ONE");
                            System.out.println("---------------------------------------------------------------------------------------------------------------==");

                            System.out.printf("%-3d | %-15s | %-15s | %-20s | %-5s | %-7s | %-15s | %-12s\n",
                                    row, rsMatch.getString(1), rsMatch.getDate(2).toString(), rsMatch.getString("NAME"),
                                    rsMatch.getString(4), rsMatch.getString(5), rsMatch.getString(6), rsMatch.getString(9));
                            row++;
                            while (rsMatch.next()) {
                                System.out.printf("%-3d | %-15s | %-15s | %-20s | %-5s | %-7s | %-15s | %-12s\n",
                                        row, rsMatch.getString(1), rsMatch.getDate(2).toString(), rsMatch.getString("NAME"),
                                        rsMatch.getString(4), rsMatch.getString(5), rsMatch.getString(6), rsMatch.getString(9));
                                row++;

                            }
                        }                        else
                            System.out.println("No match exists.");
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                    break;
                case 6: // P2_3.5.1
                    String sqlQuery3  = "SELECT T.CLASS_ID, T.DATE_TIME, U.NAME, T.RECOMMEND_TIER, T.SUBJECT, T.PLACE, T.COST_PER_ONE\n" +
                            "FROM USERS U INNER JOIN (" +
                            "    SELECT * " +
                            "    FROM TRAINING TX" +
                            "    WHERE EXISTS( " +
                            "        SELECT * " +
                            "        FROM (" +
                            "            SELECT class_id" +
                            "            FROM train_enrolls TE" +
                            "            WHERE TE.tutee_id = '"+id+"') X\n" +
                            "        WHERE TX.CLASS_ID = X.CLASS_ID)) T ON U.ID_NUMBER = T.TUTOR_ID";

                    try{
                        PreparedStatement stmt = ProjectMain.conn.prepareStatement(sqlQuery3);
                        ResultSet rsTraining = stmt.executeQuery();
                        int row = 1;
                        if(rsTraining.next()) { System.out.printf("%-3s | %-15s | %-15s | %-20s | %-17s | %-12s | %-25s | %-12s\n",
                                "ROW", "CLASS_ID", "TIME", "TUTOR_NAME", "RECOMMEND_TIER", "SUBJECT", "PLACE", "COST_PER_ONE");
                            System.out.println("------------------------------------------------------------------------------------------------------------------------------------------------=");

                            System.out.printf("%-3d | %-15s | %-15s | %-20s | %-17s | %-12s | %-25s | %-12s\n",
                                    row, rsTraining.getString(1), rsTraining.getDate(2).toString(), rsTraining.getString(3),
                                    rsTraining.getString(4), rsTraining.getString(5), rsTraining.getString(6), rsTraining.getString(7));
                            row++;
                            while (rsTraining.next()) {
                                System.out.printf("%-3d | %-15s | %-15s | %-20s | %-17s | %-12s | %-25s | %-12s\n",
                                        row, rsTraining.getString(1), rsTraining.getDate(2).toString(), rsTraining.getString(3),
                                        rsTraining.getString(4), rsTraining.getString(5), rsTraining.getString(6), rsTraining.getString(7));

                            }
                        }
                        else
                            System.out.println("No Training exists.");
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                    break;
                case 7:
                    System.out.printf("Enter the subject name which you want to search: ");
                    String subject = bf.readLine();
                    System.out.printf("Enter the recommended tier which you want to search: ");
                    String re_tier = bf.readLine();
                    String sqlQuery4 = "SELECT T.CLASS_ID, T.DATE_TIME, U.NAME, T.RECOMMEND_TIER, T.SUBJECT, T.PLACE, T.COST_PER_ONE\n" +
                            "FROM USERS U INNER JOIN (\n" +
                            "    select *\n" +
                            "    from training TX\n" +
                            "    WHERE TX.CLASS_ID IN (\n" +
                            "        (SELECT DISTINCT CLASS_ID\n" +
                            "         FROM TRAINING T1\n" +
                            "        WHERE T1.SUBJECT = '"+ subject + "') " +
                            "    INTERSECT\n" +
                            "        (SELECT DISTINCT T2.CLASS_ID\n" +
                            "        FROM TRAINING T2\n" +
                            "        WHERE T2.RECOMMEND_TIER = '"+re_tier+"'))) T ON U.ID_NUMBER = T.TUTOR_ID\n" +
                            "order by T.DATE_TIME";
                    try {
                        PreparedStatement stmt = ProjectMain.conn.prepareStatement(sqlQuery4);
                        ResultSet rsTraining_search = stmt.executeQuery();
                        int row = 1;
                        if (rsTraining_search.next()) {
                            System.out.printf("%-3s | %-15s | %-15s | %-20s | %-17s | %-12s | %-25s | %-12s\n",
                                    "ROW", "CLASS_ID", "TIME", "TUTOR_NAME", "RECOMMEND_TIER", "SUBJECT", "PLACE", "COST_PER_ONE");
                            System.out.println("------------------------------------------------------------------------------------------------------------------------------------------------=");

                            System.out.printf("%-3d | %-15s | %-15s | %-20s | %-17s | %-12s | %-25s | %-12s\n",
                                    row, rsTraining_search.getString(1), rsTraining_search.getDate(2).toString(), rsTraining_search.getString(3),
                                    rsTraining_search.getString(4), rsTraining_search.getString(5), rsTraining_search.getString(6), rsTraining_search.getString(7));
                            row++;
                            while (rsTraining_search.next()) {
                                System.out.printf("%-3d | %-15s | %-15s | %-20s | %-17s | %-12s | %-25s | %-12s\n",
                                        row, rsTraining_search.getString(1), rsTraining_search.getDate(2).toString(), rsTraining_search.getString(3),
                                        rsTraining_search.getString(4), rsTraining_search.getString(5), rsTraining_search.getString(6), rsTraining_search.getString(7));
                                row++;
                            }
                        } else {
                            System.out.println("No Training exists.");
                        }
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }

                    break;


            }
        } catch (SQLException e) {
            System.out.println("Database error occurred.");
            e.printStackTrace();
        }
    }
}