//
//  TaskStatusDefaultValues.h
//  TookTODO
//
//  Created by Глеб on 13.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "ProjectsEnumerations.h"

@interface TaskStatusDefaultValues : NSObject

// methods
- (UIColor*) returnColorForTaskStatus: (TaskStatusType) statusType;

- (NSString*) returnTitleForTaskStatus: (TaskStatusType) statusType;

- (UIImage*) returnIconImageForTaskStatus: (TaskStatusType) statusType;

+ (instancetype) sharedInstance;

@end
