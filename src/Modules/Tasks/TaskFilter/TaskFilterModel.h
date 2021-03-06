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
#import "TaskFilterContentManager.h"
#import "ProjectSystem+CoreDataProperties.h"

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

- (void) fillSelectedAditionalTermsOptionsWithValue: (BOOL)                           isOn
                                             forTag: (TaskFilterAditionalOptionsTags) tag;

- (void) fillTaskType: (NSArray*) taskTypes;

- (void) fillSystemInfo: (ProjectSystem*) system;

- (void) fillTermsInfo: (TermsData*)                     terms
     forControllerType: (FilterByDateViewControllerType) controllerType;

- (void) fillSelectedRoleType: (NSNumber*) selectedRole;

- (void) fillSelectedProjects: (NSArray*) selectedProjects
                  withIndexes: (NSArray*) selectedProjectsIndexes;
// helpers for test

- (void) saveFilterConfigurationWithCompletion: (CompletionWithSuccess) completion;

- (void) resetFilterConfigurationForCurrentProject: (CompletionWithSuccess) completion;

- (TaskFilterConfiguration*) getFilterConfig;

- (void) fillSelectedRoomsData: (NSArray*) selectedRooms
                   withIndexes: (NSArray*) selRoomIndexes;

- (void) fillSelectedSystemData: (NSArray*) selectedSystems
                    withIndexes: (NSArray*) selectedIndexes;

@end
