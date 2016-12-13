//
//  CustomExpandedIconCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "CustomExpandedIconCellFactory.h"

// Classes
#import "RightDetailWithCustomExpandedIconCell.h"

@implementation CustomExpandedIconCellFactory


#pragma mark - Public -

- (UITableViewCell*) returnRightDetailCellWithTitle: (NSString*)    titleText
                                     withDetailText: (NSString*)    detailText
                                       forTableView: (UITableView*) tableView
{
    RightDetailWithCustomExpandedIconCell* cell = [tableView dequeueReusableCellWithIdentifier: @"CustomDisclosureIconCellID"];
    
    [cell fillCellWithTitle: titleText
                 withDetail: detailText];
    
    return cell;
}

@end
