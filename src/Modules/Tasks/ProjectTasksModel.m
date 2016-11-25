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

- (NSUInteger) countOfSections
{
    return self.stages.count;
}


- (NSUInteger) countOfRowsInSection: (NSUInteger) section
{
    NSArray* rowsInfoCount = self.stages[section][contentKey];
    
    return rowsInfoCount.count;
}

- (ProjectTaskStage*) getStageForSection: (NSUInteger) section
{
    return self.stages[section][stageKey];
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
    NSArray* cellsContentInfo = self.stages[path.section][contentKey];
    id cellInfo               = cellsContentInfo[path.row];
    
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
    
    NSArray* cellsContentInfo = self.stages[path.section][contentKey];
    ProjectTask* cellInfo     = cellsContentInfo[path.row];
    
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

- (void) applyFilteringByText: (NSString*) text
{
    NSLog(@"Filtered content %@", self.filteredStagesContent);
}

@end
