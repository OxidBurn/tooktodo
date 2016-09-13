//
//  TaskRoomsModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "TaskMapContourModel.h"

@protocol TaskRoomModel;

@interface TaskRoomModel : JSONModel

@property (assign, nonatomic) NSUInteger roomID;
@property (strong, nonatomic) TaskMapContourModel* mapContour;
@property (assign, nonatomic) NSUInteger number;
@property (assign, nonatomic) NSUInteger roomLevelId;
@property (assign, nonatomic) NSUInteger tasksCount;
@property (assign, nonatomic) NSUInteger tasksWithoutMarkers;
@property (strong, nonatomic) NSString* title;

@end
