//
//  FilterSubtaskCellFactory.m
//  TookTODO
//
//  Created by Chaban Nikolay on 12.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterSubtaskCellFactory.h"

// Classes
#import "FilterSubtasksCell.h"

@implementation FilterSubtaskCellFactory

#pragma mark - Public -

- (UITableViewCell*) returnFilterSubtasksCellForTableView: (UITableView*) tableView
{
    FilterSubtasksCell* cell = [tableView dequeueReusableCellWithIdentifier: @"FilterSubtaskCellId"];
    
    return cell;
}

@end
