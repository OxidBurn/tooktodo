//
//  LogWithAssigneeCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 22.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogWithAssigneeCellFactory.h"

// Classes
#import "LogWithAssigneeCell.h"

@implementation LogWithAssigneeCellFactory


#pragma mark - Public -

- (UITableViewCell*) returnLogCellForTableView: (UITableView*)    tableView
                                   withContent: (TaskRowContent*) content
{
    static NSString* cellId = @"TaskLogWithAssigneeCellId";
    
    static NSString* nibName = @"TaskLogWithAssigneeCell";
    
    LogWithAssigneeCell* cell = [tableView dequeueReusableCellWithIdentifier: cellId];
    
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
