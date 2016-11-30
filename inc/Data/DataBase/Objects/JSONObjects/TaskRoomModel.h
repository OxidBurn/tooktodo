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
@property (strong, nonatomic) NSNumber* number;
@property (strong, nonatomic) NSString<Optional>* title;
@property (strong, nonatomic) TaskMapContourModel<Optional>* mapContour;
@property (strong, nonatomic) NSNumber<Optional>* roomLevelId;
@property (strong, nonatomic) NSNumber<Optional>* tasksCount;
@property (strong, nonatomic) NSNumber<Optional>* tasksWithoutMarkers;

@end
