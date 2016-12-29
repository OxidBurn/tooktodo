//
//  SelectedRoomsInfo.h
//  TookTODO
//
//  Created by Nikolay Chaban on 29.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SelectedRoomsType)
{
    LevelType = 1,
    RoomType  = 2,
};

@interface SelectedRoomsInfo : NSObject

// properties
@property (strong, nonatomic) NSNumber* idValue;

@property (assign, nonatomic) SelectedRoomsType roomsType;

@end
