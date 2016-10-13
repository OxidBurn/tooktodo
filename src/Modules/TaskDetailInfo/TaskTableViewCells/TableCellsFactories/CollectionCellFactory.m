//
//  CollectionCellFactory.m
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "CollectionCellFactory.h"

// Classes
#import "CollectionCell.h"

@implementation CollectionCellFactory

#pragma mark - Public -

- (UITableViewCell*) returnCellectionCellForTableView: (UITableView*) tableView
{
    CollectionCell* cell = [tableView dequeueReusableCellWithIdentifier: @"CollectionCellId"];
    
    return cell;
}


@end
