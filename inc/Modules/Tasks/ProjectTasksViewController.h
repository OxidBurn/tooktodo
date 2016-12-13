//
//  ProjectTasksViewController.h
//  TookTODO
//
// Created by Nikolay Chaban on 28.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//


//Classes
#import "BaseMainViewController.h"
#import "TaskDetailViewController.h"

@interface ProjectTasksViewController : BaseMainViewController

@property (strong, nonatomic) TaskDetailViewController* taskDetailVC;

@end
