//
//  TaskFiltersAPIService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskFiltersAPIService.h"

@implementation TaskFiltersAPIService


#pragma mark - Shared instance -

+ (instancetype)sharedInstance
{
    static TaskFiltersAPIService* instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [TaskFiltersAPIService new];
    });

    return instance;
}


#pragma mark - Public methods -

- (RACSignal*) loadTaskFilterCreators: (NSString*) url
{
    AFHTTPRequestOperationManager* requestManager = [self getDefaultManager];
    
    return [[[requestManager rac_GET: url parameters: nil] logError] replayLazily];
}

- (RACSignal*) loadTaskFilterWorkAreas: (NSString*) url
{
    AFHTTPRequestOperationManager* requestManager = [self getDefaultManager];
    
    return [[[requestManager rac_GET: url parameters: nil] logError] replayLazily];
}

- (RACSignal*) loadTaskFilterApprovers: (NSString*) url
{
    AFHTTPRequestOperationManager* requestManager = [self getDefaultManager];
    
    return [[[requestManager rac_GET: url parameters: nil] logError] replayLazily];
}

- (RACSignal*) loadTaskFilterTypes: (NSString*) url
{
    AFHTTPRequestOperationManager* requestManager = [self getDefaultManager];
    
    return [[[requestManager rac_GET: url parameters: nil] logError] replayLazily];
}

- (RACSignal*) loadTaskFilterStatuses: (NSString*) url
{
    AFHTTPRequestOperationManager* requestManager = [self getDefaultManager];
    
    return [[[requestManager rac_GET: url parameters: nil] logError] replayLazily];
}

- (RACSignal*) loadTaskFilterResponsibles: (NSString*) url
{
    AFHTTPRequestOperationManager* requestManager = [self getDefaultManager];
    
    return [[[requestManager rac_GET: url parameters: nil] logError] replayLazily];
}

- (RACSignal*) loadTaskFilterExpired: (NSString*) url
{
    AFHTTPRequestOperationManager* requestManager = [self getDefaultManager];
    
    return [[[requestManager rac_GET: url parameters: nil] logError] replayLazily];
}

@end
