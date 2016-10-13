//
//  TaskViewModel.m
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskDetailViewModel.h"

// Classes
#import "TaskDetailModel.h"
#import "TaskDescriptionCell.h"
#import "TaskInfoHeaderView.h"
#import "ProjectsEnumerations.h"
#import "TaskInfoFooterView.h"
#import "TaskDetailInfoCell.h"

@interface TaskDetailViewModel() <TaskInfoFooterDelegate, TaskDetailCellDelegate>

// properties
@property (strong, nonatomic) TaskDetailModel* model;

@property (strong, nonatomic) UITableView* tableView;

@property (strong, nonatomic) TaskInfoHeaderView* headerView;
// methods


@end

@implementation TaskDetailViewModel

#pragma mark - Properties -

- (TaskDetailModel*) model
{
    if ( _model == nil )
    {
        _model = [TaskDetailModel new];
    }
    
    return _model;
}

- (TaskInfoHeaderView*) headerView
{
    if ( _headerView == nil )
    {
        _headerView = [[MainBundle loadNibNamed: @"SubTaskInfoView"
                                          owner: self
                                        options: nil] firstObject];
       
        [_headerView fillViewWithInfo: [self.model returnHeaderInfo]
                         withDelegate: self];
    }
    
    return _headerView;
}

#pragma mark - Public -

- (TaskStatusType) getTaskStatus
{
    return [self.model getTaskStatus];
}

#pragma mark - UITableViewDataSourse methods -

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 2;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model returnNumberOfRowsForIndexPath: section];
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    self.tableView = tableView;
    
    UITableViewCell* cell = [self.model createCellForTableView: tableView
                                                 forIndexPath: indexPath];
    
    //Cheking if cell is TaskDetail info, then set viewmodel its delegate
    if ([cell isKindOfClass: [TaskDetailInfoCell class]])
    {
       TaskDetailInfoCell* detailCell = (TaskDetailInfoCell*)cell;
        
        detailCell.delegate   = self;
        
    }
    
    return cell;
}

- (CGFloat)   tableView: (UITableView*) tableView
heightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    return [self.model returnHeigtForRowAtIndexPath: indexPath
                                       forTableView: tableView];
}

- (UIView*)  tableView: (UITableView*) tableView
viewForHeaderInSection: (NSInteger)    section
{
    if ( section == 1 )
    {
        return self.headerView;
    }
    
    return nil;
}

- (CGFloat)    tableView: (UITableView*) tableView
heightForHeaderInSection: (NSInteger)    section
{
    CGFloat height = 0;
    
    if ( section == 1 )
    {
        height = [self.model returnHeaderHeight];
    }
    
    return height;
}

#pragma mark - UITableViewDelegate methods -

- (void)      tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
}

#pragma mark - TaskInfoFooterDelegate -

- (void) updateSecondSectionContentType: (NSUInteger) typeIndex
{
    [self updateSecondSectionContentForType: typeIndex];
}


#pragma mark - Public -

- (void) deselectTask
{
    [self.model deselectTask];
}

- (void) updateSecondSectionContentForType: (NSUInteger) typeIndex
{
    [self.model updateSecondSectionContentType: typeIndex];
    
    [self.tableView reloadSections: [NSIndexSet indexSetWithIndex: 1]
                  withRowAnimation: UITableViewRowAnimationFade];
}

#pragma mark - TaskDetailCellDelegate methods -

- (void) performSegueWithID: (NSString*) segueID
{
    if (self.performSegue)
        self.performSegue(segueID);
}

@end
