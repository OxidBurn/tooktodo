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

@interface FilterByAssigneeModel : NSObject

// methods
- (NSUInteger) getNumberOfRows;

- (void) handleAssigneeSelectionForIndexPath: (NSIndexPath*) indexPath;

- (void) fillFilterType: (FilterByAssigneeType) filterType;

- (void) selectAll;

- (void) deselectAll;

- (ProjectTaskAssignee*) getAssigneeForIndexPath: (NSIndexPath*) indexPath;

- (NSArray*) getSelectedAssignees;

- (NSArray*) getSelectedAssingeesIndexes;

@end
