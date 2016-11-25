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

@interface FilterByAssigneeModel()

// properties
@property (strong, nonatomic) NSArray* assigneeArray;

@property (strong, nonatomic) NSArray* selectedAssigneeIndexes;

@property (strong, nonatomic) NSArray* selectedAssignee;

@property (assign, nonatomic) BOOL isSelectedResponsible;

@property (assign, nonatomic) BOOL hasAnySelectedMembers;

@property (assign, nonatomic) FilterByAssigneeType filterType;

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
    return self.assigneeArray.count;
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
    
    ProjectTaskAssignee* selectedAssignee = self.assigneeArray[indexPath.row];
    
    if ( [self.selectedAssigneeIndexes containsObject: selectedAssignee] )
    {
        [tmpAssignees removeObject: selectedAssignee];
    }
    else
        [tmpAssignees addObject: selectedAssignee];
    
    self.selectedAssignee = tmpAssignees.copy;
}


- (ProjectTaskAssignee*) getAssigneeForIndexPath: (NSIndexPath*) indexPath
{
    ProjectTaskAssignee* assignee = self.assigneeArray[indexPath.row];
    
    return assignee;
}

- (void) saveSelectedAssignees
{
    NSLog(@"selected assingnees indexes %@", self.selectedAssigneeIndexes);
    
    [self.selectedAssigneeIndexes enumerateObjectsUsingBlock: ^(NSNumber* index, NSUInteger idx, BOOL * _Nonnull stop) {
       
        ProjectTaskAssignee* assingee = self.assigneeArray[index.integerValue];
        
        NSLog(@"selected assingee %@", assingee );
        
    }];
}

- (void) selectAll
{
    
}

- (void) deselectAll
{
    
}

- (NSArray*) getSelectedAssignees
{
    return self.selectedAssignee;
}

- (NSArray*) getSelectedAssingeesIndexes
{
    return self.selectedAssigneeIndexes;
}

@end
