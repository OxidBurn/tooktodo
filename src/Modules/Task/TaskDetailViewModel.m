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
#import "SubTaskInfoView.h"

@interface TaskDetailViewModel()

// properties
@property (strong, nonatomic) TaskDetailModel* model;

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

    return [self.model createCellForTableView: tableView
                                 forIndexPath: indexPath];
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
    SubTaskInfoView* footer = [SubTaskInfoView new];
    
    
    if ( section == 0)
    {
        footer = [[MainBundle loadNibNamed: @"SubTaskInfoView"
                                     owner: self
                                   options: nil] firstObject];
    }
    
    [footer fillViewWithInfo: [self.model returnFooterInfo]];
    
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

#pragma mark - Public -

- (void) deselectTask
{
    [self.model deselectTask];
}


@end
