//
//  TaskDescriptionFactory.m
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskDescriptionFactory.h"

// Classes
#import "TaskDescriptionCell.h"

@implementation TaskDescriptionFactory

#pragma mark - Public -

- (UITableViewCell*) returnDescriptionCellWithContent: (TaskRowContent*) content
                                         forTableView: (UITableView*)    tableView
{
    TaskDescriptionCell* cell = [tableView dequeueReusableCellWithIdentifier: content.cellId];
    
    [cell fillCellWithContent: content];
    
    return cell;
}


@end
