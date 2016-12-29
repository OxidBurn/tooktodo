//
//  LevelContent.h
//  TookTODO
//
//  Created by Nikolay Chaban on 29.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classed
#import "ProjectTaskRoomLevel+CoreDataClass.h"

@interface LevelContent : NSObject

// properties
@property (strong, nonatomic) NSArray* rooms;

@property (assign, nonatomic) BOOL isSelected;

@property (assign, nonatomic) BOOL isExpanded;

@property (strong, nonatomic) NSNumber* levelNumber;

@property (strong, nonatomic) NSNumber* levelId;

@property (strong, nonatomic) NSNumber* numberOfRowsInContent;

// methods
- (void) fillLevelContent: (ProjectTaskRoomLevel*) roomLevel;

- (void) handleSectionSelection;

@end
