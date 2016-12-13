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

// methods
- (NSInteger) numberOfRows;

- (TaskStatusType) getCurrentStatus;

- (TaskStatusType) getStatusTypeForRow: (NSUInteger) row;

- (NSUInteger) returnOnComletionStatusIndex;

- (NSUInteger) returnCancelRequestStatusIndex;

- (NSArray*) getAvailableStatusActions;

- (void) updateTaskStatusWithNewStatus: (TaskStatusType)        status
                        withCompletion: (CompletionWithSuccess) completion;

- (UIImage*) getExpandedArrowMarkImage;

- (CGFloat) countTableViewHeight;

- (NSNumber*) getSelectedStatusAtIndex: (NSUInteger) index;

@end
