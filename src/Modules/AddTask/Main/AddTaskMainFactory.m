//
//  AddTaskMainFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 14.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskMainFactory.h"

// Classes
#import "ProjectsEnumerations.h"
#import "FilledTeamInfo.h"

// Factories
#import "OSRightDetailCellFactory.h"
#import "OSMarkedRightDetailCellFactory.h"
#import "OSSingleUserInfoCellFactory.h"
#import "OSGroupOfUsersInfoCellFactory.h"
#import "OSSwitchTableCellFactory.h"
#import "OSFlexibleTextCellFactory.h"
#import "OSFlexibleTextFieldCellFactory.h"
#import "OSSwitchTableCell.h"

@interface AddTaskMainFactory()

// properties


// methods


@end

@implementation AddTaskMainFactory


#pragma mark - Public -

- (UITableViewCell*) createCellForTableView: (UITableView*) tableView
                                withContent: (RowContent*)  content
                               withDelegate: (id)           delegate
{
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    
    NSUInteger cellTypeIndex = content.cellIndex;
    
    switch ( cellTypeIndex )
    {
        case FlexibleTextFieldCell:
        {
            OSFlexibleTextFieldCellFactory* factory = [OSFlexibleTextFieldCellFactory new];
            
            cell = [factory returnFlexibleTextFieldCellWithTextContent: content.title
                                                          forTableView: tableView
                                                          withDelegate: delegate];
        }
            break;
            
        case RightDetailCell:
        {
            OSRightDetailCellFactory* factory = [OSRightDetailCellFactory new];
            
            cell = [factory returnRightDetailCellWithTitle: content.title
                                            withDetailText: content.detail
                                        withSelectedDetail: YES
                                              forTableView: tableView];
            
        }
            break;
            
        case FlexibleCell:
        {
            OSFlexibleTextCellFactory* factory = [OSFlexibleTextCellFactory new];
            
            cell = [factory returnFlexibleCellWithTextContent: content.title
                                                 forTableView: tableView];
            
            
        }
            break;
            
        case SwitchCell:
        {
            OSSwitchTableCellFactory* factory = [OSSwitchTableCellFactory new];
            
            BOOL stateBoolValue = content.isHidden;
            
            cell = [factory returnSwitchCellWithTitle: content.title
                                              withTag: AddTaskIsHiddenTaskSwitchTag
                                      withSwitchState: stateBoolValue
                                         forTableView: tableView
                                         withDelegate: self
                                     withEnabledState: content.isSwitchEnabled];
        }
            break;
            
        case SingleUserInfoCell:
        {
            OSSingleUserInfoCellFactory* factory = [OSSingleUserInfoCellFactory new];
            
            id user = content.membersArray[0];
            NSString* userFullName = @"";
            NSString* userAvatarSrc = @"";
            
            if ([user isKindOfClass:[ProjectTaskAssignee class]])
            {
                ProjectTaskAssignee* assignee = (ProjectTaskAssignee*) user;
                
                userFullName  = [NSString stringWithFormat: @"%@ %@", assignee.firstName, assignee.lastName];
                
                userAvatarSrc = assignee.avatarSrc;
            }
            
            else if ([user isKindOfClass:[ProjectInviteInfo class]])

            {
                ProjectInviteInfo* invite = (ProjectInviteInfo*) user;

                userFullName  = [NSString stringWithFormat: @"%@ %@", invite.firstName, invite.lastName];
            }
           
            
            cell = [factory returnSingleUserCellWithTitle: content.title
                                         withUserFullName: userFullName
                                           withUserAvatar: userAvatarSrc
                                             forTableView: tableView];
        }
            break;
            
        case GroupOfUsersCell:
        {
            OSGroupOfUsersInfoCellFactory* factory = [OSGroupOfUsersInfoCellFactory new];
            
            cell = [factory returnGroupOfUsersCellWithTitle: content.title
                                             withUsersArray: content.membersArray
                                               forTableView: tableView];
            
        }
            break;
            
        case MarkedRightDetailCell:
        {
            OSMarkedRightDetailCellFactory* factory = [OSMarkedRightDetailCellFactory new];
            
            cell = [factory returnMarkedRightDetailCellWithTitle: content.title
                                                  withDetailText: content.detail
                                                   withMarkImage: content.markImage
                                                    forTableView: tableView];
        }
            break;
            
        default:
            break;
    }
    
    if (content.userInteractionEnabled == NO)
    {
        cell.userInteractionEnabled = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    
    return cell;
}


@end
