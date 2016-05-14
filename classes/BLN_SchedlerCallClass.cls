public with sharing class BLN_SchedlerCallClass {
	public String BLN_SchedlerMethod(Integer SessionTime,String OrderId) {
		Bln_Scheduler_tcreation scCls =new Bln_Scheduler_tcreation();
        return scCls.Bln_Scheduler(SessionTime,OrderId);
    }
}