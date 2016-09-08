//
//  ProjectsControllersDelegate.h
//  TookTODO
//
//  Created by Nikolay Chaban on 17.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProjectsControllersDelegate <NSObject>

- (void) showMainMenu;

- (void) showLogin;

- (void) dismissTopController: (UIViewController*) controller;

- (void) showWelcomeTour;

- (void) showControllerWithSegueID: (NSString*) segueID;

- (void) showFeedsForSelectedProject;

@end
