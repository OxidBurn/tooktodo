//
//  ChangeStatusViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectsEnumerations.h"

@protocol ChangeStatusControllerDelegate;

@interface ChangeStatusViewController : UIViewController

// properties

@property (nonatomic, weak) id <ChangeStatusControllerDelegate> delegate;

@end

@protocol ChangeStatusControllerDelegate <NSObject>

@optional

- (void) performSegueWithID: (NSString*) segueID;

- (void) updataTaskDetailInfoTaskStatus;

@end
