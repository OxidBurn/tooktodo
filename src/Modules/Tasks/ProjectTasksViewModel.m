//
//  ProjectTasksViewModel.m
//  TookTODO
//
// Created by Nikolay Chaban on 28.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectTasksViewModel.h"

// Classes
#import "ProjectTasksModel.h"
#import "StageTitleView.h"
#import "ProjectInfo+CoreDataClass.h"
#import "AllTaskBaseTableViewCell.h"
#import "TaskDetailInfoCell.h"
#import "ProjectsEnumerations.h"
#import "ProjectTask+CoreDataClass.h"
#import "DataManager+Tasks.h"
#import "DataManager+ProjectInfo.h"

@interface ProjectTasksViewModel()

// properties

@property (strong, nonatomic) ProjectTasksModel* model;

@property (nonatomic, strong) NSArray* tasksArray;

// methods


@end

@implementation ProjectTasksViewModel

#pragma mark - Properties -

- (ProjectTasksModel*) model
{
    if ( _model == nil )
    {
        _model = [ProjectTasksModel new];
    }
    
    return _model;
}

- (NSArray *)tasksArray
{
    if (_tasksArray == nil)
    {
        _tasksArray = [self getTasks];
    }
    
    return _tasksArray;
}

#pragma mark - Public methods -

- (RACSignal*) updateContent
{
    RACSignal* updateSignal = [self.model updateContent];
    
    return updateSignal;
}

- (void) applySortingForTaskList: (TasksSortingType)           type
                      isAcceding: (ContentAccedingSortingType) isAcceding
{
    self.tasksArray = [self.model applyTasksSortingType: type
                                                toArray: self.tasksArray
                                             isAcceding: isAcceding];
}

- (NSArray*) getTasks
{
    ProjectInfo* currentProject = [DataManagerShared getSelectedProjectInfo];
    
    NSArray* tasks = currentProject.tasks.allObjects;
    
    return tasks;
}

- (ProjectTask*) getSelectedProjectTask
{
    return [self.model getSelectedProjectTask];
}

#pragma mark - UITable view data source -

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return [self.model countOfSections];
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model countOfRowsInSection: section];
}

- (CGFloat)     tableView: (UITableView*) tableView
 heightForHeaderInSection: (NSInteger)    section
{
    return 48.0f;
}

- (CGFloat)    tableView: (UITableView*) tableView
 heightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    return 139.f;
}

- (nullable UIView*) tableView: (UITableView*) tableView
        viewForHeaderInSection: (NSInteger)    section
{
    StageTitleView* stageInfoView = [[MainBundle loadNibNamed: @"StageTitleView"
                                                                 owner: self
                                                               options: nil] firstObject];
    
    stageInfoView.tag = section;
    
    ProjectTaskStage* stage = [self.model getStageForSection: section];
    
    [stageInfoView fillInfo: stage];
    
    // Handle changing expand state of the project
    __weak typeof(self) blockSelf = self;
    
    stageInfoView.didChangeExpandState = ^( NSUInteger section ){
        
        [blockSelf.model markStageAsExpandedAtIndexPath: section
                                         withCompletion: ^(BOOL isSuccess) {
                                             
                                             [tableView reloadData];
                                             
                                         }];
        
    };
    
    return stageInfoView;
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    AllTaskBaseTableViewCell* cell = (AllTaskBaseTableViewCell*)[tableView dequeueReusableCellWithIdentifier: @"TaskInfoCellID"];
    
    cell.cellIndexPath = indexPath;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    [cell fillInfoForCell: self.tasksArray[indexPath.row]];
    
    __weak typeof(self) blockSelf = self;
    
    cell.didSelectedTaskAtIndex = ^( NSIndexPath* index){
        
        [blockSelf.model markTaskAsSelected: index];
        
        if ( blockSelf.didShowTaskInfo )
            blockSelf.didShowTaskInfo();
        
    };
    
    
    return cell;
}


#pragma mark - Table view delegate methods -

- (void)       tableView: (UITableView*) tableView
 didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    AllTaskBaseTableViewCell* cell = (AllTaskBaseTableViewCell*)[tableView cellForRowAtIndexPath: indexPath];
    
    AllTasksCellType selectedCellType = cell.cellType;
    
    switch (selectedCellType)
    {
        case AllTasksStageCellType:
        {
            [self.model markStageAsExpandedAtIndexPath: indexPath.section
                                        withCompletion: ^(BOOL isSuccess) {
                                            
                                            [tableView reloadData];
                                            
                                        }];
        }
            break;
            
        case AllTasksTaskCellType:
        {
            
        }
            break;
    }
}

#pragma mark - PopoverViewController dataSource methods -

- (NSArray*) getPopoverContent
{
    return [self.model getPopoverContent];
}

- (NSUInteger) selectedItem
{
    return [self.model getTasksSortingType];
}

- (ContentAccedingSortingType) getProjectsSortAccedingType
{
    return [self.model getTasksSortingAscendingType];
}

#pragma mark - PopoverViewController delegate methods -

- (void) didDiminutionSortingAtIndex: (NSUInteger) index
{
    [self applySortingForTaskList: index
                       isAcceding: DiminutionSortingType];
    
    //Load new data for table
    if ( self.reloadTable )
        self.reloadTable();
}

- (void) didGrowSortingAtIndex: (NSUInteger) index
{
    [self applySortingForTaskList: index
                       isAcceding: GrowsSortingType];
    
     //Load new data for table
    if ( self.reloadTable )
        self.reloadTable();
}

@end
