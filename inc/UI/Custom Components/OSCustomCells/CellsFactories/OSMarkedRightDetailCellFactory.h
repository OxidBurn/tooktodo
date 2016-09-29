//
//  OSMarkedRightDetailCellFactory.h
//  TookTODO
//
//  Created by Nikolay Chaban on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSMarkedRightDetailCellFactory : NSObject

// methods
- (UITableViewCell*) returnMarkedRightDetailCellWithTitle: (NSString*)    titleText
                                           withDetailText: (NSString*)    detailText
                                            withMarkImage: (UIImage*)     markImage
                                             forTableView: (UITableView*) tableView;

@end
