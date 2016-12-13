//
//  RolesModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 02.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

//Classes
#import "InviteInfo.h"
#import "RolesService.h"
#import "ProjectRoles+CoreDataProperties.h"

@interface RolesModel : NSObject

- (RACSignal*) updateRolesInfo;

- (NSUInteger) countOfRows;

- (NSString*) getRoleNameByIndex: (NSIndexPath*) indexPath;

- (BOOL) handleSelectedStateForRole: (NSIndexPath*) indexPath;

- (void) updateLastIndexPath: (NSIndexPath*) indexPath;

- (ProjectRoles*) getSelectedItem;

- (void) fillSelectedRole: (NSString*) role;

- (void) updateSelectedRole;

@end
