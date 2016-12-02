//
//  ProjectTasksViewModel.m
//  TookTODO
//
// Created by Nikolay Chaban on 28.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectTasksViewModel.h"

// Classes
#import "StageTitleView.h"
#import "ProjectInfo+CoreDataClass.h"
#import "AllTaskBaseTableViewCell.h"
#import "TaskDetailInfoCell.h"
#import "ProjectsEnumerations.h"
#import "ProjectTask+CoreDataClass.h"
#import "DataManager+Tasks.h"
#import "DataManager+ProjectInfo.h"
#import "NSObject+Sorting.h"
#import "TasksListTableViewCell.h"

// Categories
#import "UISearchBar+TextFieldControl.h"

@interface ProjectTasksViewModel() <TaskListTableViewCellDelegate, UISearchBarWithClearButtonDelegate>

// properties

@property (strong, nonatomic) ProjectTasksModel* model;

@property (assign, nonatomic) BOOL isCanceledSearch;

@property (nonatomic, assign) CGRect searchBarBackgroundRect;

// methods


@end

@implementation ProjectTasksViewModel


#pragma mark - Properties -

- (NSValue*) searchBarBackgroungRectValue
{
    if (_searchBarBackgroungRectValue == nil)
    {
        _searchBarBackgroungRectValue = [NSValue valueWithCGRect: (CGRectMake(0, 0, 375, 44))];
    }
    
    return _searchBarBackgroungRectValue;
}

- (ProjectTasksModel*) model
{
    if ( _model == nil )
    {
        _model = [ProjectTasksModel new];
    }
    
    return _model;
}

#pragma mark - Public methods -

- (RACSignal*) updateContent
{
    RACSignal* updateSignal = [self.model updateContent];
    
    return updateSignal;
}

- (RACSignal*) applyFilters
{
    return [self.model applyFilters];
}

- (ProjectTask*) getSelectedProjectTask
{
    return [self.model getSelectedProjectTask];
}

- (SearchTableState) getSearchTableState
{
    return [self.model getSearchTableState];
}

- (NSUInteger) getCountOfFoundTaks
{
    return [self.model getCountOfFoundTaks];
}

#pragma mark - UITable view data source -

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return [self.model countOfSections];
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    NSUInteger countOfRows = [self.model countOfRowsInSection: section];
    
    return countOfRows;
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
    
    [stageInfoView fillInfo: stage
        withStagesTasksList: [self.model rowsContentForSection: section]
            withSearchState: [self.model getSearchTableState]];
    
    self.countOfFoundTasksText = [NSString stringWithFormat: @"Найдено %lu задач", [self getCountOfFoundTaks]];
    
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
    
    [cell fillInfoForCell: [self.model getInfoForCellAtIndexPath: indexPath]];
    
    return cell;
}


#pragma mark - Table view delegate methods -

- (void)       tableView: (UITableView*) tableView
 didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    AllTaskBaseTableViewCell* cell = (AllTaskBaseTableViewCell*)[tableView cellForRowAtIndexPath: indexPath];
    
    [self.model markTaskAsSelected: cell.cellIndexPath
                    withCompletion: ^(BOOL isSuccess) {
                             
                        if ( self.performSegue )
                             self.performSegue(@"ShowTaskDetailSegueId");
                             
                    }];
    
}


#pragma mark - TaskListTableViewCellDelegate methods -

- (void) performSegueToChangeStatusWithID: (NSString*) segueID
{
    if (self.performSegue)
        self.performSegue(segueID);
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


#pragma mark - Search bar delegate methods -

- (void) searchBar: (UISearchBar*) searchBar
     textDidChange: (NSString*)    searchText
{
    
    if ( self.isCanceledSearch == NO )
    {
        [self.model applyFilteringByText: searchText];
        
        self.foundedTasksHeigthConstraintConstant = 24;
        
        self.searchBarBackgroundRect = CGRectMake(0, 0, 375, 68);
        
        self.searchBarBackgroungRectValue = [NSValue valueWithCGRect: self.searchBarBackgroundRect];
        
        if ( self.reloadTable )
            self.reloadTable();
    }
    
    else
    {
        self.searchBarBackgroundRect = CGRectMake(0, 0, 375, 44);
        self.searchBarBackgroungRectValue = [NSValue valueWithCGRect: self.searchBarBackgroundRect];
     
        if ( self.reloadTable )
            self.reloadTable();
    }
}

- (void) searchBarSearchButtonClicked: (UISearchBar*) searchBar
{
    [searchBar resignFirstResponder];
}

- (BOOL) searchBarShouldBeginEditing: (UISearchBar*) searchBar
{
    return !self.isCanceledSearch;
}

- (void) searchBarTextDidBeginEditing: (UISearchBar*) searchBar
{
    [self.model setTableSearchState: TableSearchState];
    
    if ( self.reloadTable )
        self.reloadTable();
}

- (void) searchBarClearButtonClicked: (id) sender
{
    [self.model setTableSearchState: TableNormalState];
    
    if ( self.endSearching )
        self.endSearching();
    
    self.isCanceledSearch = YES;
    
    self.foundedTasksHeigthConstraintConstant = 0;
    self.searchBarBackgroungRectValue = [NSValue valueWithCGRect: (CGRectMake( 0, 0, 375, 44))];
    
    if (self.reloadTable)
        self.reloadTable();

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.isCanceledSearch = NO;
        
    });
}


@end
