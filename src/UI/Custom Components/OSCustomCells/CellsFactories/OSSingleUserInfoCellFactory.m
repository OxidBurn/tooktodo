//
//  OSSingleUserInfoCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSSingleUserInfoCellFactory.h"

// Classes
#import "OSSingleUserInfoCell.h"

@implementation OSSingleUserInfoCellFactory

#pragma mark - Public -

- (UITableViewCell*) returnSingleUserCellWithTitle: (NSString*)    titleText
                                  withUserFullName: (NSString*)    userFullName
                                    withUserAvatar: (UIImage*)     userAvatar
                                      forTableView: (UITableView*) tableView
{
    OSSingleUserInfoCell* cell = [tableView dequeueReusableCellWithIdentifier: @"SingleUserInfoCellID"];
    
    [cell fillCellWithTitle: titleText
           withUserFullName: userFullName
             withUserAvatar: userAvatar];
    
    return cell;
}

@end
