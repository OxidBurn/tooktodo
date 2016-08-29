//
//  RolesViewController.h
//  TookTODO
//
//  Created by Lera on 29.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RolesViewControllerDelegate; // делегат этого контроллера

@interface RolesViewController : UIViewController

- (void) setRolesViewControllerDelegate: (id<RolesViewControllerDelegate>) delegate;

@end

@protocol RolesViewControllerDelegate

- (void) didSelectRole: (NSString*) value; //устанавливает выбранную роль

@end