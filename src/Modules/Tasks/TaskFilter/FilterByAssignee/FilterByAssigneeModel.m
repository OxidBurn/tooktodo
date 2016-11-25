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

@property (strong, nonatomic) NSArray* selectedAssigneeArray;

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
                
            default:
            {
                _assigneeArray = [NSArray new];
            }
                break;
        }
    }
    
    return _assigneeArray;
}

- (NSArray*) selectedAssigneeArray
{
    if ( _selectedAssigneeArray == nil )
    {
        _selectedAssigneeArray = [NSArray new];
    }
    
    return _selectedAssigneeArray;
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
    NSMutableArray* tmp = self.selectedAssigneeArray.mutableCopy;
    
    NSNumber* index = @(indexPath.row);
    
    if ( [self.selectedAssigneeArray containsObject: index] )
    {
        [tmp removeObject: index];
    }
    else
        [tmp addObject: index];
    
    self.selectedAssigneeArray = tmp.copy;
}


- (ProjectTaskAssignee*) getAssigneeForIndexPath: (NSIndexPath*) indexPath
{
    ProjectTaskAssignee* assignee = self.assigneeArray[indexPath.row];
    
    return assignee;
}

- (void) saveSelectedAssignees
{
    NSLog(@"selected assingnees indexes %@", self.selectedAssigneeArray);
    
    [self.selectedAssigneeArray enumerateObjectsUsingBlock: ^(NSNumber* index, NSUInteger idx, BOOL * _Nonnull stop) {
       
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

@end
