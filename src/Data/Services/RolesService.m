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
#import "ProjectRoleObject.h"

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


#pragma mark - Internal methods -

- (void) parseRolesRequestResponse: (NSArray*)              response
                    withCompletion: (CompletionWithSuccess) completion
{
    NSError* parseError = nil;
    NSArray* rolesInfo  = [ProjectRoleObject arrayOfModelsFromDictionaries: response
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
