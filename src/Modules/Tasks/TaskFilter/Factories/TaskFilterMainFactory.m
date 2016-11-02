//
//  TaskFilterMainFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskFilterMainFactory.h"

// Classes

// Factories
#import "OSRightDetailCellFactory.h"
#import "OSSingleUserInfoCell.h"
#import "OSSwitchTableCellFactory.h"
#import "FilterSubtaskCellFactory.h"
#import "CustomExpandedIconCellFactory.h"

@implementation TaskFilterMainFactory

#pragma mark - Public -

- (UITableViewCell*) createCellForTableView: (UITableView*) tableView
                             withRowContent: (RowContent*)  content
{
    UITableViewCell* cell = [UITableViewCell new];
    
    return cell;
}

@end
