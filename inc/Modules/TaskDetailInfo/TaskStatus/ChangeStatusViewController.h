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

//Properties

@property (nonatomic, weak) id<ChangeStatusControllerDelegate> delegate;

//Methods

- (void) fillSelectedStatus: (TaskStatusType) status
               withDelegate: (id<ChangeStatusControllerDelegate>) delegate;

- (void) getChangedTaskStatusInfo;

@end

@protocol ChangeStatusControllerDelegate <NSObject>

@optional

- (void) performSegueWithID: (NSString*) segueID;

- (void) didChangedTaskStatus: (TaskStatusType) statustType
                     withName: (NSString*)      statusName
                    withImage: (UIImage*)       statusImage
          withBackGroundColor: (UIColor*)       background;


@end
