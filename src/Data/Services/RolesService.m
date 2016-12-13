//
//  RolesService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RolesService.h"

// Classes
#import "APIConstance.h"
#import "RolesAPIService.h"
#import "ProjectRoleModel.h"
#import "DefaultRoleModel.h"
#import "NewProjectRoleTypeModel.h"

// Categories
#import "DataManager+Roles.h"
#import "DataManager+ProjectInfo.h"

@implementation RolesService

static dispatch_once_t onceToken;
static RolesService* SINGLETON = nil;
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


#pragma mark - Methods -

- (RACSignal*) loadAllRolesForProject: (ProjectInfo*) project
{
    if ( project && project.projectID )
    {
        NSString* buildRequestURL = [projectRolesURL stringByReplacingOccurrencesOfString: @"{projectID}"
                                                                               withString: project.projectID.stringValue];
        
        @weakify(self)
        
        RACSignal* loadingRolesSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [[[RolesAPIService sharedInstance] loadProjectsRoles: buildRequestURL]
             subscribeNext: ^(RACTuple* response) {
                 
                 @strongify(self)
                 
                 [self parseRolesRequestResponse: response[0]
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
        
        return loadingRolesSignal;

    }

    return nil;
}

- (RACSignal*) getRolesOfTheSelectedProject
{
    RACSignal* fetchProjectsRolesSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[RACScheduler mainThreadScheduler] schedule: ^{
            
            [subscriber sendNext: [DataManagerShared getAllRolesInCurrentProject]];
            
            [subscriber sendCompleted];
            
        }];
        
        return nil;
    }];
    
    return fetchProjectsRolesSignal;
}

- (RACSignal*) loadDefaultListOfRoles
{
    @weakify(self)
    
    RACSignal* getDefaultListOfRolesSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[RolesAPIService sharedInstance] loadDefaultRoles]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             [self parseDefaultRolesRequestResponse: response[0]
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
    
    return getDefaultListOfRolesSignal;
}

- (RACSignal*) getDefaultRoles
{
    RACSignal* fetchDefaultRolesSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[RACScheduler mainThreadScheduler] schedule: ^{
            
            [subscriber sendNext: [DataManagerShared getAllDefaultRoles]];
            
            [subscriber sendCompleted];
            
        }];
        
        return nil;
    }];
    
    return fetchDefaultRolesSignal;
}

- (RACSignal*) addNewRoleForCurrentProjectWithTitle: (NSString*) roleTitle
{
    NSString* requestURL = [self buildCreateRoleTypeForProject];
    
    NSDictionary* parameters = @{@"title" : roleTitle};
    
    @weakify(self)
    
    RACSignal* createNewRoleTypeSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[[RolesAPIService sharedInstance] createNewRoleTypeForProject: requestURL
                                                        withParameter: parameters]
         deliverOn: [RACScheduler mainThreadScheduler]]
         subscribeNext: ^(NSDictionary* response) {
             
             @strongify(self)
             
             [self parseCreationRoleTypeResponse: response
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
    
    return createNewRoleTypeSignal;
}


#pragma mark - Parsing and store to DataBase -

- (void) parseRolesRequestResponse: (NSArray*)              response
                    withCompletion: (CompletionWithSuccess) completion
{
    NSError* parseError = nil;
    NSArray* rolesInfo  = [ProjectRoleModel arrayOfModelsFromDictionaries: response
                                                                    error: &parseError];
    
    if ( parseError )
    {
        NSLog(@"<ERROR> Parse roles error: %@", parseError.localizedDescription);
    }
    else
    {
        [DataManagerShared persistNewRoles: rolesInfo
                            withCompletion: completion];
    }
}

- (void) parseDefaultRolesRequestResponse: (NSArray*)              response
                           withCompletion: (CompletionWithSuccess) completion
{
    NSError* parseError = nil;
    NSArray* rolesInfo  = [DefaultRoleModel arrayOfModelsFromDictionaries: response
                                                                     error: &parseError];
    
    if ( parseError )
    {
        NSLog(@"<ERROR> Parse roles error: %@", parseError.localizedDescription);
    }
    else
    {
        [DataManagerShared persistNewDefaultRoles: rolesInfo
                                   withCompletion: completion];
    }
}

- (void) parseCreationRoleTypeResponse: (NSDictionary*)         response
                        withCompletion: (CompletionWithSuccess) completion
{
    NSError* parseError                = nil;
    NewProjectRoleTypeModel* roleModel = [[NewProjectRoleTypeModel alloc] initWithDictionary: response
                                                                                       error: &parseError];
    
    if ( parseError )
    {
        NSLog(@"<ERROR> Error with parsing role type response: %@", parseError.localizedDescription);
    }
    else
    {
        [DataManagerShared persistNewRole: roleModel
                           withCompletion: completion];
    }
}


#pragma mark - Internal methods -

- (NSString*) buildCreateRoleTypeForProject
{
    ProjectInfo* selectedProject = [DataManagerShared getSelectedProjectInfo];
    
    NSString* requestURL = [createNewProjectRoleTypeURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                                                  withString: selectedProject.projectID.stringValue];
    
    return requestURL;
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
    return [[RolesService alloc] init];
}

- (instancetype) mutableCopy
{
    return [[RolesService alloc] init];
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
