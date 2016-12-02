//
//  ProjectTasksModel.m
//  TookTODO
//
// Created by Nikolay Chaban on 28.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectTasksModel.h"

// Classes
#import "ProjectTaskStage+CoreDataClass.h"
#import "TasksService.h"
#import "ConfigurationManager.h"
#import "ProjectTaskResponsible+CoreDataClass.h"

// Categories
#import "DataManager+ProjectInfo.h"
#import "DataManager+Tasks.h"
#import "NSObject+Sorting.h"
#import "DataManager+Filters.h"

static NSString* stageKey   = @"stageInfoKey";
static NSString* contentKey = @"contentInfoKey";

@interface ProjectTasksModel()

// properties

@property (nonatomic, strong) ProjectInfo* currentProjectInfo;

@property (nonatomic, strong) NSArray* stages;

@property (strong, nonatomic) ProjectTask* selectedTask;

@property (assign, nonatomic) SearchTableState tableState;

@property (strong, nonatomic) NSPredicate* searchFilteredPredicate;

@property (assign, nonatomic) TasksSortingType sortType;

@property (assign, nonatomic) BOOL isSortingAcceding;

@property (nonatomic, assign) NSUInteger countOfFoundTasks;
// methods


@end

@implementation ProjectTasksModel


#pragma mark - Public methods -

- (ProjectTask*) getSelectedProjectTask
{
    return self.selectedTask;
}

- (RACSignal*) updateContent
{
    RACSignal* updateInfoSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [self updateAllTasksData];
        
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    return updateInfoSignal;
}

- (RACSignal*) applyFilters
{
    return nil;
}

- (void) sortArrayForType: (TasksSortingType)           type
               isAcceding: (ContentAccedingSortingType) isAcceding
{
    self.sortType          = type;
    self.isSortingAcceding = isAcceding;
}

- (NSUInteger) countOfSections
{
    return self.currentProjectInfo.stage.count;
}

- (NSUInteger) countOfRowsInSection: (NSUInteger) section
{
    NSArray* rowsInfoCount = [self rowsContentForSection: section];
    
    return rowsInfoCount.count;
}

- (NSArray*) rowsContentForSection: (NSUInteger) section
{
    ProjectTaskStage* stage = [self getStageForSection: section];
    
    if ( stage.isExpanded.boolValue )
    {
        NSArray* rowsContent = stage.tasks.array;
        
        if ( self.searchFilteredPredicate )
            rowsContent = [rowsContent filteredArrayUsingPredicate: self.searchFilteredPredicate];
        
        // Apply sorting
        rowsContent = [rowsContent applyTasksSortingType: self.sortType
                                                 toArray: rowsContent
                                              isAcceding: self.isSortingAcceding];
        
        // Apply filters
        rowsContent = [DataManagerShared applyFiltersToTasks: rowsContent];
        
        self.countOfFoundTasks = rowsContent.count;
        
        return rowsContent;
    }
    else
    {
        return 0;
    }
}

- (ProjectTaskStage*) getStageForSection: (NSUInteger) section
{
    return [self.currentProjectInfo.stage objectAtIndex: section];
}

- (void) markStageAsExpandedAtIndexPath: (NSInteger)             section
                         withCompletion: (CompletionWithSuccess) completion
{
    ProjectTaskStage* stage = (ProjectTaskStage*)self.currentProjectInfo.stage.array[section];
    
    __weak typeof(self) blockSelf = self;
    
    [DataManagerShared updateExpandedStateOfStage: stage
                                   withCompletion: ^(BOOL isSuccess) {
                                       
                                       [blockSelf updateAllTasksData];
                                       
                                       if ( completion )
                                           completion(YES);
                                       
                                   }];
}

- (ProjectTask*) getInfoForCellAtIndexPath: (NSIndexPath*) path
{
    ProjectTask* cellsContentInfo = [[self rowsContentForSection: path.section] objectAtIndex: path.row];
    
    return cellsContentInfo;
}

- (void) markTaskAsSelected: (NSIndexPath*)          index
             withCompletion: (CompletionWithSuccess) completion
{    
    self.selectedTask = [self getInfoForCellAtIndexPath: index];
    
    [[TasksService sharedInstance] changeSelectedStageForTask: self.selectedTask
                                            withSelectedState: YES
                                               withCompletion: completion];
}

- (void) updateAllTasksData
{
    self.currentProjectInfo = [DataManagerShared getSelectedProjectInfo];
}

- (void) setTableSearchState: (SearchTableState) state
{
    self.tableState = state;
    
    if ( state == TableNormalState )
        self.searchFilteredPredicate = nil;
}

- (SearchTableState) getSearchTableState
{
    return self.tableState;
}

- (void) applyFilteringByText: (NSString*) text
{
    if ( text.length > 0 )
        self.searchFilteredPredicate = [NSPredicate predicateWithFormat: @"title CONTAINS[cd] %@", text];
    else
        self.searchFilteredPredicate = nil;
}

- (NSUInteger) getCountOfFoundTaks
{
    return self.countOfFoundTasks;
}

@end
