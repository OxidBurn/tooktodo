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

@interface ProjectTaskModel : JSONModel

@property (strong, nonatomic) NSDate     * endDate;
@property (assign, nonatomic) BOOL       isIncludedRestDays;
@property (assign, nonatomic) NSUInteger storageFilesCount;
@property (assign, nonatomic) NSUInteger taskID;
@property (strong, nonatomic) NSString   * storageDirectoryId;
@property (strong, nonatomic) NSString   * statusDescription;
@property (strong, nonatomic) NSString   * taskTypeDescription;
@property (assign, nonatomic) NSUInteger duration;
@property (assign, nonatomic) NSUInteger extraId;
@property (assign, nonatomic) BOOL       isAllRooms;
@property (assign, nonatomic) BOOL       isExpired;
@property (assign, nonatomic) BOOL       isTaskStatusChanged;
@property (assign, nonatomic) BOOL       isUrgent;
@property (strong, nonatomic) NSString   * mapPreviewImage;
@property (assign, nonatomic) NSUInteger ownerUserId;
@property (assign, nonatomic) NSUInteger parentTaskId;
@property (assign, nonatomic) NSUInteger projectId;
@property (assign, nonatomic) NSUInteger projectRelatedId;
@property (assign, nonatomic) NSUInteger status;
@property (assign, nonatomic) NSUInteger taskAccess;
@property (assign, nonatomic) NSUInteger taskType;
@property (strong, nonatomic) NSString   * title;
@property (strong, nonatomic) NSDate<  Optional> *   closedDate;
@property (strong, nonatomic) NSString<Optional> * taskDescription;

@property (strong, nonatomic) TaskResponsibleModel * responsible;
@property (strong, nonatomic) TaskStageModel       * stage;
@property (strong, nonatomic) TaskWorkAreaModel    * workArea;
@property (strong, nonatomic) TaskOwnerModel       * ownerUser;
@property (strong, nonatomic) TaskMarkerModel<Optional> * marker;
@property (strong, nonatomic) TaskRoomLevelModel<Optional> * roomLevel;

@property (strong, nonatomic) NSArray<TaskRoomModel *>            * rooms;
@property (strong, nonatomic) NSArray<TaskSubTasksModel *>        * subTasks;
@property (strong, nonatomic) NSArray<TaskRoleAssignmentsModel *> * taskRoleAssignments;



@end
