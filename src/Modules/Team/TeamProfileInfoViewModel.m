//
//  TeamProfileInfoViewModel.m
//  TookTODO
//
//  Created by Глеб on 06.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamProfileInfoViewModel.h"

// Frameworks
#import "ReactiveCocoa.h"

//Classes
#import "ContactInfoCell.h"
#import "TeamMember.h"
#import "DataManager+Team.h"
#import "Utils.h"
#import "TeamProfileInfoModel.h"

typedef NS_ENUM(NSUInteger, CellType)
{
    RoleType,
    PermissionType,
};

static NSString* RoleControllerSegueID = @"ShowRolesControllerID";

@interface TeamProfileInfoViewModel() 

@property (nonatomic, strong) TeamProfileInfoModel* model;

@property (nonatomic, strong) TeamMember* memberInfo;

@property (nonatomic, strong) UITableViewCell* cell;

@end

@implementation TeamProfileInfoViewModel


#pragma mark - Properties -

- (TeamProfileInfoModel *)model
{
    if ( _model == nil )
    {
        _model = [TeamProfileInfoModel new];
    }
    
    return _model;
}


#pragma mark - Public -

- (RACSignal*) updateInfo
{
    return [self.model updateUserInfo];
}

- (void)performActionForIndex:(NSUInteger)index
{
    [self.model performActionForIndex: index];
}


#pragma mark - TableView datasource methods -

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    
    if (indexPath.section == 0)
    {
        ContactInfoCell* cell = (ContactInfoCell*)[tableView dequeueReusableCellWithIdentifier: @"UserContactCellID"];
        
        [cell fillCellWithContactInfo: [self.model getContactValueForIndexPath: indexPath]
                         withBtnImage: [self.model getBtnImageForIndexPath: indexPath]
                         forIndexPath: indexPath];
        
        cell.tag = indexPath.row;
        
        return cell;
    }
    else
    {
        self.cell = [tableView dequeueReusableCellWithIdentifier: @"RoleInfoCellID"];
        
        self.cell.textLabel.text  = [self.model getRoleInfoCellLabelTextForIndexPath: indexPath];
        
        
        UIFont* customFont = [UIFont fontWithName: @"SFUIText-Regular"
                                             size: 13.0f];
        self.cell.detailTextLabel.textColor = [UIColor blackColor];
        self.cell.detailTextLabel.font = customFont;
        
        return self.cell;
    }
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    if (section == 0)
    {
        return [self.model countOfContactsContent];
    }
    
    else
        return 2;
}

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 2;
}


#pragma mark - TableView delegate methods -

- (CGFloat)     tableView: (UITableView*) tableView
 heightForHeaderInSection: (NSInteger)    section
{
    if (section == 0)
    {
        return 0;
    }
    
    else return 10.f;
}

- (void)        tableView: (UITableView*) tableView
  didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    self.cell = [tableView cellForRowAtIndexPath: indexPath];
    
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    if (indexPath.section == 1)
    {
        self.cell.tag = indexPath.row;
        if (self.cell.tag == RoleType)
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(showControllerWithIdentifier:)])
            {
                [self.delegate showControllerWithIdentifier: RoleControllerSegueID];
            }
        }
        
        else
            if (self.cell.tag == PermissionType)
            {
                if (self.delegate && [self.delegate respondsToSelector:@selector(showDesignationAlert:)])
                {
                    [self.delegate showDesignationAlert: [self.model getMemberName]];
                }
            }
    }
    
}


#pragma mark - RolesViewControllerDelegate methods -

- (void) didSelectRole: (ProjectRoles*) value
{
    self.cell.detailTextLabel.text = value.title;
}
@end
