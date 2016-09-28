//
//  OSFlexibleTextFieldCellFactory.m
//  TookTODO
//
//  Created by Глеб on 21.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSFlexibleTextFieldCellFactory.h"

//Classes
#import "OSFlexibleTextFieldCell.h"

@implementation OSFlexibleTextFieldCellFactory

- (UITableViewCell*) returnFlexibleTextFieldCellWithTextContent: (NSString*)    textContent
                                                   forTableView: (UITableView*) tableView
{
    OSFlexibleTextFieldCell* cell = [tableView dequeueReusableCellWithIdentifier: @"FlexibleTextFieldCellID"];
    
    [cell fillCellWithText: textContent];
    
    return cell;
}

@end
