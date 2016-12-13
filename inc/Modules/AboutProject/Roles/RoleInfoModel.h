//
//  RoleInfoModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectRoles.h"

// Frameworks
#import "ReactiveCocoa.h"

@interface RoleInfoModel : NSObject

// properties


// methods

- (RACSignal*) updateInfo;

- (NSUInteger) countOfRoleItems;

- (ProjectRoles*) getRoleInfoAtIndex: (NSUInteger) index;

@end
