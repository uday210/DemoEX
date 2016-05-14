public class BLN_AppMenuItem_DAO{
    public LIST<AppMenuItem> getConnectedAppDetails(){
        LIST<AppMenuItem> connectedApps=new LIST<AppMenuItem>();
        connectedApps = [SELECT Label,MobilePlatform,Type FROM AppMenuItem where type='ConnectedApplication' and MobilePlatform IN ('android','ios')];
        return connectedApps;
    }

}