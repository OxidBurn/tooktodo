//
//  TermsData.h
//  TookTODO
//
//  Created by Nikolay Chaban on 03.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TermsData : NSObject

@property (strong, nonatomic) NSDate* startDate;

@property (strong, nonatomic) NSString* startDateString;

@property (strong, nonatomic) NSDate* endDate;

@property (strong, nonatomic) NSDate* factualStartDate;

@property (strong, nonatomic) NSDate* factualEndDate;

@property (strong, nonatomic) NSDate* closedDate;

@property (strong, nonatomic) NSString* endDateString;

@property (assign, nonatomic) NSUInteger duration;

@property (assign, nonatomic) BOOL includingWeekends;

@property (assign, nonatomic) BOOL isUrgent;

- (instancetype) initWithStartDate: (NSDate*) startDate
                       withEndDate: (NSDate*) endDate;

@end
