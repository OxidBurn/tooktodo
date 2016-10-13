//
//  ChangeStatusViewModel.m
//  TookTODO
//
//  Created by Lera on 11.10.16.
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
@property (strong, nonatomic) NSIndexPath* selectedCell;

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

- (void) fillSelectedStatusType: (TaskStatusType) status
{
    self.selectedCell = [NSIndexPath indexPathForRow: status
                                           inSection: 0];
}

- (TaskStatusType) getCurrentStatusType
{
    return [self.model getCurrentStatus];
}

- (void) getChangedInfo: (GetChangedStatusBlock) completion
{
    NSString* statusName  = [self.model getStatusName: self.selectedCell.row];
    UIColor*  background  = [self.model getBackgroundColor: self.selectedCell.row];
    UIImage*  statusImage = [self.model getStatusImage: self.selectedCell.row];
    
    if (completion) {
        completion(statusName, self.selectedCell.row, background, statusImage);
    }
}

#pragma mark - TableViewDatasource methods -

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    NSString* cellID = @"CellWithBackgroundID";
    
    CellWithBackground* cell = [tableView dequeueReusableCellWithIdentifier: cellID
                                                               forIndexPath: indexPath];
    
    if (indexPath.row == 0)
    {
        [cell fillCellWithStatusName: [self.model getStatusName: indexPath.row]
                               image: [self.model getStatusImage: indexPath.row]
                          background: [self.model getBackgroundColor: indexPath.row]
                          arrowState: NO];
    }
    
    else
        [cell fillCellWithStatusName: [self.model getStatusName: indexPath.row]
                               image: [self.model getStatusImage: indexPath.row]
                          background: [self.model getBackgroundColor: indexPath.row]
                          arrowState: YES];
    
    
    return cell;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return 6;
}

#pragma mark - TableViewDelegate methods -

- (void)        tableView: (UITableView*) tableView
  didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
     self.selectedCell = indexPath;
    
    
    if ([self.model getCurrentStatus] == TaskOnApprovingStatusType)
    {
        if (self.selectedCell.row == TaskOnCompletionStatusType)
        {
            NSLog(@"lol");
            if (self.dismissController)
                self.dismissController();
        }
    }
    
    
   

}


@end
