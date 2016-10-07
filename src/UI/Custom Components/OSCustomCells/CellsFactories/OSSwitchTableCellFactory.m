//
//  OSSwitchTableCellFactory.m
//  TookTODO
//
//  Created by Nikolay Chaban on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSSwitchTableCellFactory.h"

// Classes
#import "OSSwitchTableCell.h"

@implementation OSSwitchTableCellFactory

#pragma mark - Public -

- (UITableViewCell*) returnSwitchCellWithTitle: (NSString*)    titleText
                                       withTag: (NSUInteger)   tag
                               withSwitchState: (BOOL)         isEnabled
                                  forTableView: (UITableView*) tableView
                                  withDelegate: (id)           delegate
{
    OSSwitchTableCell* cell = [tableView dequeueReusableCellWithIdentifier: @"SwitchCellID"];
    
    [cell fillCellWithTitle: titleText
                    withTag: (NSUInteger) tag
            withSwitchState: isEnabled
               withDelegate: delegate];
    
    return cell;
}

@end