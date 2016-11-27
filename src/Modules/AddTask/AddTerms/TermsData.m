//
//  TermsData.m
//  TookTODO
//
//  Created by Nikolay Chaban on 03.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TermsData.h"

@implementation TermsData

- (instancetype) initWithStartDate: (NSDate*) startDate
                       withEndDate: (NSDate*) endDate
{
    if ( self = [super init] )
    {
        self.startDate = startDate;
        self.endDate   = endDate;
    }
    
    return self;
}

@end
