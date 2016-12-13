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

// Classes
#import "OSRightDetailCell.h"

@interface OSRightDetailCellFactory : NSObject

// methods
- (UITableViewCell*) returnRightDetailCellWithTitle: (NSString*)    titleText
                                     withDetailText: (NSString*)    detailText
                                 withSelectedDetail: (BOOL)         isSelected
                                       forTableView: (UITableView*) tableView;

- (UITableViewCell*) returnAboutProjectCommentCellWithComment: (NSString*)    comment
                                            withSelectedState: (BOOL)         isSelected
                                                 forTableView: (UITableView*) tableView;

@end
