//
//  ChangeStatusViewModel.h
//  TookTODO
//
//  Created by Lera on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectsEnumerations.h"

@interface ChangeStatusViewModel : NSObject <UITableViewDataSource, UITableViewDelegate>

typedef void (^GetChangedStatusBlock)(NSString* statusName, TaskStatusType statusType, UIColor* background, UIImage* statusImage);

- (void) getChangedInfo: (GetChangedStatusBlock) completion;

- (void) fillSelectedStatusType: (TaskStatusType) status;

@end
