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

static NSString* projectKey = @"projectInfoKey";
static NSString* contentKey = @"contentInfoKey";

@interface AllTasksModel()

// properties

@property (strong, nonatomic) NSArray* projectsInfo;

@property (strong, nonatomic) NSArray* rowsInfo;

// methods


@end

@implementation AllTasksModel


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
    return self.projectsInfo.count;
}

- (NSUInteger) countOfRowsInSection: (NSUInteger) section
{
    NSArray* rowsInfoCount = self.projectsInfo[section][contentKey];
    
    return rowsInfoCount.count;
}

- (ProjectInfo*) getProjectInfoForSection: (NSUInteger) section
{
    return self.projectsInfo[section][projectKey];
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
    ProjectTaskStage* stage = self.projectsInfo[indexPath.section][contentKey][indexPath.row];
    
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
    else
    {
        return @"TaskInfoCellID";
    }
    
    return @"";
}

- (id) getInfoForCellAtIndexPath: (NSIndexPath*) path
{
    NSArray* cellsContentInfo = self.projectsInfo[path.section][contentKey];
    id cellInfo               = cellsContentInfo[path.row];
    
    return cellInfo;
}

- (CGFloat) getCellHeightAtIndexPath: (NSIndexPath*) path
{
    NSString* cellID = [self getCellIDAtIndexPath: path];
    
    if ( [cellID isEqualToString: @"StageTypeCellID"] )
        return 55.0f;
    else
        return 139.0f;
}

- (void) markTaskAsSelected: (NSIndexPath*) index
{
    ProjectTask* selectedTask = [self getInfoForCellAtIndexPath: index];
    
    [[TasksService sharedInstance] changeSelectedStageForTask: selectedTask
                                            withSelectedState: YES];
}

- (void) sortArrayForType: (TasksSortingType)           type
               isAcceding: (ContentAccedingSortingType) isAcceding
{
    NSMutableArray* projectsInfoCopy  = self.projectsInfo.copy;
    
    NSMutableArray* tmpSectionContent = [NSMutableArray array];
    
    [self.projectsInfo enumerateObjectsUsingBlock: ^(NSDictionary* _Nonnull section, NSUInteger idx, BOOL * _Nonnull stop) {
    
        if (section[contentKey])
        {
            [section[contentKey] enumerateObjectsUsingBlock: ^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[ProjectTask class]])
                {
                    [tmpSectionContent addObject: obj];
                }
                
            }];
            
            NSArray* newSectionContent = [self applyTasksSortingType: type
                                                             toArray: tmpSectionContent
                                                          isAcceding: isAcceding];
            
            NSMutableDictionary* newSection = section.mutableCopy;
            
            [newSection setObject: newSectionContent
                           forKey: contentKey];
            
            [projectsInfoCopy replaceObjectAtIndex: idx
                                        withObject: newSection];
        }
    }];
    
    self.projectsInfo = projectsInfoCopy.copy;
}

#pragma mark - Internal methods -

- (void) updateAllTasksData
{
    self.projectsInfo = [DataManagerShared getAllProjects];
    
    __block NSMutableArray* tmpRowsInfo     = [NSMutableArray array];
    __block NSMutableArray* tmpProjectsInfo = [NSMutableArray array];
    
    [self.projectsInfo enumerateObjectsUsingBlock:^(ProjectInfo* project, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableDictionary* projectsInfoDic = [NSMutableDictionary dictionaryWithDictionary: @{projectKey : project}];
        
        if ( project.isExpanded.boolValue )
        {
            [project.stage enumerateObjectsUsingBlock: ^(ProjectTaskStage * _Nonnull obj, BOOL * _Nonnull stop) {
                
                [tmpRowsInfo addObject: obj];
                
                if ( obj.isExpanded.boolValue )
                {
                    [obj.tasks enumerateObjectsUsingBlock: ^(ProjectTask * _Nonnull obj, BOOL * _Nonnull stop) {
                        
                        [tmpRowsInfo addObject: obj];
                        
                    }];
                }
                
            }];
        }
        
        if ( tmpRowsInfo.count > 0 )
        {
            [projectsInfoDic setObject: tmpRowsInfo.copy
                                forKey: contentKey];
            
            [tmpRowsInfo removeAllObjects];
        }
        
        [tmpProjectsInfo addObject: projectsInfoDic];
        
    }];
    
    self.projectsInfo = tmpProjectsInfo.copy;
    
    tmpRowsInfo     = nil;
    tmpProjectsInfo = nil;
}

@end
