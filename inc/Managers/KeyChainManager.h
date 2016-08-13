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


@end
