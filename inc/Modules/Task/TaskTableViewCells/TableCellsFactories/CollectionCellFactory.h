//
//  CollectionCellFactory.h
//  TookTODO
//
//  Created by Глеб on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>


// Frameworks
@import UIKit;

// Classes
#import "TaskRowContent.h"

@interface CollectionCellFactory : NSObject

// methods
- (UITableViewCell*) returnCellectionCellForTableView: (UITableView*) tableView;

@end
