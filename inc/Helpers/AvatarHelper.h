//
//  AvatarManager.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

@import Foundation;

@interface AvatarHelper : NSObject

// properties


// methods

/*
 * Shared instance
 */
+ (AvatarHelper*) sharedInstance;

/**
 *  Generate avatar for full user name and return avatar image path
 *
 *  @param name full user name
 *
 *  @return path to the avatar image
 */
- (NSString*) generateAvatarForName: (NSString*) name;

@end
