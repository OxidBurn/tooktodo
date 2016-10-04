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

//Properties
@property (nonatomic, strong) NSArray* systemsArray;

@property (strong, nonatomic) NSIndexPath* lastIndexPath;

@property (strong, nonatomic) ProjectSystem* selectedSystem;

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
    return self.systemsArray.count + 1;
}

- (NSArray*) getSystems
{
    return self.systemsArray;
}

- (void) handleCheckmarkForIndexPath: (NSIndexPath*) indexPath
{
    if ( indexPath.row == 0 )
    {
        self.selectedSystem.isSelected = @(NO);
        self.selectedSystem            = nil;
    }
    else
    {
        self.selectedSystem = self.systemsArray[indexPath.row - 1];
        
        if ([indexPath compare: self.lastIndexPath] != NSOrderedSame)
        {
           self.selectedSystem.isSelected = @(YES);
        }
        else
        {
            self.selectedSystem.isSelected = @(NO);
        }
    }
}

- (void) updateLastIndexPath: (NSIndexPath*) indexPath
{
    self.lastIndexPath = indexPath;
}

- (ProjectSystem*) getSelectedSystem
{
    return self.selectedSystem;
}

- (NSIndexPath*) getLastIndexPath
{
    return self.lastIndexPath;
}

- (void) fillSelectedSystem: (ProjectSystem*) system
{
   self.selectedSystem = system;
    
    NSUInteger indexOfSelectedSystem = [self.systemsArray indexOfObject: system];
    
    self.lastIndexPath = [NSIndexPath indexPathForRow: indexOfSelectedSystem + 1
                                            inSection: 0];
}

- (BOOL) systemsIsSelected: (ProjectSystem*) system
{
    return ([self.selectedSystem isEqual: system]);
}

@end
