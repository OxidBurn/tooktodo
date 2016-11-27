//
//  TermsData.m
//  TookTODO
//
//  Created by Nikolay Chaban on 03.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TermsData.h"

// Classes
#import "NSDate+Helper.h"

@implementation TermsData

- (instancetype) initWithStartDate: (NSDate*) startDate
                       withEndDate: (NSDate*) endDate
{
    if ( self = [super init] )
    {
        self.startDate       = startDate;
        self.startDateString = [NSDate stringFromDate: startDate
                                           withFormat: @"yyyy.dd.MM"];
        self.endDate         = endDate;
        self.endDateString   = [NSDate stringFromDate: endDate
                                         withFormat: @"yyyy.dd.MM"];
    }
    
    return self;
}

@end
