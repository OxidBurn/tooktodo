//
//  TaskViewModel.m
//  TookTODO
//
//  Created by Глеб on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskDetailViewModel.h"

// Classes
#import "TaskDetailModel.h"
#import "TaskDescriptionCell.h"
#import "TaskInfoFooterView.h"
#import "TaskDetailInfoCell.h"


@interface TaskDetailViewModel() <TaskInfoFooterDelegate, TaskDetailCellDelegate>

// properties
@property (strong, nonatomic) TaskDetailModel* model;

@property (strong, nonatomic) UITableView* tableView;

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
    UIView* header = [UIView new];
    
    if ( section == 1 )
        header = [self.model returnHeaderForSection];
    
    return header;
}

- (UIView*)  tableView: (UITableView*) tableView
viewForFooterInSection: (NSInteger)    section
{
    TaskInfoFooterView* footer = [TaskInfoFooterView new];
    
    
    if ( section == 0)
    {
        footer = [[MainBundle loadNibNamed: @"SubTaskInfoView"
                                     owner: self
                                   options: nil] firstObject];
    }
    
    [footer fillViewWithInfo: [self.model returnFooterInfo]
                withDelegate: self];
    
    return footer;
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

- (CGFloat)    tableView: (UITableView*) tableView
heightForFooterInSection: (NSInteger)    section
{
    CGFloat height = 0;
    
    if ( section == 0 )
    {
        height = 43.0f;
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
    [self.model updateSecondSectionContentType: typeIndex];
    
    [self.tableView reloadSections: [NSIndexSet indexSetWithIndex: 1]
                  withRowAnimation: UITableViewRowAnimationAutomatic];
}


#pragma mark - Public -

- (void) deselectTask
{
    [self.model deselectTask];
}

#pragma mark - TaskDetailCellDelegate methods -

- (void) performSegueWithID: (NSString*) segueID
{
    if (self.performSegue)
        self.performSegue(segueID);
}

@end
