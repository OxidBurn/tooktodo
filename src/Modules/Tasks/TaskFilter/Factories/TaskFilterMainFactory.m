//
//  TaskFilterMainFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskFilterMainFactory.h"

// Classes
#import "ProjectsEnumerations.h"
#import "ProjectTaskAssignee+CoreDataProperties.h"

// Factories
#import "OSRightDetailCellFactory.h"
#import "OSSingleUserInfoCellFactory.h"
#import "OSSwitchTableCellFactory.h"
#import "FilterByTermsCellFactory.h"
#import "CustomExpandedIconCellFactory.h"
#import "OSGroupOfUsersInfoCellFactory.h"

@implementation TaskFilterMainFactory

#pragma mark - Public -

- (UITableViewCell*) createCellForTableView: (UITableView*)           tableView
                             withRowContent: (TaskFilterRowContent*)  content
                               withDelegate: (id)                     delegate
{
    NSUInteger cellTypeId = content.cellTypeId;
    
    UITableViewCell* cell = [UITableViewCell new];
    
    switch ( cellTypeId )
    {
        case TaskFilterRightDetailCell:
        {
            OSRightDetailCellFactory* factory = [OSRightDetailCellFactory new];
            
            cell = [factory returnRightDetailCellWithTitle: content.title
                                            withDetailText: content.detail
                                        withSelectedDetail: content.detailIsSelected
                                              forTableView: tableView];
        }
            break;
            
        case TaskFilterSwitchCell:
        {
            OSSwitchTableCellFactory* factory = [OSSwitchTableCellFactory new];
            
            cell = [factory returnSwitchCellWithTitle: content.title
                                              withTag: content.switchControllTag
                                      withSwitchState: content.isOn
                                         forTableView: tableView
                                         withDelegate: delegate
                                     withEnabledState: YES];
        }
            break;
            
        case TaskFilterSingleUserCell:
        {
            OSSingleUserInfoCellFactory* factory = [OSSingleUserInfoCellFactory new];
            
            ProjectTaskAssignee* assignee = content.selectedUsers.firstObject;
            
            NSString* userFullName = @"";
            NSString* urlString    = @"";
            
            if ( [assignee isKindOfClass: [ProjectTaskAssignee class]] )
            {
                userFullName = assignee.displayName;
                
                urlString = assignee.avatarSrc;
                
                if ( [assignee.avatarSrc containsString: @"http://api.taketowork.com"] == NO )
                {
                    urlString = [NSString stringWithFormat: @"http://api.taketowork.com%@", assignee.avatarSrc];
                }
            }
            else
            {
                userFullName = [NSString stringWithFormat: @"%@ %@", assignee.firstName, assignee.lastName];
            }
            
            
            cell = [factory returnSingleUserCellWithTitle: content.title
                                         withUserFullName: userFullName
                                           withUserAvatar: urlString
                                             forTableView: tableView];
        }
            break;
            
        case TaskFilterGroupOfUsersCell:
        {
            OSGroupOfUsersInfoCellFactory* factory = [OSGroupOfUsersInfoCellFactory new];
            
            cell = [factory returnGroupAssigneesCellWithTitle: content.title
                                               withUsersArray: content.selectedUsers
                                                 forTableView: tableView];
        }
            break;
            
        case TaskFilterFilterByTermsCell:
        {
            FilterByTermsCellFactory* factory = [FilterByTermsCellFactory new];
            
            cell = [factory returnFilterByTermsCellWithContent: content
                                                  forTableView: tableView
                                                  withDelegate: delegate];
        }
            break;
            
        case TaskFilterCustomDisclosureCell:
        {
             CustomExpandedIconCellFactory* factory = [CustomExpandedIconCellFactory new];
            
            cell = [factory returnRightDetailCellWithTitle: content.title
                                            withDetailText: content.detail
                                              forTableView: tableView];
        }
            break;
            
        default:
            break;
    }
        
    return cell;
}

@end
