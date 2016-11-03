//
//  FilterByTermsCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByTermsCellFactory.h"

// Classes
#import "FilterByTermsCell.h"

@implementation FilterByTermsCellFactory


#pragma mark - Public -

- (UITableViewCell*) returnFilterByTermsCellWithTitle: (NSString*)    title
                                           withDetail: (NSString*)    detail
                                         forTableView: (UITableView*) tableView
{
    FilterByTermsCell* cell = [tableView dequeueReusableCellWithIdentifier: @"FilterByTermsCellID"];
    
    [cell fillCellWithTitle: title
                 withDetail: detail];
    
    return cell;
}


@end
