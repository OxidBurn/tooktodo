//
//  FilterAttachmentsCellFactory.h
//  TookTODO
//
//  Created by Chaban Nikolay on 12.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

// Classes
#import "TaskRowContent.h"

@interface FilterAttachmentsCellFactory : NSObject

// methods
- (UITableViewCell*) returnFilterAttachmentsCellForTableView: (UITableView*) tableView;

@end
