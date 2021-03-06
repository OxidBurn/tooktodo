//
//  SelectStageModel.h
//  TookTODO
//
// Created by Nikolay Chaban on 30.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

//Classes
#import "ProjectTaskStage+CoreDataClass.h"

@interface SelectStageModel : NSObject

// Methods
- (NSInteger) countOfRows;

- (NSArray*) getStages;

- (void) handleCheckmarkForIndexPath: (NSIndexPath*) indexPath;

- (BOOL) getStateForStageAtIndex: (NSUInteger) index;

- (void) updateLastIndexPath: (NSIndexPath*) indexPath;

- (NSIndexPath*) getLastIndexPath;

- (ProjectTaskStage*) getSelectedStage;

- (void) fillSelectedStage: (ProjectTaskStage*) stage;

- (BOOL) isStageSelected: (ProjectTaskStage*) stage;

@end
