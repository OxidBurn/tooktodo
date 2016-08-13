//
//  KeyChainManager.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

@import Foundation;

@interface KeyChainManager : NSObject

// properties


// methods

/*
 * Shared instance
 */
+ (KeyChainManager*) sharedInstance;

/**
 *  Store access token to the app keychain store
 *
 *  @param token string token value. Value stored by accessToken key
 */
- (void) storeAccessToken: (NSString*) token;

/**
 *  Check if exist token for current user
 *
 *  @return bool value if token is exist
 */
- (BOOL) isExistTokenForCurrentUser;

/**
 *  Store to keychain current user password
 *
 *  @param password string password value
 */
- (void) storeUserPassword: (NSString*) password;

/**
 *  Check if entered user password is equal with stored
 *
 *  @param password string value of the password which need to check with current
 *
 *  @return bool state if passwords is equals
 */
- (BOOL) isCorrectEnteredPassword: (NSString*) password;


@end
