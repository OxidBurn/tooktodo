//
//  ChangeStatusViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectsEnumerations.h"

@interface ChangeStatusViewModel : NSObject <UITableViewDataSource, UITableViewDelegate>

typedef void (^GetChangedStatusBlock)(NSString* statusName, TaskStatusType statusType, UIColor* background, UIImage* statusImage);

@property (nonatomic, copy) void(^dismissController)();

- (void) getChangedInfo: (GetChangedStatusBlock) completion;

- (void) fillSelectedStatusType: (TaskStatusType) status;

- (TaskStatusType) getCurrentStatusType;

@end
