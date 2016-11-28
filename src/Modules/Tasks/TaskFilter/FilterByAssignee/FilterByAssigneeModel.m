//
//  FilterByAssigneeModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 24.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByAssigneeModel.h"

// Classes
#import "DataManager+Filters.h"
#import "NSString+APUtils.h"

@interface FilterByAssigneeModel()

// properties
@property (strong, nonatomic) NSArray* assigneeArray;

@property (strong, nonatomic) NSArray* filteredAssigneesContent;

@property (strong, nonatomic) NSArray* selectedAssigneeIndexes;

@property (strong, nonatomic) NSArray* selectedAssignee;

@property (assign, nonatomic) BOOL isSelectedResponsible;

@property (assign, nonatomic) BOOL hasAnySelectedMembers;

@property (assign, nonatomic) FilterByAssigneeType filterType;

@property (assign, nonatomic) SearchTableState tableState;

// methods


@end

@implementation FilterByAssigneeModel


#pragma mark - Properties -

- (NSArray*) assigneeArray
{
    if ( _assigneeArray == nil )
    {
        switch ( self.filterType )
        {
            case FilterByCreator:
            {
                _assigneeArray = [DataManagerShared getFilterCreatorsListForCurrentProject];
            }
                break;
                
            case FilterByResponsible:
            {
                _assigneeArray = [DataManagerShared getFilterResponsiblesForCurrentProject];
            }
                break;
                
            case FilterByApprovers:
            {
                _assigneeArray = [DataManagerShared getFilterApprovesForCurrentProject];
            }
                break;
                
            default:
            {
                _assigneeArray = [NSArray new];
            }
                break;
        }
    }
    
    return _assigneeArray;
}

- (NSArray*) selectedAssigneeIndexes
{
    if ( _selectedAssigneeIndexes == nil )
    {
        _selectedAssigneeIndexes = [NSArray new];
    }
    
    return _selectedAssigneeIndexes;
}

- (NSArray*) selectedAssignee
{
    if ( _selectedAssignee == nil )
    {
        _selectedAssignee = [NSArray new];
    }
    
    return _selectedAssignee;
}


#pragma mark - Public -

- (void) fillFilterType: (FilterByAssigneeType) filterType
{
    self.filterType = filterType;
}

- (NSUInteger) getNumberOfRows
{
    switch (self.tableState)
    {
        case TableSearchState:
        {
            return self.filteredAssigneesContent.count;
        }
            break;
        case TableNormalState:
        {
            return self.assigneeArray.count;
        }
            break;
    }
}

- (void) handleAssigneeSelectionForIndexPath: (NSIndexPath*) indexPath
{
    // adding to array indexes of selected assignee
    NSMutableArray* tmp = self.selectedAssigneeIndexes.mutableCopy;
    
    NSNumber* index = @(indexPath.row);
    
    if ( [self.selectedAssigneeIndexes containsObject: index] )
    {
        [tmp removeObject: index];
    }
    else
        [tmp addObject: index];
    
    self.selectedAssigneeIndexes = tmp.copy;
    
    // adding to array selected assignees
    NSMutableArray* tmpAssignees = self.selectedAssignee.mutableCopy;
    
    ProjectTaskAssignee* selectedItem = nil;
    
    switch (self.tableState)
    {
        case TableSearchState:
            selectedItem = self.filteredAssigneesContent[indexPath.row];
            break;
        case TableNormalState:
            selectedItem = self.assigneeArray[indexPath.row];
            break;
    }
    
    if ( [self.selectedAssignee containsObject: selectedItem] )
    {
        [tmpAssignees removeObject: selectedItem];
    }
    else
        [tmpAssignees addObject: selectedItem];
    
    self.selectedAssignee = tmpAssignees.copy;
}


- (ProjectTaskAssignee*) getAssigneeForIndexPath: (NSIndexPath*) indexPath
{
    ProjectTaskAssignee* assignee = nil;
    
    switch (self.tableState)
    {
        case TableSearchState:
        {
            assignee = self.filteredAssigneesContent[indexPath.row];
        }
            break;
        case TableNormalState:
        {
            assignee = self.assigneeArray[indexPath.row];
        }
            break;
    }
    
    return assignee;
}

- (BOOL) getCheckmarkStateForIndexPath: (NSIndexPath*) indexPath
{
    BOOL isSelected;
    
    if ( [self.selectedAssigneeIndexes containsObject: @(indexPath.row)] )
        isSelected = YES;
    
    return isSelected;
}

- (void) selectAll
{
    self.selectedAssigneeIndexes = nil;
    
    __block NSMutableArray* tmp = [NSMutableArray new];
    
    switch (self.tableState)
    {
        case TableSearchState:
        {
            self.selectedAssignee = self.filteredAssigneesContent;
        
            [self.filteredAssigneesContent enumerateObjectsUsingBlock: ^(ProjectTaskAssignee* assignee, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [tmp addObject: @(idx)];
                
            }];
        }
            break;
            
        case TableNormalState:
        {
            self.selectedAssignee = self.assigneeArray;
            
            [self.assigneeArray enumerateObjectsUsingBlock: ^(ProjectTaskAssignee* assignee, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [tmp addObject: @(idx)];
                
            }];
        }
            break;
            
        default:
            break;
    }
    
    self.selectedAssigneeIndexes = tmp.copy;
}

- (void) deselectAll
{
    self.selectedAssigneeIndexes = nil;
    self.selectedAssignee        = nil;
}

- (NSArray*) getSelectedAssignees
{
    return self.selectedAssignee;
}

- (void) updateSelectedIndexesAfterApplyingSearch
{
  __block NSMutableArray* updatedSelectedIndexes = [NSMutableArray array];
        
    [self.assigneeArray enumerateObjectsUsingBlock: ^(ProjectTaskAssignee*  _Nonnull assignee, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ( [self.selectedAssignee containsObject: assignee] )
        {
            [updatedSelectedIndexes addObject: @(idx)];
        }
        
    }];
        
    self.selectedAssigneeIndexes = updatedSelectedIndexes.copy;
    
    updatedSelectedIndexes = nil;
}

- (NSArray*) getSelectedAssingeesIndexes
{
    if ( self.tableState == TableSearchState )
    {
        [self updateSelectedIndexesAfterApplyingSearch];
    }
    
    return self.selectedAssigneeIndexes;
}

- (void) fillSelectedUsersInfoFromConfig: (TaskFilterConfiguration*) filterConfig
{
    switch ( self.filterType )
    {
        case FilterByCreator:
        {
            self.selectedAssignee        = filterConfig.byCreator;
            self.selectedAssigneeIndexes = filterConfig.byCreatorIndexes;
        }
            break;
            
        case FilterByApprovers:
        {
            self.selectedAssignee        = filterConfig.byApprovers;
            self.selectedAssigneeIndexes = filterConfig.byApproversIndexes;
        }
            break;
            
        case FilterByResponsible:
        {
            self.selectedAssignee        = filterConfig.byResponsible;
            self.selectedAssigneeIndexes = filterConfig.byResponsibleIndexes;
        }
            break;
            
        default:
            break;
    }
}

- (void) updateSelectedIndexesAfterSearchFiltering
{
  __block NSMutableArray* updatedSelectedIndexes = [NSMutableArray array];
    
    [self.filteredAssigneesContent enumerateObjectsUsingBlock: ^(ProjectTaskAssignee*  _Nonnull assignee, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ( [self.selectedAssignee containsObject: assignee] )
        {
            [updatedSelectedIndexes addObject: @(idx)];
        }
        
    }];
    
    self.selectedAssigneeIndexes = updatedSelectedIndexes.copy;
    
    updatedSelectedIndexes = nil;
}

- (void) applyFilteringByText: (NSString*) searchText
{
    if ( searchText.length > 0 )
    {
        __block NSMutableArray* updatedFilteredContent = [NSMutableArray array];
        
        [self.filteredAssigneesContent enumerateObjectsUsingBlock: ^(ProjectTaskAssignee*  _Nonnull assignee, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ( [assignee.firstName containsString: searchText caseSensitive: NO] || [assignee.lastName containsString: searchText caseSensitive: NO] )
            {
                [updatedFilteredContent addObject: assignee];
                
                
            }
        }];
        
        self.filteredAssigneesContent = updatedFilteredContent.copy;
        
        updatedFilteredContent = nil;
    }
    else
    {
        self.filteredAssigneesContent = self.assigneeArray;
    }
    
    [self updateSelectedIndexesAfterSearchFiltering];
}

- (void) setTableSearchState: (SearchTableState) state
{
    self.tableState = state;
    
    switch (state)
    {
        case TableSearchState:
        {
            self.filteredAssigneesContent = self.assigneeArray;
        }
            break;
        case TableNormalState:
        {
            self.filteredAssigneesContent = nil;
        }
            break;
    }
}

- (SearchTableState) getSearchTableState
{
    return self.tableState;
}

@end
