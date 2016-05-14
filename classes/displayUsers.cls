public with sharing class displayUsers {
public List<user> listOfusers{get;set;}
public displayUsers(){

}

public void usersListmethod(set<id> values){
listOfusers = new List<user>();
listOfusers =[select userName from user where isActive=true and id IN :values];

}



static testMethod  void mytest(){
displayUsers rt = new displayUsers ();
}


}