//
//  RolesViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 29.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "ProjectRoles.h"

@protocol RolesViewControllerDelegate; // делегат этого контроллера

@interface RolesViewController : UIViewController

- (void) setRolesViewControllerDelegate: (id<RolesViewControllerDelegate>) delegate;

@end

@protocol RolesViewControllerDelegate

- (void) didSelectRole: (ProjectRoles*) value; //устанавливает выбранную роль

@end