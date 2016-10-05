//
//  RoomsAPIService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 10/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RoomsAPIService.h"

@implementation RoomsAPIService

#pragma mark - Shared instance -

+ (instancetype) sharedInstance
{
    static RoomsAPIService* instance = nil;

    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        instance = [RoomsAPIService new];
    });

    return instance;
}


#pragma mark - Public methods -

- (RACSignal*) fetchRoomsLevelInfoForProject: (NSString*) url
{
    AFHTTPRequestOperationManager* requestManager = [self getDefaultManager];
    
    return [[[requestManager rac_GET: url parameters: nil] logError] replayLazily];
}

@end
