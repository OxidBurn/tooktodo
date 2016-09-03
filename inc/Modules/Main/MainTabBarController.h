//
//  MainTabBarController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/12/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

@import UIKit;

#import "ProjectsControllersDelegate.h"
#import "BaseMainViewController.h"

@interface MainTabBarController : BaseMainViewController <ProjectsControllersDelegate>

// properties

@property (strong, nonatomic) UIViewController* containerController;

@property (weak, nonatomic) IBOutlet UIView* containerView;

// methods


@end
