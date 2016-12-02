//
//  OSFlexibleTextFieldCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 21.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSFlexibleTextFieldCellFactory.h"

//Classes
#import "OSFlexibleTextFieldCell.h"

@implementation OSFlexibleTextFieldCellFactory

- (UITableViewCell*) returnFlexibleTextFieldCellWithTextContent: (NSString*)    textContent
                                                   forTableView: (UITableView*) tableView
                                                   withDelegate: (id)           delegate
{
    OSFlexibleTextFieldCell* cell = [tableView dequeueReusableCellWithIdentifier: @"FlexibleTextFieldCellID"];
    
    [cell fillCellWithText: textContent
              withDelegate: delegate];
    
    return cell;
}

@end
