//
//  ProjectsService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectsService.h"

// Classes
#import "ProjectsAPIService.h"
#import "ProjectInfoModel.h"
#import "TeamService.h"
#import "RolesService.h"
#import "SystemsService.h"
#import "TasksService.h"
#import "RoomsService.h"
#import "TaskFiltersService.h"

// Extensions
#import "DataManager+ProjectInfo.h"

@implementation ProjectsService

static dispatch_once_t onceToken;
static ProjectsService* SINGLETON = nil;
static bool isFirstAccess = YES;

#pragma mark - Public Method -

+ (instancetype) sharedInstance
{
    dispatch_once(&onceToken, ^{
        
        isFirstAccess = NO;
        SINGLETON     = [[super allocWithZone: NULL] init];
    });
    
    return SINGLETON;
}


#pragma mark - Public methods -

- (RACSignal*) getAllProjectsList
{
    NSDictionary* requestParameter = @{@"skip" : @(0),
                                       @"take" : @(100)};
    
    @weakify(self)
    
    RACSignal* loadingSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext: [DataManagerShared getAllProjects]];
        
        [[[ProjectsAPIService sharedInstance] getProjectsList: requestParameter]
         subscribeNext: ^(RACTuple* tuple) {
            
            @strongify(self)
            
            [self parseGettingProjectsResponse: tuple[0]
                                withCompletion: ^{
                                    
                                    [subscriber sendNext: [DataManagerShared getAllProjects]];
                                    [subscriber sendCompleted];
                                    
                                }];
            
        }
                                                                                         error: ^(NSError *error) {
                                                                      
                                                                                             [subscriber sendError: error];
                                                                      
                                                                  }];
        
        
        return nil;
    }];
    
    
    return loadingSignal;
}

- (RACSignal*) updateAllProjectsListWithServer
{
    return [RACSignal empty];
}

- (void) loadProjectData: (ProjectInfo*) project
{
    // Load all roles
    // Load systems
    // Load all task filters data
    NSArray* signals = @[[[RolesService sharedInstance] loadAllRolesForProject: project],
                         [[SystemsService sharedInstance] loadCurrentProjectSystems: project.projectID],
                         [[TasksService sharedInstance] loadAllTasksForProject: project],
                         [self loadUserPermissionForProjectWithID: project.projectID],
                         [[RoomsService sharedInstance] getRoomLevelsForSelectedProjectWithID: project.projectID],
                         [[TaskFiltersService sharedInstance] loadAllTaskFiltersInfo: project.projectID]];
    
    RACSignal* loadProjectInfo = [RACSignal combineLatest: signals];
    
    [loadProjectInfo subscribeCompleted: ^{
        
        NSLog(@"<INFO> Load project info is successful!");
        
        [DefaultNotifyCenter postNotificationName: @"NeedToUpdateContent"
                                           object: nil];
        
        [SVProgressHUD dismiss];
        
    }];
}

- (RACSignal*) updatedProjectInfo: (ProjectInfo*) project
{
    NSString* requestURL = [loadProjectInfoURL stringByReplacingOccurrencesOfString: @"{id}"
                                                                         withString: project.projectID.stringValue];
    
    @weakify(self)
    
    RACSignal* loadProjectInfoSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[ProjectsAPIService sharedInstance] loadProjectInfo: requestURL]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             [self parseProjectInfoResponse: response[0]
                             withCompletion: ^(BOOL isSuccess) {
                                
                                 [subscriber sendNext: nil];
                                 [subscriber sendCompleted];
                                 
                             }];
             
         }
         error: ^(NSError *error) {
             
             [subscriber sendError: error];
             
         }];
        
        return nil;
    }];
    
    return loadProjectInfoSignal;
}

#pragma mark - Internal methods -

- (void) parseGettingProjectsResponse: (NSDictionary*) response
                       withCompletion: (void(^)())     completion
{
    NSError* parseError       = nil;
    NSArray* responseProjects = response[@"list"];
    NSArray* projectsList     = [ProjectInfoModel arrayOfModelsFromDictionaries: responseProjects
                                                                          error: &parseError];
    
    if ( parseError )
    {
        NSLog(@"<ERROR> Parse error: %@", parseError.localizedDescription);
    }
    else
    {
        [DataManagerShared persistNewProjects: projectsList
                               withCompletion: ^{
                                   
                                   completion();
                                   
                               }];
    }
}

- (RACSignal*) loadUserPermissionForProjectWithID: (NSNumber*) projectID
{
    NSString* requestURL = [projectUserPermissionURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                                               withString: projectID.stringValue];
    
    @weakify(self)
    
    RACSignal* loadUserPermissionSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[ProjectsAPIService sharedInstance] getProjectPermission: requestURL]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             [self updateProjectPermissionValue: response[0]
                                 withCompletion: ^(BOOL isSuccess) {
                                     
                                     [subscriber sendNext: nil];
                                     [subscriber sendCompleted];
                                     
                                 }];
             
         }
         error: ^(NSError* error) {
             
             [subscriber sendError: error];
             
         }];
        
        
        return nil;
    }];
    
    return loadUserPermissionSignal;
}


- (void) updateProjectPermissionValue: (NSDictionary*)         response
                       withCompletion: (CompletionWithSuccess) completion
{
    NSUInteger projectPermissionValue = [response[@"projectPermission"] integerValue];
    
    [DataManagerShared updateSelectedProjectPermission: projectPermissionValue
                                        withCompletion: completion];
}

- (void) parseProjectInfoResponse: (NSDictionary*)         response
                   withCompletion: (CompletionWithSuccess) completion
{
    NSError* parseError           = nil;
    ProjectInfoModel* projectInfo = [[ProjectInfoModel alloc] initWithDictionary: response
                                                                           error: &parseError];
    
    if ( parseError )
    {
        NSLog(@"<ERROR> with parsing project info: %@", parseError.debugDescription);
    }
    else
    {
        [DataManagerShared updateSelectedProjectInfo: projectInfo
                                      withCompletion: completion];
    }
}



#pragma mark - Life Cycle -

+ (instancetype) allocWithZone: (NSZone*) zone
{
    return [self sharedInstance];
}

+ (instancetype) copyWithZone: (struct _NSZone*) zone
{
    return [self sharedInstance];
}

+ (instancetype) mutableCopyWithZone: (struct _NSZone*) zone
{
    return [self sharedInstance];
}

- (instancetype) copy
{
    return [[ProjectsService alloc] init];
}

- (instancetype) mutableCopy
{
    return [[ProjectsService alloc] init];
}

- (instancetype) init
{
    if( SINGLETON )
    {
        return SINGLETON;
    }
    
    if ( isFirstAccess )
    {
        [self doesNotRecognizeSelector: _cmd];
    }
    
    self = [super init];
    
    return self;
}

@end
