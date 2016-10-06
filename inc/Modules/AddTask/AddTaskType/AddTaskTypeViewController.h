//
//  SelectTaskTypeViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10/7/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "ProjectsEnumerations.h"

@protocol AddTaskTypeDelegate;

@interface AddTaskTypeViewController : UIViewController

// properties

@property (weak, nonatomic) id<AddTaskTypeDelegate> delegate;

// methods

@end

@protocol AddTaskTypeDelegate <NSObject>

// methods


- (void) didSelectedTaskType: (TaskType)  type
             withDescription: (NSString*) typeDescription;

@end
