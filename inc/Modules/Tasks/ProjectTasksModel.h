//
//  ProjectTasksModel.h
//  TookTODO
//
// Created by Nikolay Chaban on 28.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

#import "ProjectTaskStage+CoreDataClass.h"

@interface ProjectTasksModel : NSObject

- (RACSignal*) updateContent;

- (NSUInteger) countOfRowsInSection: (NSUInteger) section;

- (CGFloat) getCellHeightAtIndexPath: (NSIndexPath*) path;

- (void) markStageAsExpandedAtIndexPath: (NSInteger)             indexPath
                         withCompletion: (CompletionWithSuccess) completion;

- (NSString*) getCellIDAtIndexPath: (NSIndexPath*) path;

- (id) getInfoForCellAtIndexPath: (NSIndexPath*) path;

- (NSUInteger) countOfSections;

- (ProjectTaskStage*) getStageForSection: (NSUInteger) section;

- (void) markTaskAsSelected: (NSIndexPath*) index;

@end
