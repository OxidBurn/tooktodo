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
    
    return [self getAssigneeListWithFilter: filtersCreatorsIDs];
}

- (NSArray*) getFilterResponsiblesForCurrentProject
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    NSDictionary* filterResponsibleDic = (NSDictionary*)project.filters.responsibles;
    NSArray* filterResponsiblesIDs     = filterResponsibleDic.allKeys;
    
    return [self getAssigneeListWithFilter: filterResponsiblesIDs];
}

- (NSArray*) getFilterApprovesForCurrentProject
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    NSDictionary* filterApprovesDic = (NSDictionary*)project.filters.approves;
    NSArray* filterApprovesIDs      = filterApprovesDic.allKeys;
    
    return [self getAssigneeListWithFilter: filterApprovesIDs];
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


#pragma mark - Internal methods -

- (NSArray*) getAssigneeListWithFilter: (NSArray*) filter
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    __block NSMutableArray* creators = [NSMutableArray array];
    
    [project.projectRoleAssignments enumerateObjectsUsingBlock: ^(ProjectRoleAssignments * _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ( [filter containsObject: obj.assignee.assigneeID.stringValue] )
        {
            [creators addObject: obj.assignee];
        }
        
        NSLog(@"Role assignee %@", obj.assignee.assigneeID);
        
    }];
    
    return creators;
}

@end
