//
//  TeamService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/3/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamService.h"

// Classes
#import "ProjectInfo+CoreDataClass.h"
#import "APIConstance.h"
#import "TeamAPIService.h"
#import "TeamMemberModel.h"
#import "ProjectRoleAssignmentsModel.h"

// Categories
#import "DataManager+Team.h"
#import "DataManager+ProjectInfo.h"
//#import "UIAl"



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
            
            [subscriber sendNext: [DataManagerShared getSelectedProjectRoleAssignments]];
            
        }];
        
        [[[TeamAPIService sharedInstance] getProjectTeamWithRequestURL: [self buildRequestURL]]
         subscribeNext: ^(RACTuple* tuple) {
             
             [self parseGettingTeamResponse: tuple[0]
                             withCompletion: ^(BOOL isSuccess) {
                                 
                                 [[RACScheduler mainThreadScheduler] schedule: ^{
                                     
                                     [subscriber sendNext: [DataManagerShared getSelectedProjectRoleAssignments]];
                                     [subscriber sendCompleted];
                                     
                                 }];
                                 
                             }];
         }
         error: ^(NSError *error) {
             
             [subscriber sendError: error];
             
         }];
        
        
        return nil;
    }];
    
    return fetchTeamInfoSignal;
}

- (RACSignal*) inviteUserWithInfo: (InviteInfo*) info
{
    info.projectId                 = @([[self getProjectID] integerValue]);
    
    NSDictionary* inviteParameter  = [info toDictionary];
    NSArray* invites               = @[inviteParameter];
    NSDictionary* requestParameter = @{@"invites" : invites};
    
    @weakify(self)
    
    RACSignal* inviteSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[TeamAPIService sharedInstance] sendInviteToTeam: requestParameter]
         subscribeNext: ^(RACTuple* response) {
             
             BOOL isSuccess = [response[0][@"succeeded"] boolValue];
             
             @strongify(self)
             
             if ( isSuccess )
             {
                 [self addNewTeamMember: info
                         withCompletion: ^(BOOL isSuccess) {
                             
                             [subscriber sendNext: nil];
                             [subscriber sendCompleted];
                             
                         }];
             }
             else
             {
                 NSString* errorMessage = [NSString stringWithFormat: @"%@\n%@", response[0][@"errors"][0][@"email"], response[0][@"errors"][0][@"message"]];
                 
                 [Utils showErrorAlertWithMessage: errorMessage];
                 
                 [subscriber sendNext: nil];
             }
             
         }
         error: ^(NSError *error) {
             
             [subscriber sendError: error];
             
         }
         completed: ^{
             

             
         }];
        
        return nil;
    }];
    
    return inviteSignal;
}

- (RACSignal*) getProjectUserPermission
{
    return [RACSignal empty];
}

- (RACSignal*) updateSelectedUserPermission: (NSUInteger) permission
                              withProjectID: (NSNumber*)  projectID
                                 withUserID: (NSNumber*)  userID
{
    RACSignal* updateSelectedUserPermissionSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        [DataManagerShared updateTeamMemberPermission: permission
                                       withCompletion: ^(BOOL isSuccess) {
                                           
                                           [subscriber sendNext: nil];
                                           
                                       }];
        
        NSString* requestURL = [[projectRolePermissionURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                                                   withString: projectID.stringValue]
                                stringByReplacingOccurrencesOfString: @"{userId}"
                                withString: userID.stringValue];
        
        switch (permission)
        {
            case 2:
            {
                [[[TeamAPIService sharedInstance] setUserAsAdmin: requestURL]
                 subscribeNext: ^(id x) {
                     
                     [subscriber sendNext: x];
                     [subscriber sendCompleted];
                     
                 }
                 error: ^(NSError *error) {
                     
                     [subscriber sendNext: error];
                     
                 }];
            }
                break;
                
            case 0:
            {
                [[[TeamAPIService sharedInstance] removeAdminRightFromUser: requestURL]
                 subscribeNext: ^(id x) {
                     
                     [subscriber sendNext: x];
                     [subscriber sendCompleted];
                     
                 }
                 error: ^(NSError *error) {
                     
                     [subscriber sendNext: error];
                     
                 }];
            }
                break;
        }
        
        
        return nil;
    }];
    
    return updateSelectedUserPermissionSignal;
}

- (RACSignal*) updateSelectedUserRole: (ProjectRoles*) role
{
    return [RACSignal empty];
}

#pragma mark - Internal methods -

- (void) parseGettingTeamResponse: (NSArray*)              response
                   withCompletion: (CompletionWithSuccess) completion
{
    NSError* parseError = nil;
    NSArray* teamList   = [ProjectRoleAssignmentsModel arrayOfModelsFromDictionaries: response
                                                                               error: &parseError];
    
    if ( parseError )
    {
        NSLog(@"<ERROR> Parse error: %@", parseError.localizedDescription);
    }
    else
    {
        [DataManagerShared persistSelectedProjectRoleAssignments: teamList
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
    if ( [self getProjectID] )
    {
        NSString* requestURL = [projectRoleAssignmentsURL stringByReplacingOccurrencesOfString: @"{id}"
                                                                                    withString: [self getProjectID]];
        
        return requestURL;
    }
    else
    {
        return @"";
    }
}

- (void) addNewTeamMember: (InviteInfo*)           info
           withCompletion: (CompletionWithSuccess) completion
{
    TeamMemberModel* object = [[TeamMemberModel alloc] init];
    
    object.firstName = info.firstName;
    object.lastName = info.lastName;
    object.email = info.email;
    
    [DataManagerShared persistTeamMemebers: @[object]
                                 inProject: [self getSelectedProject]
                            withCompletion: completion];
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
