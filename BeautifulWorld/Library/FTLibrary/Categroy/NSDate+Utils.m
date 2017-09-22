//
//  NSDate+Utils.m
//  iOSCodeProject
//
//  Created by Fox on 14-7-18.
//  Copyright (c) 2014年 翔傲信息科技（上海）有限公司. All rights reserved.
//

#import "NSDate+Utils.h"

@implementation NSDate (Utils)

#pragma mark - Date Property

-(NSInteger)year{
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit fromDate:self];
    return [components year];
    
}

-(NSInteger)month{
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSMonthCalendarUnit fromDate:self];
    return [components month];
    
}

-(NSInteger)day{
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit fromDate:self];
    return [components day];
    
}

-(NSInteger)numDaysInMonth{
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange rng = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
    NSUInteger numberOfDaysInMonth = rng.length;
    return numberOfDaysInMonth;
}

#pragma mark - Format Date

+ (NSString *)currentTimeString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSString *)currentFullTimeString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSString *)currentDetailTimeString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"HH:mm:ss"];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSDate*)dateWithString:(NSString*)dateString formatString:(NSString*)dateFormatterString {
	if(!dateString) return nil;
	
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:dateFormatterString];
	
	NSDate *theDate = [formatter dateFromString:dateString];
    
	return theDate;
}

+ (NSDate*)dateWithDateString:(NSString*)str{
    return [[self class] dateWithString:str formatString:@"yyyy-MM-dd"];
}

+ (NSDate*)dateWithDateTimeString:(NSString*)str{
    return [[self class] dateWithString:str formatString:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)formatStringWithFormat:(NSString *)formatString{

    if (formatString.length == 0) {
        return @"";
    }
    //@"yyyy-MM-dd"
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    
    return [dateFormatter stringFromDate:self];
}

+ (NSString *)dateFormTimestampString:(NSString *)timestamp{
    
    NSTimeInterval timeInterval = [timestamp doubleValue];
    NSDate *confromTimsp = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    return [formatter stringFromDate:confromTimsp];
}

+ (NSString *)dateFormTimestampStringForMinute:(NSString *)timestamp
{
    NSTimeInterval timeInterval = [timestamp doubleValue];
    NSDate *confromTimsp = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    return [formatter stringFromDate:confromTimsp];
}

+ (NSString *)dateFormTimestampStringForDay:(NSString *)timestamp;
{
    NSTimeInterval timeInterval = [timestamp doubleValue];
    NSDate *confromTimsp = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    
    return [formatter stringFromDate:confromTimsp];
}


+ (NSString *)dateFormTimestampStringForMonth:(NSString *)timestamp
{
    NSTimeInterval timeInterval = [timestamp doubleValue];
    NSDate *confromTimsp = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM-dd"];
    
    return [formatter stringFromDate:confromTimsp];
}


+ (NSString *)dateFormTimestampStringForDayed:(NSString *)timestamp{
    
    NSTimeInterval timeInterval = [timestamp doubleValue];
    NSDate *confromTimsp = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM月dd日HH:mm"];
    
    return [formatter stringFromDate:confromTimsp];
}


+ (NSString *)dateFormTimestampStringForYearAndMonth:(NSString *)timestamp
{
    NSTimeInterval timeInterval = [timestamp doubleValue];
    NSDate *confromTimsp = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月"];
    
    return [formatter stringFromDate:confromTimsp];
}


+ (NSString *)dateFormmterFormSecond:(int)count{
    
    //先计算天数
    int laveCounts = count;
    int days = laveCounts/(60*60*12);
    laveCounts = laveCounts - days*(60*60*12);
    
    //计算小时
    int hours = laveCounts/(60*60);
    laveCounts = laveCounts - hours*(60*60);
    
    //计算分钟
    int minutes = laveCounts/60;
    laveCounts = laveCounts - minutes*60;
    
    //剩余未秒数
    int second = laveCounts;
    
    return [NSString stringWithFormat:@"%d天%d小时%d分%d秒",days,hours,minutes,second];
}

- (NSString*)formattedExactRelativeDate{
    
    NSTimeInterval time = [self timeIntervalSince1970];
	NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
	NSTimeInterval diff = now - time;
	
	if(diff < 10) {
        return [NSString stringWithFormat:@"刚刚"];
	} else if(diff < 60) {
        return [NSString stringWithFormat:@"%d秒前",(int)diff];
	}
	
	diff = round(diff/60);
	if(diff < 60) {
		if(diff == 1) {
            return [NSString stringWithFormat:@"%d分钟前",(int)diff];
		} else {
            return [NSString stringWithFormat:@"%d分钟前",(int)diff];
		}
	}
	
	diff = round(diff/60);
	if(diff < 24) {
		if(diff == 1) {
            return [NSString stringWithFormat:@"%d小时前",(int)diff];
		} else {
            return [NSString stringWithFormat:@"%d小时前",(int)diff];
		}
	}
	
	if(diff < 7) {
		if(diff == 1) {
			return @"昨天";
		} else {
            return [NSString stringWithFormat:@"%d天前", (int)diff];
		}
	}
	
	return [self formattedDateWithFormatString:@"MM/dd/yy"];
}

- (NSString*)formattedDateWithFormatString:(NSString*)dateFormatterString {
	if(!dateFormatterString) return nil;
	
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:dateFormatterString];
	[formatter setAMSymbol:@"am"];
	[formatter setPMSymbol:@"pm"];
	return [formatter stringFromDate:self];
}

+ (NSString *)pastDateString:(int )pageDays{
    
    NSDate *lastDate = [[NSDate date] dateByAddingTimeInterval:pageDays*86400*-1];
    NSMutableString *currentString = [NSMutableString stringWithFormat:@"%@",lastDate];
    return [currentString substringToIndex:10];
}

+ (NSString *)addDateString:(int )pageDays{
    
    NSDate *lastDate = [[NSDate date] dateByAddingTimeInterval:pageDays*86400];
    NSMutableString *currentString = [NSMutableString stringWithFormat:@"%@",lastDate];
    return [currentString substringToIndex:10];
}

+ (NSString *)pastMonthDateString:(int )pastMonth{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:-1 * pastMonth];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:[NSDate date] options:0];
    NSMutableString *currentString = [NSMutableString stringWithFormat:@"%@",mDate];
    return [currentString substringToIndex:10];
}

#pragma mark - Time comparison

- (BOOL)isPastDate{
    NSDate* now = [NSDate date];
	if([[now earlierDate:self] isEqualToDate:self]) {
		return YES;
	} else {
		return NO;
	}
}

- (BOOL)isDateToday{
    return [[[NSDate date] midnightDate] isEqual:[self midnightDate]];
}

- (BOOL)isDateYesterday{
    return [[[NSDate dateWithTimeIntervalSinceNow:-86400] midnightDate]
            isEqual:[self midnightDate]];
}

- (NSDate*)midnightDate {
	return [[NSCalendar currentCalendar] dateFromComponents:
            [[NSCalendar currentCalendar] components:
             (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self]];
}


/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获得某个时间的年月日时分秒
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}

/**
 *  判断某个时间是否为3天前
 */
- (BOOL)isThreedayBefore
{
    NSDate *now = [NSDate date];
    
    // date ==  2014-04-30 10:05:28 --> 2014-04-30 00:00:00
    // now == 2014-05-01 09:22:10 --> 2014-05-01 00:00:00
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 2014-04-30
    NSString *dateStr = [fmt stringFromDate:self];
    // 2014-10-18
    NSString *nowStr = [fmt stringFromDate:now];
    
    // 2014-10-30 00:00:00
    NSDate *date = [fmt dateFromString:dateStr];
    // 2014-10-18 00:00:00
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 3;
}

/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    BOOL bo = [dateStr isEqualToString:nowStr];
    return [dateStr isEqualToString:nowStr];
}
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday
{
    NSDate *now = [NSDate date];
    
    // date ==  2014-04-30 10:05:28 --> 2014-04-30 00:00:00
    // now == 2014-05-01 09:22:10 --> 2014-05-01 00:00:00
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 2014-04-30
    NSString *dateStr = [fmt stringFromDate:self];
    // 2014-10-18
    NSString *nowStr = [fmt stringFromDate:now];
    
    // 2014-10-30 00:00:00
    NSDate *date = [fmt dateFromString:dateStr];
    // 2014-10-18 00:00:00
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}
@end
