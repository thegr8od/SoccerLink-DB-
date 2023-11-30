package Phase3;

import java.io.*;
import java.sql.*;
import java.util.Random;

public class USERS {
    private static final char apx = '\'';
    protected static void SignUp() throws IOException, SQLException {
        System.out.println("----------------------------------------------------");
        System.out.print("Sign Up\n");
        System.out.println("----------------------------------------------------");
        System.out.println("Insert your \"Name, Password, Sex, Year of Birth, Job\"");
        String[] UserData = new String[6]; // ID, Name, Sex, Yob, Job, Passwd

        do {
            System.out.println("Insert your name in English. Number of Character have to under 30");
            System.out.print("Name : ");
            UserData[1] = ProjectMain.bf.readLine();
        } while (UserData[1].length() >= 30);

        do{
            System.out.println("Insert new Password. Number of Character have to be between 9 and 20");
            System.out.print("Password : ");
            UserData[5] = ProjectMain.bf.readLine();
        } while (UserData[5].length() > 20 || UserData[5].length() < 9);

        do {
            System.out.println("Insert your biological Sex. Male = M, Female = F");
            System.out.print("Sex : ");
            UserData[2] = ProjectMain.bf.readLine().toUpperCase();
        } while (!UserData[2].equals("M") && !UserData[2].equals("F"));

        do {
            System.out.println("Insert your Year of Birth. ex) 1998");
            System.out.print("Year of Birth : ");
            UserData[3] = ProjectMain.bf.readLine();
        } while (UserData[3].length() != 4);

        System.out.println("Insert your Job in English. ex) computer engineer");
        System.out.print("Job : ");
        UserData[4] = ProjectMain.bf.readLine();

        while (true){
            Random rand = new Random(System.currentTimeMillis());
            StringBuilder sb = new StringBuilder();
            StringBuilder where = new StringBuilder();
            sb.append("U").append(Math.abs(rand.nextInt()%10)).append(Math.abs(rand.nextInt()%10)).append(Math.abs(rand.nextInt()%10));
            sb.append("-").append(Math.abs(rand.nextInt()%10)).append(Math.abs(rand.nextInt()%10));
            sb.append("-").append(Math.abs(rand.nextInt()%10)).append(Math.abs(rand.nextInt()%10)).append(Math.abs(rand.nextInt()%10)).append(Math.abs(rand.nextInt()%10));
            UserData[0] = sb.toString();
            where.append("ID_NUMBER = "+ apx + UserData[0]+ apx);
            int rows = 0;
            ResultSet rs = SQLx.Selectx("ID_NUMBER",  "USERS", where.toString(), "");
            rs.last();
            rows = rs.getRow();
            sb.setLength(0);
            if(rows==0) break; // id중에 중복이 없으면 break;
        }
        System.out.println("-------------------------------------------------");
        System.out.println("Select your Role.");
        System.out.println("for Manager Role : Enter \"Manager\" or \"MGR\"");
        System.out.println("for Member Role : Enter \"Member\" or \"MEM\"");
        System.out.println("If you want to Quit Sign up, then enter \'q\'");
        boolean flag = false;
        while (true){
            System.out.print("Role : ");
            String UserRole = ProjectMain.bf.readLine().toUpperCase();
            if(UserRole.equals("MGR")||UserRole.equals("MANAGER")) {
                flag = true;
                break;
            }
            else if(UserRole.equals("MEM")||UserRole.equals("MEMBER")) break;
            else if(UserRole.equals("Q")) return;
            else continue;
        }
        //System.out.printf("%s %s %s %s %s %s",UserData[0],UserData[1],UserData[2],UserData[3],UserData[4],UserData[5]);
        SQLx.Insertx("USERS",UserData);
        if(flag) SignUpMgr(UserData[0]);
        else SignUpMem(UserData[0]);
        System.out.println("----------------------------------------------------");
        System.out.printf("Your ID_NUMBER is %s\n", UserData[0]);
    }
    protected static void LogIn() throws IOException, SQLException {
        StringBuilder where = new StringBuilder();
        String[] idps = new String[2];
        System.out.println("----------------------------------------------------");
        System.out.println("Log In");
        System.out.println("----------------------------------------------------");
        int rows;
        do {
            System.out.print("ID : ");
            idps[0] = ProjectMain.bf.readLine().toUpperCase();
            System.out.print("PASSWD : ");
            idps[1] = ProjectMain.bf.readLine();
            if(idps[0].equals("SOCCERLINK") && idps[1].equals("ADMIN!")) break;
            where.append("ID_NUMBER = " + apx + idps[0] + apx + " AND " + "PASSWD = " + apx + idps[1] + apx);
            ResultSet rs = SQLx.Selectx("ID_NUMBER, PASSWD", "USERS", where.toString(), "");
            rs.last();
            rows = rs.getRow();
            where.setLength(0);
            if(rows == 0) System.out.println("WRONG ID and PASSWD!, Please Re-enter");
        } while (rows != 1);
        AfterLogIn(idps);
    }
    private static void AfterLogIn(String[] idps) throws SQLException, IOException {
        if(idps[0].equals("SOCCERLINK") && idps[1].equals("ADMIN!")){
            System.out.println("----------------------------------------------------");
            System.out.println("Admin Screen for management");
            while (true){
                System.out.println("----------------------------------------------------");
                System.out.println("1. User");
                System.out.println("2. Team");
                System.out.println("3. Owner");
                System.out.println("4. Field");
                System.out.println("5. Match");
                System.out.println("6. Training");
                System.out.println("7. Check Some Information");
                System.out.println("8. Log Out");
                System.out.println("----------------------------------------------------");
                System.out.print("Enter the number : ");
                int opt = Integer.parseInt(ProjectMain.bf.readLine());
                switch (opt){
                    case 1,2,3,4,5,6 : ADMIN.Screen(opt); break;
                    case 7 : ADMIN.Select();
                    case 8 : return;
                    default: System.out.println("Wrong number!, Re-enter");
                }
            }
        }
        else {
            StringBuilder where = new StringBuilder();
            where.append("ID_NUMBER = "+apx+idps[0]+apx); // P2_3.1.1
            ResultSet rsMem = SQLx.Selectx("ID_NUMBER", "MEMBER", where.toString(), "");
            ResultSet rsMan = SQLx.Selectx("ID_NUMBER", "MANAGER", where.toString(), "");
            rsMan.last();
            rsMem.last();
            where.setLength(0);
            if(rsMan.getRow() == 1){
                rsMem.close();
                rsMan.close();
                System.out.println("----------------------------------------------------");
                System.out.println("Manager Screen");
                while (true){
                    System.out.println("----------------------------------------------------");
                    System.out.println("1. My page");
                    System.out.println("2. User Evaluation");
                    System.out.println("3. Match Apply");
                    System.out.println("4. Log Out");
                    System.out.println("----------------------------------------------------");
                    System.out.print("Enter the number : ");
                    int opt = Integer.parseInt(ProjectMain.bf.readLine());
                    switch (opt){
                        case 1 : APPLICATION.MyPage(idps[0],false); break;
                        case 2 : APPLICATION.UserEval(idps[0]); break;
                        case 3 : APPLICATION.Screen(idps[0],false,3); break;
                        case 4 : return;
                        default: System.out.println("Wrong number!, Re-enter");
                    }
                }
            }
            else if(rsMem.getRow() == 1){
                rsMem.close();
                rsMan.close();
                System.out.println("----------------------------------------------------");
                System.out.println("User Screen");
                while (true){
                    System.out.println("----------------------------------------------------");
                    System.out.println("1. My page");
                    System.out.println("2. Training");
                    System.out.println("3. Match");
                    System.out.println("4. Team");
                    System.out.println("5. Log Out");
                    System.out.println("----------------------------------------------------");
                    System.out.print("Enter the number : ");
                    int opt = Integer.parseInt(ProjectMain.bf.readLine());
                    switch (opt){
                        case 1 : APPLICATION.MyPage(idps[0],true); break;
                        case 2,3,4 : APPLICATION.Screen(idps[0],true,opt); break;
                        case 5 : return;
                        default: System.out.println("Wrong number!, Re-enter");
                    }
                }
            }
            else {
                while (true){
                    rsMem.close();
                    rsMan.close();
                    System.out.println("----------------------------------------------------");
                    System.out.println("Your Role is missed, Pick your role");
                    System.out.println("1. Member, 2. Manager, 3. Quit");
                    System.out.print("Enter the number : ");
                    int role = Integer.parseInt(ProjectMain.bf.readLine());
                    if(role == 1) SignUpMem(idps[0]);
                    else if (role == 2) SignUpMgr(idps[0]);
                    else if (role == 3) System.exit(0);
                    else {
                        System.out.println("Wrong number!, Re-enter");
                        continue;
                    }
                    System.out.println("Successfully Registered, Please Press Enter and Re-execute");
                    System.exit(0);
                }
            }
        }
    }
    private static void SignUpMgr(String ID) throws IOException, SQLException {
        System.out.println("----------------------------------------------------");
        System.out.println("Sign up : Manager page, Insert your Account Number");
        System.out.println("----------------------------------------------------");
        System.out.print("Account number : ");
        String[] data = new String[2];
        data[0] = ID;
        data[1] = ProjectMain.bf.readLine();
        SQLx.Insertx("MANAGER", data);
    }
    private static void SignUpMem(String ID) throws SQLException {
        String[] data = new String[2];
        data[0] = ID;
        data[1] = "0";
        SQLx.Insertx("MEMBER", data);
    }

}