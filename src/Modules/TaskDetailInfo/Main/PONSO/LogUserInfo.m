//
//  LogUserInfo.m
//  TookTODO
//
//  Created by Nikolay Chaban on 12/23/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogUserInfo.h"

@implementation LogUserInfo


#pragma mark - Initialization -

- (instancetype) initWithName: (NSString*) userName
               withAvatarPath: (NSString*) avatarPath
{
    if ( self = [super init] )
    {
        self.userName  = userName;
        self.avatarSrc = avatarPath;
    }
    
    return self;
}

@end
