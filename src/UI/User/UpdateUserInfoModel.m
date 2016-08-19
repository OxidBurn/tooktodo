//
//  UpdateUserInfoModel.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/18/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UpdateUserInfoModel.h"

// Classes
#import "DataManager+UserInfo.h"
#import "UserInfo.h"
#import "Utils.h"
#import "LoginService.h"

@interface UpdateUserInfoModel()

// properties

@property (strong, nonatomic) UserInfo* currentUserInfo;

// methods


@end

@implementation UpdateUserInfoModel

#pragma mark - Properties -

- (UserInfo*) currentUserInfo
{
    if ( _currentUserInfo == nil )
    {
        _currentUserInfo = [DataManagerShared getCurrentUserInfo];
    }
    
    return _currentUserInfo;
}

#pragma mark - Public -

- (NSString*) getUserName
{
    NSArray* names = [self.currentUserInfo.fullName componentsSeparatedByString: @" "];
    
    if ( names.count > 0 )
        return names.firstObject;
    
    return @"";
}

- (NSString*) getSurName
{
    NSArray* names = [self.currentUserInfo.fullName componentsSeparatedByString: @" "];
    
    if ( names.count > 1 )
        return names.lastObject;
    
    return @"";
}

- (NSString*) getUserPhoneNumber
{
    return self.currentUserInfo.phoneNumber;
}

- (NSString*) getUserAdditionalPhoneNumber
{
    return self.currentUserInfo.extendPhoneNumber;
}

- (void) updateUserValues: (UpdatedUserInfo*) newInfo
{
    self.currentUserInfo.fullName          = [newInfo.name stringByAppendingFormat: @" %@", newInfo.surname];
    self.currentUserInfo.phoneNumber       = newInfo.phoneNumber;
    self.currentUserInfo.extendPhoneNumber = newInfo.additionalPhoneNumber;
    
    [DataManagerShared updateUserInfo: self.currentUserInfo];
    
    NSDictionary* requestParameters = @{@"firstName"             : newInfo.name,
                                        @"lastName"              : newInfo.surname,
                                        @"phoneNumber"           : newInfo.phoneNumber,
                                        @"additionalPhoneNumber" : newInfo.additionalPhoneNumber};
    
    [[LoginService updateUserInfo: requestParameters] subscribeNext: ^(RACTuple* x) {
        
        NSLog(@"Server response: %@", x);
        
    }
                                                              error: ^(NSError *error) {
                                                                  
                                                                  NSLog(@"Error with request: %@", error.localizedDescription);
                                                                  
                                                              }
                                                          completed: ^{
                                                              
                                                              NSLog(@"Success complete");
                                                              
                                                          }];
}

@end
