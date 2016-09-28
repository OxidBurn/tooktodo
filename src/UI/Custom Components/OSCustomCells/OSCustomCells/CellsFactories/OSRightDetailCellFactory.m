//
//  OSRightDetailCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSRightDetailCellFactory.h"

// Classes
#import "OSRightDetailCell.h"

@implementation OSRightDetailCellFactory

#pragma mark - Public -

- (UITableViewCell*) returnRightDetailCellWithTitle: (NSString*)    titleText
                                     withDetailText: (NSString*)    detailText
                                       forTableView: (UITableView*) tableView
{
    OSRightDetailCell* cell = [tableView dequeueReusableCellWithIdentifier: @"RightDetailCellID"];
    
    [cell fillCellWithTitle: titleText
                 withDetail: detailText];
    
    return cell;
}

@end
