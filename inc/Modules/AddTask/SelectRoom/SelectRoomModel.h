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

- (id) getInfoForCellAtIndexPath: (NSIndexPath*) path;

- (NSUInteger) sectionsCount;

- (NSUInteger) countOfRowsInSection: (NSUInteger) section;

@end
