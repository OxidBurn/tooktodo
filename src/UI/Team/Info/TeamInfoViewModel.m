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

// Categories
#import "UISearchBar+TextFieldControl.h"

static CGFloat sectionHeaderHeight = 30;

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

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 1;
}

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
    
    return cell;
}

- (CGFloat)     tableView: (UITableView*) tableView
 heightForHeaderInSection: (NSInteger)    section
{
    return ([self.model isEnableFiltering] ? sectionHeaderHeight : 0);
}

- (UIView*)   tableView: (UITableView*) tableView
 viewForHeaderInSection: (NSInteger)    section
{
    if ( [self.model isEnableFiltering] )
    {
        UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, tableView.frame.size.width, sectionHeaderHeight)];
        
        label.backgroundColor = [UIColor colorWithRed: 0.90 green: 0.91 blue: 0.92 alpha: 1.00];
        label.textColor       = [UIColor colorWithRed:0.75 green:0.76 blue:0.78 alpha:1.00];
        label.textAlignment   = NSTextAlignmentCenter;
        label.font            = [UIFont fontWithName: @"SFUIText-Regular" size: 12];
        label.text            = [NSString stringWithFormat: @"Найдено %ld участников", (unsigned long)[self.model countOfItems]];
        
        return label;
    }
    
    return nil;
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


#pragma mark - Search bar delegate methods -

- (void) searchBar: (UISearchBar*) searchBar
     textDidChange: (NSString*)    searchText
{
    if ( [self.model isEnableFiltering] )
    {
        [self.model filteringWithKeyWord: searchText];
        
        if ( self.reloadTableView )
            self.reloadTableView();
    }
}

- (BOOL) searchBarShouldBeginEditing: (UISearchBar*) searchBar
{
    return ![self.model isEnableFiltering];
}

- (void) searchBarTextDidBeginEditing: (UISearchBar*) searchBar
{
    [self.model startFiltering];
    
    if ( self.reloadTableView )
        self.reloadTableView();
}

- (void) searchBarCancelButtonClicked: (UISearchBar*) searchBar
{
    if ( self.endFiltering )
        self.endFiltering();
}

- (void) searchBarTextDidEndEditing: (UISearchBar*) searchBar
{
    [self.model stopFiltering];
    
    if ( self.reloadTableView )
        self.reloadTableView();
}

@end
