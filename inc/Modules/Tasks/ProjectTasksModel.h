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
#import "ProjectsEnumerations.h"

@interface ProjectTasksModel : NSObject

- (RACSignal*) updateContent;

- (NSUInteger) countOfRowsInSection: (NSUInteger) section;

- (void) markStageAsExpandedAtIndexPath: (NSInteger)             indexPath
                         withCompletion: (CompletionWithSuccess) completion;

- (id) getInfoForCellAtIndexPath: (NSIndexPath*) path;

- (NSUInteger) countOfSections;

- (ProjectTaskStage*) getStageForSection: (NSUInteger) section;

- (void) markTaskAsSelected: (NSIndexPath*) index;

- (NSArray*) getPopoverContent;

- (ContentAccedingSortingType) getTasksSortingAscendingType;

- (TasksSortingType) getTasksSortingType;


- (NSArray*) applyTasksSortingType: (TasksSortingType)           type
                           toArray: (NSArray*)                   array
                        isAcceding: (ContentAccedingSortingType) isAcceding;

- (ProjectTask*) getSelectedProjectTask;


@end
