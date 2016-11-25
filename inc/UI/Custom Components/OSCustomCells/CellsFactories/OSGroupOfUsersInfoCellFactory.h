//
//  OSGroupOfUsersInfoCellFactory.h
//  TookTODO
//
//  Created by Nikolay Chaban on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSGroupOfUsersInfoCellFactory : NSObject

// methods
- (UITableViewCell*) returnGroupOfUsersCellWithTitle: (NSString*)    titleText
                                      withUsersArray: (NSArray*)     usersArray
                                        forTableView: (UITableView*) tableView;

- (UITableViewCell*) returnGroupAssigneesCellWithTitle: (NSString*)    titleText
                                        withUsersArray: (NSArray*)     usersArray
                                          forTableView: (UITableView*) tableView;
@end
