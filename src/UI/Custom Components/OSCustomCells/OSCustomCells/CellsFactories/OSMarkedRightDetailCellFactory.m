//
//  OSMarkedRightDetailCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSMarkedRightDetailCellFactory.h"

// Classes
#import "OSMarkedRightDetailCell.h"

@implementation OSMarkedRightDetailCellFactory

#pragma mark - Public -

- (UITableViewCell*) returnMarkedRightDetailCellWithTitle: (NSString*)    titleText
                                           withDetailText: (NSString*)    detailText
                                            withMarkImage: (UIImage*)     markImage
                                             forTableView: (UITableView*) tableView
{
    OSMarkedRightDetailCell* cell = [tableView dequeueReusableCellWithIdentifier: @"MarkedRightDetailsCellID"];
    
    [cell fillCellWithTitle: titleText
              withMarkImage: markImage
                 withDetail: detailText];
    
    return cell;
}

@end
