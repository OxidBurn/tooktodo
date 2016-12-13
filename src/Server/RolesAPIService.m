//
//  RolesAPIService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RolesAPIService.h"

@implementation RolesAPIService

static dispatch_once_t onceToken;
static RolesAPIService* SINGLETON = nil;
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

- (RACSignal*) loadProjectsRoles: (NSString*) requestURL
{
    AFHTTPRequestOperationManager* requestManager = [self getDefaultManager];
    
    return [[[requestManager rac_GET: requestURL parameters: nil] logError] replayLazily];
}

- (RACSignal*) loadDefaultRoles
{
    AFHTTPRequestOperationManager* requestManager = [self getDefaultManager];
    
    return [[[requestManager rac_GET: defaultRolesURL parameters: nil] logError] replayLazily];
}

- (RACSignal*) createNewRoleTypeForProject: (NSString*)     requestURL
                             withParameter: (NSDictionary*) parameter
{
    AFHTTPRequestOperationManager* requestManager = [self getRawManager];
    
    RACSignal* postSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [requestManager POST: requestURL
                  parameters: parameter
                     success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                         
                         [subscriber sendNext: responseObject];
                         [subscriber sendCompleted];
                         
                     }
                     failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                         
                         NSError* responseError = [NSError errorWithDomain: error.domain
                                                                      code: error.code
                                                                  userInfo: operation.responseObject];
                         
                         [subscriber sendError: responseError];
                         
                     }];
        
        
        return nil;
    }];
    
    return postSignal;
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
    return [[RolesAPIService alloc] init];
}

- (instancetype) mutableCopy
{
    return [[RolesAPIService alloc] init];
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
