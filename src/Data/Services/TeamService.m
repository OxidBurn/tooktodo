//
//  TeamService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/3/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamService.h"

// Classes
#import "ProjectInfo.h"
#import "APIConstance.h"
#import "TeamAPIService.h"
#import "TeamMemberObject.h"

// Categories
#import "DataManager+Team.h"
#import "DataManager+ProjectInfo.h"

@implementation TeamService

static dispatch_once_t onceToken;
static TeamService* SINGLETON = nil;
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

- (RACSignal*) getTeamInfo
{
    @weakify(self)
    
    RACSignal* fetchTeamInfoSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        @strongify(self)
        
        [[RACScheduler mainThreadScheduler] schedule: ^{
            
            [subscriber sendNext: [DataManagerShared getAllTeamInfo]];
            
        }];
        
        [[[TeamAPIService sharedInstance] getProjectTeamWithRequestURL: [self buildRequestURL]]
         subscribeNext: ^(RACTuple* tuple) {
             
             [self parseGettingTeamResponse: tuple[0]
                             withCompletion: ^(BOOL isSuccess) {
                                 
                                 [[RACScheduler mainThreadScheduler] schedule: ^{
                                     
                                     [subscriber sendNext: [DataManagerShared getAllTeamInfo]];
                                     
                                 }];
                                 
                             }];
         }
         error: ^(NSError *error) {
             
             [subscriber sendError: error];
             
         }
         completed: ^{
             
             [subscriber sendCompleted];
             
         }];
        
        
        return nil;
    }];
    
    return fetchTeamInfoSignal;
}

- (RACSignal*) inviteUserWithInfo: (InviteInfo*) info
{
//    NSDictionary* inviteParameter = @{};
//    NSArray* invites = @[@{}];
//    NSDictionary* requestParameter = @{@"invites" : @[
//                                               ]};
    
    return nil;
}


#pragma mark - Internal methods -

- (void) parseGettingTeamResponse: (NSDictionary*)         response
                   withCompletion: (CompletionWithSuccess) completion
{
    NSError* parseError   = nil;
    NSArray* responseTeam = response[@"list"];
    NSArray* teamList     = [TeamMemberObject arrayOfModelsFromDictionaries: responseTeam
                                                                      error: &parseError];
    
    if ( parseError )
    {
        NSLog(@"<ERROR> Parse error: %@", parseError.localizedDescription);
    }
    else
    {
        [DataManagerShared persistTeamMemebers: teamList
                                     inProject: [self getSelectedProject]
                                withCompletion: completion];
    }
}

- (NSString*) getProjectID
{
    ProjectInfo* project = [self getSelectedProject];
    
    return project.projectID.stringValue;
}

- (ProjectInfo*) getSelectedProject
{
    return [DataManagerShared getSelectedProjectInfo];
}

- (NSString*) buildRequestURL
{
    NSString* requestURL = [projectTeamInfoURL stringByReplacingOccurrencesOfString: @"{projectID}"
                                                                         withString: [self getProjectID]];
    
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
    return [[TeamService alloc] init];
}

- (instancetype) mutableCopy
{
    return [[TeamService alloc] init];
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
