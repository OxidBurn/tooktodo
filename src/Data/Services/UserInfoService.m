//
//  UserInfoService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UserInfoService.h"

// Classes
#import "UserAPIService.h"

@implementation UserInfoService

static dispatch_once_t onceToken;
static UserInfoService* SINGLETON = nil;
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

- (RACSignal*) logoutUser: (UserInfo*) info
{
    RACSignal* deleteUserInfoSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[UserAPIService sharedInstance] logOut] subscribeNext: ^(id x) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
               
                [DataManagerShared deleteCurrentUser: info];
                [DataManagerShared deleteAllProjects];
                
            }];
            
            [[KeyChainManager sharedInstance] deleteToken];
            
            [subscriber sendNext: x];
            
        }
                                                          error: ^(NSError *error) {
                                                              
                                                              [subscriber sendError: error];
                                                              
                                                          }
                                                      completed: ^{
                                                         
                                                          [subscriber sendCompleted];
                                                          
                                                      }];
        
        return nil;
        
    }];
    
    return deleteUserInfoSignal;
}

- (void) updateInfoForUser: (UserInfo*)               user
               withNewInfo: (UpdatedUserInfo*)        newInfo
            withCompletion: (void(^)(BOOL isSuccess)) completion
{
    
    
    // Update info on server
    NSDictionary* requestParameters = @{@"firstName"             : newInfo.name,
                                        @"lastName"              : newInfo.surname,
                                        @"phoneNumber"           : newInfo.phoneNumber,
                                        @"additionalPhoneNumber" : newInfo.additionalPhoneNumber};
    
    [[[UserAPIService sharedInstance] updateUserInfoOnServer: requestParameters] subscribeNext: ^(NSDictionary* info) {
        
        BOOL isSuccess = [[info valueForKey: @"isSuccess"] boolValue];
        
        if ( isSuccess )
        {
            [SVProgressHUD showSuccessWithStatus: @"Данные успешно обновлены"];
            
            // Update info localy
            [[DataManager sharedInstance] updateUserInfo: newInfo
                                                 forUser: user
                                          withCompletion: completion];
        }
        else
        {
            NSArray* modelErrors = info[@"modelErrors"];
            NSString* message    = modelErrors[0][@"message"];
            
            [message stringByReplacingOccurrencesOfString: @"Last Name"
                                               withString: @"Поле Фамилия"];
            [message stringByReplacingOccurrencesOfString: @"First Name"
                                               withString: @"Поле Имя"];
            
            [SVProgressHUD showErrorWithStatus: message];
            
            if ( completion )
                completion(NO);
        }
        
        
        
    }
                                                              error: ^(NSError *error) {
                                                                  
                                                                  [SVProgressHUD showErrorWithStatus: error.localizedDescription];
                                                                  
                                                                  if ( completion )
                                                                      completion(NO);
                                                                  
                                                              }
                                                          completed: ^{
                                                              
                                                              NSLog(@"Success complete");
                                                              
                                                          }];
}

- (RACSignal*) getUserInfo
{
    return [[UserAPIService sharedInstance] getUserInfo];
}

- (void) updateAvatarWithFile: (NSString*) filePath
{
    [[UserAPIService sharedInstance] getAvatarFileID: filePath
                                      withCompletion:^(NSDictionary *response, NSError *error) {
                                          
                                          if ( error == nil )
                                          {
                                              NSString* fileID = response[@"id"];
                                              
                                              NSDictionary* parameters = @{@"fileId" : fileID};
                                              
                                              RACSignal* updateAvatarSignal = [[UserAPIService sharedInstance] updateAvatar: parameters];
                                              
                                              [updateAvatarSignal subscribeNext: ^(RACTuple* tuple) {
                                                  
                                                  NSLog(@"Response %@", tuple);
                                                  
                                              }
                                                                          error:^(NSError *error) {
                                                                              
                                                                              NSLog(@"Error with getting file info: %@", error.localizedDescription);
                                                                              
                                                                          }];
                                          }
                                          
                                      }];
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
    return [[UserInfoService alloc] init];
}

- (instancetype) mutableCopy
{
    return [[UserInfoService alloc] init];
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
