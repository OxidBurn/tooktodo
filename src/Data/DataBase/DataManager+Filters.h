//
//  DataManager+Filters.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/24/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager.h"

typedef NS_ENUM(NSUInteger, ProjectFilterType)
{
    StatusFilterType,
    CreatorsFilterType,
    ResponsiblesFilterType,
    ApprovesFilterType,
    WorkAreasFilterType,
    TypesFilterType,
    ExpiredFilterType,
};

// Classes
#import "TaskFilterConfiguration.h"
#import "ProjectTaskFilterContent+CoreDataClass.h"

@interface DataManager (Filters)

- (void) persistProjectFilter: (NSDictionary*)         filter
                     withType: (ProjectFilterType)     type
             forProjectWithID: (NSNumber*)             projectID
               withCompletion: (CompletionWithSuccess) completion;


// Getting list of filtering objects
- (NSArray*) getFilterCreatorsListForCurrentProject;

- (NSArray*) getFilterResponsiblesForCurrentProject;

- (NSArray*) getFilterApprovesForCurrentProject;

- (NSArray*) getFilterStatusesForCurrentProject;

- (NSArray*) getFilterTypesForCurrentProject;

- (NSArray*) getFilterWorkAreasForCurrentProject;

- (NSArray*) getFilterRoomsForCurrentProject;

- (ProjectTaskFilterContent*) getFilterContentForSelectedProject;

// Save filter configuration
- (void) storeFilterConfiguration: (TaskFilterConfiguration*) config
                   withCompletion: (CompletionWithSuccess)    completion;

- (void) resetFilterConfigurationWithCompletion: (CompletionWithSuccess) completion;

- (NSArray*) applyFiltersToTasks: (NSArray*) tasks;

@end
