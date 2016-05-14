global with sharing class BLN_BatchListIteratorEBMT implements Iterator<Participant>, Iterable<Participant>
{
  List<Participant> records;
  Integer i {get; set;} 
   public BLN_BatchListIteratorEBMT(List<Participant> records)
   {
      this.records=records;
      i=0;
   }
   global Boolean hasNext()
   {
      return i >=records.size()? false: true;
   }
   global Participant next()
   {
     if(i == records.size()){return null;} 
       i++; 
       return records[i-1];
   }
   global Iterator<Participant> Iterator()
   {
      return this;   
   }

}