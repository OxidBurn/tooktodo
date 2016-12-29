//
//  RoomLevelSectionView.h
//  TookTODO
//
//  Created by Nikolay Chaban on 04.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

//Classes
#import "ProjectTaskRoomLevel+CoreDataClass.h"
#import "LevelContent.h"


@interface RoomLevelSectionView : UIView

//Properties
@property (nonatomic, copy) void(^didChangeExpandState)(NSUInteger section);

@property (nonatomic, copy) void(^didChangeSelectedState)(NSUInteger section);

// Methods
- (void) fillInfo: (ProjectTaskRoomLevel*) level;

// refactor
- (void) fillHeaderViewWithContent: (LevelContent*) levelContent;

@end
