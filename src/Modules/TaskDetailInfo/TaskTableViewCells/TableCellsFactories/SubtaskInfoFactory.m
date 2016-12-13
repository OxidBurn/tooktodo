//
//  SubtaskInfoFactory.m
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SubtaskInfoFactory.h"

// Classes
#import "SubtaskInfoCell.h"

@implementation SubtaskInfoFactory

#pragma mark - Public -

- (UITableViewCell*) returnSubtaskInfoCellForTableView: (UITableView*)    tableView
                                           withContent: (TaskRowContent*) content
{
    SubtaskInfoCell* cell = [tableView dequeueReusableCellWithIdentifier: @"SubtaskInfoCellId"];
    
    [cell fillCellWithContent: content];
    
    return cell;
}

@end
