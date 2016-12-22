//
//  LogsChangeTermsFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 23.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogsChangeTermsFactory.h"

// Classes
#import "LogWithDetailCell.h"

@implementation LogsChangeTermsFactory


#pragma mark - Public -

- (UITableViewCell*) returnLogCellForTableView: (UITableView*)    tableView
                                   withContent: (TaskRowContent*) content
{
    LogWithDetailCell* cell = [tableView dequeueReusableCellWithIdentifier: @"LogChangedTermsCellId"];
    
    [cell fillLogCellWithText: content.logContent.logText
                     withDate: content.logContent.createdDate
               withUserAvatar: content.logAuthorAvatarSrs
                 withOldTerms: content.oldTerms
                 withNewTerms: content.newTermsValue];
    
    return cell;
}

@end
