//
//  TaskRoomLavelModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

// Classes
#import "RoomLevelMapModel.h"
#import "TaskRoomModel.h"

@interface TaskRoomLevelModel : JSONModel

@property (assign, nonatomic) NSUInteger roomLevelID;
@property (assign, nonatomic) NSUInteger level;
@property (strong, nonatomic) NSArray<TaskRoomModel>* rooms;
@property (strong, nonatomic) RoomLevelMapModel<Optional>* map;

@end
