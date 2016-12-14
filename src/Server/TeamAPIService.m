//
//  TeamAPIService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/3/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamAPIService.h"

@implementation TeamAPIService

static dispatch_once_t onceToken;
static TeamAPIService* SINGLETON = nil;
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


- (RACSignal*) getProjectTeamWithRequestURL: (NSString*) url
{
    AFHTTPRequestOperationManager* requestManager = [self getDefaultManager];
    
    return [[[requestManager rac_GET: url parameters: nil] logError] replayLazily];
}

- (RACSignal*) sendInviteToTeam: (NSDictionary*) parameter
{
    AFHTTPRequestOperationManager* requestManager = [self getRawManager];
    
    return [[[requestManager rac_POST: inviteURL parameters: parameter] logError] replayLazily];
}

- (RACSignal*) setUserAsAdmin: (NSString*) url
{
    AFHTTPRequestOperationManager* manager = [self getRawManager];
    
    return [[[manager rac_POST: url parameters: nil] logError] replayLazily];
}

- (RACSignal*) removeAdminRightFromUser: (NSString*) url
{
    AFHTTPRequestOperationManager* manager = [self getRawManager];
    
    return [[[manager rac_DELETE: url parameters: nil] logError] replayLazily];
}

- (RACSignal*) updateUserRoleTypeByURL: (NSString*)     url
                        withParameters: (NSDictionary*) parameter
{
    AFHTTPRequestOperationManager* requestManager = [self getRawManager];
    
    return [[[requestManager rac_PUT: url parameters: parameter] logError] replayLazily];
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
    return [[TeamAPIService alloc] init];
}

- (instancetype) mutableCopy
{
    return [[TeamAPIService alloc] init];
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
