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

@property (nonatomic, copy) void(^showOnRevisionController)();

@property (nonatomic, copy) void(^returnToTaskDetailController)();

- (TaskStatusType) getCurrentStatusType;

- (UIImage*) getExpandedArrowMarkImage;

@end
