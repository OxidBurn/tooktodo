//
//  RoomLevelSectionView.h
//  TookTODO
//
//  Created by Lera on 04.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

//Classes
#import "ProjectTaskRoomLevel+CoreDataClass.h"


@interface RoomLevelSectionView : UIView

//Properties
@property (nonatomic, copy) void(^didChangeExpandState)(NSUInteger section);

@property (nonatomic, copy) void(^didChangeSelectedState)(NSUInteger section);

// Methods
- (void) fillInfo: (ProjectTaskRoomLevel*) level;

@end
