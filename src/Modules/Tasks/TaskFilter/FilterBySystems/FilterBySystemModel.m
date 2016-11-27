//
//  FilterBySystemModel.m
//  TookTODO
//
//  Created by Lera on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterBySystemModel.h"
#import "DataManager+Filters.h"

@interface FilterBySystemModel()

// properties

@property (nonatomic, strong) NSArray* systemsArray;

@property (nonatomic, strong) NSArray* selectedSystemsArray;

@property (nonatomic, strong) NSArray* selectedSystemsIndexesArray;

// methods


@end

@implementation FilterBySystemModel


#pragma mark - Properties -

- (NSArray*) systemsArray
{
    if (_systemsArray == nil)
    {
        _systemsArray = [DataManagerShared getFilterSystemsForCurrentProject];
    }
    
    return _systemsArray;
}

- (NSArray*) selectedSystemsArray
{
    if (_selectedSystemsArray == nil)
    {
        _selectedSystemsArray = [NSArray array];
    }
    
    return _selectedSystemsArray;
}

- (NSArray*) selectedSystemsIndexesArray
{
    if (_selectedSystemsIndexesArray == nil)
    {
        _selectedSystemsIndexesArray = [NSArray array];
    }
    
    return _selectedSystemsIndexesArray;
}

#pragma mark - Public -

- (NSArray*) getSelectedSystemsIndexes
{
    return self.selectedSystemsIndexesArray;
}

- (NSArray*) getSelectedSystems
{
    return self.selectedSystemsArray;
}

- (void) handleSystemSelectionForIndexPath: (NSIndexPath*) indexPath
{
    // adding to array indexes of selected assignee
    NSMutableArray* tmp = self.selectedSystemsIndexesArray.mutableCopy;
    
    NSNumber* index = @(indexPath.row);
    
    if ( [self.selectedSystemsIndexesArray containsObject: index] )
    {
        [tmp removeObject: index];
    }
    else
        [tmp addObject: index];
    
    self.selectedSystemsIndexesArray = tmp.copy;
    
    // adding to array selected assignees
    NSMutableArray* tmpRooms = self.selectedSystemsArray.mutableCopy;
    
    ProjectSystem* selectedSystem = self.systemsArray[indexPath.row];
    
    if ( [self.selectedSystemsArray containsObject: selectedSystem] )
    {
        [tmpRooms removeObject: selectedSystem];
    }
    else
        [tmpRooms addObject: selectedSystem];
    
    self.selectedSystemsArray = tmpRooms.copy;
    
}

- (BOOL) getCheckmarkStateForIndexPath: (NSIndexPath*) indexPath
{
    BOOL isSelected;
    
    [self handleSystemSelectionForIndexPath: indexPath];
    
    if ( [self.selectedSystemsIndexesArray containsObject: @(indexPath.row)] )
        isSelected = YES;
    
    return isSelected;
}

- (void) selectAll
{
    self.selectedSystemsIndexesArray = nil;
    self.selectedSystemsArray        = self.systemsArray;
    
    __block NSMutableArray* tmp = [NSMutableArray new];
    
    [self.systemsArray enumerateObjectsUsingBlock: ^(ProjectSystem* system, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [tmp addObject: @(idx)];
        
    }];
    
    self.selectedSystemsIndexesArray = tmp.copy;
}

- (void) deselectAll
{
    self.selectedSystemsIndexesArray = nil;
    self.selectedSystemsArray       = nil;
}

- (void) fillSelectedRoomsInfoFromConfig: (TaskFilterConfiguration*) filterConfig
{
    
    self.selectedSystemsArray        = filterConfig.bySystem;
    self.selectedSystemsIndexesArray = filterConfig.bySystemIndexes;
    
}


- (NSString*) getSystemTitleForIndexPath: (NSIndexPath*) indexPath
{
    ProjectSystem* system = self.systemsArray[indexPath.row];
    
    return system.title;
}

- (NSUInteger) getNumberOfRows
{
    return self.systemsArray.count;
}


@end
