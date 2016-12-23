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
#import "Utils.h"
#import "SearchResultsHeaderView.h"

// Categories
#import "UISearchBar+TextFieldControl.h"

@interface ProjectTasksViewModel() <TaskListTableViewCellDelegate, UISearchBarWithClearButtonDelegate>

// properties

@property (strong, nonatomic) ProjectTasksModel* model;

@property (strong, nonatomic) SearchResultsHeaderView* searchResultsHeader;

@property (nonatomic, assign) BOOL isCanceledSearch;

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

#pragma mark - Public methods -

- (RACSignal*) updateContent
{
    RACSignal* updateSignal = [self.model updateContent];
    
    return updateSignal;
}

- (RACSignal*) loadUpdatedContentFromServer
{
    return [self.model loadUpdatedContentFromServer];
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

#pragma mark - SearchBarHeaderDelegate -

- (ProjectTasksViewModel*) getViewModel
{
    return self;
}

#pragma mark - UITable view data source -

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return [self.model countOfSections];
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    if ( section == 0 && [self.model getSearchTableState] == TableSearchState )
        return 0;
    
    NSUInteger countOfRows = [self.model countOfRowsInSection: section];
    
    return countOfRows;
}

- (CGFloat)     tableView: (UITableView*) tableView
 heightForHeaderInSection: (NSInteger)    section
{
    if (section == 0 && [self.model getSearchTableState] == TableSearchState)
        return 24.0f;
    else
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

    if (section == 0 && [self.model getSearchTableState] == TableSearchState)
    {
        self.searchResultsHeader = [[MainBundle loadNibNamed: @"ResultsCountView"
                                                   owner: self
                                                 options: nil] firstObject];
        
        self.countOfFoundTasksText = [Utils getDeclensionStringWithValue: [self.model getCountOfFoundTaks]
                                                  withSearchedObjectName: @"задач"];
        
        [self.searchResultsHeader fillCountOfTasks: self.countOfFoundTasksText];
    
        
        return self.searchResultsHeader;
    }
    
    else
    {
        StageTitleView* stageInfoView = [[MainBundle loadNibNamed: @"StageTitleView"
                                                            owner: self
                                                          options: nil] firstObject];
        
        stageInfoView.tag = section;
        
        ProjectTaskStage* stage = [self.model getStageForSection: section];
        
        [stageInfoView fillInfo: stage
            withStagesTasksList: [self.model rowsContentForSection: section]
                withSearchState: [self.model getSearchTableState]];
        
        
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
        [self.model countSearchResultsForString: searchText];
        
        [self.model applyFilteringByText: searchText];
        
        RAC(self.searchResultsHeader, countOfTasksLabel) = RACObserve(self, countOfFoundTasksText);
        
        if ( self.reloadTable )
            self.reloadTable();
    }
    
    else
    {
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
    
    if (self.reloadTable)
        self.reloadTable();
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.isCanceledSearch = NO;
        
    });
}



@end
