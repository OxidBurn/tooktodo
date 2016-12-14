//
//  ChangeStatusViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ChangeStatusViewModel.h"

//Classes
#import "ChangeStatusModel.h"
#import "CellWithBackground.h"
#import "TaskDetailInfoCell.h"

@interface ChangeStatusViewModel()

// properties
@property (nonatomic, strong) ChangeStatusModel* model;

// methods

@end

@implementation ChangeStatusViewModel

#pragma mark - Properties -

- (ChangeStatusModel*) model
{
    if (_model == nil)
    {
        _model = [ChangeStatusModel new];
    }
    
    return _model;
}


#pragma mark - Public -

- (TaskStatusType) getCurrentStatusType
{
    return [self.model getCurrentStatus];
}

- (UIImage*) getExpandedArrowMarkImage
{
    return [self.model getExpandedArrowMarkImage];
}

- (CGFloat) countTableViewHeight
{
    return [self.model countTableViewHeight];
}

#pragma mark - TableViewDatasource methods -

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    NSString* cellID = @"CellWithBackgroundID";
    
    CellWithBackground* cell = [tableView dequeueReusableCellWithIdentifier: cellID
                                                               forIndexPath: indexPath];

    [cell fillCellForTaskStatus: [self.model getStatusTypeForRow: indexPath.row]];
    
    return cell;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model numberOfRows];
}

#pragma mark - TableViewDelegate methods -

- (void)        tableView: (UITableView*) tableView
  didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    TaskStatusType selectedStatus = [self.model getStatusTypeForRow: indexPath.row];
    
    if ( [self.model getCurrentStatus] == TaskToOnApprovalStatusType )
    {
        if ( selectedStatus == TaskToReworkStatusType )
        {
            if ( self.showOnRevisionController )
                self.showOnRevisionController();
        }
    }
    else
        if ( selectedStatus == TaskToCancelStatusType )
        {
            if ( self.showCancelRequestController )
                self.showCancelRequestController();
        }
    else
    {
        [self.model updateTaskStatusWithNewStatus: selectedStatus
                                   withCompletion: ^(BOOL isSuccess) {
                                       
                                       if ( self.returnToTaskDetailController )
                                           self.returnToTaskDetailController();
                                   }];
    }
}

@end
