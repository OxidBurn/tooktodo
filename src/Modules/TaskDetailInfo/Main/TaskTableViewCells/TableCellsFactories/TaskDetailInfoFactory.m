//
//  TaskDetailInfoFactory.m
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskDetailInfoFactory.h"

// Classes
#import "TaskDetailInfoCell.h"

@implementation TaskDetailInfoFactory

#pragma mark - Public -

- (UITableViewCell*) returnTaskDetailCellWithContent: (TaskRowContent*) content
                                        forTableView: (UITableView*)    tableView
{
    TaskDetailInfoCell* cell = (TaskDetailInfoCell*)[tableView dequeueReusableCellWithIdentifier: content.cellId];
    
    [cell fillCellWithContent: content];
    
    return cell;
}


@end
