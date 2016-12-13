//
//  CollectionCellFactory.m
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "CollectionCellFactory.h"



@implementation CollectionCellFactory

#pragma mark - Public -

- (UITableViewCell*) returnCollectionCellForTableView: (UITableView*) tableView
                                         withDelegate: (id<ParentCollectionCellDelegate>) delegate
{
    CollectionCell* cell = [tableView dequeueReusableCellWithIdentifier: @"CollectionCellId"];
    
    [cell fillParentCollectionCellDelegate: delegate];
    
    return cell;
}

@end
