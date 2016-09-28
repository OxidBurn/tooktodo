//
//  OSSingleUserInfoCellFactory.h
//  TookTODO
//
//  Created by Nikolay Chaban on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSSingleUserInfoCellFactory : NSObject

// methods
- (UITableViewCell*) returnSingleUserCellWithTitle: (NSString*)    titleText
                                  withUserFullName: (NSString*)    userFullName
                                    withUserAvatar: (NSString*)    userAvatar
                                      forTableView: (UITableView*) tableView;

@end
