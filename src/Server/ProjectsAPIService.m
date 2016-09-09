//
//  ProjectsAPIService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/26/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectsAPIService.h"

@implementation ProjectsAPIService

static ProjectsAPIService *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone: NULL] init];
    });
    
    return SINGLETON;
}


#pragma mark - Public mehtods -

- (RACSignal*) getProjectsList: (NSDictionary*) parameters
{
    AFHTTPRequestOperationManager* manager = [self getDefaultManager];
    
    return [[[manager rac_GET: userProjectsListURL parameters: parameters] logError] replayLazily];
}

- (RACSignal*) getProjectPermission: (NSString*) requestURL
{
    AFHTTPRequestOperationManager* requestManager = [self getDefaultManager];
    
    return [[[requestManager rac_GET: requestURL parameters: nil] logError] replayLazily];
}

#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[ProjectsAPIService alloc] init];
}

- (id)mutableCopy
{
    return [[ProjectsAPIService alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}


@end
