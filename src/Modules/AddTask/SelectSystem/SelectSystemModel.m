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
    
    if ([indexPath isEqual: self.lastIndexPath])
    {
        self.lastIndexPath = nil;
    }
    
    if (self.systemsArray.count > 0)
    {
        if ( [indexPath isEqual: self.lastIndexPath] == NO )
        {
            
            [self.systemsArray enumerateObjectsUsingBlock: ^(ProjectSystem* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                obj.isSelected = @(0);
                
                if ( idx == indexPath.row )
                {
                    obj.isSelected = @(1);
                }
            }];
            
            if (indexPath.row != 0)
            {
                //self.selectedSystem = nil;
                
                self.selectedSystem = self.systemsArray[indexPath.row - 1];

            }
            
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
   //self.selectedSystem = system;
    
    [self.systemsArray enumerateObjectsUsingBlock:^(ProjectSystem* newSystem, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([system.systemID isEqual: self.selectedSystem.systemID])
        {
            newSystem.isSelected = system.isSelected;
            
            NSIndexPath* temp = [NSIndexPath indexPathForRow: idx inSection: 2];
            
            self.lastIndexPath = temp;
        }
        
        
    }];
}

@end
