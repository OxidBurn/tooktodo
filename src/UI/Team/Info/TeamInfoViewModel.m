//
//  TeamInfoViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/3/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamInfoViewModel.h"

// Classes
#import "TeamInfoModel.h"
#import "TeamMember.h"
#import "TeamInfoTableViewCell.h"

@interface TeamInfoViewModel()

// properties
@property (strong, nonatomic) TeamInfoModel* model;

// methods


@end

@implementation TeamInfoViewModel

#pragma mark - Properties -

- (TeamInfoModel*) model
{
    if ( _model == nil )
    {
        _model = [[TeamInfoModel alloc] init];
    }
    
    return _model;
}


#pragma mark - Public methods -

- (void) updateInfoWithCompletion: (CompletionWithSuccess) completion
{
    [self.model updateTeamInfoWithCompletion: completion];
}


#pragma mark - Table view data source methods -

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model countOfItems];
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    TeamInfoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"UserCellID"];
    
    TeamMember* memberInfo = [self.model teamMemberByIndex: indexPath.row];
    
    [cell fillCellWithInfo: memberInfo
              forIndexPath: indexPath];
    
    NSLog(@"Member info: %@", memberInfo.firstName);
    
    return cell;
}

@end
