//
//  RoleInfoModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectRoles.h"

@interface RoleInfoModel : NSObject

- (NSUInteger) countOfRoleItems;

- (ProjectRoles*) getRoleInfoAtIndex: (NSUInteger) index;

@end
