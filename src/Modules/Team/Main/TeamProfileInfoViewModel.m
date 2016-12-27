//
//  TeamProfileInfoViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 06.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamProfileInfoViewModel.h"

// Frameworks
#import "ReactiveCocoa.h"

//Classes
#import "ContactInfoCell.h"
#import "TeamMember+CoreDataProperties.h"
#import "DataManager+Team.h"
#import "Utils.h"
#import "TeamProfileInfoModel.h"
#import <SVProgressHUD.h>
#import "ProjectsEnumerations.h"


// Categories
#import "DataManager+ProjectInfo.h"

typedef NS_ENUM(NSUInteger, SecondSectionCellType)
{
    RoleType,
    PermissionType,
};

typedef NS_ENUM(NSUInteger, ButtonOnAlertType)
{
    Cancel,
    Ready,
};



@interface TeamProfileInfoViewModel() <TeamProfileInfoModelDelegate>

@property (nonatomic, strong) TeamProfileInfoModel* model;

@end

@implementation TeamProfileInfoViewModel


#pragma mark - Properties -

- (TeamProfileInfoModel*) model
{
    if ( _model == nil )
    {
        _model = [[TeamProfileInfoModel alloc] init];
        
        _model.delegate = self;
    }
    
    return _model;
}


#pragma mark - Public -

- (NSString*) getProjectName
{
    return [DataManagerShared getSelectedProjectName];;
}

- (RACSignal*) updateInfo
{
    return [self.model updateUserInfo];

}

- (void) performActionForIndex: (NSUInteger) index
{
    [self.model performActionForIndex: index];
}

- (void) fillSelectedTeamMember: (FilledTeamInfo*) teamMember
{
    [self.model fillSelectedTeamMember: teamMember];
}

- (NSString*) getRoleTitle
{
    return [self.model getRole];
}

#pragma mark - TableView datasource methods -

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    switch ( indexPath.section)
    {
        case SectionOne:
        {
            ContactInfoCell* cell = (ContactInfoCell*)[tableView dequeueReusableCellWithIdentifier: @"UserContactCellID"];
            
            [cell fillCellWithContactInfo: [self.model getContactValueForIndexPath: indexPath]
                             withBtnImage: [self.model getBtnImageForIndexPath: indexPath]
                             forIndexPath: indexPath];
            
            cell.tag = indexPath.row;
            
            __weak typeof(self) blockSelf = self;
            
            cell.didPressOnPhone = ^(NSUInteger index){
                
                [blockSelf performActionForIndex: index];
            };
            
            return cell;
        }
            break;
            
        case SectionTwo:
        {
            NSInteger currentUserPermission = [self.model getCurrentUserPermission];
            
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"RoleInfoCellID"];
            
            UIFont* customFont = [UIFont fontWithName: @"SFUIText-Regular"
                                                 size: 13.0f];

            switch ( indexPath.row)
            {
                case RoleType:
                {
                    cell.textLabel.text = [self.model getRoleInfoCellLabelTextForIndexPath: indexPath];
                    cell.tag = RoleType;
                }
                    break;
                case PermissionType:
                {
                    cell.textLabel.text = [self.model getRoleInfoCellLabelTextForIndexPath: indexPath];
                    cell.tag = PermissionType;
                }
                    break;
                    
                default:
                    break;
            }
            cell.detailTextLabel.text      = [self.model getDetailRoleCellLabelTextForIndexPath: indexPath];
            cell.detailTextLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.font      = customFont;
            
            [self handlePermissionActionsForCell: cell
                                  withPermission: currentUserPermission
                                   withIndexPath: indexPath];
            
          return cell;
        }
            break;
            
        default:
            return nil;
            break;
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
        return [self.model secondSectionRowCount];
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
    UITableViewCell* cell = [tableView cellForRowAtIndexPath: indexPath];
    
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    if ( indexPath.section == SectionTwo )
    {
        if ( cell.tag == RoleType )
        {
            NSString* segueID = IS_PHONE ? @"ShowRolesControllerIDiPhone" : @"ShowRoleControllerIDiPad";
            
            if ( [self.delegate respondsToSelector:@selector(showControllerWithIdentifier:)] )
                [self.delegate showControllerWithIdentifier: segueID];
        }
        
        else
            if ( cell.tag == PermissionType)
            {
                if ([self.model getPermissions].integerValue != AdminPermission)
                {
                    [self designateAdmin];
                }
                else
                {
                    [self cancelAdminPermission];
                }
            }
    }
}
    


- (NSIndexPath*) tableView: (UITableView*) tableView
  willSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    if ( [self.model getCurrentUserPermission] == Participant )
    {
        
        if ( indexPath.section == 1 )
        {
            
            tableView.allowsSelection = NO;
            
            return nil;
        }
        
    }
    return indexPath;
}


#pragma mark - RolesViewControllerDelegate methods -

- (void) didSelectRole: (ProjectRoles*)         value
        withCompletion: (CompletionWithSuccess) completion
{
    if ( value )
    {
        __weak typeof(self) blockSelf = self;
        
        [self.model updateMemberRole: value
                      withCompletion: ^(BOOL isSuccess) {
                          
                          [blockSelf.model reloadContent];
                          
                          if ( blockSelf.reloadTableView )
                              blockSelf.reloadTableView();
                          
                          if (blockSelf.dismissViewController)
                              blockSelf.dismissViewController();
                          
                          if (completion)
                              completion(YES);
                          
                      }];
    }
    
    else
    {
        [Utils showErrorAlertWithMessage: @"Роль не выбрана"];
    }
}


#pragma mark - Model delegate methods -

- (void) sendEmailToAdress: (NSString*) email
{
    if ( [self.delegate respondsToSelector: @selector(showEmailComposerForMail:)] )
    {
        [self.delegate showEmailComposerForMail: email];
    }
}


#pragma mark - Alert view protocol methods -

- (void) didDoneAlertAction
{
    NSInteger currentPermission = [self.model getPermissions].integerValue;
    
    switch (currentPermission)
    {
        case AdminPermission:
        {
            [self.model updateMemberPermission: ParticipantPermission];
            
            if (self.reloadTableView)
                self.reloadTableView();
        }
            break;
            
        case ParticipantPermission:
        {
            [self.model updateMemberPermission: AdminPermission];
            
            if (self.reloadTableView)
                self.reloadTableView();
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - Helpers -

- (void) designateAdmin
{
     if (self.delegate && [self.delegate respondsToSelector:@selector(showDesignationAlert:withAvatar:withMessage:)])
        {
            
            [self.delegate showDesignationAlert: [self.model getMemberName]
                                     withAvatar: [self.model getAvatar]
                                    withMessage: @"Назначить администратором"];
            
            [self.model reloadContent];
        }

}

- (void) cancelAdminPermission
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(showDesignationAlert:withAvatar:withMessage:)])
    {
        
        [self.delegate showDesignationAlert: [self.model getMemberName]
                                 withAvatar: [self.model getAvatar]
                                withMessage: @"Отменить права администратора"];
        
        [self.model reloadContent];
    }
}

- (void) handlePermissionActionsForCell: (UITableViewCell*) cell
                         withPermission: (NSUInteger)       permission
                          withIndexPath: (NSIndexPath*)     indexPath
{
    switch ( permission )
    {
        case AdminPermission:
        {
            if ( indexPath.row == RoleType )
            {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                if ([self.model checkIfTeamMemberBlockedOrInvited] == YES)
                {
                    cell.accessoryType          = UITableViewCellAccessoryNone;
                    cell.userInteractionEnabled = NO;
                }
            }
            
            else if ( indexPath.row == PermissionType )
            {
                cell.accessoryType          = UITableViewCellAccessoryNone;
                cell.userInteractionEnabled = NO;
            }
        }
            break;
            
        case OwnerPermission:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            if ( [self.model checkIfTeamMemberBlockedOrInvited] == YES )
            {
                cell.accessoryType          = UITableViewCellAccessoryNone;
                cell.userInteractionEnabled = NO;
            }
        }
        default:
            break;
    }

}

@end
