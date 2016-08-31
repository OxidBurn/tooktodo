//
//  UserAPIService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UserAPIService.h"

@implementation UserAPIService

static dispatch_once_t onceToken;
static UserAPIService* SINGLETON = nil;
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

- (RACSignal*) logOut
{
    AFHTTPRequestOperationManager* manager = [self getDefaultManager];
    
    return [[[manager rac_GET: userInfoURL parameters: nil] logError] replayLazily];
}


- (RACSignal*) updateUserInfoOnServer: (NSDictionary*) parameters
{
    AFHTTPRequestOperationManager* manager = [self getDefaultManager];
    
    return [[[manager rac_PUT: updateUserInfoURL parameters: parameters] logError] replayLazily];
}

- (RACSignal*) updatePasswordFromOld: (NSString*) old
                               toNew: (NSString*) pass
{
    AFHTTPRequestOperationManager* manager = [self getDefaultManager];
    
    NSDictionary* parameters = @{@"oldPassword"     : old,
                                 @"newPassword"     : pass,
                                 @"confirmPassword" : pass};
    
    return [[[manager rac_POST: updatePasswordURL parameters: parameters] logError] replayLazily];
}

- (RACSignal*) getUserInfo
{
    AFHTTPRequestOperationManager* manager = [self getDefaultManager];
    
    return [[[manager rac_GET: userInfoURL parameters: nil] logError] replayLazily];
}

- (RACSignal*) getAvatarFileID: (NSDictionary*) parameters
{
    AFHTTPRequestOperationManager* manager = [self getManagerWithToken];
    
    return [[[manager rac_POST: fileInfoURL parameters: parameters] logError] replayLazily];
}

- (void) getAvatarFileID: (NSString*)                           filePath
          withCompletion: (void (^)(NSDictionary *, NSError *)) completion
{
    if ( filePath == nil )
        return;
    
    NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod: @"POST"
                                                                                              URLString: [serverURL stringByAppendingString: fileInfoURL]
                                                                                             parameters: nil
                                                                              constructingBodyWithBlock: ^(id<AFMultipartFormData> formData) {
                                                                                  
        [formData appendPartWithFileURL: [NSURL fileURLWithPath: filePath]
                                   name: @"file"
                               fileName: filePath.lastPathComponent
                               mimeType: @"image/png"
                                  error: nil];
    } error: nil];
    
    [request setValue: [NSString stringWithFormat: @"Bearer %@", [KeyChain getAccessToken]]
   forHTTPHeaderField: @"Authorization"];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    
    uploadTask = [manager uploadTaskWithStreamedRequest: request
                                               progress: nil
                                      completionHandler: ^(NSURLResponse *response, id responseObject, NSError *error) {
                                         
                                          completion (responseObject[0], error);
                                          
                                      }];
    
    [uploadTask resume];
}

- (RACSignal*) updateAvatar: (NSDictionary*) parameters
{
    AFHTTPRequestOperationManager* manager = [self getDefaultManager];
    
    [manager.requestSerializer setValue: @"application/x-www-form-urlencoded"
                     forHTTPHeaderField: @"Content-Type"];
    
    return [[[manager rac_PUT: updateAvatarURL parameters: parameters] logError] replayLazily];
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
    return [[UserAPIService alloc] init];
}

- (instancetype) mutableCopy
{
    return [[UserAPIService alloc] init];
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
