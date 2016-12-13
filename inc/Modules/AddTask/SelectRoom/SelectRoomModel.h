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

@interface SelectRoomModel : NSObject

- (void) markLevelAsExpandedAtIndexPath: (NSInteger) section
                         withCompletion: (CompletionWithSuccess) completion;

- (RACSignal*) updateContent;

- (ProjectTaskRoomLevel*) getLevelForSection: (NSUInteger) section;

- (ProjectTaskRoom*) getInfoForCellAtIndexPath: (NSIndexPath*) path;

- (NSUInteger) sectionsCount;

- (NSUInteger) countOfRowsInSection: (NSUInteger) section;

- (void) handleCheckmarkForSection: (NSUInteger) section
                    withCompletion: (CompletionWithSuccess) completion;

- (void) handleCheckmarkForIndexPath: (NSIndexPath*) path
                      withCompletion: (CompletionWithSuccess) completion;

- (BOOL) isSelectedRoomAtIndexPath: (NSIndexPath*) indexPath;

- (void) resetAllWithCompletion: (CompletionWithSuccess) completion;

- (void) fillSelectedRoom: (id) selectedRoom;

- (ProjectTaskRoom*) getSelectedRoom;

- (ProjectTaskRoomLevel*) getSelectedLevel;

- (id) getSelectedInfo;


@end
