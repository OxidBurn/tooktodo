//
//  OSFlexibleTextCellFactory.m
//  TookTODO
//
//  Created by Глеб on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSFlexibleTextCellFactory.h"

//Classes
#import "OSFlexibleTextTableCell.h"

@implementation OSFlexibleTextCellFactory

#pragma mark - Public -

- (UITableViewCell*) returnFlexibleCellWithTextContent: (NSString*)    textContent
                                          forTableView: (UITableView*) tableView
{
    OSFlexibleTextTableCell* cell = [tableView dequeueReusableCellWithIdentifier: @"FlexibleTextCellID"];
    
    [cell fillCellWithText: textContent];
    
    return cell;
}


@end
