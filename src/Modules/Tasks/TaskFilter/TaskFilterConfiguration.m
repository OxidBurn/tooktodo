//
//  TaskFilterConfiguration.m
//  TookTODO
//
//  Created by Nikolay Chaban on 02.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskFilterConfiguration.h"

@implementation TaskFilterConfiguration

- (instancetype) init
{
    self = [super init];
    
    if ( self )
    {
        self.byMyRoleInProject = @(0);
    }
    
    return self;
}

@end
