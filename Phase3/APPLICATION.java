package Phase3;

public class APPLICATION {
    protected static void MyPage(String id, boolean role){
        // false -> Manager, true -> Member
        // USER, MEMBER, MANAGER relation control
        ChangeMyInfo();
        CashCharge();
        Secession();
    }
    protected static void UserEval(String id){
        // UPDATE AND INSERT MANAGER -> MEMBER EVALUATION
    }
    protected static void Screen(String id, boolean role, int opt){
        // false -> Manager, true -> Member
        // opt = 2. Training, 3. Match, 4. Team
        // TRAINING, MATCH, TEAM relation control
        Make();
        Cancel();
        Delete();
        Apply();
    }
    private static void ChangeMyInfo(){

    } // UPDATE USER, MANAGER, MEMBER
    private static void CashCharge(){

    } // ONLY FOR USER, UPDATE PREPAID_MONEY
    private static void Secession(){

    } // DELETE USER ON CASCADE
    private static void Make(){

        } // insert entity rela on cascade
    private static void Cancel(){

        } // delete relationship rela -> PREPAID_MONEY CHANGE REFELCT
    private static void Delete(){

        } // delete entitiy rela on cascade
    private static void Apply(){

    } // insert relationship rela -> PREPAID_MONEY CHANGE REFELCT
    private static void Check(){} // select where id_num in ~ ex) my teams, my matches
}
