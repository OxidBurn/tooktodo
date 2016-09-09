//
//  PermissionAPIService.m
//  TookTODO
//
//  Created by Lera on 09.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "PermissionAPIService.h"

static dispatch_once_t onceToken;
static PermissionAPIService* SINGLETON = nil;
static bool isFirstAccess = YES;

@interface PermissionAPIService()

// properties
@property (strong, nonatomic) NSDictionary* permissionData;

// methods

@end

@implementation PermissionAPIService

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

//- (RACSignal*) loadProjectsPermissions: (NSString*) requestURL
//{
//    AFHTTPRequestOperationManager* requestManager = [self getDefaultManager];
//    
//    return [[[requestManager rac_GET: requestURL parameters: nil] logError] replayLazily];
//}

- (NSDictionary*) loadProjectPermissions: (NSString*) requestURL
{
    AFHTTPRequestOperationManager* requestManager = [self getDefaultManager];
    
    requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [requestManager GET: requestURL
             parameters: nil
                success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    self.permissionData = (NSDictionary*)responseObject;
                    
                } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                        message:[error localizedDescription]
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Ok"
                                                              otherButtonTitles:nil];
                    [alertView show];
                    
                }];
    
    return self.permissionData;
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
    return [[PermissionAPIService alloc] init];
}

- (instancetype) mutableCopy
{
    return [[PermissionAPIService alloc] init];
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
