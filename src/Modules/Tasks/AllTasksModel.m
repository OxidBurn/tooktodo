//
//  AllTasksModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AllTasksModel.h"

// Classes
#import "ProjectTaskStage+CoreDataClass.h"
#import "TasksService.h"

// Categories
#import "DataManager+ProjectInfo.h"
#import "DataManager+Tasks.h"
#import "NSObject+Sorting.h"

//static NSString* projectKey = @"projectInfoKey";
//static NSString* contentKey = @"contentInfoKey";


@interface AllTasksModel()

// properties

@property (strong, nonatomic) NSArray* projectsInfoArray;

@property (nonatomic, strong) NSArray* tableContentArray;

@property (strong, nonatomic) NSArray* rowsInfo;

@property (nonatomic, assign) ContentAccedingSortingType ascending;

@property (nonatomic, assign) TasksSortingType sortType;

// methods


@end

@implementation AllTasksModel


#pragma mark - Initialization -

- (instancetype) initWithDefaultSortParameters
{
    self = [super init];
    
    if (self)
    {
        //Default sorting by name in ascending
        self.ascending = GrowsSortingType;
        self.sortType  = SortByName;
    }
    
    return self;
}


#pragma mark - Properties -

- (NSArray*) projectsInfoArray
{
    if (_projectsInfoArray == nil)
    {
        _projectsInfoArray = [DataManagerShared getAllProjects];
    }
    
    return _projectsInfoArray;
}


#pragma mark - Public methods -

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
    return self.projectsInfoArray.count;
}

- (NSUInteger) countOfRowsInSection: (NSUInteger) section
{
    NSArray* sectionInfo = self.tableContentArray[section];
    
    return sectionInfo.count;
}

- (ProjectInfo*) getProjectInfoForSection: (NSUInteger) section
{
    return self.projectsInfoArray[section];
}

- (void) markProjectAsExpanded: (NSUInteger)            projectIndex
                withCompletion: (CompletionWithSuccess) completion
{
    ProjectInfo* project = [self getProjectInfoForSection: projectIndex];
    
    __weak typeof(self) blockSelf = self;
    
    [DataManagerShared updateProjectExpandedState: project
                                   withCompletion: ^(BOOL isSuccess) {
                                       
                                       [blockSelf updateAllTasksData];
                                       
                                       if ( completion )
                                           completion(YES);
                                       
                                   }];
}

- (void) markStageAsExpandedAtIndexPath: (NSIndexPath*)          indexPath
                         withCompletion: (CompletionWithSuccess) completion
{
    ProjectTaskStage* stage = self.tableContentArray[indexPath.section][indexPath.row];
    
    __weak typeof(self) blockSelf = self;
    
    [DataManagerShared updateExpandedStateOfStage: stage
                                   withCompletion: ^(BOOL isSuccess) {
                                       
                                       [blockSelf updateAllTasksData];
                                       
                                       if ( completion )
                                           completion(YES);
                                       
                                   }];
}

- (NSString*) getCellIDAtIndexPath: (NSIndexPath*) path
{
    id cellInfo = [self getInfoForCellAtIndexPath: path];
    
    if ( [cellInfo isKindOfClass: [ProjectTaskStage class]] )
    {
        return @"StageTypeCellID";
    }
    else if ([cellInfo isKindOfClass: [ProjectTask class]])
    {
        return @"TaskInfoCellID";
    }
    else
        return @"";
}

- (id) getInfoForCellAtIndexPath: (NSIndexPath*) path
{

    NSArray* sectionContent = self.tableContentArray[path.section];
    
    return sectionContent[path.row];
}

- (CGFloat) getCellHeightAtIndexPath: (NSIndexPath*) path
{
    NSString* cellID = [self getCellIDAtIndexPath: path];
    
    if ( [cellID isEqualToString: @"StageTypeCellID"] )
        return 55.0f;
    else
        return 139.0f;
}

- (void) markTaskAsSelected: (NSIndexPath*)          index
             withCompletion: (CompletionWithSuccess) completion
{
    ProjectTask* selectedTask = [self getInfoForCellAtIndexPath: index];
    
    [[TasksService sharedInstance] changeSelectedStageForTask: selectedTask
                                            withSelectedState: YES
                                               withCompletion: completion];
}

- (void) sortArrayForType: (TasksSortingType)           type
               isAcceding: (ContentAccedingSortingType) isAcceding
{
    self.sortType  = type;
    self.ascending = isAcceding;
    
    [self updateAllTasksData];
}

#pragma mark - Internal methods -

- (void) updateAllTasksData
{
    //array which contains all info about projects, stages, tasks
    __block NSMutableArray* tmpContent = [NSMutableArray array];
    
    [self.projectsInfoArray enumerateObjectsUsingBlock:^(ProjectInfo*  _Nonnull projectInfo, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //Storing stages and tasks as rows in one section
        NSMutableArray* tmpSectionContent = [NSMutableArray array];
        
        
        if (projectInfo.isExpanded.boolValue)
        {
           
            [projectInfo.stage enumerateObjectsUsingBlock:^(ProjectTaskStage * _Nonnull stage, BOOL * _Nonnull stop) {
                
                [tmpSectionContent addObject: stage];
                
                if (stage.isExpanded.boolValue)
                {
                    __block NSMutableArray* tasksArray = [NSMutableArray array];
                    
                    [stage.tasks enumerateObjectsUsingBlock:^(ProjectTask * _Nonnull task, BOOL * _Nonnull stop) {
                    
                        [tasksArray addObject: task];
                    }];
                    
                    //applying sorting for tasks in expanded stages
                    NSArray* sortedTasks = [self applyTasksSortingType: self.sortType
                                                               toArray: tasksArray.copy
                                                            isAcceding: self.ascending];
                    
                    [sortedTasks enumerateObjectsUsingBlock:^(ProjectTask*  _Nonnull sortedTask, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        [tmpSectionContent addObject: sortedTask];
                    }];
                    
                }
             
            }];
        }
        
        [tmpContent addObject: tmpSectionContent.copy];
        
        tmpSectionContent = nil;
        
    }];
    
    self.tableContentArray = tmpContent.copy;
    
    tmpContent = nil;
}


@end
