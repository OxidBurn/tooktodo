//
//  RoomLevelSectionView.h
//  TookTODO
//
//  Created by Lera on 04.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

//Classes
#import "ProjectTaskStage+CoreDataClass.h"

@interface RoomLevelSectionView : UIView

//Properties
@property (nonatomic, copy) void(^didChangeExpandState)(NSUInteger section);

// Methods
- (void) fillInfo: (ProjectTaskStage*) level;

@end
