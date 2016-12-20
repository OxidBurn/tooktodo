//
//  NewTask.m
//  TookTODO
//
//  Created by Nikolay Chaban on 21.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "NewTask.h"

@implementation NewTask

#pragma mark - Properties -

- (TermsData*) terms
{
    if ( _terms == nil )
    {
        _terms = [TermsData new];
    }
    
    return _terms;
}


#pragma mark - Desctiption -

- (NSString*) description
{
    return [NSString stringWithFormat: @"New task: \nname:%@, description: %@", self.taskName, self.taskDescription];
}

@end
