//
//  ProjectTaskObject.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

// Classes
#import "TaskMarkerModel.h"
#import "TaskOwnerModel.h"

@interface ProjectTaskModel : JSONModel

@property (strong, nonatomic) NSDate          * endDate;
@property (assign, nonatomic) BOOL            isIncludedRestDays;
@property (assign, nonatomic) NSUInteger      storageFilesCount;
@property (assign, nonatomic) NSUInteger      taskID;
@property (strong, nonatomic) TaskMarkerModel * marker;
@property (strong, nonatomic) NSString        * storageDirectoryId;
@property (strong, nonatomic) NSString        * statusDescription;
@property (strong, nonatomic) NSString        * taskTypeDescription;
@property (assign, nonatomic) NSUInteger      duration;
@property (strong, nonatomic) TaskOwnerModel  * ownerUser;

@end
