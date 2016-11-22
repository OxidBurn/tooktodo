//
//  AllTasksViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AllTasksViewModel.h"

// Classes
#import "AllTasksModel.h"
#import "TasksProjectTitleView.h"
#import "ProjectInfo+CoreDataClass.h"
#import "AllTaskBaseTableViewCell.h"
#import "ProjectsEnumerations.h"
#import "DataManager+Tasks.h"
#import "NSObject+Sorting.h"

@interface AllTasksViewModel()

// properties

@property (strong, nonatomic) AllTasksModel* model;

// methods


@end

@implementation AllTasksViewModel


#pragma mark - Properties -

- (AllTasksModel*) model
{
    if ( _model == nil )
    {
        _model = [[AllTasksModel alloc]  initWithDefaultSortParameters];
    }
    
    return _model;
}


#pragma mark - Public methods -

- (RACSignal*) updateContent
{
    return [self.model updateContent];
}

- (ProjectTask*) getSelectedProjectTask
{
    return [DataManagerShared getSelectedTask];
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
    return 59.0f;
}

- (CGFloat)    tableView: (UITableView*) tableView
 heightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    return [self.model getCellHeightAtIndexPath: indexPath];
}

- (nullable UIView*) tableView: (UITableView*) tableView
        viewForHeaderInSection: (NSInteger)    section
{
    TasksProjectTitleView* projectInfoView = [[MainBundle loadNibNamed: @"AllTasksProjectTitleView"
                                                                 owner: self
                                                               options: nil] firstObject];

    projectInfoView.tag = section;
    
    ProjectInfo* project = [self.model getProjectInfoForSection: section];

    [projectInfoView fillInfo: project];
    
    // Handle changing expand state of the project
    __weak typeof(self) blockSelf = self;
    
    projectInfoView.didChangeExpandState = ^( NSUInteger section ){
        
        [blockSelf.model markProjectAsExpanded: section
                                withCompletion: ^(BOOL isSuccess) {
                                   
                                    [tableView reloadData];
                                    
                                }];
        
    };
    
    return projectInfoView;
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    AllTaskBaseTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: [self.model getCellIDAtIndexPath: indexPath]];
    
    cell.cellIndexPath  = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell fillInfoForCell: [self.model getInfoForCellAtIndexPath: indexPath]];
    
    __weak typeof(self) blockSelf = self;
    
    cell.didSelectedTaskAtIndex = ^( NSIndexPath* index ){
        
        [blockSelf.model markTaskAsSelected: index
                             withCompletion: ^(BOOL isSuccess) {
                                 
                                 if ( blockSelf.didShowTaskInfo )
                                     blockSelf.didShowTaskInfo();
                                 
                             }];
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
            [self.model markStageAsExpandedAtIndexPath: indexPath
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
    return [self getTasksSortingAscendingType];
}

#pragma mark - PopoverViewController delegate methods -

- (void) didDiminutionSortingAtIndex: (NSUInteger) index
{
    [self.model sortArrayForType: index
                      isAcceding: DiminutionSortingType];
    
    //Load new data for table
    if ( self.reloadTable )
        self.reloadTable();
}

- (void) didGrowSortingAtIndex: (NSUInteger) index
{
    [self.model sortArrayForType: index
                      isAcceding: GrowsSortingType];
    
    //Load new data for table
    if ( self.reloadTable )
        self.reloadTable();
}


@end
