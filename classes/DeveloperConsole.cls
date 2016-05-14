public with sharing class DeveloperConsole {
public List<Sobject> listofRecords {get;set;}
  public String quertstr { get; set; }
  
    public PageReference getResult() {
    listofRecords  = new List<Sobject>();
    listofRecords  =DataBase.Query(quertstr );
        return null;
    }
}