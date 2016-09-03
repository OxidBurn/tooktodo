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

@interface TeamInfoViewModel() <TeamInfoModelDelegate, TeamInfoTableViewCellDelegate>

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
        
        _model.delegate = self;
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
    
    cell.delegate = self;
    
    [cell fillCellWithInfo: memberInfo
              forIndexPath: indexPath];
    
    NSLog(@"Member info: %@", memberInfo.firstName);
    NSLog(@"Phone number: %@", memberInfo.phoneNumber);
    
    return cell;
}


#pragma mark - Table view delegate methods -

- (void)       tableView: (UITableView*) tableView
 didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [self.model markItemAsSelectedAtIndex: indexPath.row];
}


#pragma mark - TeamCellDelegate methods -

- (void) didTriggerCallActionAtIndex: (NSUInteger) index
{
    [self.model handleCallForUserAtIndex: index];
}

- (void) didTriggerEmailActionIndex: (NSUInteger) index
{
    NSString* email = [self.model getEmailOfMemberAtIndex: index];
    
    if ([self.delegate respondsToSelector: @selector(showEmailComposerForMail:)])
    {
        [self.delegate showEmailComposerForMail: email];
    }
}

#pragma mark - TeamModelDelegate methods -

- (void) returnPhoneNumbers: (NSString*) mainNumber
                       with: (NSString*) additionNumber
{
    if ( [self.delegate respondsToSelector: @selector(createActionSheetWithMainNumber:andAdditionNumber:)] )
    {
        [self.delegate createActionSheetWithMainNumber: mainNumber
                                     andAdditionNumber: additionNumber];
    }
}

@end
