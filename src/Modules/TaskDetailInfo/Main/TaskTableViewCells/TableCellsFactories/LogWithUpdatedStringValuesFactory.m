//
//  LogWithUpdatedStringValuesFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 23.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogWithUpdatedStringValuesFactory.h"

// Classes
#import "LogWithUpdatedStringValuesCell.h"

@implementation LogWithUpdatedStringValuesFactory


#pragma mark - Public -

- (UITableViewCell*) returnLogCellForTableView: (UITableView*)    tableView
                                   withContent: (TaskRowContent*) content
{
    static NSString* cellId = @"TaskLogWithUpdatedStringsCellId";
    
    LogWithUpdatedStringValuesCell* cell = [tableView dequeueReusableCellWithIdentifier: cellId];
    
    if ( cell == nil )
    {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed: @"TaskLogWithUpdatedStrings"
                                                     owner: tableView
                                                   options: nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell fillLogCellWithText: content.logContent.logText
                     withDate: content.logContent.createdDate
               withUserAvatar: content.logAuthorAvatarSrs
                 withOldTerms: content.oldTerms
                 withNewTerms: content.newTermsValue];
    
    return cell;
}

@end
