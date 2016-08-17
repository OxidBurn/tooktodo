//
//  ProjectsControllersDelegate.h
//  TookTODO
//
//  Created by Глеб on 17.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProjectsControllersDelegate <NSObject>

- (void) showMainMenu;

- (void) dismissTopController: (UIViewController*) controller;

- (void) showWelcomeTour;

- (void) showControllerWithSegueID: (NSString*) segueID;

@end
