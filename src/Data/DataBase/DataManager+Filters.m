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
#import "ProjectTaskRoom+CoreDataClass.h"
#import "ProjectSystem+CoreDataClass.h"

// Categories
#import "DataManager+ProjectInfo.h"
#import "NSDate-Utilities.h"

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
             @{@"title" : @"Завершена",
               @"value" : @2},
             @{@"title" : @"Отменена",
               @"value" : @3},
             @{@"title" : @"На утверждении",
               @"value" : @4},
             @{@"title" : @"На доработке",
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

- (NSArray*) getFilterWorkAreasForCurrentProject
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    NSDictionary* filterWorkAreasDic = (NSDictionary*)project.filters.workAreas;
    NSArray* filterWorkAreasIDs      = filterWorkAreasDic.allKeys;
    
    return [self getWorkAreasListWithFilter: filterWorkAreasIDs];
}

- (NSArray*) getFilterRoomsForCurrentProject
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    __block NSMutableArray* rooms = [NSMutableArray array];
    
    [project.tasks enumerateObjectsUsingBlock: ^(ProjectTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [obj.rooms enumerateObjectsUsingBlock: ^(ProjectTaskRoom * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            if ( [rooms containsObject: obj] == NO )
            {
                [rooms addObject: obj];
            }
            
        }];
        
    }];
    
    return rooms;
}

- (ProjectTaskFilterContent*) getFilterContentForSelectedProject
{
    ProjectTaskFilterContent* content = [self getTaskFilterContentForCurrentProject];
    
    return content;
}


#pragma mark - Internal methods -

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
                              withIndexes: config.byCreatorIndexes
                                inContext: localContext];
        
        // Responsibles
        [self saveFilterResponsiblesFromConfig: taskFilterContent
                                       withSet: config.byResponsible
                                   withIndexes: config.byResponsibleIndexes
                                     inContext: localContext];
        
        // Approvers
        [self saveFilterApproversFromConfig: taskFilterContent
                                    withSet: config.byApprovers
                                withIndexes: config.byApproversIndexes
                                  inContext: localContext];
        
        // Statuses
        [self saveFilterStatusesFromConfig: taskFilterContent
                                   withSet: config.statusesList];
        
        // Dates
        [self saveFiltersDateFromConfig: taskFilterContent
                             withConfig: config];
        
        // Rooms
        [self saveFiltersRoomsForConfig: taskFilterContent
                                withSet: config.byRooms
                            withIndexes: config.byRoomIndexes
                              inContext: localContext];
        
        // Systems
        [self saveFilterWorkAreasForConfig: taskFilterContent
                                   withSet: config.byWorkAreas
                               withIndexes: config.byWorkAreasIndexes
                                 inContext: localContext];
        
        // Types
        [self saveFiltersTypesFromConfig: taskFilterContent
                                 withSet: config.byTaskType];
        
        
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
        
        [project.taskFilterConfig MR_deleteEntityInContext: localContext];
        
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
                         withCreatorsList: content.creators.array];
        
        // Responsibles
        tasks = [self applyResponsiblesFilter: tasks
                         withResponsiblesList: content.responsibles.array];
        
        // Approvements
        NSMutableArray* approvers = [NSMutableArray arrayWithArray: content.approvementsAssignee.array];
        
        [approvers addObjectsFromArray: content.approvementsInvite.array];
        
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
        
        // Filtering by Rooms
        tasks = [self applyFiltersByRooms: tasks
                                withRooms: content.rooms.array];
        
        // Filtering by systems
        tasks = [self applyFiltersByWorkAreas: tasks
                                withWorkAreas: content.workAreas.array];
    }
    
    return tasks;
}

- (void) deleteProjectTasksFilterItem: (FilterTagParameterInfo*) info
                       withCompletion: (CompletionWithSuccess)   completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        ProjectTaskFilterContent* filterContent = [[self getTaskFilterContentForCurrentProject] MR_inContext: localContext];
        
        switch (info.parameterType)
        {
            case CreatorsFilterParameter:
            case CreatorsAllFilterParameter:
            {
                [self deleteFilterCreatorsParameter: filterContent
                                           withInfo: info];
            }
                break;
            case ResponsiblesFilterParamter:
            case ResponsiblesAllFilterParamter:
            {
                [self deleteFilterResponsiblesParameter: filterContent
                                               withInfo: info];
            }
                break;
            case ApprovesFilterParameter:
            case ApprovesAllFilterParameter:
            {
                [self deleteFilterApprovementsParameter: filterContent
                                               withInfo: info];
            }
                break;
            case StatusesFilterParameter:
            case StatusesAllFilterParameter:
            {
                [self deleteFilterStatusesParameter: filterContent
                                           withInfo: info];
            }
                break;
            case StartDateFilterParameter:
            {
                [self deleteStartDateParameter: filterContent
                                      withInfo: info];
            }
                break;
            case EndDateFilterParameter:
            {
                [self deleteCloseDateParameter: filterContent
                                      withInfo: info];
            }
                break;
            case FactualStartDateFilterParameter:
            {
                [self deleteFactualStartDateParameter: filterContent
                                             withInfo: info];
            }
                break;
            case FactualEndDateFilterParameter:
            {
                [self deleteFactualEndDateParameter: filterContent
                                           withInfo: info];
            }
                break;
            case TypeFilterParameter:
            case TypeAllFilterParameter:
            {
                [self deleteFilterTypesParameter: filterContent
                                        withInfo: info];
            }
                break;
            case WorkAreasFilterParameter:
            case WorkAreasAllFilterParameter:
            {
                [self deleteWorkAreasParameter: filterContent
                                      withInfo: info];
            }
                break;
            case RoomsFilterParameter:
            case RoomsAllFilterParameter:
            {
                [self deleteRoomsParameter: filterContent
                                  withInfo: info];
            }
                break;
            case DoneFilterParameter:
            case ExpiredFilterParameter:
            case CanceledFilterParameter:
            {
                [self resetBooleanParameters: filterContent
                                    withInfo: info];
            }
                break;
                
            default:
                break;
        }
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

#pragma mark - Internal methods -

- (NSArray*) getCreatorsListWithFilter: (NSArray*) filter
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    __block NSMutableArray* creators = [NSMutableArray array];
    
    [project.projectRoleAssignments enumerateObjectsUsingBlock: ^(ProjectRoleAssignments * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ( [filter containsObject: obj.assignee.assigneeID.stringValue] )
        {
            [creators addObject: obj.assignee];
        }
        
    }];
    
    return creators.copy;
}

- (NSArray*) getResponsiblesListWithFilter: (NSArray*) filter
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    __block NSMutableArray* responsiblesList = [NSMutableArray array];
    __block NSMutableArray* addedIDs         = [NSMutableArray array];
    
    [project.tasks enumerateObjectsUsingBlock: ^(ProjectTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
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
    
    return responsiblesList.copy;
}

- (NSArray*) getApproversListWithFilter: (NSArray*) filter
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    __block NSMutableArray* approversList = [NSMutableArray array];
    __block NSMutableArray* tmpFilter = filter.mutableCopy;
    
    [project.tasks enumerateObjectsUsingBlock:^(ProjectTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [task.taskRoleAssignments enumerateObjectsUsingBlock: ^(ProjectTaskRoleAssignments * _Nonnull roleAssignments, NSUInteger idx, BOOL * _Nonnull stop) {
           
            [roleAssignments.projectRoleAssignment enumerateObjectsUsingBlock:^(ProjectTaskRoleAssignment * _Nonnull assignment, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ( [tmpFilter containsObject: assignment.taskRoleAssignmnetID.stringValue] &&
                    roleAssignments.taskRoleType.integerValue == 1 )
                {   
                    [tmpFilter removeObject: assignment.taskRoleAssignmnetID.stringValue];
                    
                    ProjectTaskAssignee* assignee = assignment.assignee.firstObject;
                    
                    ProjectInviteInfo* invite = assignment.invite.firstObject;
                    
                    if ( assignee )
                        [approversList addObject: assignee];
                    else
                        if ( invite )
                            [approversList addObject: invite];
                }
                
            }];
            
        }];
        
    }];
    
    
    return approversList.copy;
}

- (NSArray*) getWorkAreasListWithFilter: (NSArray*) filter
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    __block NSMutableArray* workAreasList = [NSMutableArray array];
    __block NSMutableArray* tmpFilter     = filter.mutableCopy;
    
    [project.tasks enumerateObjectsUsingBlock: ^(ProjectTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ( [tmpFilter containsObject: obj.workArea.workAreaID.stringValue] )
        {
            [tmpFilter removeObject: obj.workArea.workAreaID.stringValue];
            
            [workAreasList addObject: obj.workArea];
        }
        
    }];
    
    return workAreasList.copy;
}

- (ProjectTaskFilterContent*) getTaskFilterContentForCurrentProject
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    return project.taskFilterConfig;
}


// MARK: saving filter configuration items to database
- (void) saveFilterCreatorsForConfig: (ProjectTaskFilterContent*) filterConfig
                             withSet: (NSArray*)                  creators
                         withIndexes: (NSArray*)                  indexes
                           inContext: (NSManagedObjectContext*)   context
{
    filterConfig.creators                = nil;
    filterConfig.creatorsSelectedIndexes = indexes;
    
    [creators enumerateObjectsUsingBlock: ^(ProjectTaskAssignee* assignee, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [filterConfig addCreatorsObject: [assignee MR_inContext: context]];
        
    }];
}

- (void) saveFilterResponsiblesFromConfig: (ProjectTaskFilterContent*) filterConfig
                                  withSet: (NSArray*)                  responsibles
                              withIndexes: (NSArray*)                  indexes
                                inContext: (NSManagedObjectContext*)   context
{
    filterConfig.responsibles                = nil;
    filterConfig.responsiblesSelectedIndexes = indexes;
    
    [responsibles enumerateObjectsUsingBlock: ^(ProjectTaskAssignee*  _Nonnull assignee, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [filterConfig addResponsiblesObject: [assignee MR_inContext: context]];
        
    }];
}

- (void) saveFilterApproversFromConfig: (ProjectTaskFilterContent*) filterConfig
                               withSet: (NSArray*)                  approvers
                           withIndexes: (NSArray*)                  indexes
                             inContext: (NSManagedObjectContext*)   context
{
    filterConfig.approvementsInvite          = nil;
    filterConfig.approvementsAssignee        = nil;
    filterConfig.approvementsSelectedIndexes = indexes;
    
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

- (void) saveFiltersDateFromConfig: (ProjectTaskFilterContent*) filterConfig
                        withConfig: (TaskFilterConfiguration*)  config
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

- (void) saveFiltersRoomsForConfig: (ProjectTaskFilterContent*) filterConfig
                           withSet: (NSArray*)                  rooms
                       withIndexes: (NSArray*)                  roomIndexes
                         inContext: (NSManagedObjectContext*)   context
{
    filterConfig.rooms                = nil;
    filterConfig.roomsSelectedIndexes = roomIndexes;
    
    [rooms enumerateObjectsUsingBlock: ^(ProjectTaskRoom*  _Nonnull room, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [filterConfig addRoomsObject: [room MR_inContext: context]];
        
    }];
}

- (void) saveFilterWorkAreasForConfig: (ProjectTaskFilterContent*) filterContent
                              withSet: (NSArray*)                  workAreas
                          withIndexes: (NSArray*)                  workAreasIndexes
                            inContext: (NSManagedObjectContext*)   context
{
    filterContent.workAreas                = nil;
    filterContent.workAreasSelectedIndexes = workAreasIndexes;
    
    [workAreas enumerateObjectsUsingBlock: ^(ProjectTaskWorkArea*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [filterContent addWorkAreasObject: [obj MR_inContext: context]];
        
    }];
}

- (void) saveFiltersTypesFromConfig: (ProjectTaskFilterContent*) filterConfig
                            withSet: (NSArray*)                  types
{
    filterConfig.types = types;
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
            
            [task.taskRoleAssignments enumerateObjectsUsingBlock: ^(ProjectTaskRoleAssignments * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
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

- (NSArray*) applyFiltersByRooms: (NSArray*) tasks
                       withRooms: (NSArray*) rooms
{
    if ( rooms.count > 0 )
    {
        NSPredicate* predicate = [NSPredicate predicateWithFormat: @"ANY %K IN %@", @"rooms", rooms];
        
        tasks = [tasks filteredArrayUsingPredicate: predicate];
    }
    
    return tasks;
}

- (NSArray*) applyFiltersByWorkAreas: (NSArray*) tasks
                       withWorkAreas: (NSArray*) workAreas
{
    if ( workAreas.count > 0 )
    {
        NSPredicate* predicate = [NSPredicate predicateWithFormat: @"workArea IN %@", workAreas];
        
        tasks = [tasks filteredArrayUsingPredicate: predicate];
    }
    
    return tasks;
}


#pragma mark - Delete items -

- (void) deleteFilterCreatorsParameter: (ProjectTaskFilterContent*) filterContent
                              withInfo: (FilterTagParameterInfo*)   info
{
    if ( info.parameterType == CreatorsAllFilterParameter )
    {
        filterContent.creators                = nil;
        filterContent.creatorsSelectedIndexes = nil;
    }
    else
    {
        __block ProjectTaskAssignee* assignee = nil;
        __block NSUInteger assigneeIndex      = 0;
        
        [filterContent.creators enumerateObjectsUsingBlock:^(ProjectTaskAssignee * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ( [obj.assigneeID isEqual: info.parameterValue] )
            {
                assignee      = obj;
                assigneeIndex = idx;
                *stop         = YES;
            }
            
        }];
        
        [filterContent removeCreatorsObject: assignee];
        
        NSMutableArray* selectedIndexes = [NSMutableArray arrayWithArray: (NSArray*)filterContent.creatorsSelectedIndexes];
        
        [selectedIndexes removeObjectAtIndex: assigneeIndex];
        
        filterContent.creatorsSelectedIndexes = selectedIndexes;
    }
}

- (void) deleteFilterResponsiblesParameter: (ProjectTaskFilterContent*) filterContent
                                  withInfo: (FilterTagParameterInfo*)   info
{
    if ( info.parameterType == ResponsiblesAllFilterParamter )
    {
        filterContent.responsibles                = nil;
        filterContent.responsiblesSelectedIndexes = nil;
    }
    else
    {
        __block ProjectTaskAssignee* assignee = nil;
        
        [filterContent.responsibles enumerateObjectsUsingBlock: ^(ProjectTaskAssignee * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ( [obj.assigneeID isEqual: info.parameterValue] )
            {
                assignee = obj;
                *stop    = YES;
            }
            
        }];
        
        NSUInteger assigneeIndex = [filterContent.responsibles indexOfObject: assignee];
        
        [filterContent removeResponsiblesObject: assignee];
        
        NSMutableArray* selectedIndexes = [NSMutableArray arrayWithArray: (NSArray*)filterContent.responsiblesSelectedIndexes];
        
        if ( assigneeIndex < selectedIndexes.count )
            [selectedIndexes removeObjectAtIndex: assigneeIndex];
        
        filterContent.responsiblesSelectedIndexes = selectedIndexes;
    }
}

- (void) deleteFilterApprovementsParameter: (ProjectTaskFilterContent*) filterContent
                                  withInfo: (FilterTagParameterInfo*)   info
{
    if ( info.parameterType == ApprovesAllFilterParameter )
    {
        filterContent.approvementsAssignee        = nil;
        filterContent.approvementsInvite          = nil;
        filterContent.approvementsSelectedIndexes = nil;
    }
    else
    {
        __block ProjectTaskAssignee* assignee = nil;
        __block ProjectInviteInfo* inviteInfo = nil;
        __block NSUInteger assigneeIndex      = 0;
        
        [filterContent.approvementsAssignee enumerateObjectsUsingBlock: ^(ProjectTaskAssignee * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ( [obj.assigneeID isEqual: info.parameterValue] )
            {
                assignee = obj;
                
                assigneeIndex++;
                
                *stop    = YES;
            }
            
        }];
        
        if ( assignee )
        {
            assigneeIndex = [filterContent.approvementsAssignee indexOfObject: assignee];
            
            [filterContent removeApprovementsAssigneeObject: assignee];
        }
        else
        {
            [filterContent.approvementsInvite enumerateObjectsUsingBlock: ^(ProjectInviteInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ( [obj.inviteID isEqual: info.parameterValue] )
                {
                    inviteInfo = obj;
                    
                    assigneeIndex++;
                    
                    *stop = YES;
                }
                
            }];
            
            [filterContent removeApprovementsInviteObject: inviteInfo];
        }
        
        NSMutableArray* selectedIndexes = [NSMutableArray arrayWithArray: (NSArray*)filterContent.approvementsSelectedIndexes];
        
        if ( selectedIndexes.count > assigneeIndex )
            [selectedIndexes removeObjectAtIndex: assigneeIndex];
        
        filterContent.approvementsSelectedIndexes = selectedIndexes;
    }

}

- (void) deleteFilterTypesParameter: (ProjectTaskFilterContent*) content
                           withInfo: (FilterTagParameterInfo*)   info
{
    if ( info.parameterType == TypeAllFilterParameter )
    {
        content.types = nil;
    }
    else
    {
        NSMutableArray* tmpArr = [NSMutableArray arrayWithArray: (NSArray*)content.types];
        
        [tmpArr removeObject: info.parameterValue];
        
        content.types = tmpArr;
    }
}

- (void) deleteStartDateParameter: (ProjectTaskFilterContent*) content
                         withInfo: (FilterTagParameterInfo*)   info
{
    content.startBeginDate = nil;
    content.startEndDate   = nil;
}

- (void) deleteCloseDateParameter: (ProjectTaskFilterContent*) content
                         withInfo: (FilterTagParameterInfo*)   info
{
    content.closeBeginDate = nil;
    content.closeEndDate   = nil;
}

- (void) deleteFactualStartDateParameter: (ProjectTaskFilterContent*) content
                                withInfo: (FilterTagParameterInfo*)   info
{
    content.factualStartBeginDate = nil;
    content.factualStartEndDate   = nil;
}

- (void) deleteFactualEndDateParameter: (ProjectTaskFilterContent*) content
                              withInfo: (FilterTagParameterInfo*)   info
{
    content.factualCloseBeginDate = nil;
    content.factualCloseEndDate   = nil;
}

- (void) deleteRoomsParameter: (ProjectTaskFilterContent*) content
                     withInfo: (FilterTagParameterInfo*)   info
{
    if ( info.parameterType == RoomsAllFilterParameter )
    {
        content.rooms                = nil;
        content.roomsSelectedIndexes = nil;
    }
    else
    {
        __block ProjectTaskRoom* room    = nil;
        __block NSUInteger selectedIndex = 0;
        
        [content.rooms enumerateObjectsUsingBlock: ^(ProjectTaskRoom * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ( [info.parameterValue isEqual: obj.roomID] )
            {
                room          = obj;
                selectedIndex = idx;
                *stop         = YES;
            }
            
        }];
        
        [content removeRoomsObject: room];
        
        NSMutableArray* tmpArr = [NSMutableArray arrayWithArray: (NSArray*)content.roomsSelectedIndexes];
        
        [tmpArr removeObjectAtIndex: selectedIndex];
        
        content.roomsSelectedIndexes = tmpArr;
    }
}

- (void) deleteWorkAreasParameter: (ProjectTaskFilterContent*) content
                         withInfo: (FilterTagParameterInfo*)   info
{
    if ( info.parameterType == WorkAreasAllFilterParameter )
    {
        content.workAreas                = nil;
        content.workAreasSelectedIndexes = nil;
    }
    else
    {
        __block ProjectTaskWorkArea* workArea = nil;
        __block NSUInteger selectedIndex      = 0;
        
        [content.workAreas enumerateObjectsUsingBlock: ^(ProjectTaskWorkArea * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ( [info.parameterValue isEqual: obj.workAreaID] )
            {
                workArea      = obj;
                selectedIndex = idx;
                *stop         = YES;
            }
            
        }];
        
        [content removeWorkAreasObject: workArea];
        
        NSMutableArray* tmpArr = [NSMutableArray arrayWithArray: (NSArray*)content.workAreasSelectedIndexes];
        
        [tmpArr removeObjectAtIndex: selectedIndex];
        
        content.workAreasSelectedIndexes = tmpArr;
    }
}

- (void) deleteFilterStatusesParameter: (ProjectTaskFilterContent*) content
                              withInfo: (FilterTagParameterInfo*)   info
{
    if ( info.parameterType == StatusesAllFilterParameter )
    {
        content.types = nil;
    }
    else
    {
        NSMutableArray* tmpArr = [NSMutableArray arrayWithArray: (NSArray*)content.statuses];
        
        [tmpArr removeObject: info.parameterValue];
        
        content.statuses = tmpArr;
    }
}

- (void) resetBooleanParameters: (ProjectTaskFilterContent*) content
                       withInfo: (FilterTagParameterInfo*)   info
{
    switch (info.parameterType)
    {
        case DoneFilterParameter:
            content.isDone = @NO;
            break;
        case ExpiredFilterParameter:
            content.isExpired = @NO;
            break;
        case CanceledFilterParameter:
            content.isCanceled = @NO;
            break;
        default:
            break;
    }
}

@end
