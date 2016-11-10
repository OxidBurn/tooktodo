//
//  RowContent.m
//  TookTODO
//
//  Created by Nikolay Chaban on 28.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RowContent.h"

@implementation RowContent

- (instancetype) initWithUserInteractionEnabled
{
    if (self = [super init])
    {
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

@end
