//
//  OSFlexibleTextFieldCellFactory.h
//  TookTODO
//
//  Created by Глеб on 21.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSFlexibleTextFieldCellFactory : NSObject

// methods
- (UITableViewCell*) returnFlexibleTextFieldCellWithTextContent: (NSString*)    textContent
                                                   forTableView: (UITableView*) tableView;

@end
