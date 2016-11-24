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
    
    __block NSMutableArray* creators = [NSMutableArray array];
    NSDictionary* filterCreatorsDic  = (NSDictionary*)project.filters.creators;
    NSArray* filtersCreatorsIDs      = filterCreatorsDic.allKeys;
    
    [project.projectRoleAssignments enumerateObjectsUsingBlock: ^(ProjectRoleAssignments * _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ( [filtersCreatorsIDs containsObject: obj.assignee.assigneeID.stringValue] )
        {
            [creators addObject: obj.assignee];
        }
        
        NSLog(@"Role assignee %@", obj.assignee.assigneeID);
        
    }];
    
    return creators;
}

@end