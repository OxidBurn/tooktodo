//
//  KeyChainManager.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "KeyChainManager.h"
#import "ConstanceKeys.h"

static dispatch_once_t onceToken;
static KeyChainManager* sharedInstance = nil;

@interface KeyChainManager()

// properties


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
    
}

@end
