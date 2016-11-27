//
//  DataManager+Filters.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/24/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager+Filters.h"

// Class
#import "ProjectFilterInfo+CoreDataClass.h"
#import "ProjectRoleAssignments+CoreDataClass.h"
#import "ProjectTaskAssignee+CoreDataClass.h"
#import "ProjectTaskWorkArea+CoreDataClass.h"
#import "ProjectTask+CoreDataClass.h"
#import "ProjectTaskFilterContent+CoreDataClass.h"
#import "ProjectTaskResponsible+CoreDataClass.h"
#import "ProjectTaskRoleAssignments+CoreDataClass.h"
#import "ProjectTaskRoleAssignment+CoreDataClass.h"
#import "TeamMember+CoreDataClass.h"
#import "ProjectInviteInfo+CoreDataClass.h"

// Categories
#import "DataManager+ProjectInfo.h"

@implementation DataManager (Filters)

- (void) persistProjectFilter: (NSDictionary*)         filter
                     withType: (ProjectFilterType)     type
             forProjectWithID: (NSNumber*)             projectID
               withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        ProjectInfo* project = [DataManagerShared getProjectWithID: projectID
                                                          inCotext: localContext];
        
        ProjectFilterInfo* filterInfo = [ProjectFilterInfo MR_findFirstOrCreateByAttribute: @"project"
                                                                                 withValue: project
                                                                                 inContext: localContext];
        
        if ( filterInfo.project == nil )
            filterInfo.project = project;
        
        switch (type)
        {
            case StatusFilterType:
            {
                filterInfo.statuses = filter[@"items"];
            }
                break;
            
            case CreatorsFilterType:
            {
                filterInfo.creators = filter[@"items"];
            }
                break;
                
            case ApprovesFilterType:
            {
                filterInfo.approves = filter[@"items"];
            }
                break;
                
            case ResponsiblesFilterType:
            {
                filterInfo.responsibles = filter[@"items"];
            }
                break;
                
            case WorkAreasFilterType:
            {
                filterInfo.workAreas = filter[@"items"];
            }
                break;
                
            case TypesFilterType:
            {
                filterInfo.types = filter[@"items"];
            }
                break;
                
            case ExpiredFilterType:
            {
                filterInfo.expired = filter[@"count"];
            }
                break;
        }
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}


- (NSArray*) getFilterCreatorsListForCurrentProject
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    NSDictionary* filterCreatorsDic  = (NSDictionary*)project.filters.creators;
    NSArray* filtersCreatorsIDs      = filterCreatorsDic.allKeys;
    
    return [self getCreatorsListWithFilter: filtersCreatorsIDs];
}

- (NSArray*) getFilterResponsiblesForCurrentProject
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    NSDictionary* filterResponsibleDic = (NSDictionary*)project.filters.responsibles;
    NSArray* filterResponsiblesIDs     = filterResponsibleDic.allKeys;
    
    return [self getResponsiblesListWithFilter: filterResponsiblesIDs];
}

- (NSArray*) getFilterApprovesForCurrentProject
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    NSDictionary* filterApprovesDic = (NSDictionary*)project.filters.approves;
    NSArray* filterApprovesIDs      = filterApprovesDic.allKeys;
    
    return [self getApproversListWithFilter: filterApprovesIDs];
}

- (NSArray*) getFilterStatusesForCurrentProject
{
    return @[@{@"title" : @"Ожидание",
               @"value" : @0},
             @{@"title" : @"В работе",
               @"value" : @1},
             @{@"title" : @"На утверждении",
               @"value" : @2},
             @{@"title" : @"На доработке",
               @"value" : @3},
             @{@"title" : @"Завершена",
               @"value" : @4},
             @{@"title" : @"Отменена",
               @"value" : @5}];
}

- (NSArray*) getFilterTypesForCurrentProject
{
    return @[@{@"title" : @"Работа",
               @"value" : @0},
             @{@"title" : @"Согласование",
               @"value" : @1},
             @{@"title" : @"Наблюдение",
               @"value" : @2},
             @{@"title" : @"Замечание",
               @"value" : @3}];
}

- (NSArray*) getFilterSystemsForCurrentProject
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    return project.systems.allObjects;
}

- (NSArray*) getFilterWorkAreasForCurrentProject
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    NSDictionary* filterWorkAreasDic = (NSDictionary*)project.filters.workAreas;
    NSArray* filterWorkAreasIDs      = filterWorkAreasDic.allKeys;
    
    __block NSMutableArray* workAreas = [NSMutableArray array];
    
    [project.tasks enumerateObjectsUsingBlock:^(ProjectTask * _Nonnull obj, BOOL * _Nonnull stop) {
       
        if ( [filterWorkAreasIDs containsObject: obj.workArea.workAreaID] )
        {
            [workAreas addObject: obj.workArea];
        }
        
    }];
    
    return workAreas;
}

- (void) storeFilterConfiguration: (TaskFilterConfiguration*) config
                   withCompletion: (CompletionWithSuccess)    completion
{
    NSLog(@"<INFO> Filter configuration %@", config);
    
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        ProjectInfo* project = [DataManagerShared getSelectedProjectInfoInContext: localContext];
        
        ProjectTaskFilterContent* taskFilterContent = [ProjectTaskFilterContent MR_findFirstOrCreateByAttribute: @"project"
                                                                                                      withValue: project
                                                                                                      inContext: localContext];
        
        // Creators
        [self saveFilterCreatorsForConfig: taskFilterContent
                                  withSet: config.byCreator
                                inContext: localContext];
        
        // Responsibles
        [self saveFilterResponsiblesFromConfig: taskFilterContent
                                       withSet: config.byResponsible
                                     inContext: localContext];
        
        // Approvers
        [self saveFilterApproversFromConfig: taskFilterContent
                                    withSet: config.byApprovers
                                  inContext: localContext];
        
        // Statuses
        [self saveFilterStatusesFromConfig: taskFilterContent
                                   withSet: config.statusesList];
        
        
        
        // Is Done
        [self saveFilterisDoneOptionFromConfig: taskFilterContent
                                     withValue: config.isDone];
        
        // Is Canceled
        [self saveFilterisCanceledOptionFromConfig: taskFilterContent
                                         withValue: config.isCanceled];
        
        // Is Expired
        [self saveFilterisExpiredOptionFromConfig: taskFilterContent
                                        withValue: config.isOverdue];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

- (void) resetFilterConfigurationWithCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        ProjectInfo* project = [DataManagerShared getSelectedProjectInfoInContext: localContext];
        
        [project.filters MR_deleteEntityInContext: localContext];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

- (NSArray*) applyFiltersToTasks: (NSArray*) tasks
{
    ProjectTaskFilterContent* content = [self getTaskFilterContentForCurrentProject];
    
    if ( content )
    {
        // Creators
        tasks = [self applyCreatorsFilter: tasks
                         withCreatorsList: content.creators.allObjects];
        
        // Responsibles
        tasks = [self applyResponsiblesFilter: tasks
                         withResponsiblesList: content.responsibles.allObjects];
        
        // Approvements
        NSMutableArray* approvers = [NSMutableArray arrayWithArray: content.approvementsAssignee.allObjects];
        
        [approvers addObjectsFromArray: content.approvementsInvite.allObjects];
        
        tasks = [self applyApproversFilters: tasks
                          withApproversList: approvers];
        
        // Filtered isDone, isExpired and isCanceled
        if ( content.isDone.boolValue )
            tasks = [self applyisDoneFilter: tasks];
        else
            if ( content.isCanceled.boolValue )
                tasks = [self applyisCanceledFilter: tasks];
        
        // Filtering expired state
        tasks = [self applyisExpiredFilter: tasks
                                 withValue: content.isExpired.boolValue];
        
        // Filtering by status
        tasks = [self applyStatusesFilter: tasks
                               withFilter: (NSArray*)content.statuses];
        
        
        return tasks;
    }
    else
    {
        return tasks;
    }
    
    return @[];
}

#pragma mark - Internal methods -

- (NSArray*) getCreatorsListWithFilter: (NSArray*) filter
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    __block NSMutableArray* creators = [NSMutableArray array];
    
    [project.projectRoleAssignments enumerateObjectsUsingBlock: ^(ProjectRoleAssignments * _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ( [filter containsObject: obj.assignee.assigneeID.stringValue] )
        {
            [creators addObject: obj.assignee];
        }
        
    }];
    
    return creators;
}

- (NSArray*) getResponsiblesListWithFilter: (NSArray*) filter
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    __block NSMutableArray* responsiblesList = [NSMutableArray array];
    __block NSMutableArray* addedIDs         = [NSMutableArray array];
    
    [project.tasks enumerateObjectsUsingBlock: ^(ProjectTask * _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ( [filter containsObject: obj.responsible.responsibleID.stringValue] &&
             [addedIDs containsObject: obj.responsible.responsibleID] == NO )
        {
            [addedIDs addObject: obj.responsible.responsibleID];
            
            if ( obj.responsible.firstName.length > 0 )
                [responsiblesList addObject: obj.responsible];
            else
                if ( obj.responsible.assignee )
                {
                    [responsiblesList addObject: obj.responsible.assignee];
                }
        }
        
    }];
    
    return responsiblesList;
}

- (NSArray*) getApproversListWithFilter: (NSArray*) filter
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    __block NSMutableArray* approversList = [NSMutableArray array];
    __block NSMutableArray* tmpFilter = filter.mutableCopy;
    
    [project.tasks enumerateObjectsUsingBlock:^(ProjectTask * _Nonnull task, BOOL * _Nonnull stop) {
       
        [task.taskRoleAssignments enumerateObjectsUsingBlock: ^(ProjectTaskRoleAssignments * _Nonnull roleAssignments, BOOL * _Nonnull stop) {
           
            [roleAssignments.projectRoleAssignment enumerateObjectsUsingBlock:^(ProjectTaskRoleAssignment * _Nonnull assignment, BOOL * _Nonnull stop) {
                
                if ( [tmpFilter containsObject: assignment.taskRoleAssignmnetID.stringValue] &&
                    roleAssignments.taskRoleType.integerValue == 1 )
                {   
                    [tmpFilter removeObject: assignment.taskRoleAssignmnetID.stringValue];
                    
                    ProjectTaskAssignee* assignee = assignment.assignee.anyObject;
                    
                    ProjectInviteInfo* invite = assignment.invite.anyObject;
                    
                    if ( assignee )
                        [approversList addObject: assignee];
                    else
                        if ( invite )
                            [approversList addObject: invite];
                }
                
            }];
            
        }];
        
    }];
    
    
    return approversList;
}

- (ProjectTaskFilterContent*) getTaskFilterContentForCurrentProject
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    return project.taskFilterConfig;
}


// MARK: saving filter configuration items to database
- (void) saveFilterCreatorsForConfig: (ProjectTaskFilterContent*) filterConfig
                             withSet: (NSArray*)                  creators
                           inContext: (NSManagedObjectContext*)   context
{
    filterConfig.creators = nil;
    
    [creators enumerateObjectsUsingBlock: ^(ProjectTaskAssignee* assignee, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [filterConfig addCreatorsObject: [assignee MR_inContext: context]];
        
    }];
}

- (void) saveFilterResponsiblesFromConfig: (ProjectTaskFilterContent*) filterConfig
                                  withSet: (NSArray*)                  responsibles
                                inContext: (NSManagedObjectContext*)   context
{
    filterConfig.responsibles = nil;
    
    [responsibles enumerateObjectsUsingBlock: ^(ProjectTaskAssignee*  _Nonnull assignee, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [filterConfig addResponsiblesObject: [assignee MR_inContext: context]];
        
    }];
}

- (void) saveFilterApproversFromConfig: (ProjectTaskFilterContent*) filterConfig
                               withSet: (NSArray*)                  approvers
                             inContext: (NSManagedObjectContext*)   context
{
    filterConfig.approvementsInvite   = nil;
    filterConfig.approvementsAssignee = nil;
    
    [approvers enumerateObjectsUsingBlock: ^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ( [obj isKindOfClass: [ProjectTaskAssignee class]] )
        {
            [filterConfig addApprovementsAssigneeObject: [(ProjectTaskAssignee*)obj MR_inContext: context]];
        }
        else
        {
            [filterConfig addApprovementsInviteObject: [(ProjectInviteInfo*)obj MR_inContext: context]];
        }
        
    }];
}



- (void) saveFilterisDoneOptionFromConfig: (ProjectTaskFilterContent*) filterConfig
                                withValue: (BOOL)                      isDone
{
    filterConfig.isDone = @(isDone);
}

- (void) saveFilterisExpiredOptionFromConfig: (ProjectTaskFilterContent*) filterConfig
                                   withValue: (BOOL)                      isExpired
{
    filterConfig.isExpired = @(isExpired);
}

- (void) saveFilterisCanceledOptionFromConfig: (ProjectTaskFilterContent*) filterConfig
                                    withValue: (BOOL)                      isCanceled
{
    filterConfig.isCanceled = @(isCanceled);
}

- (void) saveFilterStatusesFromConfig: (ProjectTaskFilterContent*) filterConfig
                              withSet: (NSArray*)                  statuses
{
    filterConfig.statuses = statuses;
}


// MARK: Apply filters

- (NSArray*) applyCreatorsFilter: (NSArray*) tasks
                withCreatorsList: (NSArray*) filter
{
    if ( filter.count > 0 )
    {
        NSMutableArray* creatorsIDs = [NSMutableArray arrayWithCapacity: filter.count];
        
        [filter enumerateObjectsUsingBlock: ^(ProjectTaskAssignee*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [creatorsIDs addObject: obj.assigneeID];
            
        }];
        
        NSPredicate* creatorsPredicate = [NSPredicate predicateWithFormat: @"ownerUserId IN %@", creatorsIDs];
        
        tasks = [tasks filteredArrayUsingPredicate: creatorsPredicate];
        
        return tasks;
    }
    
    return tasks;
}

- (NSArray*) applyResponsiblesFilter: (NSArray*) tasks
                withResponsiblesList: (NSArray*) filter
{
    if ( filter.count > 0 )
    {
        NSMutableArray* responsiblesIDs = [NSMutableArray arrayWithCapacity: filter.count];
        
        [filter enumerateObjectsUsingBlock: ^(ProjectTaskAssignee*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [responsiblesIDs addObject: obj.assigneeID];
            
        }];
        
        NSPredicate* responsiblesPredicate = [NSPredicate predicateWithFormat: @"responsible.responsibleID IN %@", responsiblesIDs];
        
        tasks = [tasks filteredArrayUsingPredicate: responsiblesPredicate];
    }
    
    return tasks;
}

- (NSArray*) applyApproversFilters: (NSArray*) tasks
                 withApproversList: (NSArray*) filter
{
    if ( filter.count > 0 )
    {
        NSMutableArray* approversIDs = [NSMutableArray arrayWithCapacity: filter.count];
        
        [filter enumerateObjectsUsingBlock: ^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ( [obj isKindOfClass: [ProjectTaskAssignee class]] )
                [approversIDs addObject: [[[(ProjectTaskAssignee*)obj roleAssignment] projectRoleAssignments] roleAssignmentsID]];
            else
                [approversIDs addObject: [[[(ProjectInviteInfo*)obj projectTaskAssignment] projectRoleAssignments] roleAssignmentsID]];
            
        }];
        
        __block NSMutableArray* tmpTasksArray = [NSMutableArray array];
        
        [tasks enumerateObjectsUsingBlock:^(ProjectTask*  _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [task.taskRoleAssignments enumerateObjectsUsingBlock:^(ProjectTaskRoleAssignments * _Nonnull obj, BOOL * _Nonnull stop) {
               
                if ( [approversIDs containsObject: obj.roleAssignmentsID] &&
                    [tmpTasksArray containsObject: task] == NO )
                {
                    [tmpTasksArray addObject: task];
                }
                
            }];
        }];
        
        tasks = tmpTasksArray.copy;
        
        tmpTasksArray = nil;
    }
    
    return tasks;
}

- (NSArray*) applyisDoneFilter: (NSArray*) tasks
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"status == 2"];
    
    tasks = [tasks filteredArrayUsingPredicate: predicate];
    
    return tasks;
}

- (NSArray*) applyisExpiredFilter: (NSArray*) tasks
                        withValue: (BOOL)     isExpired
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"isExpired == %@", isExpired ? @1 : @0];
    
    tasks = [tasks filteredArrayUsingPredicate: predicate];
    
    return tasks;
}

- (NSArray*) applyisCanceledFilter: (NSArray*) tasks
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"status == 3"];
    
    tasks = [tasks filteredArrayUsingPredicate: predicate];
    
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

@end
