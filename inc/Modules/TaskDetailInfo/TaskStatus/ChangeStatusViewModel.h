//
//  ChangeStatusViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "ProjectsEnumerations.h"

@interface ChangeStatusViewModel : NSObject <UITableViewDataSource, UITableViewDelegate>

// properties
@property (nonatomic, copy) void(^showOnRevisionController)();

@property (nonatomic, copy) void(^returnToTaskDetailController)();

@property (nonatomic, copy) void(^showCancelRequestController)();

// methods
- (TaskStatusType) getCurrentStatusType;

- (UIImage*) getExpandedArrowMarkImage;

- (CGFloat) countTableViewHeight;

@end
