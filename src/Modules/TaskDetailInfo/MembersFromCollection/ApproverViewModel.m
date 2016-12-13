//
//  ApproverViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 25.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ApproverViewModel.h"

//Classes
#import "ApproverModel.h"
#import "ApproverTableViewCell.h"

@interface ApproverViewModel() 

// properties
@property (nonatomic, strong) ApproverModel* model;

// methods

@end

@implementation ApproverViewModel


#pragma mark - Properties -

- (ApproverModel*) model
{
    if (_model == nil)
    {
        _model = [ApproverModel new];
    }
    
    return _model;
}


#pragma mark - Public -


#pragma mark - UITableView datasourse methods -

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    ApproverTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"approverCellID"];
    
    [cell fillCellWithApproverUser: [self.model getApproverUserForIndexPath: indexPath.row] withApprovedCheckmarkState: [self.model isApprovedAssignee: indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model countOfRows];
}

#pragma mark - UITableView delegate methods -


@end
