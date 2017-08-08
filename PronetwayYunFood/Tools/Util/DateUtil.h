//
//  DateUtil.h
//  lfys
//
//  Created by tao on 15/6/28.
//  Copyright (c) 2015年 qinghui. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * 日期转换工具类
 */
@interface DateUtil : NSObject

/**
 *  时间戳转日期字符串,格式为yyyy-MM-dd HH:mm:ss
 *
 *  @param timestamp 事件戳
 *
 */
+(NSString *) timestampToDateTimeStr:(long) timestamp;


/**
 *  时间戳转字符串,格式为yyyy-MM-dd
 *timestamp
 *
 */
+(NSString *) timestampToDateStr:(long) timestamp;


/**
 *  时间戳转字符串,格式为yyyy-MM-dd HH:mm
 *
 *   timestamp
 *
 */
+(NSString *) timestampToMinuteStr:(long) timestamp;


/**
 *  时间戳转NSDate
 *
 *
 */
+(NSDate *) timestampToNSDate:(long) timestamp;


/**
 * 传入一个日期,得到一天的开始,即00:00:00
 *
 *
 */
+(NSString *) getDateForDayStart:(NSDate *) date;


/**
 * 传入一个日期,得到一天的结束,即23:59:59
 *
 *
 */
+(NSString *) getDateForDayEnd:(NSDate *) date;

/*
 * 将NSDate转成年、月、日的日期格式
 */
+(NSString *) dateToDateStr:(NSDate *) date;

/*
 * 将NSDate转成月、日的格式
 */
+(NSString *)dateToMonthDayStr:(NSDate *) date;


/*
 * 将NSDate转成时、分的格式
 */
+(NSString *)dateToHourMinuteStr:(NSDate *) date;


/*
 * 获取当前星期
 */
+ (NSString *)weekdayStringFromDate:(NSDate *)inputDate;

/*
 * 获取明天8点日期
 */
+(NSDate *)getTomorrowAightOclock;


/**
 *  字符串转date*
 */
+(NSDate *)stringToDate:(NSString *) dateStr;

/**
 *  日期格式转换
 *   str
 */
+(NSString *)compareCurrentTime:(NSString *)str;

/**
 *  获取当前时间戳
 */
+(NSString *)getCurrentTimestamp;
/**
 *  获取当前时间,年 月 日 类型;
 */
+(NSString *)getCurrentTime;

//标准时间 2016-11-09 13:34:40转化成时间戳
+(NSString *)TimeToTimestamp:(NSString *)Time;

//月
+(NSString *)getCurrentTimeToMonth;

//获取当前时间 , 日
+(NSString *)getCurrentTimeDay;

//获取当前时间 , 年
+(NSString *)getCurrentTimeToyear;


//标准时间 2016-11-09
+(NSString *)TimeToTimestampForday:(NSString *)Time;

//获取当前时间 -- 时 分 精确到分 
+(NSString *)getCurrentMutil;

//获取当前时间,精确到秒
+(NSString *)getCurrentTimeFormiao;

@end
