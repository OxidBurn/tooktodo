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
#import "TaskRoomLavelModel.h"
#import "TaskResponsibleModel.h"
#import "TaskRoomModel.h"
#import "TaskStageModel.h"
#import "TaskSubTasksModel.h"
#import "TaskRoleAssignmentsModel.h"
#import "TaskWorkAreaModel.h"

@interface ProjectTaskModel : JSONModel

@property (strong, nonatomic) NSDate         * endDate;
@property (assign, nonatomic) BOOL           isIncludedRestDays;
@property (assign, nonatomic) NSUInteger     storageFilesCount;
@property (assign, nonatomic) NSUInteger     taskID;
@property (strong, nonatomic) TaskMarkerModel<Optional> * marker;
@property (strong, nonatomic) NSString       * storageDirectoryId;
@property (strong, nonatomic) NSString       * statusDescription;
@property (strong, nonatomic) NSString       * taskTypeDescription;
@property (assign, nonatomic) NSUInteger     duration;
@property (strong, nonatomic) TaskOwnerModel * ownerUser;

@property (strong, nonatomic) NSDate<Optional>*   closedDate;
@property (strong, nonatomic) NSString<Optional>* description;
@property (assign, nonatomic) NSUInteger          extraId;
@property (assign, nonatomic) NSUInteger          id;
@property (assign, nonatomic) BOOL                isAllRooms;
@property (assign, nonatomic) BOOL                isExpired;
@property (assign, nonatomic) BOOL                isTaskStatusChanged;
@property (assign, nonatomic) BOOL                isUrgent;
@property (strong, nonatomic) NSString*           mapPreviewImage;
@property (assign, nonatomic) NSUInteger          ownerUserId;
@property (assign, nonatomic) NSUInteger          parentTaskId;
@property (assign, nonatomic) NSUInteger          projectId;
@property (assign, nonatomic) NSUInteger          projectRelatedId;
@property (strong, nonatomic) TaskRoomLavelModel<Optional>* roomLevel;
@property (assign, nonatomic) NSUInteger          status;
@property (assign, nonatomic) NSUInteger          taskAccess;
@property (assign, nonatomic) NSUInteger          taskType;
@property (strong, nonatomic) NSString*           title;
@property (strong, nonatomic) TaskResponsibleModel              * responsible;
@property (strong, nonatomic) NSArray<TaskRoomModel *>            * rooms;
@property (strong, nonatomic) TaskStageModel                    * stage;
@property (strong, nonatomic) NSArray<TaskSubTasksModel *>        * subTasks;
@property (strong, nonatomic) NSArray<TaskRoleAssignmentsModel *> * taskRoleAssignments;
@property (strong, nonatomic) TaskWorkAreaModel                 * workArea;




@end
