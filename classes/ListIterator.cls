global with sharing class ListIterator implements Iterator<String>, Iterable<String>
{
  LIST<String> records;
  Integer i {get; set;} 
   public ListIterator(LIST<String> records)
   {
      this.records=records;
      i=0;
   }
   global Boolean hasNext()
   {
      return i >=records.size()? false: true;
   }
   global String next()
   {
     if(i == records.size()){return null;} 
       i++; 
       return records[i-1];
   }
   global Iterator<String> Iterator()
   {
      return this;   
   }

}