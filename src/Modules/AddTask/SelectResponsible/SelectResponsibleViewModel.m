//
//  SelectResponsibleViewModel.m
//  TookTODO
//
//  Created by Глеб on 22.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectResponsibleViewModel.h"

// Classes
#import "OSUserInfoWithCheckmarkCell.h"
#import "FilledTeamInfo.h"


@interface SelectResponsibleViewModel()

// properties
@property (strong, nonatomic) SelectResponsibleModel* model;

// methods


@end

@implementation SelectResponsibleViewModel

#pragma mark - Properties -

- (SelectResponsibleModel*) model
{
    if ( _model == nil )
    {
        _model = [SelectResponsibleModel new];
    }
    
    return _model;
}

#pragma mark - UITableViewDataSourse methods -

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 1;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model getNumberOfRows];
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    OSUserInfoWithCheckmarkCell* cell = [tableView dequeueReusableCellWithIdentifier: @"UserInfoWithCheckmarkID"];
    
    [cell fillCellWithFilledMemberInfo: [self.model returnFilledUserInfoForIndex: indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods -

- (void)      tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    [self.model handleCheckmarkForIndexPath: indexPath];
    
    OSUserInfoWithCheckmarkCell* cell = [tableView cellForRowAtIndexPath: indexPath];
    
    [cell changeCheckmarkState: [self.model getStateForMemberAtIndex: indexPath.row]];

}

#pragma mark - Public -

- (void) updateInfoWithCompletion: (CompletionWithSuccess) completion
{
    [self.model updateTeamInfoWithCompletion: completion];
}

- (void) fillContollerMarkOption: (MarkOption) controllerMarkOption
{
    [self.model fillContollerMarkOption: controllerMarkOption];
}

@end
