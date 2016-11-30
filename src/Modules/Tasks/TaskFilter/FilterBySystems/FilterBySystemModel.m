//
//  FilterByWorkAreaModel.m
//  TookTODO
//
//  Created by Lera on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterBySystemModel.h"

// Classes
#import "DataManager+Filters.h"
#import "ProjectTaskWorkArea+CoreDataClass.h"

@interface FilterBySystemModel()

// properties

@property (nonatomic, strong) NSArray* workAreasArray;

@property (nonatomic, strong) NSArray* selectedWorkAreasArray;

@property (nonatomic, strong) NSArray* selectedWorkAreasIndexesArray;

// methods


@end

@implementation FilterBySystemModel


#pragma mark - Properties -

- (NSArray*) workAreasArray
{
    if (_workAreasArray == nil)
    {
        _workAreasArray = [DataManagerShared getFilterWorkAreasForCurrentProject];
    }
    
    return _workAreasArray;
}

- (NSArray*) selectedWorkAreasArray
{
    if (_selectedWorkAreasArray == nil)
    {
        _selectedWorkAreasArray = [NSArray array];
    }
    
    return _selectedWorkAreasArray;
}

- (NSArray*) selectedWorkAreasIndexesArray
{
    if (_selectedWorkAreasIndexesArray == nil)
    {
        _selectedWorkAreasIndexesArray = [NSArray array];
    }
    
    return _selectedWorkAreasIndexesArray;
}

#pragma mark - Public -

- (NSArray*) getSelectedWorkAreasIndexes
{
    return self.selectedWorkAreasIndexesArray;
}

- (NSArray*) getSelectedWorkAreas
{
    return self.selectedWorkAreasArray;
}

- (void) handleWorkAreaSelectionForIndexPath: (NSIndexPath*) indexPath
{
    // adding to array indexes of selected assignee
    NSMutableArray* tmp = self.selectedWorkAreasIndexesArray.mutableCopy;
    
    NSNumber* index = @(indexPath.row);
    
    if ( [self.selectedWorkAreasIndexesArray containsObject: index] )
    {
        [tmp removeObject: index];
    }
    else
        [tmp addObject: index];
    
    self.selectedWorkAreasIndexesArray = tmp.copy;
    
    // adding to array selected assignees
    NSMutableArray* tmpWorkAreas = self.selectedWorkAreasArray.mutableCopy;
    
    ProjectTaskWorkArea* selectedWorkArea = self.workAreasArray[indexPath.row];
    
    if ( [self.selectedWorkAreasArray containsObject: selectedWorkArea] )
    {
        [tmpWorkAreas removeObject: selectedWorkArea];
    }
    else
        [tmpWorkAreas addObject: selectedWorkArea];
    
    self.selectedWorkAreasArray = tmpWorkAreas.copy;
    
}

- (BOOL) getCheckmarkStateForIndexPath: (NSIndexPath*) indexPath
{
    BOOL isSelected;
    
    [self handleWorkAreaSelectionForIndexPath: indexPath];
    
    if ( [self.selectedWorkAreasIndexesArray containsObject: @(indexPath.row)] )
        isSelected = YES;
    
    return isSelected;
}

- (void) selectAll
{
    self.selectedWorkAreasIndexesArray = nil;
    self.selectedWorkAreasArray        = self.workAreasArray;
    
    __block NSMutableArray* tmp = [NSMutableArray new];
    
    [self.workAreasArray enumerateObjectsUsingBlock: ^(ProjectTaskWorkArea* WorkArea, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [tmp addObject: @(idx)];
        
    }];
    
    self.selectedWorkAreasIndexesArray = tmp.copy;
}

- (void) deselectAll
{
    self.selectedWorkAreasIndexesArray = nil;
    self.selectedWorkAreasArray       = nil;
}

- (void) fillSelectedWorkAreasInfoFromConfig: (TaskFilterConfiguration*) filterConfig
{
    self.selectedWorkAreasArray        = filterConfig.byWorkAreas;
    self.selectedWorkAreasIndexesArray = filterConfig.byWorkAreasIndexes;
    
}


- (NSString*) getWorkAreaTitleForIndexPath: (NSIndexPath*) indexPath
{
    ProjectTaskWorkArea* workArea = self.workAreasArray[indexPath.row];
    
    return workArea.title;
}

- (NSUInteger) getNumberOfRows
{
    return self.workAreasArray.count;
}

- (BOOL) checkIfAllSelected
{
    return (self.selectedWorkAreasArray.count == self.workAreasArray.count);
}


@end
