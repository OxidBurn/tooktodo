//
//  FilterByTermsCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByTermsCellFactory.h"

@implementation FilterByTermsCellFactory


#pragma mark - Public -

- (UITableViewCell*) returnFilterByTermsCellWithContent: (TaskFilterRowContent*) rowContent
                                           forTableView: (UITableView*)          tableView
                                           withDelegate: (id)                    delegate
{
    FilterByTermsCell* cell = [tableView dequeueReusableCellWithIdentifier: @"FilterByTermsCellID"];
    
    [cell fillCellWithWithContent: rowContent
                     forTableView: tableView
                     withDelegate: delegate];
    
    return cell;
}


@end
