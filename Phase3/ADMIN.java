package Phase3;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;
import java.util.StringTokenizer;

public class ADMIN {
    protected static void Screen(int option) throws IOException, SQLException {
        // opt = 1. user, 2. team, 3. owner, 4. field, 5.match, 6. training
        System.out.println("----------------------------------------------------");
        System.out.println("Admin Screen for management");
        while (true){
            System.out.println("----------------------------------------------------");
            System.out.println("1. Update");
            System.out.println("2. Delete");
            if(option == 3 || option == 4 || option == 5){
                System.out.println("3. Insert");
                System.out.println("4. Back to Menu");
            }
            else System.out.println("3. Back to Menu");
            System.out.println("----------------------------------------------------");
            System.out.print("Enter the number : ");
            int opt = Integer.parseInt(ProjectMain.bf.readLine());
            if(option == 3 || option == 4 || option == 5){
                switch (opt){
                    case 1 : Update(option); break;
                    case 2 : Delete(option); break;
                    case 3 : Insert(option); break;
                    case 4 : return;
                    default: System.out.println("Wrong number!, Re-enter");
                }
            }
            else {
                switch (opt) {
                    case 1: Update(option); break;
                    case 2: Delete(option); break;
                    case 3: return;
                    default: System.out.println("Wrong number!, Re-enter");
                }
            }
        }
    }
    public static void Insert(int opt) throws IOException, SQLException {
        String[] data;
        ResultSet rs;
        Random rand = new Random(System.currentTimeMillis());
        StringBuilder sb = new StringBuilder();
        switch (opt){
            case 3 :
                data = new String[2];
                System.out.print("Input new Owner's Phone number : ");
                data[0] = ProjectMain.bf.readLine();
                System.out.print("Input new Owner's name : ");
                data[1] = ProjectMain.bf.readLine();
                SQLx.Insertx("OWNER", data);
                break;
            case 4 :
                data = new String[5];
                System.out.print("Input Owner's Phone number : ");
                data[3] = ProjectMain.bf.readLine();
                rs = SQLx.Selectx("OWNER_HP", "OWNER", "WHERE OWNER_HP = \'" + data[3]+"\'");
                rs.last();
                if(rs.getRow()==0){
                    System.out.println("There is no Owner info, please add the Owner info first");
                    return;
                }
                while (true){
                    sb.append("F").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
                    sb.append("-").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
                    sb.append("-").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
                    rs = SQLx.Selectx("FIELD_ID", "FIELD", "WHERE FIELD_ID = \'" + sb +"\'");
                    rs.last();
                    if(rs.getRow()==0) {
                        data[0] = sb.toString();
                        break;
                    }
                }
                System.out.print("Input Field's name: ");
                data[1] = ProjectMain.bf.readLine();
                System.out.print("Input Field's Phone number: ");
                data[2] = ProjectMain.bf.readLine();
                System.out.print("Input Field's Address: ");
                data[4] = ProjectMain.bf.readLine();
                SQLx.Insertx("FIELD", data);
                break;
            case 5 :
                data = new String[9];
                System.out.print("Input PlaceID to hold Match  : ");
                data[2] = ProjectMain.bf.readLine();
                rs = SQLx.Selectx("FIELD_ID", "FIELD", "WHERE FIELD_ID = \'" + data[2]+"\'");
                rs.last();
                if(rs.getRow()==0){
                    System.out.println("There is no PlaceID, please add the Field info first");
                    return;
                }
                while (true){
                    sb.append("M").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
                    sb.append("-").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
                    sb.append("-").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
                    rs = SQLx.Selectx("MATCH_ID", "MATCH", "WHERE MATCH_ID = \'" + sb +"\'");
                    rs.last();
                    if(rs.getRow()==0) {
                        data[0] = sb.toString();
                        break;
                    }
                }
                System.out.print("Input when the Match holds : ");
                data[1] = ProjectMain.bf.readLine();
                System.out.print("Input Match Type (Futsal = \'F\', Soccer = \'S\') : ");
                data[3] = ProjectMain.bf.readLine().toUpperCase();
                System.out.print("Input Maximum People number of Match : ");
                data[4] = ProjectMain.bf.readLine();
                System.out.print("Input Sex Constraint of Match (Male only = \'M\', Female Only = \'F\', Everyone able = \'A\') : ");
                data[5] = ProjectMain.bf.readLine().toUpperCase();
                data[6]= "NULL";
                System.out.print("Input Manger's Wage of Match : ");
                data[7] = ProjectMain.bf.readLine();
                System.out.print("Input Cost per Person of Match : ");
                data[8] = ProjectMain.bf.readLine();
                SQLx.Insertx("MATCH", data);
                break;
        }
    }
    private static void Update(int opt) throws IOException, SQLException {
        String[] tbls = {"USERS", "TEAM", "OWNER", "FIELD", "MATCH", "TRAINING"};
        String[] key = new String[1];
        String[] attr;
        ResultSet rs;
        int target;
        String value;
        switch (opt){
            case 1 :
                attr = new String[6];
                attr[0] = "ID_NUMBER";
                attr[1] = "NAME";
                attr[2] = "SEX";
                attr[3] = "YOB";
                attr[4] = "JOB";
                attr[5] = "PASSWD";
                System.out.print("input target user id number : ");
                key[0] = ProjectMain.bf.readLine().toUpperCase().toUpperCase();
                rs = SQLx.Selectx("*", tbls[opt-1], attr[0] + " = '" + key[0] + "'", "");
                rs.last();
                if(rs.getRow()==0){
                    System.out.printf("There is no %s : %s\n", attr[0], key[0]);
                    return;
                }
                System.out.println("attribute ");
                System.out.printf("1. %s 2. %s 3. %s \n", attr[0], attr[1], attr[2]);
                System.out.printf("4. %s 5. %s 6. %s \n", attr[3], attr[4], attr[5]);
                System.out.println("any other number. exit ");
                System.out.print("input target attribute number(only 1) : ");
                target = Integer.parseInt(ProjectMain.bf.readLine());
                if(target<1 || target>6) return;
                System.out.printf("selected attribute : %s\n", attr[target-1]);
                System.out.printf("now value : %s\n", rs.getString(target));
                System.out.print("input new value : ");
                value = ProjectMain.bf.readLine();
                SQLx.Updatex(tbls[opt-1], attr[target-1], value, key);
                break;
            case 2 :
                attr = new String[2];
                attr[0] = "TEAM_ID";
                attr[1] = "TEAM_NAME";
                System.out.print("input target team id number : ");
                key[0] = ProjectMain.bf.readLine().toUpperCase();
                rs = SQLx.Selectx("*", tbls[opt-1], attr[0] + " = '" + key[0] + "'", "");
                rs.last();
                if(rs.getRow()==0){
                    System.out.printf("There is no %s : %s\n", attr[0], key[0]);
                    return;
                }
                System.out.println("attribute ");
                System.out.printf("1. %s 2. %s \n", attr[0], attr[1]);
                System.out.println("any other number. exit ");
                System.out.print("input target attribute number(only 1) : ");
                target = Integer.parseInt(ProjectMain.bf.readLine());
                if(target<1 || target>2) return;
                System.out.printf("selected attribute : %s\n", attr[target-1]);
                System.out.printf("now value : %s\n", rs.getString(target));
                System.out.print("input new value : ");
                value = ProjectMain.bf.readLine();
                SQLx.Updatex(tbls[opt-1], attr[target-1], value, key);
                break;
            case 3 :
                attr = new String[2];
                attr[0] = "OWNER_HP";
                attr[1] = "NAME";
                System.out.print("input target owner telephone number : ");
                key[0] = ProjectMain.bf.readLine().toUpperCase();
                rs = SQLx.Selectx("*", tbls[opt-1], attr[0] + " = '" + key[0] + "'", "");
                rs.last();
                if(rs.getRow()==0){
                    System.out.printf("There is no %s : %s\n", attr[0], key[0]);
                    return;
                }
                System.out.println("attribute ");
                System.out.printf("1. %s 2. %s \n", attr[0], attr[1]);
                System.out.println("any other number. exit ");
                System.out.print("input target attribute number(only 1) : ");
                target = Integer.parseInt(ProjectMain.bf.readLine());
                if(target<1 || target>2) return;
                System.out.printf("selected attribute : %s\n", attr[target-1]);
                System.out.printf("now value : %s\n", rs.getString(target));
                System.out.print("input new value : ");
                value = ProjectMain.bf.readLine();
                SQLx.Updatex(tbls[opt-1], attr[target-1], value, key);
                break;
            case 4 :
                attr = new String[5];
                attr[0] = "FIELD_ID";
                attr[1] = "NAME";
                attr[2] = "FIELD_HP";
                attr[3] = "OWNER_HP";
                attr[4] = "ADDRESS";
                System.out.print("input target field id number : ");
                key[0] = ProjectMain.bf.readLine().toUpperCase();
                rs = SQLx.Selectx("*", tbls[opt-1], attr[0] + " = '" + key[0] + "'", "");
                rs.last();
                if(rs.getRow()==0){
                    System.out.printf("There is no %s : %s\n", attr[0], key[0]);
                    return;
                }
                System.out.println("attribute ");
                System.out.printf("1. %s 2. %s 3. %s ", attr[0], attr[1], attr[2]);
                System.out.printf("4. %s 5. %s\n", attr[3], attr[4]);
                System.out.println("any other number. exit ");
                System.out.print("input target attribute number(only 1) : ");
                target = Integer.parseInt(ProjectMain.bf.readLine());
                if(target<1 || target>5) return;
                System.out.printf("selected attribute : %s\n", attr[target-1]);
                System.out.printf("now value : %s\n", rs.getString(target));
                System.out.print("input new value : ");
                value = ProjectMain.bf.readLine();
                SQLx.Updatex(tbls[opt-1], attr[target-1], value, key);
                break;
            case 5 :
                attr = new String[8];
                attr[0] = "MATCH_ID";
                attr[1] = "DATE_TIME";
                attr[2] = "PLACE_ID";
                attr[3] = "TYPE";
                attr[4] = "MAX_NUM";
                attr[5] = "SEX_CONSTRAINT";
                attr[6] = "MANAGER_ID";
                attr[7] = "WAGE";
                System.out.print("input target match id number : ");
                key[0] = ProjectMain.bf.readLine().toUpperCase().toUpperCase();
                rs = SQLx.Selectx("*", tbls[opt-1], attr[0] + " = '" + key[0] + "'", "");
                rs.last();
                if(rs.getRow()==0){
                    System.out.printf("There is no %s : %s\n", attr[0], key[0]);
                    return;
                }
                System.out.println("attribute ");
                System.out.printf("1. %s 2. %s 3. %s 4. %s\n", attr[0], attr[1], attr[2], attr[3]);
                System.out.printf("5. %s 6. %s 7. %s 8. %s\n", attr[4], attr[5], attr[6], attr[7]);
                System.out.println("any other number. exit ");
                System.out.print("input target attribute number(only 1) : ");
                target = Integer.parseInt(ProjectMain.bf.readLine());
                if(target<1 || target>8) return;
                System.out.printf("selected attribute : %s\n", attr[target-1]);
                System.out.printf("now value : %s\n", rs.getString(target));
                System.out.print("input new value : ");
                value = ProjectMain.bf.readLine();
                SQLx.Updatex(tbls[opt-1], attr[target-1], value, key);
                break;
            case 6 :
                attr = new String[8];
                attr[0] = "CLASS_ID";
                attr[1] = "DATE_TIME";
                attr[2] = "TUTOR_ID";
                attr[3] = "RECOMMEND_TIER";
                attr[4] = "SUBJECT";
                attr[5] = "PLACE";
                attr[6] = "MAX_NUM";
                attr[7] = "WAGE";
                System.out.print("input target class id number : ");
                key[0] = ProjectMain.bf.readLine().toUpperCase().toUpperCase();
                rs = SQLx.Selectx("*", tbls[opt-1], attr[0] + " = '" + key[0] + "'", "");
                rs.last();
                if(rs.getRow()==0){
                    System.out.printf("There is no %s : %s\n", attr[0], key[0]);
                    return;
                }
                System.out.println("attribute ");
                System.out.printf("1. %s 2. %s 3. %s 4. %s\n", attr[0], attr[1], attr[2], attr[3]);
                System.out.printf("5. %s 6. %s 7. %s 8. %s\n", attr[4], attr[5], attr[6], attr[7]);
                System.out.println("any other number. exit ");
                System.out.print("input target attribute number(only 1) : ");
                target = Integer.parseInt(ProjectMain.bf.readLine());
                if(target<1 || target>8) return;
                System.out.printf("selected attribute : %s\n", attr[target-1]);
                System.out.printf("now value : %s\n", rs.getString(target));
                System.out.print("input new value : ");
                value = ProjectMain.bf.readLine();
                SQLx.Updatex(tbls[opt-1], attr[target-1], value, key);
                break;
        }
    }
    private static void Delete(int opt) throws SQLException, IOException {
        String[] tbls = {"USERS", "TEAM", "OWNER", "FIELD", "MATCH", "TRAINING"};
        String[] key = new String[1];
        String keyAttr;
        ResultSet rs;
        String value;
        switch (opt){
            case 1 :
                keyAttr = "ID_NUMBER";
                System.out.print("input target user id number : ");
                key[0] = ProjectMain.bf.readLine().toUpperCase().toUpperCase();
                rs = SQLx.Selectx("*", tbls[opt-1], keyAttr + " = '" + key[0] + "'", "");
                rs.last();
                if(rs.getRow()==0){
                    System.out.printf("There is no %s : %s\n", keyAttr, key[0]);
                    return;
                }
                SQLx.Deletex(tbls[opt-1], key);
                break;
            case 2 :
                keyAttr = "TEAM_ID";
                System.out.print("input target team id number : ");
                key[0] = ProjectMain.bf.readLine().toUpperCase().toUpperCase();
                rs = SQLx.Selectx("*", tbls[opt-1], keyAttr + " = '" + key[0] + "'", "");
                rs.last();
                if(rs.getRow()==0){
                    System.out.printf("There is no %s : %s\n", keyAttr, key[0]);
                    return;
                }
                SQLx.Deletex(tbls[opt-1], key);
                break;
            case 3 :
                keyAttr = "OWNER_HP";
                System.out.print("input target owner telephone number : ");
                key[0] = ProjectMain.bf.readLine().toUpperCase().toUpperCase();
                rs = SQLx.Selectx("*", tbls[opt-1], keyAttr + " = '" + key[0] + "'", "");
                rs.last();
                if(rs.getRow()==0){
                    System.out.printf("There is no %s : %s\n", keyAttr, key[0]);
                    return;
                }
                SQLx.Deletex(tbls[opt-1], key);
                break;
            case 4 :
                keyAttr = "FIELD_ID";
                System.out.print("input target field id number : ");
                key[0] = ProjectMain.bf.readLine().toUpperCase();
                rs = SQLx.Selectx("*", tbls[opt-1], keyAttr + " = '" + key[0] + "'", "");
                rs.last();
                if(rs.getRow()==0){
                    System.out.printf("There is no %s : %s\n", keyAttr, key[0]);
                    return;
                }
                SQLx.Deletex(tbls[opt-1], key);
                break;
            case 5 :
                keyAttr = "MATCH_ID";
                System.out.print("input target match id number : ");
                key[0] = ProjectMain.bf.readLine().toUpperCase().toUpperCase();
                rs = SQLx.Selectx("*", tbls[opt-1], keyAttr + " = '" + key[0] + "'", "");
                rs.last();
                if(rs.getRow()==0){
                    System.out.printf("There is no %s : %s\n", keyAttr, key[0]);
                    return;
                }
                SQLx.Deletex(tbls[opt-1], key);
                break;
            case 6 :
                keyAttr = "CLASS_ID";
                System.out.print("input target class id number : ");
                key[0] = ProjectMain.bf.readLine().toUpperCase().toUpperCase();
                rs = SQLx.Selectx("*", tbls[opt-1], keyAttr + " = '" + key[0] + "'", "");
                rs.last();
                if(rs.getRow()==0){
                    System.out.printf("There is no %s : %s\n", keyAttr, key[0]);
                    return;
                }
                SQLx.Deletex(tbls[opt-1], key);
                break;
        }
    }
    protected static void Select() throws SQLException, IOException {
        System.out.println("Admin's Check");
        while (true){
            System.out.println("----------------------------------------------------");
            System.out.println("1. Check Sum of Prepaid_money");
            System.out.println("2. Check the Fields/Owner");
            System.out.println("3. MatchData Order by date");
            System.out.println("4. TrainingData Order by date");
            System.out.println("5. Back to Menu");
            System.out.println("----------------------------------------------------");
            System.out.print("Enter the number : ");
            ResultSet rs;
            int opt = Integer.parseInt(ProjectMain.bf.readLine());
            switch (opt){
                case 1 :
                    rs = SQLx.Selectx("SUM(PREPAID_MONEY)", "MEMBER");
                    while (rs.next()) System.out.printf("Sum of prepaid_money : %d\n", rs.getInt(1));
                    break;
                //SELECT SUM(PREPAID_MONEY)
                //FROM MEMBER;
                case 2 : // P2_3.1.2
                    System.out.print("Input Owner's Phone Number : ");
                    String hp = ProjectMain.bf.readLine();
                    rs = SQLx.Selectx("*","FIELD","WHERE OWNER_HP = '"+ hp + "'");
                    System.out.println("this owner has these fields ");
                    for(int i=1; i<=rs.getMetaData().getColumnCount(); i++)
                        System.out.printf("%30s", rs.getMetaData().getColumnName(i));
                    System.out.println();
                    System.out.println("--------------------------------------------------------------");
                    while (rs.next()) {
                        for(int i=1; i<=rs.getMetaData().getColumnCount(); i++)
                            System.out.printf("%30s", rs.getString(i));
                    }
                    System.out.println();
                    break;
                //SELECT *
                //FROM FIELD
                //WHERE OWNER_HP = '053-437-9417';
                case 3 : // P2_3.3.1
                    rs = SQLx.Selectx("*","MATCH NATURAL JOIN MATCH_EVAL_VIEW NATURAL JOIN " +
                                    "(SELECT MATCH_ID, COUNT(MEMBER_ID) FROM MATCH_APP_MEMBER GROUP BY MATCH_ID)",
                            "ORDER BY DATE_TIME DESC");
                    System.out.println();
                    for(int i=1; i<=rs.getMetaData().getColumnCount(); i++)
                        System.out.printf("%20s", rs.getMetaData().getColumnName(i));
                    System.out.println("\n-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
                    while (rs.next()) {
                        for(int i=1; i<=rs.getMetaData().getColumnCount(); i++)
                            if(i==8 || i==9 || i==11 || i == 12|| i==5) System.out.printf("%20d", rs.getInt(i));
                            else if(i==2) System.out.printf("%20s", rs.getDate(i).toString());
                            else System.out.printf("%20s", rs.getString(i));
                        System.out.println();
                    }
                    break;
                //SELECT *
                //FROM MATCH NATURAL JOIN (
                //    SELECT MATCH_ID, count(MEMBER_ID), sum(cost)
                //    FROM MATCH_APP_MEMBER
                //    GROUP BY MATCH_ID)
                //ORDER BY DATE_TIME DESC ;
                case 4 : //P2_3.3.2
                    rs = SQLx.Selectx("*","TRAINING NATURAL JOIN " +
                                    "(SELECT CLASS_ID, COUNT(TUTEE_ID) FROM TRAIN_ENROLLS GROUP BY CLASS_ID)",
                            "ORDER BY DATE_TIME DESC");
                    for(int i=1; i<=rs.getMetaData().getColumnCount(); i++)
                        System.out.printf("%27s", rs.getMetaData().getColumnName(i));
                    System.out.println("\n------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
                    while (rs.next()) {
                        for(int i=1; i<=rs.getMetaData().getColumnCount(); i++)
                            if(i==2) System.out.printf("%20s", rs.getDate(i).toString());
                            else if(i>=7) System.out.printf("%27d", rs.getInt(i));
                            else System.out.printf("%27s", rs.getString(i));
                        System.out.println();
                    }
                    break;
                //SELECT *
                //FROM TRAINING NATURAL JOIN (
                //    SELECT CLASS_ID, count(TUTEE_ID)
                //    FROM TRAIN_ENROLLS
                //    GROUP BY CLASS_ID)
                //ORDER BY DATE_TIME DESC ;
                case 5 : return;
                default: System.out.println("Wrong number!, Re-enter");
            }
        }
    }

}