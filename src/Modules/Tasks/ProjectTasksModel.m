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

// Categories
#import "DataManager+ProjectInfo.h"
#import "DataManager+Tasks.h"

static NSString* stageKey   = @"stageInfoKey";
static NSString* contentKey = @"contentInfoKey";

@interface ProjectTasksModel()

// properties

@property (nonatomic, strong) ProjectInfo* currentProjectInfo;

@property (nonatomic, strong) NSArray* stages;

@property (strong, nonatomic) ProjectTask* selectedTask;

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

- (void) markTaskAsSelected: (NSIndexPath*) index
{    
    self.selectedTask = [self getInfoForCellAtIndexPath: index];
    
    [[TasksService sharedInstance] changeSelectedStageForTask: self.selectedTask
                                            withSelectedState: YES];
}

- (NSArray*) getPopoverContent
{
    NSArray* contentArr = @[@"Название",
                            @"Дата начала",
                            @"Дата завершения",
                            @"Факт. дата начала",
                            @"Факт. дата завершения",
                            @"Ответственный",
                            @"Помещение",
                            @"Система",
                            @"Статус"];
    
    return contentArr;
}

- (TasksSortingType) getTasksSortingType
{
    return [[ConfigurationManager sharedInstance] getTasksSortingType];
}

- (ContentAccedingSortingType) getTasksSortingAscendingType
{
    return [[ConfigurationManager sharedInstance] getAccedingTypeForTasks];
}

#pragma mark - Internal methods -

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

@end
