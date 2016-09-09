//
//  PermissionService.m
//  TookTODO
//
//  Created by Lera on 09.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "PermissionService.h"
#import "APIConstance.h"
#import "PermissionAPIService.h"

@implementation PermissionService

static dispatch_once_t onceToken;
static PermissionService* SINGLETON = nil;
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
    return [[PermissionService alloc] init];
}

- (instancetype) mutableCopy
{
    return [[PermissionService alloc] init];
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

#pragma mark - Public -

- (NSDictionary*) loadUserPermissionForProject: (ProjectInfo*) projectInfo
{
    
    
    NSString* buildRequstURL = [projectUserPermissionURL stringByReplacingOccurrencesOfString: @"{projectID}"
                                                                                   withString: projectInfo.projectID.stringValue];
    
    PermissionAPIService* manager = [PermissionAPIService new];
    
    return [manager loadProjectPermissions: buildRequstURL];
}

@end
