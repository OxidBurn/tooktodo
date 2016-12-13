//
//  OfflineSyncModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OfflineSyncModel.h"

@interface OfflineSyncModel()

// properties

@property (strong, nonatomic) NSArray* settingsContent;

@property (strong, nonatomic) NSMutableArray* currentContent;

// methods


@end

@implementation OfflineSyncModel

#pragma mark - Properties -

- (NSArray*) settingsContent
{
    if ( _settingsContent == nil )
    {
        _settingsContent = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"OfflineSyncSettings"
                                                                                             ofType: @"plist"]];
    }
    
    return _settingsContent;
}

- (NSMutableArray*) currentContent
{
    if ( _currentContent == nil )
    {
        _currentContent = [NSMutableArray arrayWithObject: @""];
    }
    
    return _currentContent;
}

@end
