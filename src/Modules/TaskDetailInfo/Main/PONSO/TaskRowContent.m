//
//  TaskRowContent.m
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskRowContent.h"

@implementation TaskRowContent


#pragma mark - Properties -

- (NSString*) newTermsValue
{
    if ( _newTermsValue == nil )
    {
        _newTermsValue = [NSString new];
    }
    
    return _newTermsValue;
}

@end
