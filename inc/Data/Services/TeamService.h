//
//  TeamService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/3/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

// Classes
#import "InviteInfo.h"

@interface TeamService : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+ (TeamService*) sharedInstance;

- (RACSignal*) getTeamInfo;

- (RACSignal*) inviteUserWithInfo: (InviteInfo*) info;

@end
