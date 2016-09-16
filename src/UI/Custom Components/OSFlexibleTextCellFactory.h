//
//  OSFlexibleTextCellFactory.h
//  TookTODO
//
//  Created by Глеб on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSFlexibleTextCellFactory : NSObject

// methods
- (UITableViewCell*) returnFlexibleCellWithTextContent: (NSString*)    textContent
                                          forTableView: (UITableView*) tableView;

@end
