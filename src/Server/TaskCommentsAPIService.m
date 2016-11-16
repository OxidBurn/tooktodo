//
//  TaskCommentsAPIService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskCommentsAPIService.h"

@implementation TaskCommentsAPIService


#pragma mark - Shared -

+ (instancetype) sharedInstance
{
    static TaskCommentsAPIService* instance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [TaskCommentsAPIService new];
        
    });
    
    return instance;
}


#pragma mark - Public methods -

- (RACSignal*) loadAllCommentsForTask: (NSString*) requestString
{
    AFHTTPRequestOperationManager* requestManager = [self getDefaultManager];
    
    return [[[requestManager rac_GET: requestString parameters: nil] logError] replayLazily];
}

@end
