public class MFSI_FormatDateTime {
    public DateTime dateTimeValue { get; set; }
    public String getTimeZoneValue() {
        if( dateTimeValue != null ) {
            String localeFormatDT = dateTimeValue.format('MMMM d,  yyyy h:mm a');
            return localeFormatDT;
        }
        return null;
    }
}