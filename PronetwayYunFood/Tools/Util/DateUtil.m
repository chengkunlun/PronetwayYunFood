//
//  DateUtil.m
//  lfys
//
//  Created by tao on 15/6/28.
//  Copyright (c) 2015年 qinghui. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil

/**
 *  时间戳转日期字符串,格式为yyyy-MM-dd HH:mm:ss
 *
 *  @param timestamp 时间戳
 *
 *  @return
 */
+(NSString *) timestampToDateTimeStr:(long) timestamp{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    return [formatter stringFromDate:date];
}

/**
 *  时间戳转字符串,格式为yyyy-MM-dd
 *
 *  @param timestamp
 *
 *  @return
 */
+(NSString *) timestampToDateStr:(long) timestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    return [formatter stringFromDate:date];
    
}

/**
 *  时间戳转字符串,格式为yyyy-MM-dd HH:mm
 *
 *  @param timestamp
 *
 *  @return
 */
+(NSString *) timestampToMinuteStr:(long) timestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    return [formatter stringFromDate:date];
}


/**
 *  时间戳转NSDate
 *
 *  @param timestamp
 *
 *  @return
 */
+(NSDate *) timestampToNSDate:(long) timestamp{
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
}


/**
 * 传入一个日期,得到一天的开始,即00:00:00
 *
 *  @param date
 *
 *  @return
 */
+(NSString *) getDateForDayStart:(NSDate *) date{
    
    //追加到00:00:00的字符串
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"] ;
    NSMutableString *strDate = [NSMutableString stringWithString:[formatter stringFromDate:date]];
    [strDate appendString:@" 00:00:00"];
    
    //再变成时间戳
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [NSString stringWithFormat:@"%ld",(long) [[formatter dateFromString:strDate] timeIntervalSince1970]];
    
    
}

/**
 * 传入一个日期,得到一天的结束,即23:59:59
 *
 *  @param date
 *
 *  @return
 */
+(NSString *) getDateForDayEnd:(NSDate *) date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSMutableString *strDate = [NSMutableString stringWithString:[formatter stringFromDate:date]];
    [strDate appendString:@" 23:59:59"];
    
    //再变成时间戳
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [NSString stringWithFormat:@"%ld",(long) [[formatter dateFromString:strDate] timeIntervalSince1970]];
}

/*
 * 将NSDate转成年、月、日的日期格式
 */
+(NSString *) dateToDateStr:(NSDate *) date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"] ;
    
    return [formatter stringFromDate:date];
}

/*
 * 将NSDate转成月、日的格式
 */
+(NSString *) dateToMonthDayStr:(NSDate *) date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"] ;
    
    return [formatter stringFromDate:date];
    
}

/*
 * 将NSDate转成时、分的格式
 */
+(NSString *) dateToHourMinuteStr:(NSDate *) date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"] ;
    
    return [formatter stringFromDate:date];
    
}


/*
 * 获取当前星期
 */
+ (NSString*)weekdayStringFromDate:(NSDate *) inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday; //NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

/*
 * 获取明天8点日期
 */
+(NSDate *) getTomorrowAightOclock{
    
    //1,日期 + 24小时
    NSDate *tomoroowDate = [NSDate dateWithTimeIntervalSinceNow:(24 * 60 * 60)];
    
    //2,只获取年-月-日部分
    NSString *dateStr = [DateUtil dateToDateStr:tomoroowDate];
    
    //3,再追加时间
    dateStr = [NSString stringWithFormat:@"%@ 08:00:00",dateStr];
    
    //4,转换成NSDate返回
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [formatter dateFromString:dateStr];
    
}

/**
 *  字符串转date
 *
 *  @param dateStr
 *
 *  @return
 */
+(NSDate *) stringToDate:(NSString *) dateStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [formatter dateFromString:dateStr];
    return date;
}


/**
 *  日期格式转换
 *
 *  @param str
 *
 *  @return
 */
+(NSString *) compareCurrentTime:(NSString *)str{
    
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    //设置时区
    form.locale = [NSLocale localeWithLocaleIdentifier:@"cn"];
    form.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [form dateFromString:str];
    
    //得到当前的时间差
    NSTimeInterval timeInterval = [date timeIntervalSinceNow];
    timeInterval = -timeInterval;
    
    //小于一小时
    NSInteger minute = timeInterval / 60;
    if(minute == 0){
        return @"1分钟前";
    }
    else if(minute < 60){
        return [NSString stringWithFormat:@"%ld分钟前",(long)minute];
    }
    
    //小于24小时
    NSInteger hours = minute / 60;
    if(hours < 24){
        return [NSString stringWithFormat:@"%ld小时前",(long)hours];
    }
    form.dateFormat = @"M月d日";
    NSString *oldtime = [form stringFromDate:date];
    return [NSString stringWithFormat:@"%@",oldtime];
    
}

//获取当前时间的时间戳
+(NSString*)getCurrentTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
    
}

//获取当前时间 ,年 月 日 类型
+(NSString *)getCurrentTime {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyy-MM-dd"];
    NSString*dateTime = [formatter stringFromDate:[NSDate  date]];
    // NSString *str1 = [dateTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return dateTime;
}

//获取当前时间 ,年 月 日 分 秒 类型
+(NSString *)getCurrentTimeFormiao {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyy-MM-dd HH:mm:ss"];
    NSString*dateTime = [formatter stringFromDate:[NSDate  date]];
    // NSString *str1 = [dateTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return dateTime;
}

//标准时间 2016-11-09 13:34:40转化成时间戳;
+(NSString *)TimeToTimestamp:(NSString *)Time{

    //NSString* timeStr = @"2011-01-26 17:40:50";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];    
    NSDate* date = [formatter dateFromString:Time]; //------------将字符串按formatter转成nsdate

 //   时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
   // NSLog(@"timeSp:%@",timeSp); //时间戳的值
    
    return timeSp;
}


//标准时间 2016-11-09 13:34:40转化成时间戳;
+(NSString *)TimeToTimestampForday:(NSString *)Time{
    
    //NSString* timeStr = @"2011-01-26 17:40:50";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:Time]; //------------将字符串按formatter转成nsdate
    
    //   时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    // NSLog(@"timeSp:%@",timeSp); //时间戳的值
    
    return timeSp;
}


//获取当前时间 ,月
+(NSString *)getCurrentTimeToyear {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY"];
    NSString*dateTime = [formatter stringFromDate:[NSDate  date]];
    // NSString *str1 = [dateTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return dateTime;
}


//获取当前时间 ,月
+(NSString *)getCurrentTimeToMonth {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM"];
    NSString*dateTime = [formatter stringFromDate:[NSDate  date]];
    // NSString *str1 = [dateTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return dateTime;
}

//获取当前时间 , 日
+(NSString *)getCurrentTimeDay {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    NSString*dateTime = [formatter stringFromDate:[NSDate  date]];
    // NSString *str1 = [dateTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return dateTime;
}

//获取当前时间 -- 时分
+(NSString *)getCurrentMutil {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString*dateTime = [formatter stringFromDate:[NSDate  date]];
    // NSString *str1 = [dateTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return dateTime;
}




@end
