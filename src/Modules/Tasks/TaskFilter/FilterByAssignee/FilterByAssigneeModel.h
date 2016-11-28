//
//  FilterByAssigneeModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 24.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "ProjectsEnumerations.h"
#import "ProjectTaskAssignee+CoreDataProperties.h"
#import "TaskFilterConfiguration.h"

typedef NS_ENUM(NSUInteger, SearchTableState)
{
    TableNormalState = 0,
    TableSearchState = 1,
};

@interface FilterByAssigneeModel : NSObject

// methods
- (NSUInteger) getNumberOfRows;

- (void) handleAssigneeSelectionForIndexPath: (NSIndexPath*) indexPath;

- (void) fillFilterType: (FilterByAssigneeType) filterType;

- (BOOL) getCheckmarkStateForIndexPath: (NSIndexPath*) indexPath;

- (void) selectAll;

- (void) deselectAll;

- (ProjectTaskAssignee*) getAssigneeForIndexPath: (NSIndexPath*) indexPath;

- (NSArray*) getSelectedAssignees;

- (NSArray*) getSelectedAssingeesIndexes;

- (void) fillSelectedUsersInfoFromConfig: (TaskFilterConfiguration*) filterConfig;

- (void) setTableSearchState: (SearchTableState) state;

- (void) applyFilteringByText: (NSString*) text;

- (SearchTableState) getSearchTableState;

- (BOOL) checkIfAllSelected;


@end
