//
//  TaskOptionsFactory.m
//  TookTODO
//
//  Created by Глеб on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskOptionsFactory.h"

// Classes
#import "TaskOptionsCell.h"

@implementation TaskOptionsFactory

#pragma mark - Public -

- (UITableViewCell*) returnTaskOptionsCellForContent: (TaskRowContent*) content
                                        forTableView: (UITableView*)    tableView
{
    TaskOptionsCell* cell = [tableView dequeueReusableCellWithIdentifier: content.cellId];
    
    return cell;
}


@end
