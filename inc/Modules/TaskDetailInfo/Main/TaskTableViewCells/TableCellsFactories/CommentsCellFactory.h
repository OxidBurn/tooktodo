//
//  CommentsCellFactory.h
//  TookTODO
//
//  Created by Chaban Nikolay on 13.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

// Classes
#import "TaskRowContent.h"

@interface CommentsCellFactory : NSObject

// methods
- (UITableViewCell*) returnCommentsCellForTableView: (UITableView*)    tableView
                                        withContent: (TaskRowContent*) content
                                       withDelegate: (id)              delegate;

@end
