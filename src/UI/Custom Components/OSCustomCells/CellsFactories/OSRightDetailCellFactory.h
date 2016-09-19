//
//  OSRightDetailCellFactory.h
//  TookTODO
//
//  Created by Nikolay Chaban on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

@interface OSRightDetailCellFactory : NSObject

// methods
- (UITableViewCell*) returnRightDetailCellWithTitle: (NSString*)    titleText
                                     withDetailText: (NSString*)    detailText
                                       forTableView: (UITableView*) tableView;
@end
