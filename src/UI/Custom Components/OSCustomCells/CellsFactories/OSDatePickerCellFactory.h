//
//  OSDatePickerCellFactory.h
//  TookTODO
//
//  Created by Nikolay Chaban on 19.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

@interface OSDatePickerCellFactory : NSObject

// methods
- (UITableViewCell*) returnDatePickerCellWithTag: (NSUInteger)   pickerTag
                                    forTableView: (UITableView*) tableView
                                    withDelegate: (id)           delegate;

@end
