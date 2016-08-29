//
//  KeyChainManager.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "UICKeyChainStore.h"

// Classes
#import "KeyChainManager.h"
#import "ConstanceKeys.h"

static dispatch_once_t onceToken;
static KeyChainManager* sharedInstance = nil;

@interface KeyChainManager()

// properties

@property (strong, nonatomic) UICKeyChainStore* keyChainStore;

// methods

/**
 *  Setup defaults
 */
- (void) setupDefaults;

@end

@implementation KeyChainManager


#pragma mark - Shared -

+ (KeyChainManager*) sharedInstance
{
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


#pragma mark - Initialization -

- (id) init
{
    if ( self = [super init] )
    {
        [self setupDefaults];
    }
    
    return self;
}


#pragma mark - Defautls -

- (void) setupDefaults
{
    // Setup keychain store for current application
    // Specific key: app site url
    self.keyChainStore = [UICKeyChainStore keyChainStoreWithService: keychainServiceKey];
}


#pragma mark - Public methods -

- (void) storeAccessToken: (NSString*) token
{
    self.keyChainStore[accessToken] = token;
}

- (BOOL) isExistTokenForCurrentUser
{
    return ([self getAccessToken] != nil);
}

- (NSString*) getAccessToken
{
    return self.keyChainStore[accessToken];
}

- (void) deleteToken
{
    [self.keyChainStore removeItemForKey: accessToken];
}

- (void) storeUserPassword: (NSString*) password
{
    self.keyChainStore[passwordKey] = password;
}

- (BOOL) isCorrectEnteredPassword: (NSString*) password
{
    BOOL isEqual = ([self.keyChainStore[passwordKey] isEqualToString: password]);
    
    return isEqual;
}

@end
