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

//#pragma mark - TableViewDelegate methods -
//
//- (void)        tableView: (UITableView*) tableView
//  didSelectRowAtIndexPath: (NSIndexPath*) indexPath
//{
//    
//}
//
//#pragma mark - TaskDetailCellDataSource methods -
//- (TaskStatusType) changeStatusType
//{
////  TaskStatusType selectedStatus = 
//}

@end
