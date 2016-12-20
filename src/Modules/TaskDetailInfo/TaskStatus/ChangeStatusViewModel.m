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
    
    TaskStatusType currentStatus = [self.model getCurrentStatus];
    
    // handling unique cases
    // if 'Resume' action was selected we switch it to 'OnWaiting'
    // if 'Approve' action was selected we switch it to 'Completed'
    // if 'Cancel request' or 'On rework' was selected we go to another controller
    
 
    switch ( currentStatus )
    {
        case TaskToOnApprovalStatusType:
        {
            if ( selectedStatus == TaskOnReworkStatusType )
            {
                if ( self.showOnRevisionController )
                    self.showOnRevisionController();
                
                return;
            }
        }
            break;
            
        case TaskToInWorkStatusType:
        {
            selectedStatus = TaskToPauseStatusType;
        }
            break;
            
        case TaskApproveStatusType:
        {
            selectedStatus = TaskCompleteStatusType;
        }
            break;
            
        case TaskToCancelStatusType:
        {
            if ( self.showCancelRequestController )
                self.showCancelRequestController();
            
            return;
        }
            break;
    
        default:
            break;
    }

    [self.model updateTaskStatusWithNewStatus: selectedStatus
                               withCompletion: ^(BOOL isSuccess) {
                                   
                                   if ( self.returnToTaskDetailController )
                                       self.returnToTaskDetailController();
                               }];
}

@end
