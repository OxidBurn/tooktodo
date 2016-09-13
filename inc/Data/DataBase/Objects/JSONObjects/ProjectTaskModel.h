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
#import "TaskRoomLevelModel.h"
#import "TaskResponsibleModel.h"
#import "TaskRoomModel.h"
#import "TaskStageModel.h"
#import "TaskSubTasksModel.h"
#import "TaskRoleAssignmentsModel.h"
#import "TaskWorkAreaModel.h"

@protocol ProjectTaskModel;

@interface ProjectTaskModel : JSONModel

@property (strong, nonatomic) NSDate<Optional>     * endDate;
@property (assign, nonatomic) BOOL       isIncludedRestDays;
@property (strong, nonatomic) NSNumber<Optional>* storageFilesCount;
@property (assign, nonatomic) NSUInteger taskID;
@property (strong, nonatomic) NSString<Optional>   * storageDirectoryId;
@property (strong, nonatomic) NSString   * statusDescription;
@property (strong, nonatomic) NSString<Optional>   * taskTypeDescription;
@property (strong, nonatomic) NSNumber<Optional>* duration;
@property (strong, nonatomic) NSNumber<Optional>* extraId;
@property (strong, nonatomic) NSNumber<Optional>*       isAllRooms;
@property (assign, nonatomic) BOOL       isExpired;
@property (strong, nonatomic) NSNumber<Optional>*       isTaskStatusChanged;
@property (assign, nonatomic) BOOL       isUrgent;
@property (strong, nonatomic) NSString<Optional>   * mapPreviewImage;
@property (strong, nonatomic) NSNumber<Optional>* ownerUserId;
@property (strong, nonatomic) NSNumber<Optional>* parentTaskId;
@property (assign, nonatomic) NSUInteger projectId;
@property (strong, nonatomic) NSNumber<Optional>* projectRelatedId;
@property (assign, nonatomic) NSUInteger status;
@property (strong, nonatomic) NSNumber<Optional>* taskAccess;
@property (strong, nonatomic) NSNumber<Optional>* taskType;
@property (strong, nonatomic) NSString   * title;
@property (strong, nonatomic) NSDate<Optional>   * closedDate;
@property (strong, nonatomic) NSString<Optional> * taskDescription;

@property (strong, nonatomic) TaskResponsibleModel<Optional> * responsible;
@property (strong, nonatomic) TaskStageModel       * stage;
@property (strong, nonatomic) TaskWorkAreaModel<Optional> * workArea;
@property (strong, nonatomic) TaskOwnerModel<Optional> * ownerUser;
@property (strong, nonatomic) TaskMarkerModel<Optional> * marker;
@property (strong, nonatomic) TaskRoomLevelModel<Optional> * roomLevel;
@property (strong, nonatomic) TaskSubTasksModel<Optional> * subTasks;

@property (strong, nonatomic) NSArray<TaskRoomModel, Optional>  * rooms;
@property (strong, nonatomic) NSArray<TaskRoleAssignmentsModel, Optional> * taskRoleAssignments;



@end
