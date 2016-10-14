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

- (NSString*) getStatusName: (TaskStatusType) statusType;

- (UIColor*) getBackgroundColor: (TaskStatusType) statusType;

- (UIImage*) getStatusImage: (TaskStatusType) statusType;

//- (void) fillCurrentStatus: (TaskStatusType) status;

- (TaskStatusType) getCurrentStatus;

@end
