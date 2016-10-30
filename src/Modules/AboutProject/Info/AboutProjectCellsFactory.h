//
//  AboutProjectCellsFactory.h
//  TookTODO
//
//  Created by Глеб on 28.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

@interface AboutProjectCellsFactory : NSObject

// methods
- (UITableViewCell*) returnRightDetailCellWithTitle: (NSString*)    title
                                         withDetail: (NSString*)    detail
                                       forTableView: (UITableView*) tableView;

- (UITableViewCell*) returnMapViewCellWithTitle: (NSString*)    title
                                withCoordinates: (NSString*)    coordinates
                                   forTableView: (UITableView*) tableView;

@end
