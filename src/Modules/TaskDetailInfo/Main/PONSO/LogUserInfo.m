//
//  LogUserInfo.m
//  TookTODO
//
//  Created by Nikolay Chaban on 12/23/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogUserInfo.h"
#import "APIConstance.h"

@implementation LogUserInfo


#pragma mark - Initialization -

- (instancetype) initWithName: (NSString*) name
                   andSurName: (NSString*) surname
               withAvatarPath: (NSString*) avatarPath
{
    if ( self = [super init] )
    {
        self.userName  = [[name substringToIndex: 1] stringByAppendingFormat: @". %@", surname];
        
        if ( [avatarPath containsString: @"http"] )
        {
            self.avatarSrc = avatarPath;
        }
        else
        {
            self.avatarSrc = [serverURL stringByAppendingString: avatarPath];
        }
    }
    
    return self;
}

@end
