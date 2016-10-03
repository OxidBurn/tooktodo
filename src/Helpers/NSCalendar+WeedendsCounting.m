//
//  NSCalendar+WeedendsCounting.m
//  TestWeekendsBetweenDates
//
//  Created by Глеб on 03.10.16.
//  Copyright © 2016 GlebCherkashyn. All rights reserved.
//

#import "NSCalendar+WeedendsCounting.h"

@implementation NSCalendar (WeedendsCounting)

#pragma mark - Public -

- (NSInteger) countOfWorkdaysFromDate: (NSDate*) startDate
                   toAndIncludingDate: (NSDate*) endDate
{
    NSInteger workdays   = 5 * [self inclusiveCountOfWeeksFromDate: startDate
                                                            toDate: endDate];
    
    NSInteger beforeDays = [self countOfWorkdaysPrecedingDate: startDate];
    
    NSInteger afterDays  = [self countOfWorkdaysFollowingDate: endDate];
    
    return workdays - beforeDays - afterDays;
}

- (NSInteger) countOfWorkdaysFromDate: (NSDate*) startDate
                               toDate: (NSDate*) endDate
{
    NSInteger workdays   = 5 * [self inclusiveCountOfWeeksFromDate : startDate
                                                             toDate: endDate];
    
    NSInteger beforeDays = [self countOfWorkdaysPrecedingDate: startDate];
    
    NSInteger afterDays  = [self countOfWorkdaysFollowingAndIncludingDate: endDate];
    
    return workdays - beforeDays - afterDays;
}

#pragma mark - Helpers -

- (NSInteger) inclusiveCountOfWeeksFromDate: (NSDate*) startDate
                                     toDate: (NSDate*) endDate
{
    startDate = [self sundayOnOrBeforeDate: startDate];
    endDate   = [self sundayAfterDate:      endDate];
    
    NSDateComponents* components = [self components: NSCalendarUnitDay
                                           fromDate: startDate
                                             toDate: endDate
                                            options: 0];
    return components.day / 7;
}

- (NSDate*) sundayOnOrBeforeDate: (NSDate*) date
{
    return [self dateByAddingDays: 1 - [self weekdayOfDate: date]
                           toDate: date];
}

- (NSDate*) sundayAfterDate: (NSDate*) date
{
    return [self dateByAddingDays: 8 - [self weekdayOfDate: date]
                           toDate: date];
}

- (NSInteger) weekdayOfDate: (NSDate*) date
{
    return [self components: NSCalendarUnitWeekday
                   fromDate: date].weekday;
}

- (NSDate*) dateByAddingDays: (NSInteger) days
                      toDate: (NSDate*)   date
{
    if ( days != 0 )
    {
        NSDateComponents* components = [[NSDateComponents alloc] init];
        
        components.day = days;
        
        date = [self dateByAddingComponents: components
                                     toDate: date
                                    options: 0];
    }
    return date;
}

- (NSInteger) countOfWorkdaysPrecedingDate: (NSDate*) date
{
    switch ( [self weekdayOfDate:date] )
    {
        case 1: return 0; break;
        case 2: return 0; break;
        case 3: return 1; break;
        case 4: return 2; break;
        case 5: return 3; break;
        case 6: return 4; break;
        case 7: return 5; break;
            
        default: abort();
    }
}

- (NSInteger) countOfWorkdaysFollowingAndIncludingDate: (NSDate*) date
{
    switch ( [self weekdayOfDate:date] )
    {
        case 1: return 5; break;
        case 2: return 5; break;
        case 3: return 4; break;
        case 4: return 3; break;
        case 5: return 2; break;
        case 6: return 1; break;
        case 7: return 0; break;
            
        default: abort();
    }
}

- (NSInteger) countOfWorkdaysFollowingDate: (NSDate*) date
{
    switch ( [self weekdayOfDate: date] )
    {
        case 1: return 5; break;
        case 2: return 4; break;
        case 3: return 3; break;
        case 4: return 2; break;
        case 5: return 1; break;
        case 6: return 0; break;
        case 7: return 0; break;
            
        default: abort();
    }
}

@end
