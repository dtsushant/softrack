package com.softrack

import java.text.SimpleDateFormat

/**
 * Created with IntelliJ IDEA.
 * User: spandey
 * Date: 2/9/15
 * Time: 11:43 AM
 * To change this template use File | Settings | File Templates.
 */
class DateUtils {
    static String standardDateFormat="MM/dd/yyyy"
    static String standardTimeDateFormat="MM/dd/yyyy HH:mm:ss"

    static String getFormattedDate(){
        return getFormattedDate(new Date())
    }

    static String getFormattedDate(def date,String format="yyyy-MM-dd",String stringDateFormat="yyyy-MM-dd"){
        if(!date) return null
        def sdf = new SimpleDateFormat(format)

        if(date instanceof Date)
            return sdf.format(date)
        else{
            return sdf.format(parseStringToDate(date,stringDateFormat))
        }
    }
    static String getFormatttedDateWithTimeZone(def date,String timezone,String format="MM/dd/yyyy HH:mm:ss",String stringDateFormat="MM/dd/yyyy HH:mm:ss"){
        if(!date) return null
        def sdf = new SimpleDateFormat(format)
        if (timezone)
            sdf.setTimeZone(TimeZone.getTimeZone(timezone));
        if(date instanceof Date)
            return sdf.format(date)
        else
            return sdf.format(parseStringToDateWithTimeZone(date,timezone,stringDateFormat))
    }
    def static parseStringToDate(def date,def parseStringFormat="yyyy-MM-dd"){
        return new Date().parse(parseStringFormat,date)
    }
    def static Date parseStringToDateWithTimeZone(def date,def timeZone,def parseStringFormat="MM/dd/yyyy HH:mm:ss"){
        def sdf = new SimpleDateFormat(parseStringFormat)
        if (timeZone)
            sdf.setTimeZone(TimeZone.getTimeZone(timeZone));
        return sdf.parse(date)
    }
    public static Map getDateDifference(def prevDate, Date newDate = new Date()) {
        Date oldDate = parseStringToDate(prevDate)
        Long difference = newDate.time - oldDate.time
        Map diffMap =[:]
        difference = difference / 1000
        diffMap.seconds = difference % 60
        difference = (difference - diffMap.seconds) / 60
        diffMap.minutes = difference % 60
        difference = (difference - diffMap.minutes) / 60
        diffMap.hours = difference % 24
        difference = (difference - diffMap.hours) / 24
        diffMap.years = (difference / 365).toInteger()
        if(diffMap.years)
            difference = (difference) % 365
        diffMap.days = difference % 7
        diffMap.months = Math.round((difference - diffMap.days) / 30)
        return diffMap
    }

    public static getDayDifference(def prevDate, Date newDate = new Date()){
        Date oldDate = parseStringToDate(prevDate)
        Long difference = newDate.time - oldDate.time
        difference = difference / (1000 * 60 * 60 * 24)
        return difference
    }

    public static def calculateAge(def birthday, Date offset = new Date(),def dateFormat='MM/dd/yyyy'){
        if (!birthday) return null
        if (!offset) return null
        def bDate
        if(birthday instanceof Date){
            bDate=birthday
        }else{
            bDate=DateUtils.parseStringToDate(birthday,dateFormat)
        }
        if(!bDate) return null;
        def birthdayThisYear =(Date) offset.clone().clearTime()
        birthdayThisYear.setMonth(bDate.month)
        birthdayThisYear.setDate(bDate.date)
        return offset[Calendar.YEAR] - bDate[Calendar.YEAR] - (birthdayThisYear > offset ? 1 : 0)
    }

//StringDate e.g; 2013-04-30T18:15:00Z
    public static def getformattedDateFromStringDate(def _date, def format='MM/dd/yyyy', def timeFlag=false){
        def parsedStringDate
        def _stringFormat
        (parsedStringDate,_stringFormat)=parseStringDate(_date,timeFlag)
        return  getFormattedDate(parsedStringDate,format,_stringFormat)
    }

    public static def getDateFromStringDate(def _date,def timeFlag=false){
        if (_date instanceof Date) return _date
        if (StringUtils.checkNull(_date)) return null
        def stringDateParts=parseStringDate(_date,timeFlag)
        return parseStringToDate(stringDateParts[0],stringDateParts[1])
    }

    public static def parseStringDate(String _date,Boolean timeFlag=false){
        def date
        def stringFormat='yyyy-MM-dd'
        def datePart=_date.toString().substring(0,10)
        if (timeFlag){
            date = datePart+" "+_date.toString().substring(11,19)
            stringFormat=stringFormat+" "+'HH:mm:ss'
        }else date = datePart
        return [date, stringFormat]
    }

    static  def getDateInterval(Integer intervalPeriod, String timeUnit,Date point=new Date()){
        def date1
        def date2
        Calendar c=Calendar.instance
        c.setTime(point)
//        use(TimeCategory) {
        switch(timeUnit.toLowerCase()){
            case 'year': case 'years':
                c.set(c.get(Calendar.YEAR)-(intervalPeriod-1),0,1,0,0,0)
                date1=c.getTime()
                c.setTime(point)
                c.set(c.get(Calendar.YEAR),11,31,23,59,59) //last time of the year
                date2=c.getTime()
                break
            case 'month': case 'months':
                def monthIndex=c.get(Calendar.MONTH)
                def periodIndex=intervalPeriod-1
                def startMonth
                def endMonth
                for (def i=0;i<=11;){
                    startMonth=i
                    endMonth=i+periodIndex
                    if(monthIndex>=startMonth && monthIndex<=endMonth)
                        break
                    i = endMonth+1
                }
                c.set(Calendar.MONTH,startMonth)
                c.set(Calendar.DAY_OF_MONTH,1)
                date1=c.getTime().clearTime()
                c.set(c.get(Calendar.YEAR),endMonth,
                        1,23,59,59)
                c.set(Calendar.MILLISECOND,0)
                c.set(Calendar.DAY_OF_MONTH,c.getActualMaximum(Calendar.DAY_OF_MONTH))
                date2=c.getTime()
                break
            case 'day': case 'days':
//                    date1=c.getTime().clearTime()
//                    date2=date1+24.hours-1.second
                break
        }
//        }
        return [date1,date2]
    }

    public static def timeDurationInSeconds(def startTimeInNs, def endTimeInNs){
        def durationInSec = endTimeInNs - startTimeInNs
        durationInSec = (Double) durationInSec / 1000000000.0;
        return durationInSec

    }
    private static Date convertDateToNewTimeZone(Date date, String fromTZ, String toTZ){

        // Construct FROM and TO TimeZone instances
        TimeZone fromTimeZone = TimeZone.getTimeZone(fromTZ);
        TimeZone toTimeZone = TimeZone.getTimeZone(toTZ);

        // Get a Calendar instance using the default time zone and locale.
        Calendar calendar = Calendar.getInstance();

        // Set the calendar's time with the given date
        calendar.setTimeZone(fromTimeZone);
        calendar.setTime(date);

        System.out.println("Input: " + calendar.getTime() + " in " + fromTimeZone.getDisplayName());

        // FROM TimeZone to UTC
        calendar.add(Calendar.MILLISECOND, fromTimeZone.getRawOffset() * -1);

        if (fromTimeZone.inDaylightTime(calendar.getTime())) {
            calendar.add(Calendar.MILLISECOND, calendar.getTimeZone().getDSTSavings() * -1);
        }

        // UTC to TO TimeZone
        calendar.add(Calendar.MILLISECOND, toTimeZone.getRawOffset());

        if (toTimeZone.inDaylightTime(calendar.getTime())) {
            calendar.add(Calendar.MILLISECOND, toTimeZone.getDSTSavings());
        }

        return calendar.getTime();

    }

    public static Boolean checkDateBetween(Date minDate, Date maxDate, Date point){
        if (!minDate || !maxDate) return false;
        Long minDate_l = minDate.getTime()
        Long maxDate_l = maxDate.getTime()
        Long point_l = point.getTime()
        return point_l>=minDate_l && point_l<=maxDate_l
    }

    public static int getNumberOfDaysBetweenTwoDates(String d1,String d2){
        if(!d1 && !d2)
            return null
        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd")
        def date1= simpleDateFormat.parse(d1);
        def date2= simpleDateFormat.parse(d2);
        int difference = (date2.getTime() - date1.getTime())/(24 * 60 * 60 * 1000);
        return difference
    }
}
