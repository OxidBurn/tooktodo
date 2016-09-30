//
//  SelectSystemModel.m
//  TookTODO
//
//  Created by Lera on 30.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectSystemModel.h"

//Classes
#import "DataManager+Systems.h"

@interface SelectSystemModel()

@property (nonatomic, strong) NSArray* systemsArray;

@end

@implementation SelectSystemModel

#pragma mark - Properties-

- (NSArray*) systemsArray
{
    if (_systemsArray == nil)
    {
        _systemsArray = [DataManagerShared getAllSystemsForCurrentProject];
    }
    
    return _systemsArray;
}

#pragma mark - Public -

- (NSInteger) countOfRows
{
    return self.systemsArray.count;
}

- (NSArray*) getSystems
{
    return self.systemsArray;
}


@end
