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

@implementation DataManager (AllProjectsFilter)


#pragma mark - Public methods -

- (void) saveAllProjectTasksFilterContent: (TaskFilterConfiguration*) config
                           withCompletion: (CompletionWithSuccess)    completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        AllProjectTasksFilterContent* filterContent = [self getAllProjectTaskFilterContentInContext: localContext];
        
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


#pragma mark - Internal methods -

- (AllProjectTasksFilterContent*) getAllProjectTaskFilterContentInContext: (NSManagedObjectContext*) context
{
    AllProjectTasksFilterContent* filterContent = [AllProjectTasksFilterContent MR_findFirstInContext: context];
    
    if ( filterContent == nil )
    {
        filterContent = [AllProjectTasksFilterContent MR_createEntityInContext: context];
    }
    
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

@end
