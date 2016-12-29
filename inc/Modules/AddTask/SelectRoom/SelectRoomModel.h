//
//  SelectRoomModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//


//Frameworks
#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

//Classes
#import "ProjectTaskStage+CoreDataClass.h"
#import "ProjectTaskRoomLevel+CoreDataClass.h"


// refactor classes
#import "LevelContent.h"
#import "RoomContent.h"
#import "SelectedRoomsInfo.h"

@interface SelectRoomModel : NSObject

// Methods

    // getters
- (SelectedRoomsInfo*) getSelectedInfo;

- (LevelContent*) getLevelContentForSection: (NSUInteger) section;

- (RoomContent*) getRoomContentForIndexPath: (NSIndexPath*) indexPath;

- (NSUInteger) getNumberOfRowsInSection: (NSUInteger) section;

- (NSUInteger) getNumberOfSections;

    // updaters
- (void) markLevelAsExpandedAtIndexPath: (NSInteger)             section
                         withCompletion: (CompletionWithSuccess) completion;

- (void) handleCheckmarkForSection: (NSUInteger)            section
                    withCompletion: (CompletionWithSuccess) completion;

- (void) handleCheckmarkForIndexPath: (NSIndexPath*)          path
                      withCompletion: (CompletionWithSuccess) completion;

- (void) resetAllWithCompletion: (CompletionWithSuccess) completion;

- (void) fillSelectedRoomsInfo: (SelectedRoomsInfo*) selectedRooms;

@end
