package Phase3;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.SQLException;
import java.util.StringTokenizer;

public class ADMIN {
    protected static void Screen(int option) throws IOException, SQLException {
        // opt = 1. user, 2. team, 3. owner, 4. field, 5.match, 6. training
        BufferedReader bf = new BufferedReader(new InputStreamReader(System.in));
        System.out.println("----------------------------------------------------");
        System.out.println("Admin Screen for management");
        while (true){
            System.out.println("----------------------------------------------------");
            System.out.println("1. Update");
            System.out.println("2. Delete");
            System.out.println("3. Select");
            System.out.println("4. Log Out");
            System.out.println("----------------------------------------------------");
            System.out.print("Enter the number : ");
            int opt = Integer.parseInt(bf.readLine());
            switch (opt){
                case 1 : Update(option); break;
                case 2 : Delete(option); break;
                case 3 : Select(option); break;
                case 4 : return;
                default: System.out.println("Wrong number!, Re-enter");
            }
        }
    }
    private static void Update(int opt) throws IOException, SQLException {
        BufferedReader bf = new BufferedReader(new InputStreamReader(System.in));
        String[] key = new String[2];
        String target;
        String value;
        switch (opt){
            case 1 :
                System.out.print("input target user id number : ");
                key[0] = bf.readLine();
                System.out.print("input target attribute(only 1) : ");
                target = bf.readLine();
                System.out.print("input new value : ");
                value = bf.readLine();
                SQLx.Updatex("USERS", target, value, key);
                break;
            case 2 :
                System.out.print("input target team id number : ");
                key[0] = bf.readLine();
                System.out.print("input target attribute(only 1) : ");
                target = bf.readLine();
                System.out.print("input new value : ");
                value = bf.readLine();
                SQLx.Updatex("TEAM", target, value, key);
                break;
            case 3 :
                System.out.print("input target owner telephone number : ");
                key[0] = bf.readLine();
                System.out.print("input target attribute(only 1) : ");
                target = bf.readLine();
                System.out.print("input new value : ");
                value = bf.readLine();
                SQLx.Updatex("OWNER", target, value, key);
                break;
            case 4 :
                System.out.print("input target field id number : ");
                key[0] = bf.readLine();
                System.out.print("input target attribute(only 1) : ");
                target = bf.readLine();
                System.out.print("input new value : ");
                value = bf.readLine();
                SQLx.Updatex("FIELD", target, value, key);
                break;
            case 5 :
                System.out.print("input target match id number : ");
                key[0] = bf.readLine();
                System.out.print("input target attribute(only 1) : ");
                target = bf.readLine();
                System.out.print("input new value : ");
                value = bf.readLine();
                SQLx.Updatex("MATCH", target, value, key);
                break;
            case 6 :
                System.out.print("input target class id number : ");
                key[0] = bf.readLine();
                System.out.print("input target attribute(only 1) : ");
                target = bf.readLine();
                System.out.print("input new value : ");
                value = bf.readLine();
                SQLx.Updatex("TRAINING", target, value, key);
                break;
        }
    }
    private static void Delete(int opt){
        switch (opt){
            case 1 : break;
            case 2 : break;
            case 3 : break;
            case 4 : break;
            case 5 : break;
            case 6 : break;
        }
    }
    private static void Select(int opt){
        switch (opt){
            case 1 : break;
            case 2 : break;
            case 3 : break;
            case 4 : break;
            case 5 : break;
            case 6 : break;
        }
    }

}
