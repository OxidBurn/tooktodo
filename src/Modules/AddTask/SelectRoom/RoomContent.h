//
//  RoomContent.h
//  TookTODO
//
//  Created by Nikolay Chaban on 29.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "ProjectTaskRoom+CoreDataClass.h"

@interface RoomContent : NSObject

// properties
@property (strong, nonatomic) NSString* roomTitle;

@property (assign, nonatomic) BOOL isSelected;

@property (strong, nonatomic) NSNumber* roomId;

// methods
- (void) fillRoomWithInfo: (ProjectTaskRoom*) roomInfo;

@end
