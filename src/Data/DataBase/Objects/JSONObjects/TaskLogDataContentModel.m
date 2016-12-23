//
//  TaskLogDataContentModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/23/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskLogDataContentModel.h"

@implementation TaskLogDataContentModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"newStartDate"   : @"startDateNew",
                                                        @"newEndDate"     : @"endDateNew",
                                                        @"newStatus"      : @"statusNew",
                                                        @"newDescription" : @"descriptionNew",
                                                        @"newValue"       : @"valueNew",
                                                        @"newWorkArea"    : @"WorkAreaNew",
                                                        @"newTitle"       : @"titleNew",
                                                        @"newStageId"     : @"stageIdNew",
                                                        @"newRoomId"      : @"roomIdNew",
                                                        @"newIsAllRooms"  : @"isAllRoomsNew",
                                                        @"newValue"       : @"valueNew"}];
}

@end
