package Phase3;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class ProjectMain {
    // Commons
    public static final String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
    public static final String USER_NAME = "TERMPROJECT";
    public static final String USER_PASSWD = "COMP0322";
    public static Connection conn = null;
    //public static Statement stmt = null;
    public static BufferedReader bf= new BufferedReader(new InputStreamReader(System.in));
    public static void main(String[] args) throws IOException, SQLException {

        //jdbc 드라이버 불러오기
        try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("Success!");
        }catch (ClassNotFoundException e){
            System.err.println("error : " + e.getMessage());
            System.exit(1);
        }

        // connection 설정
        try {
            conn = DriverManager.getConnection(URL, USER_NAME, USER_PASSWD);
            System.out.println("Connected");
        }catch (SQLException e){
            System.err.println("Cannot get a connection : " + e.getLocalizedMessage());
            System.err.println("Cannot get a connection : " + e.getMessage());
            System.exit(1);
        }

        conn.setAutoCommit(false);
        //stmt = conn.createStatement();
        System.out.println("------------------------------");
        System.out.println("Hello, Welcome to SoccerLink");
        while (true){
            System.out.println("------------------------------");
            System.out.println("Select Option");
            System.out.println("1. Log In");
            System.out.println("2. Sign Up");
            System.out.println("3. Credits");
            System.out.println("4. Quit");
            System.out.println("------------------------------");
            System.out.print("Option Number : ");
            int mainOpt = Integer.parseInt(bf.readLine());
            boolean flag = false;
            switch (mainOpt) {
                case 1 : USERS.LogIn(); break;
                case 2 : USERS.SignUp(); break;
                case 3 : Credits(); break;
                case 4 : flag = true; break;
                default: System.out.println("Wrong number!, Re-enter");
            }
            if (flag) break;

        }

        conn.close();
        //stmt.close();
        bf.close();
    }
    private static void Credits() throws IOException {
        System.out.println("-----------------------------------");
        System.out.println("Credits");
        System.out.println("--------------------------------------------------------------------------");
        System.out.printf("|%-15s|%-40s|%-15s|\n", "Name", "Major", "ID_Number");
        System.out.println("--------------------------------------------------------------------------");
        System.out.printf("|%-15s|%-40s|%-15s|\n", "Dong-Hyeok Seo", "Computer Science and Engineering", "2021115360");
        System.out.printf("|%-15s|%-40s|%-15s|\n", "Du-Young Hwang", "English Language and Literature", "2018110976");
        System.out.printf("|%-15s|%-40s|%-15s|\n", "Seung-Jun Kim", "English Language and Literature", "2019110248");
        System.out.println("--------------------------------------------------------------------------");
        System.out.println(" SoccerLink, Project of Team 6, Updated : 2023.11.07");
        System.out.println(" Database(comp322), Instructor : Young-Kyoon Suh");
        System.out.println(" 2023 Fall Semester, Kyungpook National University");
        System.out.println("--------------------------------------------------------------------------");
        System.out.println(" Press Enter to return Main Screen");
        bf.readLine();
    }
}