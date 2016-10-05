//
//  StageTitleView.h
//  TookTODO
//
// Created by Nikolay Chaban on 28.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectTaskStage+CoreDataClass.h"

@interface StageTitleView : UIView

// properties

@property (nonatomic, copy) void(^didChangeExpandState)(NSUInteger section);

// methods

- (void) fillInfo: (ProjectTaskStage*) info;

@end
