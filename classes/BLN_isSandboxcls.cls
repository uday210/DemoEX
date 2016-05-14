public class BLN_isSandboxcls{
  public static boolean isSandbox(){
   return  [SELECT Id, IsSandbox FROM Organization LIMIT 1].IsSandbox;
  }

}