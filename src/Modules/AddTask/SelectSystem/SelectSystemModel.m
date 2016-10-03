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
    if ( indexPath.row == 0 && self.selectedSystem )
        self.selectedSystem.isSelected = @(NO);
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

- (BOOL) getStateForSystemAtIndex: (NSUInteger) index
{
    ProjectSystem* system = self.systemsArray[index];
    
    return system.isSelected;
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
    
    [self.systemsArray enumerateObjectsUsingBlock:^(ProjectSystem* newSystem, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self.selectedSystem.systemID isEqual: newSystem.systemID])
        {
            newSystem.isSelected = system.isSelected;
            
            NSIndexPath* temp = [NSIndexPath indexPathForRow: idx inSection: 2];
            
            self.lastIndexPath = temp;
        }
        
        
    }];
}

@end
