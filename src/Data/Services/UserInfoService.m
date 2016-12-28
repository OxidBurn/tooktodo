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
#import "ProjectsService.h"

// Categories
#import "DataManager+ProjectInfo.h"

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
    [DataManagerShared updateUserInfo: newInfo
                              forUser: user
                       withCompletion: completion];
    
    // Update info on server
    NSDictionary* requestParameters = @{@"firstName"             : newInfo.name,
                                        @"lastName"              : newInfo.surname,
                                        @"phoneNumber"           : (newInfo.phoneNumber.length == 0 || newInfo.phoneNumber.length == 16) ? newInfo.phoneNumber : user.phoneNumber,
                                        @"additionalPhoneNumber" : (newInfo.additionalPhoneNumber.length == 0 || newInfo.additionalPhoneNumber.length == 16) ? newInfo.additionalPhoneNumber : user.extendPhoneNumber};
    
    [[[UserAPIService sharedInstance] updateUserInfoOnServer: requestParameters] subscribeNext: ^(NSDictionary* info) {
        
        BOOL isSuccess = [[info valueForKey: @"isSuccess"] boolValue];
        
        if (newInfo.name.length > 0 && newInfo.surname.length > 0 )
        {
            if ([self isCorrectNewUserPhone: newInfo])
            {
                if ( isSuccess )
                {
                    [SVProgressHUD showSuccessWithStatus: @"Данные успешно обновлены"];
                    
                    // Update info localy
                    [[DataManager sharedInstance] updateUserInfo: newInfo
                                                         forUser: user
                                                  withCompletion: completion];
                    
                    if ( completion )
                        completion(YES);
                }
            }
            
            else
            {
                NSString* message = @"Введите корректный номер телефона";
                [Utils showErrorAlertWithMessage: message];
                
                if ( completion )
                    completion(NO);
            }
        }
        
        else
        {
            NSArray* modelErrors = info[@"modelErrors"];
            NSString* message    = modelErrors[0][@"message"];
            
            message = [message stringByReplacingOccurrencesOfString: @"'First Name'"
                                                         withString: @"Поле 'Имя'"];
            message = [message stringByReplacingOccurrencesOfString: @"'Last Name'"
                                                         withString: @"Поле 'Фамилия'"];
            
            [Utils showErrorAlertWithMessage: message];
            
            if ( completion )
                completion(NO);
        }
        
        
        
    }
                                                              error: ^(NSError *error) {
                                                                  
                                                                  [Utils showErrorAlertWithMessage: error.localizedDescription];
                                                                  
                                                                  if ( completion )
                                                                      completion(NO);
                                                                  
                                                              }
                                                          completed: ^{
                                                              
                                                              NSLog(@"Success complete");
                                                              
                                                          }];
}

- (RACSignal*) getNewUserInfo
{
    RACSignal* getUserInfoSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
       
        [[[UserAPIService sharedInstance] getUserInfo] subscribeNext: ^(RACTuple* response) {
            
            [self parsingLoginResponseInfo: [response objectAtIndex: 0]
                            withCompletion: ^(BOOL isSuccess) {
                                
                                [subscriber sendNext: nil];
                                [subscriber sendCompleted];
                                
                            }];
            
            
        }
                                                               error: ^(NSError* error) {
                                                                   
                                                                   [subscriber sendError: error];
                                                                   
                                                               }
         
                                                           completed: ^{
                                                               
                                                           }];
        
        return nil;
    }];
    
    return getUserInfoSignal;
}

- (void) updateAvatarWithFile: (NSString*)             filePath
               withCompletion: (CompletionWithSuccess) completion
{
    [[UserAPIService sharedInstance] getAvatarFileID: filePath
                                      withCompletion: ^(NSDictionary *response, NSError *error) {
                                          
                                          if ( error == nil )
                                          {
                                              NSString* fileID = response[@"id"];
                                              
                                              NSDictionary* parameters = @{@"fileId" : fileID};
                                              
                                              RACSignal* updateAvatarSignal = [[UserAPIService sharedInstance] updateAvatar: parameters];
                                              
                                              [updateAvatarSignal subscribeNext: ^(RACTuple* tuple) {
                                                  
                                                  NSLog(@"Response %@", tuple);
                                                  
                                                  [DataManagerShared updateAvatarURLPathForCurrentUser: response[@"virtualPath"]
                                                                                        withCompletion: ^(BOOL isSuccess) {
                                                                               
                                                                               if ( completion )
                                                                                   completion(YES);
                                                                               
                                                                           }];
                                                  
                                              }
                                                                          error:^(NSError *error) {
                                                                              
                                                                              NSLog(@"Error with getting file info: %@", error.localizedDescription);
                                                                              
                                                                              if ( completion )
                                                                                  completion(NO);
                                                                              
                                                                          }];
                                          }
                                          
                                      }];
}

- (NSNumber*) getUserID
{
    return [DataManagerShared getCurrentUserID];
}


#pragma mark - Internal methods -

- (void) parsingLoginResponseInfo: (NSDictionary*)           info
                   withCompletion: (void(^)(BOOL isSuccess)) completion
{
    UserInfoData* userInfo = [[UserInfoData alloc] initWithDictionary: info
                                                                error: nil];
    
    [DataManagerShared persistUserWithInfo: userInfo
                            withCompletion: ^(BOOL isSuccess) {
                                
                                completion(isSuccess);
                                
                            }];
}

- (BOOL) isCorrectNewUserPhone: (UpdatedUserInfo*) newInfo
{
    BOOL isCorect = NO;
    
    if ((newInfo.phoneNumber.length == 0 || newInfo.phoneNumber.length == 16) && (newInfo.additionalPhoneNumber.length == 0 || newInfo.additionalPhoneNumber.length == 16))
    {
        isCorect = YES;
    }
    
    return isCorect;
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
