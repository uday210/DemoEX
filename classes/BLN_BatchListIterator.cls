global with sharing class BLN_BatchListIterator implements Iterator<List<String>>, Iterable<List<String>>
{
  List<List<String>> records;
  Integer i {get; set;} 
   public BLN_BatchListIterator(List<List<String>> records)
   {
      this.records=records;
      i=0;
   }
   global Boolean hasNext()
   {
      return i >=records.size()? false: true;
   }
   global List<String> next()
   {
     if(i == records.size()){return null;} 
       i++; 
       return records[i-1];
   }
   global Iterator<List<String>> Iterator()
   {
      return this;   
   }

}