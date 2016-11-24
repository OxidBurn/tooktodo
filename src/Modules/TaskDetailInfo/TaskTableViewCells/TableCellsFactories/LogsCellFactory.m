//
//  LogsCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 23.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogsCellFactory.h"

// Classes
#import "LogCell.h"

@implementation LogsCellFactory

#pragma mark - Public -

- (UITableViewCell*) returnLogCellForTableView: (UITableView*)    tableView
                                   withContent: (TaskRowContent*) content
{
    LogCell* cell = [tableView dequeueReusableCellWithIdentifier: @"LogDefaultCellId"];
    
    [cell fillLogCellWithText: content.logText
                     withDate: content.logDateInString
               withUserAvatar: content.logAuthorAvatarSrs];
    
    return cell;
}

@end
