//
//  RoomContent.m
//  TookTODO
//
//  Created by Nikolay Chaban on 29.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RoomContent.h"

@implementation RoomContent


#pragma mark - Public -

- (void) fillRoomWithInfo: (ProjectTaskRoom*) roomInfo
{
    self.roomId    = roomInfo.roomID;
    self.roomTitle = roomInfo.title;
    
    self.isSelected = roomInfo.isSelected;
}

@end
