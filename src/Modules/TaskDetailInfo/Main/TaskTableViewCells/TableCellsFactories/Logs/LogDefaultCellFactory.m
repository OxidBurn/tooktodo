//
//  LogDefaultCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 23.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogDefaultCellFactory.h"

// Classes
#import "LogDefaultCell.h"

@implementation LogDefaultCellFactory

#pragma mark - Public -

- (UITableViewCell*) returnLogCellForTableView: (UITableView*)    tableView
                                   withContent: (TaskRowContent*) content
{
    static NSString* cellId = @"TaskLogDefaultCellId";
    
    static NSString* nibName = @"TaskLogDefaultCell";
    
    LogDefaultCell* cell = [tableView dequeueReusableCellWithIdentifier: cellId];
    
    if ( cell == nil )
    {
        [tableView registerNib: [UINib nibWithNibName: nibName
                                               bundle: nil]
        forCellReuseIdentifier: cellId];
        
        cell = [tableView dequeueReusableCellWithIdentifier: cellId];
    }
    
    [cell fillLogCellWithContent: content.logContent];
    
    return cell;
}

@end
