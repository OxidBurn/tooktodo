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

// Classes
#import "FilterByTermsCell.h"

@interface FilterByTermsCellFactory : NSObject

// methods

- (UITableViewCell*) returnFilterByTermsCellWithTitle: (NSString*)             title
                                       withStartTerms: (NSString*)             startTerms
                                         withEndTerms: (NSString*)             endTerms
                                         forTableView: (UITableView*)          tableView
                                         withCellType: (FilterByTermsCellType) cellType
                                         withDelegate: (id)                    delegate;

@end
