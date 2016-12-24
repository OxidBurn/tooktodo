//
//  LogWithMarkCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 24.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogWithMarkCellFactory.h"

// Classes
#import "LogWithMarkCell.h"

@implementation LogWithMarkCellFactory


#pragma mark - Public -


- (UITableViewCell*) returnLogCellForTableView: (UITableView*)    tableView
                                   withContent: (TaskRowContent*) content
{
    static NSString* cellId = @"TaskLogMarkCellId";
    
    static NSString* nibName = @"TaskLogMarkCell";
    
    LogWithMarkCell* cell = [tableView dequeueReusableCellWithIdentifier: cellId];
    
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
