//
//  TaskDetailInfoFactory.m
//  TookTODO
//
//  Created by Глеб on 05.10.16.
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
    TaskDetailInfoCell* cell = [tableView dequeueReusableCellWithIdentifier: content.cellId];
    
    return cell;
}


@end
