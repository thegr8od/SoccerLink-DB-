package classes;

import java.sql.SQLException;

public class SQLx {
    private static final char apx = '\'';
    private static final char comma = ',';
    private static final String lparen = " (";
    private static final String rparen = ") ";
    
    public static String Insertx(String tbl, String[] data) {
            StringBuilder sb = new StringBuilder();
            String sql = "";
            sb.append("INSERT INTO ").append(tbl);
            sb.append(" VALUES ");
            if(tbl.equals("USERS")){
                sb.append(lparen);
                sb.append(apx+data[0]+apx+comma);
                sb.append(apx+data[1]+apx+comma);
                sb.append(apx+data[2]+apx+comma);
                sb.append(apx+data[3]+apx+comma);
                sb.append(apx+data[4]+apx+comma);
                sb.append(apx+data[5]+apx+rparen);
            }
            else if(tbl.equals("MANAGER")){
                sb.append(lparen);
                sb.append(apx+data[0]+apx+comma);
                sb.append(apx+data[1]+apx+rparen);
            }
            else if(tbl.equals("MEMBER")){
                sb.append(lparen);
                sb.append(apx+data[0]+apx+comma);
                sb.append(data[1]+rparen);
            }
            else if(tbl.equals("MAN_EVAL_MEM")){
                sb.append(lparen);
                sb.append(apx+data[0]+apx+comma);
                sb.append(apx+data[1]+apx+comma);
                sb.append(apx+data[2]+apx+comma);
                sb.append(apx+data[3]+apx+rparen);
            }
            else if(tbl.equals("OWNER")){
                sb.append(lparen);
                sb.append(apx+data[0]+apx+comma);
                sb.append(apx+data[1]+apx+rparen);
            }
            else if(tbl.equals("FIELD")){
                sb.append(lparen);
                sb.append(apx+data[0]+apx+comma);
                sb.append(apx+data[1]+apx+comma);
                sb.append(apx+data[2]+apx+comma);
                sb.append(apx+data[3]+apx+comma);
                sb.append(apx+data[4]+apx+rparen);
            }
            else if(tbl.equals("TEAM")){
                sb.append(lparen);
                sb.append(apx+data[0]+apx+comma);
                sb.append(apx+data[1]+apx+rparen);
            }
            else if(tbl.equals("TEAM_MEM")){
                sb.append(lparen);
                sb.append(apx+data[0]+apx+comma);
                sb.append(apx+data[1]+apx+rparen);
            }
            else if(tbl.equals("TRAINING")){
                sb.append(lparen);
                sb.append(apx+data[0]+apx+comma);
                sb.append(apx+data[1]+apx+comma);
                sb.append(apx+data[2]+apx+comma);
                sb.append(apx+data[3]+apx+comma);
                sb.append(apx+data[4]+apx+comma);
                sb.append(apx+data[5]+apx+comma);
                sb.append(data[6]+comma);
                sb.append(data[7]+comma);
                sb.append(data[8]+rparen);
            }
            else if(tbl.equals("TRAIN_ENROLLS")){
                sb.append(lparen);
                sb.append(apx+data[0]+apx+comma);
                sb.append(apx+data[1]+apx+rparen);
            }
            else if(tbl.equals("MATCH")){
                sb.append(lparen);
                sb.append(apx+data[0]+apx+comma);
                sb.append(apx+data[1]+apx+comma);
                sb.append(apx+data[2]+apx+comma);
                sb.append(apx+data[3]+apx+comma);
                sb.append(data[4]+comma);
                sb.append(apx+data[5]+apx+comma);
                sb.append(data[6]+comma);
                sb.append(data[7]+comma);
                sb.append(data[8]+rparen);
            }
            else if(tbl.equals("MATCH_APP_MEMBER")){
                sb.append(lparen);
                sb.append(apx+data[0]+apx+comma);
                sb.append(apx+data[1]+apx+rparen);
            }
            else {
                System.err.println("Insert Error");
                System.exit(1);
            }
            sql = sb.toString();
            return sql;
    }
    public static String Updatex(String tbl, String target, String data, String[] key){
            StringBuilder sb = new StringBuilder();
            String sql = "";
            sb.append("UPDATE "+tbl);
            sb.append(" SET "+target);
            sb.append(" = "+apx+data+apx);
            sb.append(" WHERE ");
            if(tbl.equals("USERS"))
                sb.append("ID_NUMBER = "+apx+key[0]+apx);
            else if(tbl.equals("MANAGER"))
                sb.append("ID_NUMBER = "+apx+key[0]+apx);
            else if(tbl.equals("MEMBER"))
                sb.append("ID_NUMBER = "+apx+key[0]+apx);
            else if(tbl.equals("MAN_EVAL_MEM")){
                sb.append("MEM_ID = "+apx+key[0]+apx+" AND ");
                sb.append("MAN_ID = "+apx+key[1]+apx);
            }
            else if(tbl.equals("OWNER")) sb.append("OWNER_HP = "+apx+key[0]+apx);
            else if(tbl.equals("FIELD")) sb.append("FIELD_ID = "+apx+key[0]+apx);
            else if(tbl.equals("TEAM"))
                sb.append("TEAM_ID = "+apx+key[0]+apx);
            else if(tbl.equals("TEAM_MEM")){
                sb.append("TEAM_ID = "+apx+key[0]+apx+" AND ");
                sb.append("MEM_ID = "+apx+key[1]+apx);
            }
            else if(tbl.equals("TRAINING"))
                sb.append("CLASS_ID = "+apx+key[0]+apx);
            else if(tbl.equals("TRAIN_ENROLLS")){
                sb.append("CLASS_ID = "+apx+key[0]+apx+" AND ");
                sb.append("TUTEE_ID = "+apx+key[1]+apx);
            }
            else if(tbl.equals("MATCH")) sb.append("MATCH_ID = "+apx+key[0]+apx);
            else if(tbl.equals("MATCH_APP_MEMBER")){
                sb.append("MATCH_ID = "+apx+key[0]+apx+" AND ");
                sb.append("MEMBER_ID = "+apx+key[1]+apx);
            }
            sql = sb.toString();
            return sql;
    }
    public static String Deletex(String tbl, String[] key)  {
            StringBuilder sb = new StringBuilder();
            String sql = "";
            sb.append("DELETE FROM "+tbl);
            sb.append(" WHERE ");
            if(tbl.equals("USERS"))
                sb.append("ID_NUMBER = "+apx+key[0]+apx);
            else if(tbl.equals("MANAGER"))
                sb.append("ID_NUMBER = "+apx+key[0]+apx);
            else if(tbl.equals("MEMBER"))
                sb.append("ID_NUMBER = "+apx+key[0]+apx);
            else if(tbl.equals("MAN_EVAL_MEM")){
                sb.append("MEM_ID = "+apx+key[0]+apx+" AND ");
                sb.append("MAN_ID = "+apx+key[1]+apx);
            }
            else if(tbl.equals("OWNER")) sb.append("OWNER_HP = "+apx+key[0]+apx);
            else if(tbl.equals("FIELD")) sb.append("FIELD_ID = "+apx+key[0]+apx);
            else if(tbl.equals("TEAM"))
                sb.append("TEAM_ID = "+apx+key[0]+apx);
            else if(tbl.equals("TEAM_MEM")){
                sb.append("TEAM_ID = "+apx+key[0]+apx+" AND ");
                sb.append("MEM_ID = "+apx+key[1]+apx);
            }
            else if(tbl.equals("TRAINING"))
                sb.append("CLASS_ID = "+apx+key[0]+apx);
            else if(tbl.equals("TRAIN_ENROLLS")){
                sb.append("CLASS_ID = "+apx+key[0]+apx+" AND ");
                sb.append("TUTEE_ID = "+apx+key[1]+apx);
            }
            else if(tbl.equals("MATCH")) sb.append("MATCH_ID = "+apx+key[0]+apx);
            else if(tbl.equals("MATCH_APP_MEMBER")){
                sb.append("MATCH_ID = "+apx+key[0]+apx+" AND ");
                sb.append("MEMBER_ID = "+apx+key[1]+apx);
            }
            sql = sb.toString();
            return sql;
    }
    public static String Selectx(String attr, String tbl) {
            StringBuilder sb = new StringBuilder();
            String sql = "";
            sb.append("SELECT "+attr);
            sb.append(" FROM "+tbl);
            sql = sb.toString();
            return sql;
    }
    public static String Selectx(String attr, String tbl, String opt) {
            StringBuilder sb = new StringBuilder();
            String sql = "";
            sb.append("SELECT "+attr);
            sb.append(" FROM "+tbl);
            sb.append(" "+opt);
            sql = sb.toString();
            return sql;
    }
    public static String Selectx(String attr, String tbl, String where, String opt)  {
            StringBuilder sb = new StringBuilder();
            String sql = "";
            sb.append("SELECT "+attr);
            sb.append(" FROM "+tbl);
            sb.append(" WHERE "+where);
            sb.append(" "+opt);
            sql = sb.toString();
            return sql;
    }
    public static String Selectx(String attr, String tbl, String where, String groups, String opt) throws SQLException {
            StringBuilder sb = new StringBuilder();
            String sql = "";
            sb.append("SELECT " + attr);
            sb.append(" FROM " + tbl);
            sb.append(" WHERE " + where);
            sb.append(" GROUP BY " + groups);
            sb.append(" " + opt);
            sql = sb.toString();
            return sql;
    }
}