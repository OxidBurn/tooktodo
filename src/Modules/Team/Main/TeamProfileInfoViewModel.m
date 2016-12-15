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

typedef NS_ENUM(NSUInteger, CellType)
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

@property (nonatomic, strong) UITableViewCell* cell;

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
    
    if (indexPath.section == 0)
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
    else
    {
        NSInteger currentUserPermission = [self.model getCurrentUserPermission];
        
        self.cell = [tableView dequeueReusableCellWithIdentifier: @"RoleInfoCellID"];
        
        self.cell.textLabel.text  = [self.model getRoleInfoCellLabelTextForIndexPath: indexPath];
        
        UIFont* customFont = [UIFont fontWithName: @"SFUIText-Regular"
                                             size: 13.0f];
        [self.model reloadContent];
        
        self.cell.detailTextLabel.text = [self.model getDetailRoleCellLabelTextForIndexPath: indexPath];
        self.cell.detailTextLabel.textColor = [UIColor blackColor];
        self.cell.detailTextLabel.font = customFont;
        
        switch ( currentUserPermission )
        {
            case AdminPermission:
            {
                if ( indexPath.row == 0 )
                {
                    self.cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    
                    if ([self.model checkIfTeamMemberBlockedOrInvited] == YES)
                    {
                        self.cell.accessoryType = UITableViewCellAccessoryNone;
                        self.cell.userInteractionEnabled = NO;
                    }
                }
            }
                break;
                
            case OwnerPermission:
            {
                self.cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                if ([self.model checkIfTeamMemberBlockedOrInvited] == YES)
                {
                    self.cell.accessoryType = UITableViewCellAccessoryNone;
                    self.cell.userInteractionEnabled = NO;
                }
            }
                
            default:
                break;
        }

        
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
    self.cell = [tableView cellForRowAtIndexPath: indexPath];
    
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    if (indexPath.section == 1)
    {
        self.cell.tag = indexPath.row;
        
        if (self.cell.tag == RoleType)
        {
            NSString* segueID = IS_PHONE ? @"ShowRolesControllerIDiPhone" : @"ShowRoleControllerIDiPad";
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(showControllerWithIdentifier:)])
            {
                [self.delegate showControllerWithIdentifier: segueID];
            }
        }
        
        else
            if (self.cell.tag == PermissionType)
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

#pragma mark - Helpers -

- (void) designateAdmin
{
     if (self.delegate && [self.delegate respondsToSelector:@selector(showDesignationAlert:withAvatar:withMessage:)])
        {
            
            [self.delegate showDesignationAlert: [self.model getMemberName]
                                     withAvatar: [self.model getAvatar]
                                    withMessage: @"Назначить администратором"];
            
        }

}

- (void) cancelAdminPermission
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(showDesignationAlert:withAvatar:withMessage:)])
    {
        
        [self.delegate showDesignationAlert: [self.model getMemberName]
                                 withAvatar: [self.model getAvatar]
                                withMessage: @"Отменить права администратора"];
        
    }
}

#pragma mark - RolesViewControllerDelegate methods -

- (void) didSelectRole: (ProjectRoles*) value
        withCompletion: (CompletionWithSuccess) completion
{
    if ( value )
    {
        __weak typeof(self) blockSelf = self;
        
        [self.model updateMemberRole: value
                      withCompletion: ^(BOOL isSuccess) {
                          
                          blockSelf.cell.detailTextLabel.text = value.title;
                          
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

@end
