//
//  LogUserInfo.h
//  TookTODO
//
//  Created by Nikolay Chaban on 12/23/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogUserInfo : NSObject

@property (strong, nonatomic) NSString* avatarSrc;

@property (strong, nonatomic) NSString* userName;

- (instancetype) initWithName: (NSString*) userName
                   andSurName: (NSString*) surname
               withAvatarPath: (NSString*) avatarPath;

@end
