//
//  OSGroupOfUsersInfoCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSGroupOfUsersInfoCellFactory.h"

// Classes
#import "OSGroupOfUserInfoCell.h"

@implementation OSGroupOfUsersInfoCellFactory

#pragma mark - Public -

- (UITableViewCell*) returnGroupOfUsersCellWithTitle: (NSString*)    titleText
                                      withUsersArray: (NSArray*)     usersArray
                                        forTableView: (UITableView*) tableView
{
    OSGroupOfUserInfoCell* cell = [tableView dequeueReusableCellWithIdentifier: @"GroupOfUsersCellID"];
    
    [cell fillCellWithTitle: titleText
                  withUsers: usersArray];
    
    return cell;
}


@end
