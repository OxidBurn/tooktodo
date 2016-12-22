//
//  LogsChangeStatusFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 23.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogsChangeStatusFactory.h"

// Classes
#import "LogWithAcitonCell.h"

@implementation LogsChangeStatusFactory

#pragma mark - Public -

- (UITableViewCell*) returnLogCellForTableView: (UITableView*)    tableView
                                   withContent: (TaskRowContent*) content
{
    LogWithAcitonCell* cell = [tableView dequeueReusableCellWithIdentifier: @"LogChangedTaskStatusCellId"];
    
    [cell fillLogCellWithText: content.logContent.logText
                     withDate: content.logContent.createdDate
               withUserAvatar: content.logContent.avatarSrs
                withOldStatus: content.oldStatusValue
                withNewStatus: content.newStatusValue];
    
    return cell;
}

@end
