//
//  CollectionCellFactory.h
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>


// Frameworks
@import UIKit;

// Classes
#import "TaskRowContent.h"
#import "CollectionCell.h"
#import "ParentCollectionCell.h"

@interface CollectionCellFactory : NSObject

// methods
- (UITableViewCell*) returnCollectionCellForTableView: (UITableView*) tableView
                                         withDelegate: (id<ParentCollectionCellDelegate>) delegate;

@end
