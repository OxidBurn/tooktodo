//
//  TaskSortedByProjectModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/17/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

// Classes
#import "TaskMarkerModel.h"
#import "TaskOwnerModel.h"
#import "TaskRoomLevelModel.h"
#import "TaskResponsibleModel.h"
#import "TaskRoomModel.h"
#import "TaskStageModel.h"
#import "TaskSubTasksModel.h"
#import "TaskRoleAssignmentsModel.h"
#import "TaskWorkAreaModel.h"
#import "TaskAttachmentsModel.h"

@protocol TaskSortedByProjectModel;

@interface TaskSortedByProjectModel : JSONModel

@property (strong, nonatomic) NSNumber<Optional> * access;
@property (strong, nonatomic) TaskAttachmentsModel<Optional>* attachments;
@property (strong, nonatomic) NSDate<Optional> * closedDate;
@property (strong, nonatomic) NSString<Optional> * taskDescription;
@property (strong, nonatomic) NSNumber<Optional> * duration;
@property (strong, nonatomic) NSDate<Optional> * endDate;
@property (strong, nonatomic) NSNumber<Optional> * extraId;
@property (strong, nonatomic) NSNumber<Optional> * taskID;
@property (strong, nonatomic) NSNumber<Optional> * isAllRooms;
@property (strong, nonatomic) NSString<Optional> * mapPreviewImage;
@property (strong, nonatomic) TaskMarkerModel<Optional> * marker;
@property (strong, nonatomic) TaskOwnerModel<Optional> * ownerUser;
@property (strong, nonatomic) NSNumber<Optional> * ownerUserId;
@property (strong, nonatomic) NSNumber<Optional> * parentTaskId;
@property (strong, nonatomic) NSNumber * projectId;
@property (strong, nonatomic) NSNumber<Optional> * projectRelatedId;
@property (strong, nonatomic) TaskResponsibleModel<Optional> * responsible;
@property (strong, nonatomic) TaskRoomLevelModel<Optional> * roomLevel;
@property (strong, nonatomic) TaskStageModel<Optional>* stage;
@property (strong, nonatomic) NSDate<Optional> * startDate;
@property (strong, nonatomic) NSNumber* status;
@property (strong, nonatomic) NSString* statusDescription;
@property (strong, nonatomic) NSString<Optional> * storageDirectoryId;
@property (strong, nonatomic) NSNumber<Optional> * storageFilesCount;
@property (strong, nonatomic) NSNumber<Optional> * taskAccess;
@property (strong, nonatomic) NSArray<TaskRoleAssignmentsModel, Optional> * taskRoleAssignments;
@property (strong, nonatomic) NSNumber<Optional> * taskType;
@property (strong, nonatomic) NSString<Optional> * taskTypeDescription;
@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSNumber<Optional>* commentsCount;
@property (strong, nonatomic) TaskWorkAreaModel<Optional> * workArea;

@property (strong, nonatomic) NSNumber* isIncludedRestDays;
@property (strong, nonatomic) NSNumber* isExpired;
@property (strong, nonatomic) NSNumber<Optional> * isTaskStatusChanged;
@property (strong, nonatomic) NSNumber* isUrgent;
@property (strong, nonatomic) NSArray<TaskRoomModel, Optional> * rooms;
@property (strong, nonatomic) TaskRoomModel<Optional>* room;

@property (strong, nonatomic) TaskSubTasksModel<Optional> * subTasks;

@end
