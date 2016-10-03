//
//  NSCalendar+WeedendsCounting.h
//  TestWeekendsBetweenDates
//
//  Created by Глеб on 03.10.16.
//  Copyright © 2016 GlebCherkashyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCalendar (WeedendsCounting)

- (NSInteger) countOfWorkdaysFromDate: (NSDate*) startDate
                   toAndIncludingDate: (NSDate*) endDate;

- (NSInteger) countOfWorkdaysFromDate: (NSDate*) startDate
                               toDate: (NSDate*) endDate;
@end
