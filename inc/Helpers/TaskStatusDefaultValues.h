//
//  TaskStatusDefaultValues.h
//  TookTODO
//
//  Created by Nikolay Chaban on 13.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "ProjectsEnumerations.h"

@interface TaskStatusDefaultValues : NSObject

// methods
+ (instancetype) sharedInstance;

- (UIColor*) returnColorForTaskStatus: (TaskStatusType) statusType;

- (NSString*) returnTitleForTaskStatus: (TaskStatusType) statusType;

- (UIImage*) returnIconImageForTaskStatus: (TaskStatusType) statusType;

- (UIColor*) returnFontForTaskStatus: (TaskStatusType) statusType;

- (UIImage*) returnArrowImageForTaskStatus: (TaskStatusType) statusType;

@end
