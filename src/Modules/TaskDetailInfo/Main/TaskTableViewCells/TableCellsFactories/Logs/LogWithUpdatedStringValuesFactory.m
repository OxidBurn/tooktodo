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
    static NSString* cellId = @"TaskLogWithUpdatedStringsId";
    
    static NSString* nibName = @"TaskLogWithUpdatedStrings";
    
    LogWithUpdatedStringValuesCell* cell = [tableView dequeueReusableCellWithIdentifier: cellId];
    
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
