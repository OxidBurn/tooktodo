//
//  TaskFilterModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "TaskFilterRowContent.h"
#import "TaskFilterConfiguration.h"

@interface TaskFilterModel : NSObject

// methods
- (TaskFilterRowContent*) getRowContentForIndexPath: (NSIndexPath*) indexPath;

- (NSUInteger) getNumberOfRowsIsSection: (NSUInteger) section;

- (CGFloat) getRowHeightForRowAtIndexPath: (NSIndexPath*) indexPath;

- (NSString*) getSegueIdForIndexPath: (NSIndexPath*) indexPath;

- (void) didSelectTermsCellForIndexPath: (NSIndexPath*) indexPath;

- (void) fillFilterType: (TasksFilterType) filterType;

// methods to save data from delegate methods
- (void) fillSelectedAssigneesData: (NSArray*)             selectedAssignees
                       withIndexes: (NSArray*)             indexesArray
                     forFilterType: (FilterByAssigneeType) filterType;

- (void) fillSelectedStatusesData: (NSArray*) selectedStatuses;

// helpers for test

- (void) saveFilterConfigurationWithCompletion: (CompletionWithSuccess) completion;

- (void) resetFilterConfigurationForCurrentProject: (CompletionWithSuccess) completion;

- (TaskFilterConfiguration*) getFilterConfig;

@end
