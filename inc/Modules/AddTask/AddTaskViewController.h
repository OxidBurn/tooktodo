//
//  AddTaskViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 12.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProjectTaskStage+CoreDataClass.h"

@interface AddTaskViewController : UIViewController

- (void) fillDefaultStage: (ProjectTaskStage*) stage
           andHiddenState: (BOOL)              isHidden;

@end
