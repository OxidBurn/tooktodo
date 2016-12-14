//
//  NSCalendar+WeedendsCounting.h
//  TestWeekendsBetweenDates
//
//  Created by Nikolay Chaban on 03.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCalendar (WeedendsCounting)

- (NSInteger) countOfWorkdaysFromDate: (NSDate*) startDate
                   toAndIncludingDate: (NSDate*) endDate;

- (NSInteger) countOfWorkdaysFromDate: (NSDate*) startDate
                               toDate: (NSDate*) endDate;
@end
