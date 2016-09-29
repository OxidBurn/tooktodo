//
//  OSSwitchTableCellFactory.h
//  TookTODO
//
//  Created by Nikolay Chaban on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSSwitchTableCellFactory : NSObject

// methods
- (UITableViewCell*) returnSwitchCellWithTitle: (NSString*)    titleText
                               withSwitchState: (BOOL)         isEnabled
                                  forTableView: (UITableView*) tableView
                                  withDelegate: (id) delegate;

@end
