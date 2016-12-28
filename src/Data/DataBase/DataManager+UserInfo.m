//
//  DataManager+UserInfo.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager+UserInfo.h"
#import "UserInfo.h"

// Frameworks
#import <MagicalRecord/MagicalRecord.h>
#import <MagicalRecord/NSManagedObjectContext+MagicalSaves.h>

// Helpers
#import "AvatarHelper.h"
#import "Utils.h"

@implementation DataManager (UserInfo)

- (void) persistUserWithInfo: (UserInfoData*)           info
              withCompletion: (void(^)(BOOL isSuccess)) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        UserInfo* userInfo = [self getUserInfoWithEmail: info.email];
        
        if ( userInfo == nil )
        {
            userInfo = [UserInfo MR_createEntityInContext: localContext];
            
            if ( info.avatarSrc.length == 0 )
            {
                userInfo.photoImagePath = [[AvatarHelper sharedInstance] generateAvatarForName: [Utils getEmailPrefix: info.email]
                                                                              withAbbreviation: [Utils getAbbreviationWithName: info.firstName
                                                                                                                   withSurname: info.lastName]
                                                                                 withImageSize: CGSizeMake(60, 60)];
            }
            else
            {
                userInfo.photoImagePath = [[Utils getEmailPrefix: info.email] stringByAppendingString: @".png"];
            }
        }
        
        userInfo.fullName                         = (info.displayName) ? info.displayName : @"";
        userInfo.email                            = info.email;
        userInfo.firstName                        = info.firstName;
        userInfo.lastName                         = info.lastName;
        userInfo.avatarSrc                        = info.avatarSrc;
        userInfo.userID                           = @(info.userID);
        userInfo.isSubscribedOnEmailNotifications = @(info.isSubscribedOnEmailNotifications);
        userInfo.phoneNumber                      = info.phoneNumber;
        userInfo.extendPhoneNumber                = info.additionalPhoneNumber;
        
        [[AvatarHelper sharedInstance] loadAvatarFromWeb: userInfo.avatarSrc
                                                withName: [Utils getEmailPrefix: info.email]
                                          withCompletion: ^(BOOL isSuccess) {
                                              
                                              if ( completion )
                                                  completion(isSuccess);
                                              
                                          }];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

- (UserInfo*) getUserInfoWithEmail: (NSString*) email
{
    return [UserInfo MR_findFirstByAttribute: @"email"
                                   withValue: email];
}

- (NSArray*) getAllUserInfo
{
    return [UserInfo MR_findAll];
}

- (UserInfo*) getCurrentUserInfo
{
    return [UserInfo MR_findFirst];
}

- (NSNumber*) getCurrentUserID
{
    UserInfo* userInfo = [self getCurrentUserInfo];
    
    return userInfo.userID;
}

- (void) updateAvatarURLPathForCurrentUser: (NSString*)             path
                            withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        UserInfo* currentUser = [[self getCurrentUserInfo] MR_inContext: localContext];
        
        currentUser.photoImagePath = path;
        currentUser.avatarSrc      = path;
        
        [[AvatarHelper sharedInstance] loadAvatarFromWeb: path
                                                withName: [Utils getEmailPrefix: currentUser.email]
                                          withCompletion: ^(BOOL isSuccess) {
                                              
                                              if ( completion )
                                                  completion(isSuccess);
                                              
                                          }];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          
                      }];
}

- (void) updateUserInfo: (UpdatedUserInfo*)        newInfo
                forUser: (UserInfo*)               user
         withCompletion: (void(^)(BOOL isSuccess)) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        UserInfo* userInfo = [user MR_inContext: localContext];
        
        if (newInfo.name.length > 0 && newInfo.surname.length > 0)
        {
            userInfo.fullName          = [newInfo.name stringByAppendingFormat: @" %@", newInfo.surname];
            userInfo.firstName         = newInfo.name;
            userInfo.lastName          = newInfo.surname;
            
            if (newInfo.phoneNumber.length == 16 || newInfo.phoneNumber.length == 0)
                {
                    userInfo.phoneNumber  = newInfo.phoneNumber;
                }

            if (newInfo.additionalPhoneNumber.length == 16 || newInfo.additionalPhoneNumber.length == 0)
                {
                    userInfo.extendPhoneNumber  = newInfo.additionalPhoneNumber;
                }
            
        }
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

- (void) deleteCurrentUser: (UserInfo*) info
{
    [info MR_deleteEntity];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

@end
