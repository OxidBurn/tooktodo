//
//  FilterByTermsCellFactory.h
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

@interface FilterByTermsCellFactory : NSObject

// methods

- (UITableViewCell*) returnFilterByTermsCellWithTitle: (NSString*)    title
                                           withDetail: (NSString*)    detail
                                         forTableView: (UITableView*) tableView;

@end
