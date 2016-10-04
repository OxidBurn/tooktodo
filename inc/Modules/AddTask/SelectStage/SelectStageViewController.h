//
//  SelectStageViewController.h
//  TookTODO
//
// Created by Nikolay Chaban on 30.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

//Classes
#import "ProjectTaskStage+CoreDataClass.h"

@protocol SelectStageViewControllerDelegate;

@interface SelectStageViewController : UIViewController

// Properties
@property (nonatomic, weak) id<SelectStageViewControllerDelegate> delegate;

//Methods
- (void) fillSelectedStage: (ProjectTaskStage*) stage
              withDelegate: (id <SelectStageViewControllerDelegate>) delegate;

@end

@protocol SelectStageViewControllerDelegate <NSObject>

- (void) returnSelectedStage: (ProjectTaskStage*) stage;

@end
