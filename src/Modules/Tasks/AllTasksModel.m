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
#import "DataManager+AllProjectsFilter.h"

//static NSString* projectKey = @"projectInfoKey";
//static NSString* contentKey = @"contentInfoKey";


@interface AllTasksModel()

// properties

@property (strong, nonatomic) NSArray* projectsInfoArray;

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

- (RACSignal*) applyFilters
{
    
    
    return nil;
}

- (NSUInteger) countOfSections
{
    return self.projectsInfoArray.count;
}

- (NSUInteger) countOfRowsInSection: (NSUInteger) section
{
    ProjectInfo* project           = self.projectsInfoArray[section];
    __block NSUInteger countOfRows = 0;
    
    if ( project.isExpanded.boolValue )
    {
        countOfRows = project.stage.count;
        
        [project.stage enumerateObjectsUsingBlock: ^(ProjectTaskStage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ( obj.isExpanded.boolValue )
            {
                countOfRows += obj.tasks.count;
            }
            
        }];
    }
    
    return countOfRows;
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
    ProjectInfo* project    = self.projectsInfoArray[indexPath.section];
    ProjectTaskStage* stage = project.stage[indexPath.row];
    
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
    __block NSMutableArray* sectionContent = [NSMutableArray array];
    
    ProjectInfo* projectOfSection = [self getProjectInfoForSection: path.section];
    
    if ( projectOfSection.isExpanded.boolValue )
    {
        [projectOfSection.stage enumerateObjectsUsingBlock:^(ProjectTaskStage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            [sectionContent addObject: obj];
            
            if ( obj.isExpanded.boolValue )
            {
                [obj.tasks enumerateObjectsUsingBlock: ^(ProjectTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    [sectionContent addObject: obj];
                    
                }];
            }
            
        }];
    }
    
    return [sectionContent objectAtIndex: path.row];
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
    self.projectsInfoArray = [DataManagerShared applyFiltersToProject: [DataManagerShared getAllProjects]];
}


@end
