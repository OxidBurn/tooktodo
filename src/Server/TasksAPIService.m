//
//  TasksAPIService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TasksAPIService.h"

@implementation TasksAPIService

#pragma mark - Shared -
+ (instancetype) sharedInstance
{
    static TasksAPIService* instance = nil;

    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [TasksAPIService new];
    });

    return instance;
}


#pragma mark - Public methods -

- (RACSignal*) loadTasksForProjectWithURL: (NSString*) url
{
    AFHTTPRequestOperationManager* requestManager = [self getDefaultManager];
    
    return [[[requestManager rac_GET: url parameters: nil] logError] replayLazily];
}



@end
