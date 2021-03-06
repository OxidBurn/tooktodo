//
//  DataManager+AllProjectsFilter.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/28/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager+AllProjectsFilter.h"

// Classes
#import "ProjectInfo+CoreDataClass.h"
#import "ProjectTask+CoreDataClass.h"
#import "DataManager+Filters.h"
#import "ProjectsEnumerations.h"
#import "DataManager+UserInfo.h"

// Categories
#import "NSDate-Utilities.h"

@implementation DataManager (AllProjectsFilter)


#pragma mark - Public methods -

- (void) saveAllProjectTasksFilterContent: (TaskFilterConfiguration*) config
                           withCompletion: (CompletionWithSuccess)    completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        AllProjectTasksFilterContent* filterContent = [AllProjectTasksFilterContent MR_findFirstInContext: localContext];
        
        if ( filterContent == nil )
        {
            filterContent = [AllProjectTasksFilterContent MR_createEntityInContext: localContext];
        }
        
        // Role in project
        [self saveFilerRoleInProject: filterContent
                           withValue: config.byMyRoleInProject];
        
        // Dates
        [self saveFiltersDateFromConfig: filterContent
                             withConfig: config];
        
        // --- Boolean values ---
        // Done value
        [self saveFilterisDoneOptionFromConfig: filterContent
                                     withValue: config.isDone];
        
        // Expired
        [self saveFilterisExpiredOptionFromConfig: filterContent
                                        withValue: config.isOverdue];
        
        // Canceled
        [self saveFilterisCanceledOptionFromConfig: filterContent
                                         withValue: config.isCanceled];
        
        // Types
        [self saveFiltersTypesFromConfig: filterContent
                                 withSet: config.byTaskType];
        
        // Statuses
        [self saveFilterStatusesFromConfig: filterContent
                                   withSet: config.statusesList];
        
        // Projects
        [self saveFilterProjectsFromConfig: filterContent
                                   withSet: config.byProjects
                               withIndexes: config.projectsList
                                 inContext: localContext];
        
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                        
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

- (void) resetAllProjectsTasksFilterContentWithCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        AllProjectTasksFilterContent* filterContent = [self getAllProjectTaskFilterContentInContext: localContext];
        
        if ( filterContent )
            [filterContent MR_deleteEntityInContext: localContext];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

- (AllProjectTasksFilterContent*) getAllProjectsTaskFilterContent
{
    return [self getAllProjectTaskFilterContentInContext: [NSManagedObjectContext MR_defaultContext]];
}

- (NSArray*) applyAllProjectsFiltersToTasks: (NSArray*) tasks
{
    AllProjectTasksFilterContent* content = [self getAllProjectsTaskFilterContent];
    
    if ( content )
    {
        // ---- Filtering by dates ----
        // start two dates
        tasks = [self applyFilterByStartDates: tasks
                           withStartDateValue: content.startBeginDate
                             withEndDateValue: content.startEndDate];
        
        // Close two dates
        tasks = [self applyFilterByCloseDates: tasks
                           withStartDateValue: content.closeBeginDate
                             withEndDateValue: content.closeEndDate];
        
        // Factual start dates
        tasks = [self applyFilterByFactualStartDates: tasks
                                  withStartDateValue: content.factualStartBeginDate
                                    withEndDateValue: content.factualStartEndDate];
        
        // Factual end two dates
        tasks = [self applyFilterByFactualEndDates: tasks
                                withStartDateValue: content.factualCloseBeginDate
                                  withEndDateValue: content.factualCloseEndDate];
        
        // Filtering by type
        tasks = [self applyFilterByType: tasks
                              withTypes: (NSArray*)content.types];
        
        // Filtering by status
        tasks = [self applyStatusesFilter: tasks
                               withFilter: (NSArray*)content.statuses];
        
        // Role in task
        tasks = [self applyFilterByCurrentUserRole: tasks
                                          userRole: content.rolesInProject.integerValue];
    }
    
    return tasks;
}

- (NSArray*) applyFiltersToProject: (NSArray*) projects
{
    AllProjectTasksFilterContent* content = [self getAllProjectsTaskFilterContent];
    
    if ( content &&
        content.projects.count > 0 )
    {
        return content.projects.array;
    }
    
    return projects;
}


#pragma mark - Internal methods -

- (AllProjectTasksFilterContent*) getAllProjectTaskFilterContentInContext: (NSManagedObjectContext*) context
{
    AllProjectTasksFilterContent* filterContent = [AllProjectTasksFilterContent MR_findFirstInContext: context];
    
    return filterContent;
}

- (void) saveFilerRoleInProject: (AllProjectTasksFilterContent*) filterContent
                      withValue: (NSNumber*)                     value
{
    filterContent.rolesInProject = value;
}

- (void) saveFiltersDateFromConfig: (AllProjectTasksFilterContent*) filterConfig
                        withConfig: (TaskFilterConfiguration*)      config
{
    // Start two dates
    filterConfig.startBeginDate = config.byTermsStart.startDate;
    filterConfig.startEndDate   = config.byTermsStart.endDate;
    
    // Close two dates
    filterConfig.closeBeginDate = config.byTermsEnd.startDate;
    filterConfig.closeEndDate   = config.byTermsEnd.endDate;
    
    // Factual start two dates
    filterConfig.factualStartBeginDate = config.byFactTermsStart.startDate;
    filterConfig.factualStartEndDate   = config.byFactTermsStart.endDate;
    
    // Factual close two dates
    filterConfig.factualCloseBeginDate = config.byFactTermsEnd.startDate;
    filterConfig.factualCloseEndDate   = config.byFactTermsEnd.endDate;
}

- (void) saveFilterisDoneOptionFromConfig: (AllProjectTasksFilterContent*) filterConfig
                                withValue: (BOOL)                          isDone
{
    filterConfig.isDone = @(isDone);
}

- (void) saveFilterisExpiredOptionFromConfig: (AllProjectTasksFilterContent*) filterConfig
                                   withValue: (BOOL)                          isExpired
{
    filterConfig.isExpired = @(isExpired);
}

- (void) saveFilterisCanceledOptionFromConfig: (AllProjectTasksFilterContent*) filterConfig
                                    withValue: (BOOL)                          isCanceled
{
    filterConfig.isCanceled = @(isCanceled);
}

- (void) saveFilterStatusesFromConfig: (AllProjectTasksFilterContent*) filterConfig
                              withSet: (NSArray*)                      statuses
{
    filterConfig.statuses = statuses;
}

- (void) saveFiltersTypesFromConfig: (AllProjectTasksFilterContent*) filterConfig
                            withSet: (NSArray*)                      types
{
    filterConfig.types = types;
}

- (void) saveFilterProjectsFromConfig: (AllProjectTasksFilterContent*) filterContent
                              withSet: (NSArray*)                      projects
                          withIndexes: (NSArray*)                      indexes
                            inContext: (NSManagedObjectContext*)       context
{
    filterContent.projects               = nil;
    filterContent.projectSelectedIndexes = indexes;
    
    [projects enumerateObjectsUsingBlock: ^(ProjectInfo*  _Nonnull project, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [filterContent addProjectsObject: [project MR_inContext: context]];
        
    }];
}


#pragma mark - Applying filters -

- (NSArray*) applyFilterByStartDates: (NSArray*) tasks
                  withStartDateValue: (NSDate*)  startDate
                    withEndDateValue: (NSDate*)  endDate
{
    NSPredicate* predicate = nil;
    
    if ( startDate )
    {
        predicate = [NSPredicate predicateWithBlock: ^BOOL(ProjectTask*  _Nullable task, NSDictionary<NSString *,id> * _Nullable bindings) {
            
            return ( [task.startDay isLaterThanDate: startDate] );
            
        }];
    }
    else
        if ( endDate )
        {
            predicate = [NSPredicate predicateWithBlock: ^BOOL(ProjectTask*  _Nullable task, NSDictionary<NSString *,id> * _Nullable bindings) {
                
                return ( [task.startDay isEarlierThanDate: endDate] );
                
            }];
        }
        else
            if ( startDate && endDate )
            {
                predicate = [NSPredicate predicateWithBlock: ^BOOL(ProjectTask*  _Nullable task, NSDictionary<NSString *,id> * _Nullable bindings) {
                    
                    return ( [task.startDay isLaterThanDate: startDate] && [task.startDay isEarlierThanDate: endDate] );
                    
                }];
            }
    
    if ( predicate )
        tasks = [tasks filteredArrayUsingPredicate: predicate];
    
    return tasks;
}

- (NSArray*) applyFilterByCloseDates: (NSArray*) tasks
                  withStartDateValue: (NSDate*)  startDate
                    withEndDateValue: (NSDate*)  endDate
{
    NSPredicate* predicate = nil;
    
    if ( startDate )
    {
        predicate = [NSPredicate predicateWithBlock: ^BOOL(ProjectTask*  _Nullable task, NSDictionary<NSString *,id> * _Nullable bindings) {
            
            return ( [task.endDate isLaterThanDate: startDate] );
            
        }];
    }
    else
        if ( endDate )
        {
            predicate = [NSPredicate predicateWithBlock: ^BOOL(ProjectTask*  _Nullable task, NSDictionary<NSString *,id> * _Nullable bindings) {
                
                return ( [task.endDate isEarlierThanDate: endDate] );
                
            }];
        }
        else
            if ( startDate && endDate )
            {
                predicate = [NSPredicate predicateWithBlock: ^BOOL(ProjectTask*  _Nullable task, NSDictionary<NSString *,id> * _Nullable bindings) {
                    
                    return ( [task.endDate isLaterThanDate: startDate] && [task.endDate isEarlierThanDate: endDate] );
                    
                }];
            }
    
    if ( predicate )
        tasks = [tasks filteredArrayUsingPredicate: predicate];
    
    return tasks;
}

- (NSArray*) applyFilterByFactualStartDates: (NSArray*) tasks
                         withStartDateValue: (NSDate*)  startDate
                           withEndDateValue: (NSDate*)  endDate
{
    NSPredicate* predicate = nil;
    
    if ( startDate )
    {
        predicate = [NSPredicate predicateWithBlock: ^BOOL(ProjectTask*  _Nullable task, NSDictionary<NSString *,id> * _Nullable bindings) {
            
            return ( [task.factualStartDate isLaterThanDate: startDate] );
            
        }];
    }
    else
        if ( endDate )
        {
            predicate = [NSPredicate predicateWithBlock: ^BOOL(ProjectTask*  _Nullable task, NSDictionary<NSString *,id> * _Nullable bindings) {
                
                return ( [task.factualStartDate isEarlierThanDate: endDate] );
                
            }];
        }
        else
            if ( startDate && endDate )
            {
                predicate = [NSPredicate predicateWithBlock: ^BOOL(ProjectTask*  _Nullable task, NSDictionary<NSString *,id> * _Nullable bindings) {
                    
                    return ( [task.factualStartDate isLaterThanDate: startDate] && [task.factualStartDate isEarlierThanDate: endDate] );
                    
                }];
            }
    
    if ( predicate )
        tasks = [tasks filteredArrayUsingPredicate: predicate];
    
    return tasks;
}

- (NSArray*) applyFilterByFactualEndDates: (NSArray*) tasks
                       withStartDateValue: (NSDate*)  startDate
                         withEndDateValue: (NSDate*)  endDate
{
    NSPredicate* predicate = nil;
    
    if ( startDate )
    {
        predicate = [NSPredicate predicateWithBlock: ^BOOL(ProjectTask*  _Nullable task, NSDictionary<NSString *,id> * _Nullable bindings) {
            
            return ( [task.factualEndDate isLaterThanDate: startDate] );
            
        }];
    }
    else
        if ( endDate )
        {
            predicate = [NSPredicate predicateWithBlock: ^BOOL(ProjectTask*  _Nullable task, NSDictionary<NSString *,id> * _Nullable bindings) {
                
                return ( [task.factualEndDate isEarlierThanDate: endDate] );
                
            }];
        }
        else
            if ( startDate && endDate )
            {
                predicate = [NSPredicate predicateWithBlock: ^BOOL(ProjectTask*  _Nullable task, NSDictionary<NSString *,id> * _Nullable bindings) {
                    
                    return ( [task.factualEndDate isLaterThanDate: startDate] && [task.factualEndDate isEarlierThanDate: endDate] );
                    
                }];
            }
    
    if ( predicate )
        tasks = [tasks filteredArrayUsingPredicate: predicate];
    
    return tasks;
}

- (NSArray*) applyFilterByType: (NSArray*) tasks
                     withTypes: (NSArray*) types
{
    if ( types.count > 0 )
    {
        NSPredicate* predicate = [NSPredicate predicateWithFormat: @"taskType IN %@", types];
        
        tasks = [tasks filteredArrayUsingPredicate: predicate];
    }
    
    return tasks;
}

- (NSArray*) applyStatusesFilter: (NSArray*) tasks
                      withFilter: (NSArray*) filter
{
    if ( filter.count > 0 )
    {
        NSPredicate* predicate = [NSPredicate predicateWithFormat: @"status IN %@", filter];
        
        tasks = [tasks filteredArrayUsingPredicate: predicate];
    }
    
    return tasks;
}


- (NSArray*) applyFilterByCurrentUserRole: (NSArray*)                    tasks
                                 userRole: (TaskFilterByMyRoleInProject) role
{
    NSPredicate* predicate = nil;
    
    switch (role)
    {
        case Participant:
        {
            predicate = [NSPredicate predicateWithFormat: @"ANY taskRoleAssignments.taskRoleType == %@", @2];
        }
            break;
        case Responsible:
        {
            predicate = [NSPredicate predicateWithFormat: @"ANY taskRoleAssignments.taskRoleType == %@", @1];
        }
            break;
        case Claiming:
        {
            predicate = [NSPredicate predicateWithFormat: @"ANY taskRoleAssignments.taskRoleType == %@", @0];
        }
            break;
        case Creator:
        {
            NSNumber* currentUserID = [DataManagerShared getCurrentUserID];
            predicate = [NSPredicate predicateWithFormat: @"ownerUserId == %@", currentUserID];
        }
            break;
    }
    
    tasks = [tasks filteredArrayUsingPredicate: predicate];
    
    return tasks;
}

@end
