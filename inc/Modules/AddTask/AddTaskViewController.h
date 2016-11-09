//
//  AddTaskViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 12.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProjectTaskStage+CoreDataClass.h"
#import "ProjectsEnumerations.h"

@interface AddTaskViewController : UIViewController

// methods
- (void) fillDefaultStage: (ProjectTaskStage*) stage
           andHiddenState: (BOOL)              isHidden;

- (void) fillControllerType: (TaskControllerType) controllerType;

@end

