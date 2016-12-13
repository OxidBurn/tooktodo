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

// methods

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
        
    }
    
    return self;
}


#pragma mark - Public methods -

- (void) storeAccessToken: (NSString*) token
{
    [UserDefaults setValue: token
                    forKey: accessToken];
    
    [UserDefaults synchronize];
}

- (BOOL) isExistTokenForCurrentUser
{
    return ([self getAccessToken] != nil);
}

- (NSString*) getAccessToken
{
    NSString* token = [UserDefaults valueForKey: accessToken];
    
    return token;
}

- (void) deleteToken
{
    [UserDefaults removeObjectForKey: accessToken];
    [UserDefaults removeObjectForKey: @"UserNotificationSettingsKey"];
    [UserDefaults removeObjectForKey: passwordKey];
    
    [UserDefaults synchronize];
}

- (void) storeUserEmail: (NSString*) email
            andPassword: (NSString*) password
{
    if ( email.length > 0 )
    {
        [UserDefaults setValue: email
                        forKey: emailKey];
    }
    [UserDefaults setValue: password
                    forKey: passwordKey];
    
    [UserDefaults synchronize];
}

- (BOOL) isCorrectEnteredPassword: (NSString*) password
{
    BOOL isEqual = ([[UserDefaults valueForKey: passwordKey] isEqualToString: password]);
    
    return isEqual;
}

- (NSString*) getUserEmail
{
    return [UserDefaults valueForKey: emailKey];
}

@end
