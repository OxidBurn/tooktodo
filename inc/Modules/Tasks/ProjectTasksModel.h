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

typedef NS_ENUM(NSUInteger, SearchTableState)
{
    TableNormalState = 0,
    TableSearchState = 1,
};

@interface ProjectTasksModel : NSObject

- (RACSignal*) updateContent;

- (RACSignal*) applyFilters;

- (NSUInteger) countOfRowsInSection: (NSUInteger) section;

- (NSArray*) rowsContentForSection: (NSUInteger) section;

- (void) markStageAsExpandedAtIndexPath: (NSInteger)             indexPath
                         withCompletion: (CompletionWithSuccess) completion;

- (id) getInfoForCellAtIndexPath: (NSIndexPath*) path;

- (NSUInteger) countOfSections;

- (ProjectTaskStage*) getStageForSection: (NSUInteger) section;

- (void) markTaskAsSelected: (NSIndexPath*)          index
             withCompletion: (CompletionWithSuccess) completion;

- (ProjectTask*) getSelectedProjectTask;

- (void) sortArrayForType: (TasksSortingType)           type
               isAcceding: (ContentAccedingSortingType) isAcceding;

- (void) updateTaskStatusForIndexPath: (NSIndexPath*) path;

- (void) setTableSearchState: (SearchTableState) state;

- (void) applyFilteringByText: (NSString*) text;

- (SearchTableState) getSearchTableState;

@end
