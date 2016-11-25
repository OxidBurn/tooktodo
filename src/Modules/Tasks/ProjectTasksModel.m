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

static NSString* stageKey   = @"stageInfoKey";
static NSString* contentKey = @"contentInfoKey";

@interface ProjectTasksModel()

// properties

@property (nonatomic, strong) ProjectInfo* currentProjectInfo;

@property (nonatomic, strong) NSArray* stages;

@property (strong, nonatomic) NSArray* filteredStagesContent;

@property (strong, nonatomic) ProjectTask* selectedTask;

@property (assign, nonatomic) SearchTableState tableState;

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

- (void) sortArrayForType: (TasksSortingType)           type
               isAcceding: (ContentAccedingSortingType) isAcceding
{
    if ( self.tableState == TableNormalState )
    {
        NSMutableArray* newStages = self.stages.mutableCopy;
        
        [self.stages enumerateObjectsUsingBlock: ^(NSDictionary* _Nonnull section, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (section[contentKey])
            {
                NSArray* newSectionContent =  [self applyTasksSortingType: type
                                                                  toArray: section[contentKey]
                                                               isAcceding: isAcceding];
                
                NSMutableDictionary* newSection = section.mutableCopy;
                
                [newSection setObject: newSectionContent
                               forKey: contentKey];
                
                [newStages replaceObjectAtIndex: idx
                                     withObject: newSection];
            }
            
        }];
        
        self.stages = newStages.copy;
    }
    else
    {
        NSMutableArray* newStages = self.filteredStagesContent.mutableCopy;
        
        [self.filteredStagesContent enumerateObjectsUsingBlock: ^(NSDictionary* _Nonnull section, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (section[contentKey])
            {
                NSArray* newSectionContent =  [self applyTasksSortingType: type
                                                                  toArray: section[contentKey]
                                                               isAcceding: isAcceding];
                
                NSMutableDictionary* newSection = section.mutableCopy;
                
                [newSection setObject: newSectionContent
                               forKey: contentKey];
                
                [newStages replaceObjectAtIndex: idx
                                     withObject: newSection];
            }
            
        }];
        
        self.filteredStagesContent = newStages.copy;
    }
}

- (NSUInteger) countOfSections
{
    switch (self.tableState)
    {
        case TableNormalState:
        {
            return self.stages.count;
        }
            break;
        case TableSearchState:
        {
            return self.filteredStagesContent.count;
        }
            break;
    }
    
    return 0;
}

- (NSUInteger) countOfRowsInSection: (NSUInteger) section
{
    NSArray* rowsInfoCount = [self rowsContentForSection: section];
    
    return rowsInfoCount.count;
}

- (NSArray*) rowsContentForSection: (NSUInteger) section
{
    NSArray* rowsContent = @[];
    
    switch (self.tableState)
    {
        case TableNormalState:
        {
            rowsContent = self.stages[section][contentKey];
        }
            break;
        case TableSearchState:
        {
            rowsContent = self.filteredStagesContent[section][contentKey];
        }
            break;
    }

    return rowsContent;
}


- (ProjectTaskStage*) getStageForSection: (NSUInteger) section
{
    switch (self.tableState)
    {
        case TableNormalState:
        {
            return self.stages[section][stageKey];
        }
            break;
        case TableSearchState:
        {
            return self.filteredStagesContent[section][stageKey];
        }
            break;
    }
    
    return nil;
}

- (void) markStageAsExpandedAtIndexPath: (NSInteger)             section
                         withCompletion: (CompletionWithSuccess) completion
{
    ProjectTaskStage* stage = (ProjectTaskStage*)self.currentProjectInfo.stage.allObjects[section];
    
    __weak typeof(self) blockSelf = self;
    
    [DataManagerShared updateExpandedStateOfStage: stage
                                   withCompletion: ^(BOOL isSuccess) {
                                       
                                       [blockSelf updateAllTasksData];
                                       
                                       if ( completion )
                                           completion(YES);
                                       
                                   }];
}

- (id) getInfoForCellAtIndexPath: (NSIndexPath*) path
{
    NSArray* cellsContentInfo = @[];
    
    switch (self.tableState)
    {
        case TableNormalState:
        {
            cellsContentInfo = self.stages[path.section][contentKey];
        }
            break;
        case TableSearchState:
        {
            cellsContentInfo = self.filteredStagesContent[path.section][contentKey];
        }
            break;
    }
    
    id cellInfo = cellsContentInfo[path.row];
    
    return cellInfo;
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
    
    __block NSMutableArray* tmpStageInfo = [NSMutableArray array];
    __block NSMutableArray* tmpRowsInfo  = [NSMutableArray array];
    
    [self.currentProjectInfo.stage enumerateObjectsUsingBlock: ^(ProjectTaskStage * _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSMutableDictionary* stagesInfoDic = [NSMutableDictionary dictionaryWithDictionary: @{stageKey : obj}];
        
        if ( obj.isExpanded.boolValue )
        {
            [obj.tasks enumerateObjectsUsingBlock: ^(ProjectTask * _Nonnull obj, BOOL * _Nonnull stop) {
            
                [tmpRowsInfo addObject: obj];
                
            }];
        }
        
        if ( tmpRowsInfo.count > 0 )
        {
            [stagesInfoDic setObject: tmpRowsInfo.copy
                              forKey: contentKey];
            
            [tmpRowsInfo removeAllObjects];
        }
        
        [tmpStageInfo addObject: stagesInfoDic];
                
    }];
    
    
    self.stages = tmpStageInfo.copy;
    
    tmpRowsInfo  = nil;
    tmpStageInfo = nil;
}

- (void) updateTaskStatusForIndexPath: (NSIndexPath*) path
{
    self.selectedTask = [DataManagerShared getSelectedTask];
    
    NSArray* cellsContentInfo = @[];
    
    switch (self.tableState)
    {
        case TableNormalState:
        {
            cellsContentInfo = self.stages[path.section][contentKey];
        }
            break;
        case TableSearchState:
        {
            cellsContentInfo = self.filteredStagesContent[path.section][contentKey];
        }
            break;
    }
    
    ProjectTask* cellInfo = cellsContentInfo[path.row];
    
    cellInfo.status            = self.selectedTask.status;
    cellInfo.statusDescription = self.selectedTask.statusDescription;
}

- (void) setTableSearchState: (SearchTableState) state
{
    self.tableState = state;
    
    switch (state)
    {
        case TableSearchState:
        {
            self.filteredStagesContent = self.stages;
        }
            break;
        case TableNormalState:
        {
            self.filteredStagesContent = nil;
        }
            break;
    }
}

- (SearchTableState) getSearchTableState
{
    return self.tableState;
}

- (void) applyFilteringByText: (NSString*) text
{
    if ( text.length > 0 )
    {
        self.currentProjectInfo = [DataManagerShared getSelectedProjectInfo];
        
        __block NSMutableArray* tmpStageInfo = [NSMutableArray array];
        __block NSMutableArray* tmpRowsInfo  = [NSMutableArray array];
        
        [self.currentProjectInfo.stage enumerateObjectsUsingBlock: ^(ProjectTaskStage * _Nonnull obj, BOOL * _Nonnull stop) {
            
            [obj.tasks enumerateObjectsUsingBlock: ^(ProjectTask * _Nonnull obj, BOOL * _Nonnull stop) {
                
                if ( [obj.title containsString: text] )
                    [tmpRowsInfo addObject: obj];
                
            }];
            
            if ( tmpRowsInfo.count > 0 )
            {
                obj.isExpanded = @YES;
                
                NSMutableDictionary* stagesInfoDic = [NSMutableDictionary dictionaryWithDictionary: @{stageKey : obj}];
                
                [stagesInfoDic setObject: tmpRowsInfo.copy
                                  forKey: contentKey];
                
                [tmpRowsInfo removeAllObjects];
                
                [tmpStageInfo addObject: stagesInfoDic];
            }
        }];
        
        
        self.filteredStagesContent = tmpStageInfo.copy;
        
        tmpRowsInfo  = nil;
        tmpStageInfo = nil;
    }
    else
    {
        self.filteredStagesContent = self.stages;
    }
}

@end
