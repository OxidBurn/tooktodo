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
                                       withTag: (NSUInteger)   tag
                               withSwitchState: (BOOL)         isOn
                                  forTableView: (UITableView*) tableView
                                  withDelegate: (id)           delegate
                              withEnabledState: (BOOL)         isEnabled;

@end
