//
//  DataManager+ProjectInfo.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager+ProjectInfo.h"

// Classes
#import "OfflineSettings.h"
#import "OfflineSettingsTypes.h"

@implementation DataManager (ProjectInfo)

- (void) persistNewProjects: (NSArray*)  projects
             withCompletion: (void(^)()) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        [projects enumerateObjectsUsingBlock: ^(ProjectInfoData* data, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self persistNewProjectWithInfo: data
                                  inContext: localContext];
            
        }];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion();
                          
                      }];
}

- (void) persistNewProjectWithInfo: (ProjectInfoData*)        data
                         inContext: (NSManagedObjectContext*) context
{
    ProjectInfo* projectInfo = [self getIfExistProjectWithID: data.projectID];
    
    if ( projectInfo == nil )
    {
        projectInfo = [ProjectInfo MR_createEntityInContext: context];
    }
    
    projectInfo.lastVisit                        = data.lastVisit;
    projectInfo.isTaskAddAppealClosed            = @(data.isTaskAddAppealClosed);
    projectInfo.realtyClassDescription           = data.realtyClassDescription;
    projectInfo.title                            = data.title;
    projectInfo.ownerUserId                      = @(data.ownerUserId);
    projectInfo.street                           = data.street;
    projectInfo.residentialObjectType            = @(data.residentialObjectType);
    projectInfo.building                         = data.building;
    projectInfo.city                             = data.city;
    projectInfo.residentialObjectTypeDescription = data.residentialObjectTypeDescription;
    projectInfo.regionName                       = data.regionName;
    projectInfo.apartment                        = data.apartment;
    projectInfo.endDate                          = data.endDate;
    projectInfo.projectID                        = @(data.projectID);
    projectInfo.createdDate                      = data.createdDate;
    projectInfo.isRolesInvitationAppealClosed    = @(data.isRolesInvitationAppealClosed);
    projectInfo.commercialObjectType             = @(data.commercialObjectType);
    projectInfo.realtyClass                      = @(data.realtyClass);
    projectInfo.phoneNumber                      = data.phoneNumber;
    projectInfo.commercialObjectTypeDescription  = data.commercialObjectTypeDescription;
    projectInfo.floor                            = data.floor;
    projectInfo.address                          = [NSString stringWithFormat: @"%@ %@ %@ %@", data.regionName, data.city, data.street, data.building];
//    projectInfo.
    
}

- (ProjectInfo*) getIfExistProjectWithID: (NSUInteger) projectID
{
    return [ProjectInfo MR_findFirstByAttribute: @"projectID"
                                      withValue: @(projectID)];
}

- (NSArray*) getAllProjects
{
    return [ProjectInfo MR_findAll];
}

- (OfflineSettings*) createOfflineSettingForProject: (ProjectInfo*)            project
                                          inContext: (NSManagedObjectContext*) context
{
    OfflineSettings* settings = [OfflineSettings MR_createEntityInContext: context];
    
    settings.project = project;
    settings.title = @"Задачи, Лента, Планы";
    settings.type  = @(TasksFeedsPlansType);
    
    
    return settings;
}

@end
