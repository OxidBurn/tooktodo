//
//  InfoiPadModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 28.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "InfoiPadModel.h"

@interface InfoiPadModel()

// properties
@property (strong, nonatomic) NSArray* titlesArray;

@property (strong, nonatomic) NSArray* seguesArray;

// methods


@end

@implementation InfoiPadModel

#pragma mark - Properties -

- (NSArray*) titlesArray
{
    if ( _titlesArray == nil )
    {
        _titlesArray = @[ @"Информация", @"Роли", @"Системы" ];
    }
    
    return _titlesArray;
}

- (NSArray*) seguesArray
{
    if ( _seguesArray == nil )
    {
        _seguesArray = @[ @"ShowInformationIDiPad", @"ShowRoleInfoIDiPad", @"ShowSystemInfoIDiPad" ];
    }
    
    return _seguesArray;
}

#pragma mark - Public -

- (NSString*) getTitleForIndexPath: (NSIndexPath*) indexPath
{
    return self.titlesArray[indexPath.row];
}

- (NSString*) getSegueIdForIndexPath: (NSIndexPath*) indexPath
{
    return self.seguesArray[indexPath.row];
}

@end
