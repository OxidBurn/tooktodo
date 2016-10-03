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
    return self.systemsArray.count;
}

- (NSArray*) getSystems
{
   
    return self.systemsArray;
}

- (void) handleCheckmarkForIndexPath: (NSIndexPath*) indexPath
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
        
        self.selectedSystem = self.systemsArray[indexPath.row];
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

@end