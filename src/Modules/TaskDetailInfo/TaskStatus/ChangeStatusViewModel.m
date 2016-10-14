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
@property (strong, nonatomic) NSIndexPath* selectedCellPath;

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
    self.selectedCellPath = [NSIndexPath indexPathForRow: status
                                           inSection: 0];
}

- (TaskStatusType) getCurrentStatusType
{
    return [self.model getCurrentStatus];
}

- (void) getChangedInfo: (GetChangedStatusBlock) completion
{
//    NSString* statusName  = [self.model getStatusName: self.selectedCell.row];
//    UIColor*  background  = [self.model getBackgroundColor: self.selectedCell.row];
//    UIImage*  statusImage = [self.model getStatusImage: self.selectedCell.row];
//    
//    if (completion) {
//        completion(statusName, self.selectedCell.row, background, statusImage);
//    }
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
        [cell fillCellWithStatusName: [self.model getStatusNameForIndex: indexPath.row]
                               image: [self.model getStatusImageForIndex: indexPath.row]
                          background: [self.model getBackgroundColorForIndex: indexPath.row]
                          arrowState: NO];
        
    }
    
    else
        [cell fillCellWithStatusName: [self.model getStatusNameForIndex: indexPath.row]
                               image: [self.model getStatusImageForIndex: indexPath.row]
                          background: [self.model getBackgroundColorForIndex: indexPath.row]
                          arrowState: YES];

    
    
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
    
     self.selectedCellPath = indexPath;
    
    if ([self.model getCurrentStatus] == TaskOnApprovingStatusType)
    {
        if (self.selectedCellPath.row == [self.model returnOnComletionStatusIndex])
        {
            if (self.dismissController)
                self.dismissController();
        }
    }
    
}

@end
