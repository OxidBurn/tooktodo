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

- (void) fillSelectedTaskType: (TaskType)                type
                 withDelegate: (id<AddTaskTypeDelegate>) delegate;

@end

@protocol AddTaskTypeDelegate <NSObject>

// methods

- (void) didSelectedTaskType: (TaskType)  type
             withDescription: (NSString*) typeDescription
                   withColor: (UIColor*)  typeColor;

@end
