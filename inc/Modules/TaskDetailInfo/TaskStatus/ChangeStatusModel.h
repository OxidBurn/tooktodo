//
//  ChangeStatusModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectsEnumerations.h"

@interface ChangeStatusModel : NSObject

- (NSInteger) numberOfRows;

- (TaskStatusType) getCurrentStatus;

- (NSString*) getStatusNameForIndex: (NSUInteger) index;

- (UIColor*) getBackgroundColorForIndex: (NSUInteger) index;

- (UIImage*) getStatusImageForIndex: (NSUInteger) index;

- (NSUInteger) returnOnComletionStatusIndex;

- (NSArray*) getAvailableStatusActions;

- (void) updateTaskStatusWithNewStatus: (TaskStatusType) status;

@end
